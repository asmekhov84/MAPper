unit ViewForm;

// Author: Artemiy Smekhov
// Created: 11.11.14
// Modifyed: 2.1.15

interface

uses
  Winapi.Windows, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Graphics,
  PlotConfig, Utilities, System.Types, Vcl.ExtCtrls;

type
  TwndViewForm = class(TForm)
    dlgOpenFile: TOpenDialog;
    dlgSaveFile: TSaveDialog;
    dlgPrinter: TPrintDialog;
    imgView: TPaintBox;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgViewPaint(Sender: TObject);

  public
    scale: Real;
    modPlot: Boolean;
    modGraphs: Boolean;
    plotFileName: TFileRecord;
    graphsFileName: TFileRecord;
    curFreq: Real;

    procedure LoadPlotFromFile;
    procedure LoadPlotFromWorkspace(const workspace: TStringList);
    function SavePlotToFile(forcedSave, promptForName: Boolean): Boolean;
    procedure OpenPlotDialog;

    procedure LoadGraphsFromFile;
    procedure LoadGraphsFromWorkspace(const workspace: TStringList);

    procedure UpdateView;
    procedure DrawOnPrinter;

    procedure SetScale(s: Real);
    procedure SetFreq(f: Real);
    function GetFreqs: TStringList;

  private
    scrPPM: Real;
    plot: TPlotConfig;

    // fct - scale factor = scale * ppm
    procedure DrawPlot(const canvas: TCanvas; fct: Real);
  end;

  TvfAction = (vfActive, vfInactive);

implementation

{$R *.dfm}

uses
  MainForm, PlotFilesDlg, PlotSetupDlg, GraphsFilesDlg,
  Printers, SysUtils, Axises, GraphGroups;

var ok: Boolean = false;

//////////////////////////////
// variables initialization //
//////////////////////////////
procedure TwndViewForm.FormCreate(Sender: TObject);
begin
  plot := TPlotConfig.Create;
  ok := True;
  scrPPM := GetDeviceCaps(GetDC(0), LOGPIXELSX) / 25.4;
  scale := 1;
  modPlot := False;
  modGraphs := False;
  plotFileName.name := '';
  plotFileName.path := '';
  graphsFileName.name := '';
  graphsFileName.path := '';
  curFreq := 0;
//  freqList := TList<Real>.Create;
end;

/////////////////////////////////////////////
// update state of controls of main window //
/////////////////////////////////////////////
procedure TwndViewForm.FormActivate(Sender: TObject);
begin
  TwndMainForm(Self.Owner).UpdateControlsState(Self, vfActive);
end;

////////////////////////////////////////////
// replace view image to center of window //
////////////////////////////////////////////
procedure TwndViewForm.FormResize(Sender: TObject);
begin
  if ok = False then Exit;

  UpdateView;
end;

//////////////////////////////////
// close window and free memory //
//////////////////////////////////
procedure TwndViewForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if SavePlotToFile(False, False) = False then
    Action := caNone else
    TwndMainForm(Self.Owner).UpdateControlsState(Self, vfInactive);
end;

//////////////////////////////////
// repaint view image if needed //
//////////////////////////////////
procedure TwndViewForm.imgViewPaint(Sender: TObject);
begin
  if ok = False then Exit;

  DrawPlot(imgView.Canvas, scrPPM * scale);
end;

procedure TwndViewForm.LoadPlotFromFile;
var
  fullFileName: String;
begin
  dlgOpenFile.Filter := 'Конфигурация чертежа MAPper (*.' + PC_NATIVE_PC_FILE_EXT +
    ')|*.' + PC_NATIVE_PC_FILE_EXT + '|Рисунок GRNOS (*.' + PC_GRNOS_PC_FILE_EXT + ')|*.' + PC_GRNOS_PC_FILE_EXT;
  if dlgOpenFile.Execute = True then
  begin
    fullFileName := dlgOpenFile.FileName;
    if ExtractFileExt(fullFileName) = '.' + PC_GRNOS_PC_FILE_EXT then
      Self.plot.LoadPlotFromFileGRNOS(fullFileName) else Self.plot.LoadPlotFromFile(fullFileName);
    plotFileName.name := GetFileNameNoExt(fullFileName);
    plotFileName.path := ExtractFilePath(fullFileName);
    modPlot := False;
    TwndMainForm(Self.Owner).UpdateControlsState(Self, vfActive);
    UpdateView;
  end else Self.Close;
end;

procedure TwndViewForm.LoadPlotFromWorkspace(const workspace: TStringList);
var
  fullFileName: String;
  dlg: TdlgPlotFiles;
begin
  dlg := TdlgPlotFiles.Create(Self);
  if dlg.OpenDialog(workspace, fullFileName) = True then
  begin
    if ExtractFileExt(fullFileName) = '.' + PC_GRNOS_PC_FILE_EXT then
      Self.plot.LoadPlotFromFileGRNOS(fullFileName) else Self.plot.LoadPlotFromFile(fullFileName);
    plotFileName.name := GetFileNameNoExt(fullFileName);
    plotFileName.path := ExtractFilePath(fullFileName);
    modPlot := False;
    TwndMainForm(Self.Owner).UpdateControlsState(Self, vfActive);
    UpdateView;
  end else Self.Close;
  dlg.Free;
end;

// save plot configuration
function TwndViewForm.SavePlotToFile(forcedSave, promptForName: Boolean): Boolean;
var
  res: Integer;
begin
  Result := True;
  if forcedSave = False then
  begin
    if modPlot = True then
    begin
      res := MessageBox(Application.MainFormHandle, 'Сохранить изменения в текущей конфигурации листа?',
                        PWideChar(Application.Title), MB_YESNOCANCEL);
      if res = mrCancel then
      begin
        Result := False;
        Exit;
      end else if res = mrNo then Exit;
    end else Exit;
  end;
  if (plotFileName.name = '') or (promptForName = True) then
  begin
    dlgSaveFile.DefaultExt := PC_NATIVE_PC_FILE_EXT;
    dlgSaveFile.Filter := 'Конфигурация чертежа MAPper (*.' + PC_NATIVE_PC_FILE_EXT +
    ')|*.' + PC_NATIVE_PC_FILE_EXT;
    dlgSaveFile.FilterIndex := 0;
    if plotFileName.name <> '' then dlgSaveFile.FileName := plotFileName.name + '.' + PC_NATIVE_PC_FILE_EXT;
    if dlgSaveFile.Execute = True then
    begin
      plot.SavePlotToFileAs(dlgSaveFile.FileName);
      modPlot := False;
      plotFileName.name := GetFileNameNoExt(dlgSaveFile.FileName);
      plotFileName.path := ExtractFilePath(dlgSaveFile.FileName);
    end else
    begin
      Result := False;
      Exit;
    end;
  end else
  begin
    plot.SavePlotToFileAs(plotFileName.path + plotFileName.name + '.' + PC_NATIVE_PC_FILE_EXT);
    modPlot := False;
  end;
  TwndMainForm(Self.Owner).UpdateControlsState(Self, vfActive);
end;

procedure TwndViewForm.OpenPlotDialog;
var
  dlg: TdlgPlotSetup;
  res: Boolean;
begin
  dlg := TdlgPlotSetup.Create(Self);
  res := dlg.OpenDialog(plot);
  if res = True then
  begin
    Self.modPlot := True;
    TwndMainForm(Self.Owner).UpdateControlsState(Self, vfActive);
  end;
  dlg.Free;
end;

procedure TwndViewForm.LoadGraphsFromFile;
var
  fullFileName: String;
begin
  dlgOpenFile.Filter := 'Набор графиков GRNOS (*.' + PC_GRNOS_GS_FILE_EXT + ')|*.' + PC_GRNOS_GS_FILE_EXT;
  if dlgOpenFile.Execute then
  begin
    fullFileName := dlgOpenFile.FileName;
    plot.LoadGraphsFromFileGRNOS(fullFileName);
    graphsFileName.name := GetFileNameNoExt(fullFileName);
    graphsFileName.path := ExtractFilePath(fullFileName);
    modGraphs := False;
    TwndMainForm(Self.Owner).UpdateControlsState(Self, vfActive);
    UpdateView;
  end;
end;

procedure TwndViewForm.LoadGraphsFromWorkspace(const workspace: TStringList);
var
  fullFileName: TStringList;
  dlg: TdlgGraphsFiles;
  i: Byte;
begin
  dlg := TdlgGraphsFiles.Create(Self);
  fullFileName := TStringList.Create;
  if dlg.OpenDialog(workspace, fullFileName) = True then
  begin
    for i := 1 to fullFileName.Count do
      plot.LoadGraphsFromFileGRNOS(fullFileName[i - 1]);
    if fullFileName.Count > 1 then
    begin
      graphsFileName.name := '';
      modGraphs := True;
    end else
    begin
      graphsFileName.name := GetFileNameNoExt(fullFileName[0]);
      graphsFileName.path := ExtractFilePath(fullFileName[0]);
      modGraphs := False;
    end;
    TwndMainForm(Self.Owner).UpdateControlsState(Self, vfActive);
    UpdateView;
  end;
  dlg.Free;
end;

procedure TwndViewForm.UpdateView;
begin
  imgView.Width := Round(plot.width * scrPPM * scale);
  imgView.Height := Round(plot.height * scrPPM * scale);
  Self.HorzScrollBar.Range := imgView.Width;
  Self.HorzScrollBar.Position := 0;
  Self.VertScrollBar.Range := imgView.Height;
  Self.VertScrollBar.Position := 0;
  imgView.Left := Round((ClientWidth - imgView.Width) / 2);
  if imgView.Left < 0 then imgView.Left := 0;
  imgView.Top := Round((ClientHeight - imgView.Height) / 2);
  if imgView.Top < 0 then imgView.Top := 0;
  imgView.Repaint;
end;

procedure TwndViewForm.DrawOnPrinter;
var
  prnPPM: Real;
begin
  if Printer.Printers.Count = 0 then
  begin
    ShowMessage('Нет установленных принтеров.');
    Exit;
  end;
  if dlgPrinter.Execute then
  begin
    prnPPM := GetDeviceCaps(Printer.Handle, LOGPIXELSX) / 25.4;
    Printer.BeginDoc;
    Self.DrawPlot(Printer.Canvas, prnPPM);
    Printer.EndDoc;
  end;
end;

////////////////////////////////
// set scale and update view //
///////////////////////////////
procedure TwndViewForm.SetScale(s: Real);
begin
  scale := s;
  UpdateView;
end;

procedure TwndViewForm.SetFreq(f: Real);
begin
  curFreq := f;
  UpdateView;
end;


function TwndViewForm.GetFreqs: TStringList;
var
  str: TStringList;
  i: Integer;
begin
  str := TStringList.Create;
  str.Clear;
  for i := 0 to plot.graphs.freqList.Count - 1 do str.Add(FloatToStr(plot.graphs.freqList[i]));
  Result := str;
end;

procedure TwndViewForm.DrawPlot(const canvas: TCanvas; fct: Real);
  procedure DrawBorders(const canvas: TCanvas; fct: Real);
  var
    x1, x2, y1, y2: Word;
  begin
    if plot.border.visible = False then Exit;
    canvas.Pen.Color := clBlack;
    canvas.Pen.Width := Round(0.25 * fct);
    x1 := Round(plot.border.Left * fct);
    x2 := Round((plot.width - plot.border.Right) * fct);
    y1 := Round(plot.border.Top * fct);
    y2 := Round((plot.height - plot.border.Bottom) * fct);
    canvas.Rectangle(x1, y1, x2, y2);
  end;
  // x0, y0 - table left bottom corner
  procedure DrawTable(const canvas: TCanvas; fct: Real);
  const
    txt: array[1..5] of String = ('Изм.', 'Лист', '№ докум.', 'Подп.', 'Дата');
    tblWidth = 185;
    tblHeight = 15;
    colCnt = 7;
    columns: array[1..colCnt] of Byte = (7, 10, 23, 15, 10, 110, 10);
    row1 = 5; // rows height in first 5 columns
    row2 = 8;
  var
    i: Byte;
    w, h, c, x, y, x0, y0: Integer;
    t: String;
  begin
    if plot.table.visible = False then Exit;
    canvas.Pen.Color := clBlack;
    canvas.Pen.Width := Round(0.25 * fct);
    canvas.Font.Height := Round(3.5 * fct);
    canvas.Font.Name := 'Times';
    x0 := Round(plot.border.left * fct);
    y0 := Round((plot.height - plot.border.bottom) * fct);
    canvas.Rectangle(x0, y0, Round(x0 + tblWidth * fct), Round(y0 - tblHeight * fct));
    // draw columns
    w := 0;
    for i := 1 to colCnt - 1 do
    begin
      w := w + columns[i];
      canvas.MoveTo(x0 + Round(w * fct), y0);
      canvas.LineTo(x0 + Round(w * fct), y0 - Round(tblHeight * fct));
    end;
    // draw rows in 1-5 columns
    for i := 1 to 2 do
    begin
      canvas.MoveTo(x0, y0 - Round(row1 * i * fct));
      canvas.LineTo(x0 + Round((w - columns[6]) * fct), y0 - Round(row1 * i * fct));
    end;
    canvas.MoveTo(x0 + Round(w * fct), y0 - Round(row2 * fct));
    canvas.LineTo(x0 + Round(tblWidth * fct), y0 - Round(row2 * fct));
    // text labels
    h := canvas.TextHeight(txt[1]);
    y := y0 - Round(row1 * fct - (row1 * fct - h) / 2);
    c := 0;
    for i := 1 to 5 do
    begin
      w := canvas.TextWidth(txt[i]);
      x := x0 + Round(c * fct + (columns[i] * fct - w) / 2 + 1);
      c := c + columns[i];
      canvas.TextOut(x, y, txt[i]);
    end;
    // document number
    t := plot.table.docNum;
    w := canvas.TextWidth(t);
    h := canvas.TextHeight(t);
    x := x0 + Round(c * fct + (columns[6] * fct - w) / 2);
    y := y0 - Round(tblHeight * fct - (tblHeight * fct - h) / 2);
    canvas.TextOut(x, y, t);
    // 'List' text label
    c := c + columns[6];
    w := canvas.TextWidth(txt[2]);
    h := canvas.TextHeight(txt[2]);
    x := x0 + Round(c * fct + (columns[7] * fct - w) / 2);
    y := y0 - Round(tblHeight * fct - ((tblHeight - row2) * fct - h) / 2);
    canvas.TextOut(x, y, txt[2]);
    // sheet number
    t := IntToStr(plot.table.sheetNum);
    w := canvas.TextWidth(t);
    h := canvas.TextHeight(t);
    x := x0 + Round(c * fct + (columns[7] * fct - w) / 2);
    y := y0 - Round(row2 * fct - ((tblHeight - row2) * fct - h) / 2);
    canvas.TextOut(x, y, t);
  end;
  // draw figure name
  procedure DrawFigName(const canvas: TCanvas; fct: Real);
  var
    maxTextWidth, x, y, w, h, margin, i, p, x0, y0: Integer;
    lines: TStringList;
    str, strLine, strWord: String;
  begin
    if plot.figName.name = '' then Exit;
    canvas.Font.Height := Round(5 * fct);
    canvas.Font.Name := 'Times';
    x0 := Round(plot.border.left * fct);
    y0 := Round((plot.height - plot.border.bottom) * fct);

    lines := TStringList.Create;
    margin := Round(10 * fct);
    maxTextWidth := Round((plot.width - plot.border.left - plot.border.right) * fct - margin);

    i := 1;
    str := plot.figName.name + ' ';
    strLine := '';
    while i < Length(str) do
    begin
      p := Pos(' ', str, i);
      strWord := Copy(str, i, p - i + 1);
      if canvas.TextWidth(strLine + strWord) < maxTextWidth then
      begin
        strLine := strLine + strWord;
      end else
      begin
        lines.Add(Trim(strLine));
        strLine := strWord;
      end;
      i := p + 1;
    end;
    lines.Add(Trim(strLine));

    for i := lines.Count downto 1 do
    begin
      w := canvas.TextWidth(lines[i - 1]);
      h := canvas.TextHeight(lines[i - 1]);
      x := x0 + (maxTextWidth - w + margin) div 2;
      y := y0 - Round(plot.figName.vPos * fct) - h * (lines.Count - i + 1);
      canvas.TextOut(x, y, lines[i - 1]);
    end;
  end;

  // x0, y0 - grid left bottom corner
  procedure DrawGrid(const canvas: TCanvas; fct: Real);
  var
    i: Byte;
    x0, y0, x1, y1: Integer;
    step: Real;
  begin
    canvas.Pen.Color := plot.grid.line.color;
    canvas.Pen.Width := Round(plot.grid.line.width * 0.25 * fct);
    x0 := Round((plot.border.left + plot.grid.left) * fct);
    y0 := Round((plot.height - plot.border.bottom - plot.grid.bottom) * fct);

    // draw vertical lines
    step := plot.grid.width * fct / plot.grid.xUnits;
    for i := 0 to plot.grid.xUnits do
    begin
      x1 := x0 + Round(i * step);
      canvas.MoveTo(x1, y0);
      canvas.LineTo(x1, y0 - Round(plot.grid.height * fct));
    end;
    // draw horizontal lines
    step := plot.grid.height * fct / plot.grid.yUnits;
    for i := 0 to plot.grid.yUnits do
    begin
      y1 := y0 - Round(i * step);
      canvas.MoveTo(x0, y1);
      canvas.LineTo(x0 + Round(plot.grid.width * fct), y1);
    end;
  end;

  // x0, y0 - grid left bottom corner
  procedure DrawXAxis(const canvas: TCanvas; fct: Real);
  var
    i: Byte;
    x, y, x0, y0, w, h, pXLen: Integer;
    txt: String;
    xCost, step: Real;
  begin
    canvas.Pen.Color := plot.xAxis.lineColor;
    canvas.Pen.Width := Round(plot.xAxis.lineWidth * 0.25 * fct);
    canvas.Font.Height := Round(4 * fct);
    x0 := Round((plot.border.left + plot.grid.left) * fct);
    y0 := Round((plot.height - plot.border.bottom - plot.grid.bottom) * fct);
    // draw horizontal line
    y := y0 + Round(plot.xAxis.gap * fct); // horz. axis y position
    pXLen := Round(plot.grid.width * fct);
    xCost := (plot.xAxis.max - plot.xAxis.min) / plot.xAxis.units;
    canvas.MoveTo(x0, y);
    canvas.LineTo(x0 + pXLen, y);
    step := plot.grid.width * fct / plot.grid.xUnits;
    x := 0;
    for i := 0 to plot.xAxis.units do
    begin
      x := x0 + Round(i * step);
      // draw vertical marks
      canvas.MoveTo(x, y);
      canvas.LineTo(x, y + Round(3 * fct));
      // draw text labels
      txt := FloatToStrF(plot.xAxis.min + i * xCost, ffGeneral, 4, 8); // numeric value of label
      w := canvas.TextWidth(txt); // width of text label in px
      canvas.TextOut(x - w div 2, y + Round(4 * fct), txt); // position of text label with respect to it's width
    end;
    // draw axis title
    w := canvas.TextWidth(plot.xAxis.name);
    h := canvas.TextHeight(txt);
    canvas.TextOut(x - w, y + Round(4 * fct) + h, plot.xAxis.name);
  end;
  // x0, y0 - grid left bottom corner
  procedure DrawYAxis(const canvas: TCanvas; fct: Real);
  var
    i, j: Byte;
    x0, y0, x, y, w, h: Integer;
    txt: String;
    yCost, step: Real;
  begin
    canvas.Font.Height := Round(4 * fct);
    canvas.Font.Name := 'Times';
    x0 := Round((plot.border.left + plot.grid.left) * fct);
    y0 := Round((plot.height - plot.border.bottom - plot.grid.bottom) * fct);
    step := plot.grid.height * fct / plot.grid.yUnits;
    // draw vertical line
    for i := 0 to plot.yAxis.Count - 1 do
    begin
      plot.yAxis.SetActive(i);
      canvas.Pen.Color := plot.yAxis.lineColor;
      canvas.Pen.Width := Round(plot.yAxis.lineWidth * 0.25 * fct);
      if plot.yAxis.side = yasLeft then
        x := x0 - Round(plot.yAxis.gap * fct) else
        x := x0 + Round((plot.yAxis.gap + plot.grid.width) * fct);
      canvas.MoveTo(x, y0 - Round(plot.yAxis.indent * step));
      canvas.LineTo(x, y0 - Round((plot.yAxis.indent + plot.yAxis.units) * step));
      yCost := (plot.yAxis.max - plot.yAxis.min) / plot.yAxis.units;
      y := 0;
      for j := 0 to plot.yAxis.units do
      begin
        y := y0 - Round((plot.yAxis.indent + j) * step);
        // draw horizontal marks
        canvas.MoveTo(x, y);
        if plot.yAxis.side = yasLeft then
          canvas.LineTo(x - Round(3 * fct), y) else
          canvas.LineTo(x + Round(3 * fct), y);
        // draw text labels
        txt := FloatToStrF(plot.yAxis.min + j * yCost, ffGeneral, 4, 8); // numeric value of label
        w := canvas.TextWidth(txt); // width of text label in px
        h := canvas.TextHeight(txt); // height of text label in px
        if plot.yAxis.side = yasLeft then
          canvas.TextOut(x - Round(3 * fct) - w, y - h div 2, txt) else
          canvas.TextOut(x + Round(3 * fct), y - h div 2, txt); // position of text label with respect to it's width
      end;
      // draw axis title
      w := canvas.TextWidth(plot.yAxis.name);
      h := Round(canvas.TextHeight(plot.yAxis.name) * 1.5);
      if plot.yAxis.side = yasLeft then
        canvas.TextOut(x - w, y - h, plot.yAxis.name) else
        canvas.TextOut(x, y - h, plot.yAxis.name);
    end;
  end;

  procedure DrawMarker(x0, y0: Word; m: TGraphMarker; const canvas: TCanvas; fct: Real);
  const
    s = 3; // marker size in mm
  var
    r: Word;
  begin
    r := Round(s * fct / 2);
    case m of
      gmRound:
        canvas.Ellipse(x0 - r, y0 - r, x0 + r, y0 + r);
      gmSquare:
        canvas.Rectangle(x0 - r, y0 - r, x0 + r, y0 + r);
      gmTriangle:
        canvas.Polygon([Point(x0, y0 - r), Point(x0 - Round(0.707 * r), y0 + Round(0.707 * r)),
                             Point(x0 + Round(0.707 * r), y0 + Round(0.707 * r))]);
      gmCross:
        begin
          canvas.MoveTo(x0 - r, y0 - r);
          canvas.LineTo(x0 + r, y0 + r);
          canvas.MoveTo(x0 - r, y0 + r);
          canvas.LineTo(x0 + r, y0 - r);
        end;
    end;
  end;
  // pX0, pY0 - grid left bottom corner
  procedure DrawGraph(const canvas: TCanvas; fct: Real);
  var
    i, j, k, m, h: Integer;
    cX0, cXn, cXLen, cY0, cYn, cYLen, pX0, pXLen, pY0, pYLen, x, y, step,
    markX, markY, markStep, x1, x2, y1, y2, nameXPos, nameYPos: Real;
    xi, yi: TRealVector;
    gridRect: TRect;
    prevPointHitToGrid: Boolean;
    scrPnt: TPoint;
  begin
    canvas.Font.Height := Round(4 * fct);

    gridRect.Left := Round((plot.border.left + plot.grid.left) * fct);
    gridRect.Bottom := Round((plot.height - plot.border.bottom - plot.grid.bottom) * fct);
    gridRect.Right := gridRect.Left + Round(plot.grid.width * fct);
    gridRect.Top := gridRect.Bottom - Round(plot.grid.height * fct);

    cX0 := plot.xAxis.min; // begin of the X axis [coord]
    cXn := plot.xAxis.max;
    cXLen := cXn - cX0; // X axis length [coord]
    pX0 := gridRect.Left;
    pXLen := plot.grid.width * fct; // X axis length [px]
    step := plot.grid.height * fct / plot.grid.yUnits;
    // search binded axis for current graph
    for i := 0 to plot.graphs.count - 1 do
    begin
      plot.graphs.SetActive(i);
      if (plot.graphs.N <> curFreq) and (curFreq <> 0) then Continue;
      plot.groups.SetActiveByGraphName(plot.graphs.name);
      if plot.groups.visible = False then Continue;

      for j := 0 to plot.yAxis.Count - 1 do
      begin
        plot.yAxis.SetActive(j);
        if StrComp(PWideChar(plot.graphs.yAxisName), PWideChar(plot.yAxis.name)) = 0 then
        begin
          canvas.Pen.Color := plot.groups.lineColor;
          canvas.Pen.Width := Round(plot.groups.lineWidth * 0.25 * fct);
          canvas.Pen.Style := psSolid;
          // draw graph
          cY0 := plot.yAxis.min; // begin of the Y axis [coord]
          cYn := plot.yAxis.max;
          cYLen := cYn - cY0; // Y axis length [coord]
          pY0 := gridRect.Bottom - plot.yAxis.indent * step;
          pYLen := plot.yAxis.units * step;

          m := 0;
          xi := plot.graphs.XI;
          yi := plot.graphs.YI;
          x := xi[m];
          scrPnt.X := Round((pX0 + (x - cX0) / cXLen * pXLen));
          y := yi[m];
          scrPnt.Y := Round((pY0 - (y - cY0) / cYLen * pYLen));
          prevPointHitToGrid := False;
          if gridRect.Contains(scrPnt) = True then prevPointHitToGrid := True;
          canvas.MoveTo(scrPnt.X, scrPnt.Y);
          // to each point of interpolated graph
          for k := m + 1 to plot.graphs.NI - 1 do
          begin
            x := xi[k];
            scrPnt.X := Round((pX0 + (x - cX0) / cXLen * pXLen));
            y := yi[k];
            scrPnt.Y := Round((pY0 - (y - cY0) / cYLen * pYLen));
            if gridRect.Contains(scrPnt) = True then
            begin
              if prevPointHitToGrid then canvas.LineTo(scrPnt.X, scrPnt.Y);
              prevPointHitToGrid := True;
            end else prevPointHitToGrid := False;
            canvas.MoveTo(scrPnt.X, scrPnt.Y);
          end;
          // draw markers
          if plot.groups.marker <> gmNone then
          begin
            markX := plot.xAxis.min;
            markStep := (plot.xAxis.max - plot.xAxis.min) / plot.xAxis.units;
            while markX < xi[0] do markX := markX + markStep;
            m := 0;
            while markX <= xi[plot.graphs.NI - 1] do
            begin
              while (xi[m] <= markX) and (m < plot.graphs.NI - 1) do m := m + 1;
              x1 := xi[m - 1];
              x2 := xi[m];
              y1 := yi[m - 1];
              y2 := yi[m];
              markY := (y2 - y1) / (x2 - x1) * (markX - x1) + y1; // y=kx+b
              scrPnt.X := Round((pX0 + (markX - cX0) / cXLen * pXLen));
              scrPnt.Y := Round((pY0 - (markY - cY0) / cYLen * pYLen));
              if gridRect.Contains(scrPnt) then
                DrawMarker(scrPnt.X, scrPnt.Y, plot.groups.marker, canvas, fct);
              markX := markX + markStep;
            end;
          end;
          // draw graph's note
          m := 0;
          nameXPos := plot.groups.noteXPos;
          if (nameXPos < xi[0]) or (nameXPos > xi[plot.graphs.NI - 1]) then
            nameXPos := (xi[0] + xi[plot.graphs.NI - 1]) / 2;
          while xi[m] <= nameXPos do m := m + 1;
          x1 := xi[m - 1];
          x2 := xi[m];
          y1 := yi[m - 1];
          y2 := yi[m];
          nameYPos := (y2 - y1) / (x2 - x1) * (nameXPos - x1) + y1; // y=kx+b
          scrPnt.X := Round((pX0 + (nameXPos - cX0) / cXLen * pXLen));
          scrPnt.Y := Round((pY0 - (nameYPos - cY0) / cYLen * pYLen));
          h := canvas.TextHeight(plot.graphs.note);
          if gridRect.Contains(scrPnt) then
            canvas.TextOut(scrPnt.X, scrPnt.Y - h, plot.graphs.note);

          Break;
        end;
      end;
    end;
  end;
  // pX0, pY0 - legend left bottom corner
  procedure DrawLegend(const canvas: TCanvas; fct: Real);
  var
    i, p: Integer;
    h, y, l, x0, y0: Integer;
  begin
    if plot.legend.visible = False then Exit;
    canvas.Font.Height := Round(5 * fct);
    canvas.Font.Name := 'Times';
    x0 := Round((plot.border.left + plot.legend.left) * fct);
    y0 := Round((plot.height - plot.border.bottom - plot.legend.bottom) * fct);
    l := Round(10 * fct); // length of sample line in px
    p := 0;
    for i := 0 to plot.groups.count - 1 do
    begin
      plot.groups.SetActiveByNumber(i);
      if plot.groups.visible = False then Continue;
      canvas.Pen.Width := Round(plot.groups.lineWidth * 0.25 * fct);
      canvas.Pen.Color := plot.groups.lineColor;
      h := canvas.TextHeight(plot.groups.name);
      y := y0 - Round((0.5 + p) * h);
      canvas.MoveTo(x0, y);
      canvas.LineTo(x0 + l, y);
      DrawMarker(x0 + l div 2, y, plot.groups.marker, canvas, fct);
      canvas.TextOut(x0 + l, y - h div 2, plot.groups.name);
      p := p + 1;
    end;
  end;

begin
  // clear canvas
  canvas.Brush.Color := clWhite;
  canvas.FillRect(canvas.ClipRect);
  DrawBorders(canvas, fct);
  DrawTable(canvas, fct);
  DrawFigName(canvas, fct);
  DrawGrid(canvas, fct);
  DrawXAxis(canvas, fct);
  DrawYAxis(canvas, fct);
  DrawGraph(canvas, fct);
  DrawLegend(canvas, fct);
end;

end.
