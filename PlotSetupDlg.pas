unit PlotSetupDlg;

// Author: Artemiy Smekhov
// Created: 17.11.14
// Modifyed: 2.1.15

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms,
  Vcl.StdCtrls, Vcl.ExtCtrls, Buttons, Vcl.Samples.Spin, Vcl.Grids, Vcl.ValEdit,
  Vcl.ComCtrls, PlotConfig, Vcl.Dialogs, Vcl.CheckLst;

type
  TdlgPlotSetup = class(TForm)
    trbWindowOpacity: TTrackBar;
    Label24: TLabel;
    btnApply: TButton;
    btnInsertCharToYAxisName: TButton;
    btnInsertCharToXAxisName: TButton;
    tabGraphs: TTabSheet;
    sgrGraphsList: TStringGrid;
    grpLegend: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    edtLegendLeft: TLabeledEdit;
    edtLegendBottom: TLabeledEdit;
    chkLegendVisible: TCheckBox;
    tabGroups: TTabSheet;
    GroupBox1: TGroupBox;
    clbGraphsInGroup: TCheckListBox;
    pctPageControl: TPageControl;
    tabSheet: TTabSheet;
    grpSheetSize: TGroupBox;
    edtSheetWidth: TLabeledEdit;
    edtSheetHeight: TLabeledEdit;
    grpMargins: TGroupBox;
    edtBorderLeft: TLabeledEdit;
    edtBorderRight: TLabeledEdit;
    edtBorderTop: TLabeledEdit;
    edtBorderBottom: TLabeledEdit;
    grpTable: TGroupBox;
    edtTableSheetNum: TLabeledEdit;
    edtTableDocNum: TLabeledEdit;
    chkBorderVisible: TCheckBox;
    chkTableVisible: TCheckBox;
    tabFigure: TTabSheet;
    grpYAxisList: TGroupBox;
    sgrYAxisList: TStringGrid;
    grpPlotName: TGroupBox;
    edtPlotNameText: TLabeledEdit;
    edtPlotNameVPos: TLabeledEdit;
    dlgColor: TColorDialog;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    pnlBottom: TPanel;
    btnClose: TButton;
    pnlYAxisListButtons: TPanel;
    lblYAxisCount: TLabel;
    btnAddYAxis: TButton;
    btnDelYAxis: TButton;
    pnlProperties: TPanel;
    grpGrid: TGroupBox;
    Label1: TLabel;
    lblMM: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtGridWidth: TLabeledEdit;
    edtGridHeight: TLabeledEdit;
    edtGridXUnits: TLabeledEdit;
    edtGridYUnits: TLabeledEdit;
    edtGridBottom: TLabeledEdit;
    edtGridLeft: TLabeledEdit;
    pnlGridLineColor: TPanel;
    cmbGridLineWidth: TComboBox;
    grpXAxis: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtXAxisMin: TLabeledEdit;
    edtXAxisMax: TLabeledEdit;
    edtXAxisName: TLabeledEdit;
    edtXAxisGap: TLabeledEdit;
    pnlXAxisLineColor: TPanel;
    cmbXAxisLineWidth: TComboBox;
    grpYAxis: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtYAxisMin: TLabeledEdit;
    edtYAxisMax: TLabeledEdit;
    edtYAxisGap: TLabeledEdit;
    pnlYAxisLineColor: TPanel;
    cmbYAxisLineWidth: TComboBox;
    edtYAxisIndent: TLabeledEdit;
    edtYAxisUnits: TLabeledEdit;
    Label23: TLabel;
    cmbYAxisSide: TComboBox;
    lblGraphSeriesIsEmpty: TLabel;
    Panel1: TPanel;
    sgrGroupsList: TStringGrid;
    Panel2: TPanel;
    btnDeselectAllGraphs: TButton;
    btnSelectAllGraphs: TButton;
    Panel3: TPanel;
    grpGroupProperties: TGroupBox;
    lblMarker: TLabel;
    lblLineColor: TLabel;
    lblLineWidth: TLabel;
    Label22: TLabel;
    edtGroupName: TLabeledEdit;
    chkGroupVisible: TCheckBox;
    edtGroupNoteXPos: TLabeledEdit;
    cmbGroupMarker: TComboBox;
    pnlGroupLineColor: TPanel;
    cmbGroupLineWidth: TComboBox;
    btnAddGroup: TButton;
    btnDeleteGroup: TButton;
    edtYAxisName: TComboBox;
    Label27: TLabel;
    procedure trbWindowOpacityChange(Sender: TObject);
    procedure btnInsertCharToYAxisNameClick(Sender: TObject);
    procedure btnInsertCharToXAxisNameClick(Sender: TObject);
    procedure sgrGroupsListDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgrGroupsListClick(Sender: TObject);
    procedure edtGroupNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkGroupVisibleClick(Sender: TObject);
    procedure edtGroupNoteXPosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbGroupMarkerChange(Sender: TObject);
    procedure pnlGroupLineColorClick(Sender: TObject);
    procedure cmbGroupLineWidthChange(Sender: TObject);
    procedure edtLegendLeftExit(Sender: TObject);
    procedure edtLegendBottomExit(Sender: TObject);
    procedure chkLegendVisibleClick(Sender: TObject);
    procedure sgrYAxisListClick(Sender: TObject);
    procedure edtYAxisNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtYAxisMinKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtYAxisMaxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtYAxisUnitsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbYAxisSideChange(Sender: TObject);
    procedure edtYAxisGapKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtYAxisIndentKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbYAxisLineWidthChange(Sender: TObject);
    procedure edtSheetWidthExit(Sender: TObject);
    procedure edtSheetHeightExit(Sender: TObject);
    procedure chkBorderVisibleClick(Sender: TObject);
    procedure edtBorderLeftExit(Sender: TObject);
    procedure edtBorderRightExit(Sender: TObject);
    procedure edtBorderTopExit(Sender: TObject);
    procedure edtBorderBottomExit(Sender: TObject);
    procedure chkTableVisibleClick(Sender: TObject);
    procedure edtTableSheetNumExit(Sender: TObject);
    procedure edtTableDocNumExit(Sender: TObject);
    procedure edtPlotNameTextExit(Sender: TObject);
    procedure edtPlotNameVPosExit(Sender: TObject);
    procedure edtGridWidthExit(Sender: TObject);
    procedure edtGridHeightExit(Sender: TObject);
    procedure edtGridXUnitsExit(Sender: TObject);
    procedure edtGridYUnitsExit(Sender: TObject);
    procedure edtGridLeftExit(Sender: TObject);
    procedure edtGridBottomExit(Sender: TObject);
    procedure cmbGridLineWidthChange(Sender: TObject);
    procedure edtXAxisNameExit(Sender: TObject);
    procedure edtXAxisMinExit(Sender: TObject);
    procedure edtXAxisMaxExit(Sender: TObject);
    procedure edtXAxisGapExit(Sender: TObject);
    procedure cmbXAxisLineWidthChange(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnAddYAxisClick(Sender: TObject);
    procedure btnDelYAxisClick(Sender: TObject);
    procedure sgrYAxisListDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure pnlGridLineColorClick(Sender: TObject);
    procedure pnlXAxisLineColorClick(Sender: TObject);
    procedure pnlYAxisLineColorClick(Sender: TObject);
    procedure btnAddGroupClick(Sender: TObject);
    procedure clbGraphsInGroupClickCheck(Sender: TObject);
    procedure btnDeleteGroupClick(Sender: TObject);

  public
    function OpenDialog(const plot: TPlotConfig): Boolean;

  private
    tmpPlot, srcPlot: TPlotConfig;
    procedure UpdateYAxisList;
    procedure UpdateGraphsList;
    procedure UpdateGroupsList;
  end;

implementation

{$R *.dfm}

uses
  ViewForm, Utilities, CharactersDlg, Graphics, Axises, GraphGroups;

const
  AX_COL_NME = 0;
  AX_COL_MIN = 1;
  AX_COL_MAX = 2;
  AX_COL_GAP = 3;
  AX_COL_IND = 4;
  AX_COL_UNT = 5;
  AX_COL_SDE = 6;
  AX_COL_CLR = 7;
  AX_COL_WDT = 8;

  GR_COL_NUM = 0;
  GR_COL_NME = 1;
  GR_COL_NTE = 2;
  GR_COL_AXS = 3;
  GR_COL_GRP = 4;
  GR_COL_SPD = 5;
  GR_COL_TYP = 6;
  GR_COL_RNG = 7;

  GP_COL_NUM = 0;
  GP_COL_NME = 1;
  GP_COL_VSB = 2;
  GP_COL_NTP = 3;
  GP_COL_MRK = 4;
  GP_COL_CLR = 5;
  GP_COL_WDT = 6;

  MAX_SHEET_WIDTH = 500;
  MIN_SHEET_WIDTH = 100;
  MAX_SHEET_HEIGHT = 500;
  MIN_SHEET_HEIGHT = 100;
  MIN_GRID_WIDTH = 30;
  MIN_GRID_HEIGHT = 30;
  MAX_GRID_X_UNITS = 50;
  MAX_GRID_Y_UNITS = 50;

var
  OK: Boolean = False;

/////////////////////////////////////
// fill window with initial values //
/////////////////////////////////////
procedure TdlgPlotSetup.FormActivate(Sender: TObject);
var
  i: Integer;
begin
  // Sheet tab
  edtSheetWidth.Text := IntToStr(tmpPlot.width);
  edtSheetHeight.Text := IntToStr(tmpPlot.height);
  chkBorderVisible.Checked := tmpPlot.border.visible;
  edtBorderLeft.Text := IntToStr(tmpPlot.border.Left);
  edtBorderTop.Text := IntToStr(tmpPlot.border.Top);
  edtBorderRight.Text := IntToStr(tmpPlot.border.Right);
  edtBorderBottom.Text := IntToStr(tmpPlot.border.Bottom);
  chkTableVisible.Checked := tmpPlot.table.visible;
  edtTableSheetNum.Text := IntToStr(tmpPlot.table.sheetNum);
  edtTableDocNum.Text := tmpPlot.table.docNum;
  edtPlotNameText.Text := tmpPlot.figName.name;
  edtPlotNameVPos.Text := IntToStr(tmpPlot.figName.vPos);
  chkLegendVisible.Checked := tmpPlot.legend.visible;
  edtLegendLeft.Text := IntToStr(tmpPlot.legend.left);
  edtLegendBottom.Text := IntToStr(tmpPlot.legend.bottom);
  // Figure tab
  edtGridWidth.Text := IntToStr(tmpPlot.grid.width);
  edtGridHeight.Text := IntToStr(tmpPlot.grid.height);
  edtGridXUnits.Text := IntToStr(tmpPlot.grid.xUnits);
  edtGridYUnits.Text := IntToStr(tmpPlot.grid.yUnits);
  edtGridLeft.Text := IntToStr(tmpPlot.grid.left);
  edtGridBottom.Text := IntToStr(tmpPlot.grid.bottom);
  pnlGridLineColor.Color := tmpPlot.grid.line.color;
  cmbGridLineWidth.ItemIndex := tmpPlot.grid.line.width - 1;
  edtXAxisName.Text := tmpPlot.xAxis.name;
  edtXAxisMin.Text := FloatToStr(tmpPlot.xAxis.min);
  edtXAxisMax.Text := FloatToStr(tmpPlot.xAxis.max);
  edtXAxisGap.Text := IntToStr(tmpPlot.xAxis.gap);
  pnlXAxisLineColor.Color := tmpPlot.xAxis.lineColor;
  cmbXAxisLineWidth.ItemIndex := tmpPlot.xAxis.lineWidth - 1;
  tmpPlot.yAxis.SetActive(0);
  edtYAxisName.Items.Clear;
  for i := 0 to tmpPlot.graphs.count - 1 do
  begin
    tmpPlot.graphs.SetActive(i);
    if edtYAxisName.Items.IndexOf(tmpPlot.graphs.yAxisName) < 0 then
      edtYAxisName.Items.Add(tmpPlot.graphs.yAxisName);
  end;
  edtYAxisName.Text := tmpPlot.yAxis.name;
  edtYAxisMin.Text := FloatToStr(tmpPlot.yAxis.min);
  edtYAxisMax.Text := FloatToStr(tmpPlot.yAxis.max);
  edtYAxisUnits.Text := IntToStr(tmpPlot.yAxis.units);
  cmbYAxisSide.ItemIndex := Integer(tmpPlot.yAxis.side);
  edtYAxisGap.Text := IntToStr(tmpPlot.yAxis.gap);
  edtYAxisIndent.Text := IntToStr(tmpPlot.yAxis.indent);
  pnlYAxisLineColor.Color := tmpPlot.yAxis.lineColor;
  cmbYAxisLineWidth.ItemIndex := tmpPlot.yAxis.lineWidth - 1;
  sgrYAxisList.Cells[AX_COL_NME, 0] := 'Название';
  sgrYAxisList.Cells[AX_COL_MIN, 0] := 'Минимум';
  sgrYAxisList.Cells[AX_COL_MAX, 0] := 'Максимум';
  sgrYAxisList.Cells[AX_COL_GAP, 0] := 'Отступ';
  sgrYAxisList.Cells[AX_COL_IND, 0] := 'Смещение';
  sgrYAxisList.Cells[AX_COL_UNT, 0] := 'Длина';
  sgrYAxisList.Cells[AX_COL_SDE, 0] := 'Положение';
  sgrYAxisList.Cells[AX_COL_CLR, 0] := 'Цвет линии';
  sgrYAxisList.Cells[AX_COL_WDT, 0] := 'Толщина линии';
  UpdateYAxisList;
  // Graphs tab
  sgrGraphsList.Cells[GR_COL_NUM, 0] := '№';
  sgrGraphsList.Cells[GR_COL_NME, 0] := 'Название';
  sgrGraphsList.Cells[GR_COL_NTE, 0] := 'Подпись';
  sgrGraphsList.Cells[GR_COL_AXS, 0] := 'Ось';
  sgrGraphsList.Cells[GR_COL_GRP, 0] := 'Группа';
  sgrGraphsList.Cells[GR_COL_SPD, 0] := 'Частота НХ';
  sgrGraphsList.Cells[GR_COL_TYP, 0] := 'Тип';
  sgrGraphsList.Cells[GR_COL_RNG, 0] := 'Диапазоны';
  UpdateGraphsList;
  // Groups tab
  sgrGroupsList.Cells[GP_COL_NUM, 0] := '№';
  sgrGroupsList.Cells[GP_COL_NME, 0] := 'Название';
  sgrGroupsList.Cells[GP_COL_VSB, 0] := 'Видимость';
  sgrGroupsList.Cells[GP_COL_NTP, 0] := 'Позиция подписи';
  sgrGroupsList.Cells[GP_COL_MRK, 0] := 'Маркер';
  sgrGroupsList.Cells[GP_COL_CLR, 0] := 'Цвет линии';
  sgrGroupsList.Cells[GP_COL_WDT, 0] := 'Толщина линии';
  for i := 0 to PC_MARKERS_CNT - 1 do
    cmbGroupMarker.Items.Add(GRAPH_MARKER_STR[TGraphMarker(i)]);
  cmbGroupMarker.ItemIndex := 0;
  for i := 1 to PC_LINE_WIDTH_CNT do cmbGroupLineWidth.Items.Add(PC_LINE_WIDTH_STR[i]);
  cmbGroupLineWidth.ItemIndex := 0;
  UpdateGroupsList;
end;

//////////////////////////////////////////////////////////
// show only controls that are on visible part of table //
//////////////////////////////////////////////////////////
procedure TdlgPlotSetup.sgrYAxisListDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (ARow > 0) and (ARow <= PC_MAX_Y_AXIS_CNT) and (ACol = AX_COL_CLR) then
  begin
    tmpPlot.yAxis.SetActive(ARow - 1);
    sgrYAxisList.Canvas.Brush.Color := tmpPlot.yAxis.lineColor;
    sgrYAxisList.Canvas.Rectangle(Rect);
    sgrYAxisList.Canvas.Brush.Color := clWhite;
  end;
  inherited;
end;

///////////////////////////
// change window opacity //
///////////////////////////
procedure TdlgPlotSetup.trbWindowOpacityChange(Sender: TObject);
begin
  Self.AlphaBlendValue := trbWindowOpacity.Position;
end;

{--------------------------------[ SHEET ]-------------------------------------}

procedure TdlgPlotSetup.edtSheetWidthExit(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(edtSheetWidth.Text);
  if i > MAX_SHEET_WIDTH then
  begin
    ShowMessage('Ширина листа не может быть больше ' + IntToStr(MAX_SHEET_WIDTH) + 'мм.');
    edtSheetWidth.Text := IntToStr(tmpPlot.width);
    edtSheetWidth.SetFocus;
  end else
  if i < MIN_SHEET_WIDTH then
  begin
    ShowMessage('Ширина листа не может быть меньше ' + IntToStr(MIN_SHEET_WIDTH) + 'мм.');
    edtSheetWidth.Text := IntToStr(tmpPlot.width);
    edtSheetWidth.SetFocus;
  end else tmpPlot.width := i;
end;

procedure TdlgPlotSetup.edtSheetHeightExit(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(edtSheetHeight.Text);
  if i > MAX_SHEET_HEIGHT then
  begin
    ShowMessage('Высота листа не может быть больше ' + IntToStr(MAX_SHEET_HEIGHT) + 'мм.');
    edtSheetHeight.Text := IntToStr(tmpPlot.height);
    edtSheetHeight.SetFocus;
  end else
  if i < MIN_SHEET_HEIGHT then
  begin
    ShowMessage('Высота листа не может быть меньше ' + IntToStr(MIN_SHEET_HEIGHT) + 'мм.');
    edtSheetHeight.Text := IntToStr(tmpPlot.height);
    edtSheetHeight.SetFocus;
  end else tmpPlot.height := i;
end;

procedure TdlgPlotSetup.chkBorderVisibleClick(Sender: TObject);
begin
  tmpPlot.border.visible := chkBorderVisible.Checked;
end;

procedure TdlgPlotSetup.edtBorderLeftExit(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(edtBorderLeft.Text);
  if i >= tmpPlot.width then
  begin
    ShowMessage('Левый отступ слишком велик.');
    edtBorderLeft.Text := IntToStr(tmpPlot.border.left);
    edtBorderLeft.SetFocus;
  end else tmpPlot.border.left := i;
end;

procedure TdlgPlotSetup.edtBorderRightExit(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(edtBorderRight.Text);
  if i >= tmpPlot.width - tmpPlot.border.left then
  begin
    ShowMessage('Правый отступ слишком велик.');
    edtBorderRight.Text := IntToStr(tmpPlot.border.right);
    edtBorderRight.SetFocus;
  end else tmpPlot.border.right := i;
end;

procedure TdlgPlotSetup.edtBorderTopExit(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(edtBorderTop.Text);
  if i >= tmpPlot.height then
  begin
    ShowMessage('Верхний отступ слишком велик.');
    edtBorderTop.Text := IntToStr(tmpPlot.border.top);
    edtBorderTop.SetFocus;
  end else tmpPlot.border.top := i;
end;

procedure TdlgPlotSetup.edtBorderBottomExit(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(edtBorderBottom.Text);
  if i >= tmpPlot.height - tmpPlot.border.top then
  begin
    ShowMessage('Нижний отступ слишком велик.');
    edtBorderBottom.Text := IntToStr(tmpPlot.border.bottom);
    edtBorderBottom.SetFocus;
  end else tmpPlot.border.bottom := i;
end;

procedure TdlgPlotSetup.chkTableVisibleClick(Sender: TObject);
begin
  tmpPlot.table.visible := chkTableVisible.Checked;
end;

procedure TdlgPlotSetup.edtTableSheetNumExit(Sender: TObject);
begin
  tmpPlot.table.sheetNum := StrToInt(edtTableSheetNum.Text);
end;

procedure TdlgPlotSetup.edtTableDocNumExit(Sender: TObject);
begin
  tmpPlot.table.docNum := edtTableDocNum.Text;
end;

procedure TdlgPlotSetup.edtPlotNameTextExit(Sender: TObject);
begin
  tmpPlot.figName.name := edtPlotNameText.Text;
end;

procedure TdlgPlotSetup.edtPlotNameVPosExit(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(edtPlotNameVPos.Text);
  if i >= tmpPlot.height - tmpPlot.border.top - tmpPlot.border.bottom then
  begin
    ShowMessage('Отступ подписи слишком велик.');
    edtPlotNameVPos.Text := IntToStr(tmpPlot.figName.vPos);
    edtPlotNameVPos.SetFocus;
  end else tmpPlot.figName.vPos := i;
end;

//////////////////////////////
// change legend visibility //
//////////////////////////////
procedure TdlgPlotSetup.chkLegendVisibleClick(Sender: TObject);
begin
  tmpPlot.legend.visible := chkLegendVisible.Checked;
end;

///////////////////////////////////////
// change legend horizontal position //
///////////////////////////////////////
procedure TdlgPlotSetup.edtLegendLeftExit(Sender: TObject);
begin
  if IsIntegerNumber(edtLegendLeft.Text) = False then Exit;
  tmpPlot.legend.left := StrToInt(edtLegendLeft.Text);
end;

/////////////////////////////////////
// change legend vertical position //
/////////////////////////////////////
procedure TdlgPlotSetup.edtLegendBottomExit(Sender: TObject);
begin
  if IsIntegerNumber(edtLegendBottom.Text) = False then Exit;
  tmpPlot.legend.bottom := StrToInt(edtLegendBottom.Text);
end;

{-------------------------------[ FIGURE ]-------------------------------------}

procedure TdlgPlotSetup.edtGridWidthExit(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(edtGridWidth.Text);
  if i >= tmpPlot.width - tmpPlot.border.left - tmpPlot.border.right then
  begin
    ShowMessage('Ширина сетки слишком велика.');
    edtGridWidth.Text := IntToStr(tmpPlot.grid.width);
    edtGridWidth.SetFocus;
  end else
  if i < MIN_GRID_WIDTH then
  begin
    ShowMessage('Ширина сетки не может быть меньше ' + IntToStr(MIN_GRID_WIDTH) + 'мм.');
    edtGridWidth.Text := IntToStr(tmpPlot.grid.width);
    edtGridWidth.SetFocus;
  end else tmpPlot.grid.width := i;
end;

procedure TdlgPlotSetup.edtGridHeightExit(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(edtGridHeight.Text);
  if i > tmpPlot.height then
  begin
    ShowMessage('Высота сетки слишком велика.');
    edtGridHeight.Text := IntToStr(tmpPlot.grid.height);
    edtGridHeight.SetFocus;
  end else
  if i < MIN_GRID_HEIGHT then
  begin
    ShowMessage('Высота сетки не может быть меньше ' + IntToStr(MIN_GRID_HEIGHT) + 'мм.');
    edtGridHeight.Text := IntToStr(tmpPlot.grid.height);
    edtGridHeight.SetFocus;
  end else tmpPlot.grid.height := i;
end;

procedure TdlgPlotSetup.edtGridXUnitsExit(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(edtGridXUnits.Text);
  if i > MAX_GRID_X_UNITS then
  begin
    ShowMessage('Количество делений сетки по оси X не может быть больше ' + IntToStr(MAX_GRID_X_UNITS) + '.');
    edtGridXUnits.Text := IntToStr(tmpPlot.grid.xUnits);
    edtGridXUnits.SetFocus;
  end else
  if i < 1 then
  begin
    ShowMessage('Количество делений сетки по оси X не может быть меньше 1.');
    edtGridXUnits.Text := IntToStr(tmpPlot.grid.xUnits);
    edtGridXUnits.SetFocus;
  end else
  begin
    tmpPlot.grid.xUnits := i;
    tmpPlot.xAxis.units := i;
  end;
end;

procedure TdlgPlotSetup.edtGridYUnitsExit(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(edtGridYUnits.Text);
  if i > MAX_GRID_Y_UNITS then
  begin
    ShowMessage('Количество делений сетки по оси Y не может быть больше ' + IntToStr(MAX_GRID_Y_UNITS) + '.');
    edtGridYUnits.Text := IntToStr(tmpPlot.grid.yUnits);
    edtGridYUnits.SetFocus;
  end else
  if i < 1 then
  begin
    ShowMessage('Количество делений сетки по оси Y не может быть меньше 1.');
    edtGridYUnits.Text := IntToStr(tmpPlot.grid.yUnits);
    edtGridYUnits.SetFocus;
  end else tmpPlot.grid.yUnits := i;
end;

procedure TdlgPlotSetup.edtGridLeftExit(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(edtGridLeft.Text);
  if i >= tmpPlot.width - tmpPlot.border.right - tmpPlot.border.left - tmpPlot.grid.width then
  begin
    ShowMessage('Горизонтальное смещение сетки слишком велико.');
    edtGridLeft.Text := IntToStr(tmpPlot.grid.left);
    edtGridLeft.SetFocus;
  end else tmpPlot.grid.left := i;
end;

procedure TdlgPlotSetup.edtGridBottomExit(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(edtGridBottom.Text);
  if i >= tmpPlot.height - tmpPlot.border.top - tmpPlot.border.bottom - tmpPlot.grid.height then
  begin
    ShowMessage('Вертикальное смещение сетки слишком велико.');
    edtGridBottom.Text := IntToStr(tmpPlot.grid.bottom);
    edtGridBottom.SetFocus;
  end else tmpPlot.grid.bottom := i;
end;

///////////////////////////
// grid line color enter //
///////////////////////////
procedure TdlgPlotSetup.pnlGridLineColorClick(Sender: TObject);
begin
  if dlgColor.Execute = True then
  begin
    pnlGridLineColor.Color := dlgColor.Color;
    tmpPlot.grid.line.color := dlgColor.Color;
  end;
end;

procedure TdlgPlotSetup.cmbGridLineWidthChange(Sender: TObject);
begin
  tmpPlot.grid.line.width := cmbGridLineWidth.ItemIndex + 1;
end;

procedure TdlgPlotSetup.edtXAxisNameExit(Sender: TObject);
begin
  if edtXAxisName.Text <> '' then
    tmpPlot.xAxis.name := edtXAxisName.Text else
    ShowMessage('Имя оси не может быть пустым.');
end;

procedure TdlgPlotSetup.btnInsertCharToXAxisNameClick(Sender: TObject);
var
  c: Char;
  dlg: TdlgCharacters;
begin
  dlg := TdlgCharacters.Create(Self);
  c := dlg.GetCharacter;
  edtXAxisName.Text := edtXAxisName.Text + c;
  dlg.Free;
end;

procedure TdlgPlotSetup.edtXAxisMinExit(Sender: TObject);
var
  a: Real;
begin
  if IsRealNumber(edtXAxisMin.Text) = False then
  begin
    ShowMessage('Неверное значение минимума оси X.');
    edtXAxisMin.Text := FloatToStr(tmpPlot.xAxis.min);
    edtXAxisMin.SetFocus;
  end else
  begin
    a := StrToFloat(edtXAxisMin.Text);
    if a >= tmpPlot.xAxis.max then
    begin
      ShowMessage('Значение минимума оси X должно быть меньше максимума.');
      edtXAxisMin.Text := FloatToStr(tmpPlot.xAxis.min);
      edtXAxisMin.SetFocus;
    end else tmpPlot.xAxis.min := a;
  end;
end;

procedure TdlgPlotSetup.edtXAxisMaxExit(Sender: TObject);
var
  a: Real;
begin
  if IsRealNumber(edtXAxisMax.Text) = False then
  begin
    ShowMessage('Неверное значение максимума оси X.');
    edtXAxisMax.Text := FloatToStr(tmpPlot.xAxis.max);
    edtXAxisMax.SetFocus;
  end else
  begin
    a := StrToFloat(edtXAxisMax.Text);
    if a <= tmpPlot.xAxis.min then
    begin
      ShowMessage('Значение максимума оси X должно быть больше минимума.');
      edtXAxisMax.Text := FloatToStr(tmpPlot.xAxis.max);
      edtXAxisMax.SetFocus;
    end else tmpPlot.xAxis.max := a;
  end;
end;

procedure TdlgPlotSetup.edtXAxisGapExit(Sender: TObject);
var
  i: Integer;
begin
  i := StrToInt(edtXAxisGap.Text);
  if i >= tmpPlot.grid.bottom then
  begin
    ShowMessage('Ось X выходит за пределы границ листа.');
    edtXAxisGap.Text := FloatToStr(tmpPlot.xAxis.gap);
    edtXAxisGap.SetFocus;
  end else tmpPlot.xAxis.gap := i;
end;

/////////////////////////////
// X axis line color enter //
/////////////////////////////
procedure TdlgPlotSetup.pnlXAxisLineColorClick(Sender: TObject);
begin
  if dlgColor.Execute = True then
  begin
    pnlXAxisLineColor.Color := dlgColor.Color;
    tmpPlot.xAxis.lineColor := dlgColor.Color;
  end;
end;

procedure TdlgPlotSetup.cmbXAxisLineWidthChange(Sender: TObject);
begin
  tmpPlot.xAxis.lineWidth := cmbXAxisLineWidth.ItemIndex + 1;
end;

procedure TdlgPlotSetup.edtYAxisNameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: Byte;
  r: TGridRect;
begin
  if Key <> VK_RETURN then Exit;
  if edtYAxisName.Text = '' then
  begin
    ShowMessage('Имя оси не может быть пустым.');
    Exit;
  end;
  r := sgrYAxisList.Selection;
  if r.Bottom - r.Top > 1 then
  begin
    ShowMessage('Нельзя задавать одинаковое имя нескольким осям.');
    r.Bottom := r.Top;
    sgrYAxisList.Selection := r;
    edtYAxisName.SetFocus;
    Exit;
  end;
  for i := 1 to tmpPlot.yAxis.Count do
  begin
    tmpPlot.yAxis.SetActive(i - 1);
    if (edtYAxisName.Text = tmpPlot.yAxis.name) and (i <> r.Top) then
    begin
      ShowMessage('Имена осей должны быть уникальными.');
      tmpPlot.yAxis.SetActive(r.Top - 1);
      edtYAxisName.Text := tmpPlot.yAxis.name;
      edtYAxisName.SetFocus;
      Exit;
    end;
  end;
  sgrYAxisList.Cells[AX_COL_NME, r.Top] := edtYAxisName.Text;
  tmpPlot.yAxis.SetActive(r.Top - 1);
  tmpPlot.yAxis.name := edtYAxisName.Text;
end;

procedure TdlgPlotSetup.btnInsertCharToYAxisNameClick(Sender: TObject);
var
  c: Char;
  dlg: TdlgCharacters;
begin
  dlg := TdlgCharacters.Create(Self);
  c := dlg.GetCharacter;
  edtYAxisName.Text := edtYAxisName.Text + c;
  dlg.Free;
end;

procedure TdlgPlotSetup.edtYAxisMinKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: Byte;
begin
  if Key <> VK_RETURN then Exit;
  i := sgrYAxisList.Selection.Top;
  if IsRealNumber(edtYAxisMin.Text) = False then
  begin
    ShowMessage('Неверное значение минимума оси Y.');
    tmpPlot.yAxis.SetActive(i - 1);
    edtYAxisMin.Text := FloatToStr(tmpPlot.yAxis.min);
    edtYAxisMin.SetFocus;
    Exit;
  end;
  for i := sgrYAxisList.Selection.Top to sgrYAxisList.Selection.Bottom do
  begin
    sgrYAxisList.Cells[AX_COL_MIN, i] := edtYAxisMin.Text;
    tmpPlot.yAxis.SetActive(i - 1);
    tmpPlot.yAxis.min := StrToFloat(edtYAxisMin.Text);
  end;
end;

procedure TdlgPlotSetup.edtYAxisMaxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: Byte;
begin
  if Key <> VK_RETURN then Exit;
  i := sgrYAxisList.Selection.Top;
  if IsRealNumber(edtYAxisMax.Text) = False then
  begin
    ShowMessage('Неверное значение максимума оси Y.');
    tmpPlot.yAxis.SetActive(i - 1);
    edtYAxisMax.Text := FloatToStr(tmpPlot.yAxis.max);
    edtYAxisMax.SetFocus;
    Exit;
  end;
  for i := sgrYAxisList.Selection.Top to sgrYAxisList.Selection.Bottom do
  begin
    sgrYAxisList.Cells[AX_COL_MAX, i] := edtYAxisMax.Text;
    tmpPlot.yAxis.SetActive(i - 1);
    tmpPlot.yAxis.max := StrToFloat(edtYAxisMax.Text);
  end;
end;

procedure TdlgPlotSetup.edtYAxisUnitsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: Byte;
  v: Integer;
begin
  if Key <> VK_RETURN then Exit;
  v := StrToInt(edtYAxisUnits.Text);
  i := sgrYAxisList.Selection.Top;
  if v > tmpPlot.grid.yUnits then
  begin
    ShowMessage('Ось Y выходит за пределы сетки.');
    tmpPlot.yAxis.SetActive(i - 1);
    edtYAxisUnits.Text := IntToStr(tmpPlot.yAxis.units);
    edtYAxisUnits.SetFocus;
    Exit;
  end;
  for i := sgrYAxisList.Selection.Top to sgrYAxisList.Selection.Bottom do
  begin
    sgrYAxisList.Cells[AX_COL_UNT, i] := edtYAxisUnits.Text;
    tmpPlot.yAxis.SetActive(i - 1);
    tmpPlot.yAxis.units := v;
  end;
end;

procedure TdlgPlotSetup.cmbYAxisSideChange(Sender: TObject);
var
  i: Byte;
begin
  for i := sgrYAxisList.Selection.Top to sgrYAxisList.Selection.Bottom do
  begin
    sgrYAxisList.Cells[AX_COL_SDE, i] := cmbYAxisSide.Text;
    tmpPlot.yAxis.SetActive(i - 1);
    tmpPlot.yAxis.side := TYAxisSide(cmbYAxisSide.ItemIndex);
  end;
end;

procedure TdlgPlotSetup.edtYAxisGapKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: Byte;
  v: Integer;
begin
  if Key <> VK_RETURN then Exit;
  v := StrToInt(edtYAxisGap.Text);
  i := sgrYAxisList.Selection.Top;
  if v >= tmpPlot.grid.left then
  begin
    ShowMessage('Ось Y выходит за границы листа.');
    tmpPlot.yAxis.SetActive(i - 1);
    edtYAxisGap.Text := IntToStr(tmpPlot.yAxis.gap);
    edtYAxisGap.SetFocus;
    Exit;
  end;
  for i := sgrYAxisList.Selection.Top to sgrYAxisList.Selection.Bottom do
  begin
    sgrYAxisList.Cells[AX_COL_GAP, i] := edtYAxisGap.Text;
    tmpPlot.yAxis.SetActive(i - 1);
    tmpPlot.yAxis.gap := v;
  end;
end;

procedure TdlgPlotSetup.edtYAxisIndentKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: Byte;
  v: Integer;
  r: TGridRect;
begin
  if Key <> VK_RETURN then Exit;
  v := StrToInt(edtYAxisIndent.Text);
  for i := sgrYAxisList.Selection.Top to sgrYAxisList.Selection.Bottom do
  begin
    tmpPlot.yAxis.SetActive(i - 1);
    if v + tmpPlot.yAxis.units > tmpPlot.grid.yUnits then
    begin
      ShowMessage('Ось Y выходит за пределы сетки.');
      edtYAxisIndent.Text := IntToStr(tmpPlot.yAxis.indent);
      edtYAxisIndent.SetFocus;
      r.Top := i;
      r.Bottom := i;
      sgrYAxisList.Selection := r;
      Exit;
    end;
    sgrYAxisList.Cells[AX_COL_IND, i] := edtYAxisIndent.Text;
    tmpPlot.yAxis.indent := v;
  end;
end;

/////////////////////////////
// Y axis line color enter //
/////////////////////////////
procedure TdlgPlotSetup.pnlYAxisLineColorClick(Sender: TObject);
var
  i: Byte;
begin
  if dlgColor.Execute then
  begin
    pnlYAxisLineColor.Color := dlgColor.Color;
    for i := sgrYAxisList.Selection.Top to sgrYAxisList.Selection.Bottom do
    begin
      tmpPlot.yAxis.SetActive(i - 1);
      tmpPlot.yAxis.lineColor := dlgColor.Color;
    end;
  end;
end;

procedure TdlgPlotSetup.cmbYAxisLineWidthChange(Sender: TObject);
var
  i: Byte;
begin
  for i := sgrYAxisList.Selection.Top to sgrYAxisList.Selection.Bottom do
  begin
    sgrYAxisList.Cells[AX_COL_WDT, i] := cmbYAxisLineWidth.Text;
    tmpPlot.yAxis.SetActive(i - 1);
    tmpPlot.yAxis.lineWidth := cmbYAxisLineWidth.ItemIndex + 1;
  end;
end;

procedure TdlgPlotSetup.sgrYAxisListClick(Sender: TObject);
var
  i: Byte;
begin
  if sgrYAxisList.Selection.Bottom - sgrYAxisList.Selection.Top > 1 then Exit;
  i := sgrYAxisList.Selection.Top - 1;
  tmpPlot.yAxis.SetActive(i);
  edtYAxisName.Text := tmpPlot.yAxis.name;
  edtYAxisMin.Text := FloatToStr(tmpPlot.yAxis.min);
  edtYAxisMax.Text := FloatToStr(tmpPlot.yAxis.max);
  edtYAxisUnits.Text := IntToStr(tmpPlot.yAxis.units);
  cmbYAxisSide.ItemIndex := Integer(tmpPlot.yAxis.side);
  edtYAxisGap.Text := IntToStr(tmpPlot.yAxis.gap);
  edtYAxisIndent.Text := IntToStr(tmpPlot.yAxis.indent);
  pnlYAxisLineColor.Color := tmpPlot.yAxis.lineColor;
  cmbYAxisLineWidth.ItemIndex := tmpPlot.yAxis.lineWidth - 1;
end;

////////////////////////
// add Y axis to list //
////////////////////////
procedure TdlgPlotSetup.btnAddYAxisClick(Sender: TObject);
begin
  if tmpPlot.yAxis.Count < PC_MAX_Y_AXIS_CNT then
  begin
    tmpPlot.yAxis.AddDefaultAxis;
    UpdateYAxisList;
  end else ShowMessage('Максимальное количество осей ' + IntToStr(PC_MAX_Y_AXIS_CNT) + '.');
end;

/////////////////////////////
// delete Y axis from list //
/////////////////////////////
procedure TdlgPlotSetup.btnDelYAxisClick(Sender: TObject);
var
  cnt: Integer;
  r: TGridRect;
begin
  r := sgrYAxisList.Selection;
  cnt := r.Bottom - r.Top + 1;
  if cnt < tmpPlot.yAxis.Count then
  begin
    tmpPlot.yAxis.DeleteRange(r.Top - 1, cnt);
    UpdateYAxisList;
  end else ShowMessage('Нельзя удалять все оси.');
end;

///////////////////////////////////////////////
// fill Y axis list table with saving values //
///////////////////////////////////////////////
procedure TdlgPlotSetup.UpdateYAxisList;
var
  i: Byte;
begin
  sgrYAxisList.RowCount := tmpPlot.yAxis.Count + 1;
  for i := 1 to tmpPlot.yAxis.Count do
  begin
    tmpPlot.yAxis.SetActive(i - 1);
    sgrYAxisList.Cells[AX_COL_NME, i] := tmpPlot.yAxis.name;
    sgrYAxisList.Cells[AX_COL_MIN, i] := FloatToStr(tmpPlot.yAxis.min);
    sgrYAxisList.Cells[AX_COL_MAX, i] := FloatToStr(tmpPlot.yAxis.max);
    sgrYAxisList.Cells[AX_COL_GAP, i] := IntToStr(tmpPlot.yAxis.gap);
    sgrYAxisList.Cells[AX_COL_IND, i] := IntToStr(tmpPlot.yAxis.indent);
    sgrYAxisList.Cells[AX_COL_UNT, i] := IntToStr(tmpPlot.yAxis.units);
    sgrYAxisList.Cells[AX_COL_SDE, i] := Y_AXIS_SIDE_STR[tmpPlot.yAxis.side];
    sgrYAxisList.Cells[AX_COL_WDT, i] := PC_LINE_WIDTH_STR[tmpPlot.yAxis.lineWidth];
  end;
  sgrYAxisList.Repaint;
  lblYAxisCount.Caption := 'Количество осей: ' + IntToStr(tmpPlot.yAxis.Count);
end;

{---------------------------------[ GRAPHS ]-----------------------------------}

////////////////////////////
// fill table with values //
////////////////////////////
procedure TdlgPlotSetup.UpdateGraphsList;
var
  i: Integer;
  s: String;
  r: Real;
begin
  clbGraphsInGroup.Clear;
  for i := 0 to tmpPlot.graphs.count - 1 do
  begin
    tmpPlot.graphs.SetActive(i);
    clbGraphsInGroup.Items.Add(tmpPlot.graphs.name);
  end;
  if tmpPlot.graphs.count = 0 then
  begin
    sgrGraphsList.Visible := False;
    lblGraphSeriesIsEmpty.Visible := True;
    Exit;
  end;
  lblGraphSeriesIsEmpty.Visible := False;
  sgrGraphsList.Visible := True;
  sgrGraphsList.RowCount := tmpPlot.graphs.count + 1;
  for i := 1 to tmpPlot.graphs.count do
  begin
    tmpPlot.graphs.SetActive(i - 1);
    sgrGraphsList.Cells[GR_COL_NUM, i] := IntToStr(i);
    sgrGraphsList.Cells[GR_COL_NME, i] := tmpPlot.graphs.name;
    sgrGraphsList.Cells[GR_COL_NTE, i] := tmpPlot.graphs.note;
    sgrGraphsList.Cells[GR_COL_AXS, i] := tmpPlot.graphs.yAxisName;
    tmpPlot.groups.SetActiveByGraphName(tmpPlot.graphs.name);
    sgrGraphsList.Cells[GR_COL_GRP, i] := tmpPlot.groups.name;
    sgrGraphsList.Cells[GR_COL_SPD, i] := FloatToStr(tmpPlot.graphs.N);
    sgrGraphsList.Cells[GR_COL_TYP, i] := PC_GRAPH_TYPE_STR[tmpPlot.graphs.graphType];
    s := 'X=[';
    r := GetMin(tmpPlot.graphs.XI, tmpPlot.graphs.NI);
    s := s + FloatToStrF(r, ffNumber, 7, GetPrec(r)) + ' .. ';
    r := GetMax(tmpPlot.graphs.XI, tmpPlot.graphs.NI);
    s := s + FloatToStrF(r, ffNumber, 7, GetPrec(r)) + ']; Y=[';
    r := GetMin(tmpPlot.graphs.YI, tmpPlot.graphs.NI);
    s := s + FloatToStrF(r, ffNumber, 7, GetPrec(r)) + ' .. ';
    r := GetMax(tmpPlot.graphs.YI, tmpPlot.graphs.NI);
    s := s + FloatToStrF(r, ffNumber, 7, GetPrec(r)) + ']';
    sgrGraphsList.Cells[GR_COL_RNG, i] := s;
  end;
end;

{---------------------------------[ GROUPS ]-----------------------------------}

///////////////////////////////////////////////
// replaces graphs from one group to another //
///////////////////////////////////////////////
procedure TdlgPlotSetup.clbGraphsInGroupClickCheck(Sender: TObject);
var
  r: TGridRect;
  i, j: Integer;
  graphChecked: Boolean;
  graphName: String;
begin
  r := sgrGroupsList.Selection;
  i := r.Top;
  if r.Bottom - i > 1 then Exit;
  tmpPlot.groups.SetActiveByNumber(i - 1);
  for j := 1 to tmpPlot.graphs.count do
  begin
    if j > clbGraphsInGroup.Items.Count then Exit;
    graphName := clbGraphsInGroup.Items[j - 1]; // name of current graph
    if clbGraphsInGroup.Checked[j - 1] then
      tmpPlot.groups.IncludeGraph(graphName) else
      tmpPlot.groups.ExcludeGraph(graphName);
  end;
end;

/////////////////////////////////////////////////////////
// draw cells in Line Color column with selected color //
/////////////////////////////////////////////////////////
procedure TdlgPlotSetup.sgrGroupsListDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (ARow > 0) and (ACol = GP_COL_CLR) then
  begin
    tmpPlot.groups.SetActiveByNumber(ARow - 1);
    sgrGroupsList.Canvas.Brush.Color := tmpPlot.groups.lineColor;
    sgrGroupsList.Canvas.Rectangle(Rect);
    sgrGroupsList.Canvas.Brush.Color := clWhite;
  end;
  inherited;
end;

////////////////////////////////////////
// show properties for selected group //
////////////////////////////////////////
procedure TdlgPlotSetup.sgrGroupsListClick(Sender: TObject);
var
  i: Integer;
begin
  i := sgrGroupsList.Selection.Top;
  if sgrGroupsList.Selection.Bottom - i > 1 then Exit;
  tmpPlot.groups.SetActiveByNumber(i - 1);
  edtGroupName.Text := tmpPlot.groups.name;
  chkGroupVisible.Checked := tmpPlot.groups.visible;
  edtGroupNoteXPos.Text := FloatToStr(tmpPlot.groups.noteXPos);
  cmbGroupMarker.ItemIndex := Integer(tmpPlot.groups.marker);
  pnlGroupLineColor.Color := tmpPlot.groups.lineColor;
  cmbGroupLineWidth.ItemIndex := tmpPlot.groups.lineWidth - 1;
  for i := 0 to clbGraphsInGroup.Items.Count - 1 do
    clbGraphsInGroup.Checked[i] := tmpPlot.groups.IsInGroup(clbGraphsInGroup.Items[i]);
end;

procedure TdlgPlotSetup.btnAddGroupClick(Sender: TObject);
begin
  tmpPlot.groups.AddDefaultGroup;
  UpdateGroupsList;
end;

procedure TdlgPlotSetup.btnDeleteGroupClick(Sender: TObject);
var
  cnt: Integer;
  r: TGridRect;
begin
  r := sgrGroupsList.Selection;
  cnt := r.Bottom - r.Top + 1;
  if cnt < tmpPlot.groups.count then
  begin
    tmpPlot.groups.DeleteRange(r.Top - 1, cnt);
    UpdateGroupsList;
  end else ShowMessage('Нельзя удалять все группы.');
end;

/////////////////////////////////////
// change name for selected graphs //
/////////////////////////////////////
procedure TdlgPlotSetup.edtGroupNameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: Integer;
begin
  if Key <> VK_RETURN then Exit;
  if edtGroupName.Text = '' then
  begin
    ShowMessage('Имя группы не может быть пустым.');
    Exit;
  end;
  for i := sgrGroupsList.Selection.Top to sgrGroupsList.Selection.Bottom do
  begin
    tmpPlot.groups.SetActiveByNumber(i - 1);
    tmpPlot.groups.name := edtGroupName.Text;
    sgrGroupsList.Cells[GP_COL_NME, i] := edtGroupName.Text;
  end;
end;

///////////////////////////////////////////
// change visibility for selected graphs //
///////////////////////////////////////////
procedure TdlgPlotSetup.chkGroupVisibleClick(Sender: TObject);
var
  i: Integer;
begin
  for i := sgrGroupsList.Selection.Top to sgrGroupsList.Selection.Bottom do
  begin
    tmpPlot.groups.SetActiveByNumber(i - 1);
    tmpPlot.groups.visible := chkGroupVisible.Checked;
    sgrGroupsList.Cells[GP_COL_VSB, i] := PC_VISIBLE_STR[chkGroupVisible.Checked];
  end;
end;

//////////////////////////////////////////////
// change name position for selected graphs //
//////////////////////////////////////////////
procedure TdlgPlotSetup.edtGroupNoteXPosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: Integer;
begin
  if Key <> VK_RETURN then Exit;
  i := sgrGroupsList.Selection.Top;
  if IsRealNumber(edtGroupNoteXPos.Text) = False then
  begin
    ShowMessage('Недопустимое значение.');
    tmpPlot.groups.SetActiveByNumber(i - 1);
    edtGroupNoteXPos.Text := FloatToStr(tmpPlot.groups.noteXPos);
    edtGroupNoteXPos.SetFocus;
    Exit;
  end;
  for i := sgrGroupsList.Selection.Top to sgrGroupsList.Selection.Bottom do
  begin
    tmpPlot.groups.SetActiveByNumber(i - 1);
    tmpPlot.groups.noteXPos := StrToFloat(edtGroupNoteXPos.Text);
    sgrGroupsList.Cells[GP_COL_NTP, i] := edtGroupNoteXPos.Text;
  end;
end;

////////////////////////////////////////////
// change marker type for selected graphs //
////////////////////////////////////////////
procedure TdlgPlotSetup.cmbGroupMarkerChange(Sender: TObject);
var
  i: Integer;
begin
  for i := sgrGroupsList.Selection.Top to sgrGroupsList.Selection.Bottom do
  begin
    tmpPlot.groups.SetActiveByNumber(i - 1);
    tmpPlot.groups.marker := TGraphMarker(cmbGroupMarker.ItemIndex);
    sgrGroupsList.Cells[GP_COL_MRK, i] := GRAPH_MARKER_STR[TGraphMarker(cmbGroupMarker.ItemIndex)];
  end;
end;

///////////////////////////////////////////
// change line color for selected graphs //
///////////////////////////////////////////
procedure TdlgPlotSetup.pnlGroupLineColorClick(Sender: TObject);
var
  i: Integer;
begin
  if dlgColor.Execute then
  begin
    pnlGroupLineColor.Color := dlgColor.Color;
    for i := sgrGroupsList.Selection.Top to sgrGroupsList.Selection.Bottom do
    begin
      tmpPlot.groups.SetActiveByNumber(i - 1);
      tmpPlot.groups.lineColor := pnlGroupLineColor.Color;
    end;
  end;
end;

///////////////////////////////////////////
// change line width for selected graphs //
///////////////////////////////////////////
procedure TdlgPlotSetup.cmbGroupLineWidthChange(Sender: TObject);
var
  i: Integer;
begin
  for i := sgrGroupsList.Selection.Top to sgrGroupsList.Selection.Bottom do
  begin
    tmpPlot.groups.SetActiveByNumber(i - 1);
    tmpPlot.groups.lineWidth := cmbGroupLineWidth.ItemIndex + 1;
    sgrGroupsList.Cells[GP_COL_WDT, i] := PC_LINE_WIDTH_STR[cmbGroupLineWidth.ItemIndex + 1];
  end;
end;

procedure TdlgPlotSetup.UpdateGroupsList;
var
  i: Integer;
  r: TGridRect;
begin
  tmpPlot.groups.SetActiveByNumber(0);
  for i := 0 to tmpPlot.graphs.count - 1 do
  begin
    tmpPlot.graphs.SetActive(i);
    if i + 1 <= clbGraphsInGroup.Items.Count then
    begin
      if tmpPlot.groups.graphs.IndexOf(tmpPlot.graphs.name) >= 0 then
        clbGraphsInGroup.Checked[i] := True else
        clbGraphsInGroup.Checked[i] := False;
    end;
  end;
  sgrGroupsList.RowCount := tmpPlot.groups.count + 1;
  for i := 1 to tmpPlot.groups.count do
  begin
    tmpPlot.groups.SetActiveByNumber(i - 1);
    sgrGroupsList.Cells[GP_COL_NUM, i] := IntToStr(i);
    sgrGroupsList.Cells[GP_COL_NME, i] := tmpPlot.groups.name;
    sgrGroupsList.Cells[GP_COL_VSB, i] := PC_VISIBLE_STR[tmpPlot.groups.visible];
    sgrGroupsList.Cells[GP_COL_NTP, i] := FloatToStr(tmpPlot.groups.noteXPos);
    sgrGroupsList.Cells[GP_COL_MRK, i] := GRAPH_MARKER_STR[tmpPlot.groups.marker];
    sgrGroupsList.Cells[GP_COL_WDT, i] := PC_LINE_WIDTH_STR[tmpPlot.groups.lineWidth];
  end;
  r.Top := 1;
  r.Bottom := 1;
  sgrGroupsList.Selection := r;
end;

//////////////////////////
// Apply button pressed //
//////////////////////////
procedure TdlgPlotSetup.btnApplyClick(Sender: TObject);
begin
  srcPlot.CopyPlotConfig(tmpPlot);
  (Self.Owner as TwndViewForm).UpdateView;
  OK := True;
end;

//////////////////////////
// Close button pressed //
//////////////////////////
procedure TdlgPlotSetup.btnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

////////////////////////
// show dialog window //
////////////////////////
function TdlgPlotSetup.OpenDialog(const plot: TPlotConfig): Boolean;
begin
  tmpPlot := TPlotConfig.Create;
  tmpPlot.CopyPlotConfig(plot);
  srcPlot := plot;
  Self.ShowModal();
  Result := OK;
end;

end.
