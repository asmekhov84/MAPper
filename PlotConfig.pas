unit PlotConfig;

// Author: Artemiy Smekhov
// Created: ???
// Modifyed: 1.1.15

interface

uses
  Graphics, Types, Axises, GraphGroups, GraphSeries, Classes, Generics.Collections, Utilities;

type

  TGraphType = (gtLC, gtMPC); // Ì‡„ÛıÓ˜Ì‡ˇ ı‡-Í‡ ÎË·Ó ‚ÌÂ¯Ìˇˇ ÒÍÓÓÒÚÌ‡ˇ ı‡-Í‡

const
  PC_NATIVE_PC_FILE_EXT = 'mpc';
  PC_GRNOS_PC_FILE_EXT = 'ris';
  PC_MAX_Y_AXIS_CNT = 15;

  PC_GRNOS_GS_FILE_EXT = 'gr';
  PC_MAX_GRAPHS_CNT = 500;
  PC_MARKERS_CNT = 5;

  PC_LINE_WIDTH_CNT = 8;
  PC_LINE_WIDTH_STR: array[1..PC_LINE_WIDTH_CNT] of String = ('0.25', '0.5', '0.75', '1', '1.25', '1.5', '1.75', '2');
  PC_VISIBLE_STR: array[False..True] of String = ('ÒÍ˚Ú˚È', '‚Ë‰ËÏ˚È');
  PC_GRAPH_TYPE_STR: array[0..1] of String = ('¬—’', 'Õ’');

  PC_GRID_XUNITS_MAX = 30;
  PC_GRID_YUNITS_MAX = 30;
  PC_SHEET_WIDTH_MIN = 100;
  PC_SHEET_WIDTH_MAX = 500;
  PC_SHEET_HEIGHT_MIN = 100;
  PC_SHEET_HEIGHT_MAX = 500;

type
  TBorder = record
    left, top, right, bottom: Byte; // distance from sheet edges to borders
    visible: Boolean; // border visibility
  end;

  TTable = record
    sheetNum: Byte;
    docNum: String;
    visible: Boolean;
  end;

  TGrid = record
    left, bottom: Byte; // distance from borders to left bottom corner of grid [mm]
    width, height: Byte; // grid sizes [mm]
    xUnits, yUnits: Byte; // number of units on X and Y axises
    line: TLineStyle; // width and color of line
  end;

  TFigName = record
    name: String;
    vPos: Byte; // distance to top border of table [mm]
  end;

  TLegend = record
    left, bottom: Word; // distance from borders to left bottom corner to legend [mm]
    visible: Boolean;
  end;

  TPlotConfig = class
    width, height: Word; // sheet size [mm]
    border: TBorder; // sheet margins [mm]
    table: TTable;
    figName: TFigName;
    grid: TGrid;
    legend: TLegend;
    xAxis: TXAxis;
    yAxis: TYAxises;
    graphs: TGraphSeries;
    groups: TGraphGroups;

    constructor Create;
    procedure CopyPlotConfig(const obj: TPlotConfig);
    procedure LoadPlotFromFile(fullFileName: String);
    procedure LoadPlotFromFileGRNOS(fullFileName: String);
    procedure SavePlotToFileAs(fullFileName: String);
    procedure LoadGraphsFromFileGRNOS(fullFileName: String);
  end;

implementation

uses
  Windows, SysUtils, Dialogs;


{-------------------------------[ TPlotConfig ]--------------------------------}

/////////////////////////
// default constructor //
/////////////////////////
constructor TPlotConfig.Create;
begin
  width := 210;
  height := 297;

  border.left := 15;
  border.right := 10;
  border.top := 10;
  border.bottom := 10;
  border.visible := True;

  table.sheetNum := 1;
  table.docNum := '—Ã 37.104.17.         -2014';
  table.visible := True;

  figName.name := '';
  figName.vPos := 10;

  grid.Left := 50;
  grid.bottom := 70;
  grid.width := 100;
  grid.height := 140;
  grid.xUnits := 1;
  grid.yUnits := 1;
  grid.line.color := clGray;
  grid.line.width := 1;

  legend.left := 20;
  legend.bottom := 30;
  legend.visible := False;

  xAxis := TXAxis.Create;
  yAxis := TYAxises.Create;
  graphs := TGraphSeries.Create;
  groups := TGraphGroups.Create;
end;

///////////////////////////////////
// copy config. from another one //
///////////////////////////////////
procedure TPlotConfig.CopyPlotConfig(const obj: TPlotConfig);
var
  i: Integer;
begin
  width := obj.width;
  height := obj.height;
  border := obj.border;
  table := obj.table;
  figName := obj.figName;
  grid := obj.grid;
  legend := obj.legend;
  xAxis := obj.xAxis;
  yAxis.CopyAxises(obj.yAxis);
  graphs.CopyGraphSeries(obj.graphs);
  groups.CopyGraphGroups(obj.groups);
end;

////////////////////////////////////////////////
// load plot configuration from existing file //
////////////////////////////////////////////////
procedure TPlotConfig.LoadPlotFromFile(fullFileName: string);
const
  BUF_SIZE = 1024;
var
  p, ffn: PWideChar;
  buf: array of WideChar;
  i, j, yAxisCount, groupsCount: Integer;
  axis: ^TYAxis;
  grp: TGraphGroup;
  gr: String;
  c: word;
begin
  ffn := PWideChar(fullFileName);
  SetLength(buf, BUF_SIZE);

  p := PWideChar(IntToStr(width));
  GetPrivateProfileString('plot', 'width', p, PWideChar(buf), BUF_SIZE, ffn);
  width := StrToInt(PWideChar(buf));
  p := PWideChar(IntToStr(height));
  GetPrivateProfileString('plot', 'height', p, PWideChar(buf), BUF_SIZE, ffn);
  height := StrToInt(PWideChar(buf));

  p := PWideChar(BoolToStr(border.visible, True));
  GetPrivateProfileString('border', 'visible', p, PWideChar(buf), BUF_SIZE, ffn);
  border.visible := StrToBool(PWideChar(buf));
  p := PWideChar(IntToStr(border.left));
  GetPrivateProfileString('border', 'left', p, PWideChar(buf), BUF_SIZE, ffn);
  border.left := StrToInt(PWideChar(buf));
  p := PWideChar(IntToStr(border.right));
  GetPrivateProfileString('border', 'right', p, PWideChar(buf), BUF_SIZE, ffn);
  border.right := StrToInt(PWideChar(buf));
  p := PWideChar(IntToStr(border.top));
  GetPrivateProfileString('border', 'top', p, PWideChar(buf), BUF_SIZE, ffn);
  border.top := StrToInt(PWideChar(buf));
  p := PWideChar(IntToStr(border.bottom));
  GetPrivateProfileString('border', 'bottom', p, PWideChar(buf), BUF_SIZE, ffn);
  border.bottom := StrToInt(PWideChar(buf));

  p := PWideChar(BoolToStr(table.visible, True));
  GetPrivateProfileString('table', 'visible', p, PWideChar(buf), BUF_SIZE, ffn);
  table.visible := StrToBool(PWideChar(buf));
  p := PWideChar(IntToStr(table.sheetNum));
  GetPrivateProfileString('table', 'sheetNum', p, PWideChar(buf), BUF_SIZE, ffn);
  table.sheetNum := StrToInt(PWideChar(buf));
  p := PWideChar(table.docNum);
  GetPrivateProfileString('table', 'docNum', p, PWideChar(buf), BUF_SIZE, ffn);
  table.docNum := Copy(PWideChar(buf), 1, Length(PWideChar(buf)));

  p := PWideChar(figName.name);
  GetPrivateProfileString('figName', 'name', p, PWideChar(buf), BUF_SIZE, ffn);
  figName.name := Copy(PWideChar(buf), 1, Length(PWideChar(buf)));
  p := PWideChar(IntToStr(figName.vPos));
  GetPrivateProfileString('figName', 'vPos', p, PWideChar(buf), BUF_SIZE, ffn);
  figName.vPos := StrToInt(PWideChar(buf));

  p := PWideChar(BoolToStr(legend.visible, True));
  GetPrivateProfileString('legend', 'visible', p, PWideChar(buf), BUF_SIZE, ffn);
  legend.visible := StrToBool(PWideChar(buf));
  p := PWideChar(IntToStr(legend.left));
  GetPrivateProfileString('legend', 'left', p, PWideChar(buf), BUF_SIZE, ffn);
  legend.left := StrToInt(PWideChar(buf));
  p := PWideChar(IntToStr(legend.bottom));
  GetPrivateProfileString('legend', 'bottom', p, PWideChar(buf), BUF_SIZE, ffn);
  legend.bottom := StrToInt(PWideChar(buf));

  p := PWideChar(IntToStr(grid.width));
  GetPrivateProfileString('grid', 'width', p, PWideChar(buf), BUF_SIZE, ffn);
  grid.width := StrToInt(PWideChar(buf));
  p := PWideChar(IntToStr(grid.height));
  GetPrivateProfileString('grid', 'height', p, PWideChar(buf), BUF_SIZE, ffn);
  grid.height := StrToInt(PWideChar(buf));
  p := PWideChar(IntToStr(grid.xUnits));
  GetPrivateProfileString('grid', 'xUnits', p, PWideChar(buf), BUF_SIZE, ffn);
  grid.xUnits := StrToInt(PWideChar(buf));
  p := PWideChar(IntToStr(grid.yUnits));
  GetPrivateProfileString('grid', 'yUnits', p, PWideChar(buf), BUF_SIZE, ffn);
  grid.yUnits := StrToInt(PWideChar(buf));
  p := PWideChar(IntToStr(grid.left));
  GetPrivateProfileString('grid', 'left', p, PWideChar(buf), BUF_SIZE, ffn);
  grid.left := StrToInt(PWideChar(buf));
  p := PWideChar(IntToStr(grid.bottom));
  GetPrivateProfileString('grid', 'bottom', p, PWideChar(buf), BUF_SIZE, ffn);
  grid.bottom := StrToInt(PWideChar(buf));
  p := PWideChar(IntToStr(grid.line.color));
  GetPrivateProfileString('grid', 'lineColor', p, PWideChar(buf), BUF_SIZE, ffn);
  grid.line.color := StrToInt(PWideChar(buf));
  p := PWideChar(IntToStr(grid.line.width));
  GetPrivateProfileString('grid', 'lineWidth', p, PWideChar(buf), BUF_SIZE, ffn);
  grid.line.width := StrToInt(PWideChar(buf));

  p := PWideChar(xAxis.name);
  GetPrivateProfileString('xAxis', 'name', p, PWideChar(buf), BUF_SIZE, ffn);
  xAxis.name := Copy(PWideChar(buf), 1, Length(PWideChar(buf)));
  p := PWideChar(FloatToStr(xAxis.min));
  GetPrivateProfileString('xAxis', 'min', p, PWideChar(buf), BUF_SIZE, ffn);
  xAxis.min := StrToFloat(PWideChar(buf));
  p := PWideChar(FloatToStr(xAxis.max));
  GetPrivateProfileString('xAxis', 'max', p, PWideChar(buf), BUF_SIZE, ffn);
  xAxis.max := StrToFloat(PWideChar(buf));
  p := PWideChar(IntToStr(xAxis.gap));
  GetPrivateProfileString('xAxis', 'gap', p, PWideChar(buf), BUF_SIZE, ffn);
  xAxis.gap := StrToInt(PWideChar(buf));
  p := PWideChar(IntToStr(xAxis.lineColor));
  GetPrivateProfileString('xAxis', 'lineColor', p, PWideChar(buf), BUF_SIZE, ffn);
  xAxis.lineColor := StrToInt(PWideChar(buf));
  p := PWideChar(IntToStr(xAxis.lineWidth));
  GetPrivateProfileString('xAxis', 'lineWidth', p, PWideChar(buf), BUF_SIZE, ffn);
  xAxis.lineWidth := StrToInt(PWideChar(buf));
  xAxis.units := grid.xUnits;

  yAxis.Clear;
  p := PWideChar('0');
  GetPrivateProfileString('yAxis', 'count', p, PWideChar(buf), BUF_SIZE, ffn);
  yAxisCount := StrToInt(PWideChar(buf));
  for i := 1 to yAxisCount do
  begin
    New(axis);
    axis^ := TYAxis.Create;
    p := PWideChar(axis^.name);
    GetPrivateProfileString('yAxis', PWideChar('name_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    axis^.name := Copy(PWideChar(buf), 1, Length(PWideChar(buf)));
    p := PWideChar(FloatToStr(axis^.min));
    GetPrivateProfileString('yAxis', PWideChar('min_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    axis^.min := StrToFloat(PWideChar(buf));
    p := PWideChar(FloatToStr(axis^.max));
    GetPrivateProfileString('yAxis', PWideChar('max_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    axis^.max := StrToFloat(PWideChar(buf));
    p := PWideChar(IntToStr(axis^.units));
    GetPrivateProfileString('yAxis', PWideChar('units_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    axis.units := StrToInt(PWideChar(buf));
    p := PWideChar(IntToStr(axis^.gap));
    GetPrivateProfileString('yAxis', PWideChar('gap_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    axis^.gap := StrToInt(PWideChar(buf));
    p := PWideChar(IntToStr(axis^.indent));
    GetPrivateProfileString('yAxis', PWideChar('indent_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    axis^.indent := StrToInt(PWideChar(buf));
    p := PWideChar(IntToStr(Integer(axis^.side)));
    GetPrivateProfileString('yAxis', PWideChar('side_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    axis^.side := TYAxisSide(StrToInt(PWideChar(buf)));
    p := PWideChar(IntToStr(axis^.lineColor));
    GetPrivateProfileString('yAxis', PWideChar('lineColor_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    axis^.lineColor := StrToInt(PWideChar(buf));
    p := PWideChar(IntToStr(axis^.lineWidth));
    GetPrivateProfileString('yAxis', PWideChar('lineWidth_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    axis^.lineWidth := StrToInt(PWideChar(buf));
    yAxis.AddAxis(axis^);
  end;

  groups.ClearList;
  p := PWideChar(IntToStr(groupsCount));
  GetPrivateProfileString('groups', 'count', p, PWideChar(buf), BUF_SIZE, ffn);
  groupsCount := StrToInt(PWideChar(buf));
  grp := TGraphGroup.Create;
  for i := 1 to groupsCount do
  begin
    p := PWideChar(grp.name);
    GetPrivateProfileString('groups', PWideChar('name_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    grp.name := Copy(PWideChar(buf), 1, Length(PWideChar(buf)));
    p := PWideChar(BoolToStr(grp.visible, True));
    GetPrivateProfileString('groups', PWideChar('visible_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    grp.visible := StrToBool(PWideChar(buf));
    p := PWideChar(FloatToStr(grp.noteXPos));
    GetPrivateProfileString('groups', PWideChar('noteXPos_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    grp.noteXPos := StrToFloat(PWideChar(buf));
    p := PWideChar(IntToStr(Integer(grp.marker)));
    GetPrivateProfileString('groups', PWideChar('marker_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    grp.marker := TGraphMarker(StrToInt(PWideChar(buf)));
    p := PWideChar(IntToStr(grp.line.color));
    GetPrivateProfileString('groups', PWideChar('lineColor_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    grp.line.color := StrToInt(PWideChar(buf));
    p := PWideChar(IntToStr(grp.line.width));
    GetPrivateProfileString('groups', PWideChar('lineWidth_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    grp.line.width := StrToInt(PWideChar(buf));
    p := PWideChar(grp.graphs.DelimitedText);
    GetPrivateProfileString('groups', PWideChar('graphs_' + IntToStr(i)), p, PWideChar(buf), BUF_SIZE, ffn);
    gr := '';
    grp.graphs.Clear;
    j := 0;
    while True do
    begin
      if (buf[j] = ',') or (buf[j] = #0) then
      begin
        grp.graphs.Add(gr);
        gr := '';
      end else gr := gr + buf[j];
      if buf[j] = #0 then Break;
      j := j + 1;
    end;
    groups.AddGroup(grp);
  end;

  buf := nil;
end;

////////////////////////////////////////////////
// load plot configuration from existing file //
////////////////////////////////////////////////
procedure TPlotConfig.LoadPlotFromFileGRNOS(fullFileName: string);
var
  f: TextFile;
  i, a, b, yAxisCount: Integer;
  c: Real;
  s: String;
  axis: ^TYAxis;
begin
  AssignFile(f, fullFileName);
  Reset(f);
  ReadLn(f, s);
  if s <> '‘¿…À, Œœ»—€¬¿ﬁŸ»… –»—”ÕŒ ' then
  begin
    raise Exception.Create('This file is not valid GRNOS image file.');
    Exit;
  end;
  // read figure name
  ReadLn(f); // skip line 'œŒƒœ»—‹ –»—”Õ ¿:'
  ReadLn(f, Self.figName.name);
  ReadLn(f, s);
  Self.figName.name := Self.figName.name + ' ' + s;
  // read fig. name's vertical position
  ReadLn(f, Self.figName.vPos);
  ReadLn(f); // // skip line '–¿Ã ¿:'
  // read border visibility
  ReadLn(f, s);
  Self.border.visible := (s[1] = 'ƒ');
  // read grid propesties
  ReadLn(f); // skip line '—≈“ ¿:'
  ReadLn(f, Self.grid.left);
  ReadLn(f, Self.grid.bottom);
  ReadLn(f, Self.grid.width);
  ReadLn(f, Self.grid.height);
  ReadLn(f, b); // grid cell size in mm
  Self.grid.xUnits := Self.grid.width div b;
  Self.grid.yUnits := Self.grid.height div b;
  // read X axis properties
  ReadLn(f); // skip line '’-Œ—‹:'
  ReadLn(f, s);
  a := Pos(' - Ì‡Á‚‡ÌËÂ ÓÒË ’', s);
  if a = 0 then
  begin
    raise Exception.Create('This file is not valid GRNOS image file.');
    Exit;
  end;
  Self.xAxis.name := Copy(s, 1, a - 1);
  ReadLn(f, a);
  Self.xAxis.gap := a;
  ReadLn(f); // skip line with X axis unit's cost (unused)
  ReadLn(f, s);
  a := Pos(' ', s);
  Self.xAxis.min := StrToFloat(Copy(s, 1, a - 1));
  ReadLn(f, s);
  a := Pos(' ', s);
  Self.xAxis.max := StrToFloat(Copy(s, 1, a - 1));
  Self.xAxis.units := Self.grid.xUnits;
  ReadLn(f); // skip unused line
  ReadLn(f); // skip unused line
  Self.xAxis.lineColor := clBlack;
  Self.xAxis.lineWidth := 1;

  // read Y axis properties
  ReadLn(f); // skip line 'Y-Œ—»:'
  ReadLn(f, yAxisCount);
  ReadLn(f); // skip unused line
  yAxis.Clear;
  for i := 1 to yAxisCount do
  begin
    New(axis);
    axis^ := TYAxis.Create;
    ReadLn(f, s);
    a := Pos(': ', s); // define Y axis name
    axis^.name := Copy(s, 1, a - 1);
    Delete(s, 1, a + 1);
    a := Pos('/', s); // define Y axis side
    if Copy(s, 1, a - 1) = 'ÒÎÂ‚‡' then axis^.side := yasLeft else axis^.side := yasRight;
    Delete(s, 1, a + 1);
    a := Pos('/', s); // define Y axis gap
    axis^.gap := StrToInt(Copy(s, 1, a - 1));
    Delete(s, 1, a + 1);
    a := Pos('/', s); // define Y axis indent
    axis^.indent := StrToInt(Copy(s, 1, a - 1)) div b;
    Delete(s, 1, a + 1);
    a := Pos('/', s); // define Y axis cost
    c := StrToReal(Copy(s, 1, a - 1));
    Delete(s, 1, a + 1);
    a := Pos('/', s); // define Y axis min
    axis^.min := StrToReal(Copy(s, 1, a - 1));
    Delete(s, 1, a + 1);
    a := Pos('/', s); // define Y axis max
    axis^.max := StrToReal(Copy(s, 1, a - 1));
    Delete(s, 1, a + 1);
    axis^.units := Round((axis^.max - axis^.min) / c); // define Y axis lenght
    axis^.lineColor := clBlack;
    axis^.lineWidth := 1;
    yAxis.AddAxis(axis^);
  end;
  CloseFile(f);
end;

procedure TPlotConfig.SavePlotToFileAs(fullFileName: string);
var
  p, ffn: PWideChar;
  i: Integer;
begin
  ffn := PWideChar(fullFileName);

  p := PWideChar(IntToStr(width));
  WritePrivateProfileString('plot', 'width', p, ffn);
  p := PWideChar(IntToStr(height));
  WritePrivateProfileString('plot', 'height', p, ffn);

  p := PWideChar(BoolToStr(border.visible, True));
  WritePrivateProfileString('border', 'visible', p, ffn);
  p := PWideChar(IntToStr(border.left));
  WritePrivateProfileString('border', 'left', p, ffn);
  p := PWideChar(IntToStr(border.right));
  WritePrivateProfileString('border', 'right', p, ffn);
  p := PWideChar(IntToStr(border.top));
  WritePrivateProfileString('border', 'top', p, ffn);
  p := PWideChar(IntToStr(border.bottom));
  WritePrivateProfileString('border', 'bottom', p, ffn);

  p := PWideChar(BoolToStr(table.visible, True));
  WritePrivateProfileString('table', 'visible', p, ffn);
  p := PWideChar(IntToStr(table.sheetNum));
  WritePrivateProfileString('table', 'sheetNum', p, ffn);
  p := PWideChar(table.docNum);
  WritePrivateProfileString('table', 'docNum', p, ffn);

  p := PWideChar(figName.name);
  WritePrivateProfileString('figName', 'name', p, ffn);
  p := PWideChar(IntToStr(figName.vPos));
  WritePrivateProfileString('figName', 'vPos', p, ffn);

  p := PWideChar(BoolToStr(legend.visible, True));
  WritePrivateProfileString('legend', 'visible', p, ffn);
  p := PWideChar(IntToStr(legend.left));
  WritePrivateProfileString('legend', 'left', p, ffn);
  p := PWideChar(IntToStr(legend.bottom));
  WritePrivateProfileString('legend', 'bottom', p, ffn);

  p := PWideChar(IntToStr(grid.width));
  WritePrivateProfileString('grid', 'width', p, ffn);
  p := PWideChar(IntToStr(grid.height));
  WritePrivateProfileString('grid', 'height', p, ffn);
  p := PWideChar(IntToStr(grid.xUnits));
  WritePrivateProfileString('grid', 'xUnits', p, ffn);
  p := PWideChar(IntToStr(grid.yUnits));
  WritePrivateProfileString('grid', 'yUnits', p, ffn);
  p := PWideChar(IntToStr(grid.left));
  WritePrivateProfileString('grid', 'left', p, ffn);
  p := PWideChar(IntToStr(grid.bottom));
  WritePrivateProfileString('grid', 'bottom', p, ffn);
  p := PWideChar(IntToStr(grid.line.color));
  WritePrivateProfileString('grid', 'lineColor', p, ffn);
  p := PWideChar(IntToStr(grid.line.width));
  WritePrivateProfileString('grid', 'lineWidth', p, ffn);

  p := PWideChar(xAxis.name);
  WritePrivateProfileString('xAxis', 'name', p, ffn);
  p := PWideChar(FloatToStr(xAxis.min));
  WritePrivateProfileString('xAxis', 'min', p, ffn);
  p := PWideChar(FloatToStr(xAxis.max));
  WritePrivateProfileString('xAxis', 'max', p, ffn);
  p := PWideChar(IntToStr(xAxis.gap));
  WritePrivateProfileString('xAxis', 'gap', p, ffn);
  p := PWideChar(IntToStr(xAxis.lineColor));
  WritePrivateProfileString('xAxis', 'lineColor', p, ffn);
  p := PWideChar(IntToStr(xAxis.lineWidth));
  WritePrivateProfileString('xAxis', 'lineWidth', p, ffn);

  p := PWideChar(IntToStr(yAxis.Count));
  WritePrivateProfileString('yAxis', 'count', p, ffn);
  for i := 1 to yAxis.Count do
  begin
    yAxis.SetActive(i - 1);
    p := PWideChar(yAxis.name);
    WritePrivateProfileString('yAxis', PWideChar('name_' + IntToStr(i)), p, ffn);
    p := PWideChar(FloatToStr(yAxis.min));
    WritePrivateProfileString('yAxis', PWideChar('min_' + IntToStr(i)), p, ffn);
    p := PWideChar(FloatToStr(yAxis.max));
    WritePrivateProfileString('yAxis', PWideChar('max_' + IntToStr(i)), p, ffn);
    p := PWideChar(IntToStr(yAxis.units));
    WritePrivateProfileString('yAxis', PWideChar('units_' + IntToStr(i)), p, ffn);
    p := PWideChar(IntToStr(yAxis.gap));
    WritePrivateProfileString('yAxis', PWideChar('gap_' + IntToStr(i)), p, ffn);
    p := PWideChar(IntToStr(yAxis.indent));
    WritePrivateProfileString('yAxis', PWideChar('indent_' + IntToStr(i)), p, ffn);
    p := PWideChar(IntToStr(Integer(yAxis.side)));
    WritePrivateProfileString('yAxis', PWideChar('side_' + IntToStr(i)), p, ffn);
    p := PWideChar(IntToStr(yAxis.lineColor));
    WritePrivateProfileString('yAxis', PWideChar('lineColor_' + IntToStr(i)), p, ffn);
    p := PWideChar(IntToStr(yAxis.lineWidth));
    WritePrivateProfileString('yAxis', PWideChar('lineWidth_' + IntToStr(i)), p, ffn);
  end;

  p := PWideChar(IntToStr(groups.count));
  WritePrivateProfileString('groups', 'count', p, ffn);
  for i := 1 to groups.count do
  begin
    groups.SetActiveByNumber(i - 1);
    p := PWideChar(groups.name);
    WritePrivateProfileString('groups', PWideChar('name_' + IntToStr(i)), p, ffn);
    p := PWideChar(BoolToStr(groups.visible, True));
    WritePrivateProfileString('groups', PWideChar('visible_' + IntToStr(i)), p, ffn);
    p := PWideChar(FloatToStr(groups.noteXPos));
    WritePrivateProfileString('groups', PWideChar('noteXPos_' + IntToStr(i)), p, ffn);
    p := PWideChar(IntToStr(Integer(groups.marker)));
    WritePrivateProfileString('groups', PWideChar('marker_' + IntToStr(i)), p, ffn);
    p := PWideChar(IntToStr(groups.lineColor));
    WritePrivateProfileString('groups', PWideChar('lineColor_' + IntToStr(i)), p, ffn);
    p := PWideChar(IntToStr(groups.lineWidth));
    WritePrivateProfileString('groups', PWideChar('lineWidth_' + IntToStr(i)), p, ffn);
    p := PWideChar(groups.graphs.DelimitedText);
    if p[0] = ',' then p := p + 1;
    WritePrivateProfileString('groups', PWideChar('graphs_' + IntToStr(i)), p, ffn);
  end;
end;

procedure TPlotConfig.LoadGraphsFromFileGRNOS(fullFileName: string);
var
  f: TextFile;
  graph: TGraph;
  data: TStringList;
  s: String;
  i, j, k: Word;
  vx, vy, v: TRealVector;
begin
  graph := TGraph.Create;
  AssignFile(f, fullFileName);
  Reset(f); // open file for read olny
  ReadLn(f, s);
  data := TStringList.Create;
  while not Eof(f) do
  begin
    // define graph's name and axis
    i := Pos('[', s);
    j := Pos(']', s, i);
    graph.FNote := Trim(Copy(s, 1, i - 1));
    graph.FYAxisName := Trim(Copy(s, 1, j));
    i := Pos('[', s, j);
    if s[i + 1] = 'π' then graph.FGraphType := 0 else graph.FGraphType := 1;
    graph.FN := StrToFloat(Trim(Copy(s, j + 1, i - j - 1)));
    // read all data strings to StringList
    data.Clear;
    ReadLn(f, s);
    while (Pos('[', s) = 0) do
    begin
      data.Add(s);
      if Eof(f) then Break;
      ReadLn(f, s);
    end;
    // s contains header row to next graph now, it's must be save
    j := data.Count;
    SetLength(vx, j);
    SetLength(vy, j);
    for i := 0 to j - 1 do
    begin
      StrToRealVector(data[i], v, k);
      vx[i] := v[0];
      vy[i] := v[1];
      v := nil;
    end;
    graph.SetData(vx, vy, j);
    graphs.AddGraph(graph);
    graphs.SetActive(graphs.count - 1);
    groups.CheckGraphAndAdd(graphs.name);
  end;
  CloseFile(f);
end;

end.
