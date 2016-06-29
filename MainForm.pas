unit MainForm;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, ViewForm, Vcl.Controls, Vcl.Tabs, Vcl.DockTabSet;

type
  TwndMainForm = class(TForm)
    mmAbout: TMenuItem;
    mmMainMenu: TMainMenu;
    mmFile: TMenuItem;
    mmFilePlot: TMenuItem;
    mmFilePlotCreate: TMenuItem;
    mmFilePlotLoad: TMenuItem;
    mmFilePlotLoadFromFile: TMenuItem;
    mmFilePlotLoadFromWorkspace: TMenuItem;
    mmFilePlotSave: TMenuItem;
    mmFilePlotSaveAs: TMenuItem;
    mmFileGraphs: TMenuItem;
    mmFileGraphsLoadFromFile: TMenuItem;
    mmFileGraphsLoadFromWorkspace: TMenuItem;
    mmFileExit: TMenuItem;
    mmSetup: TMenuItem;
    mmSetupPlot: TMenuItem;
    mmSetupWorkspace: TMenuItem;
    ctbControlBar: TControlBar;
    pnlScaleView: TPanel;
    lblScaleView: TLabel;
    trbScaleView: TTrackBar;
    sbStatusBar: TStatusBar;
    mmFilePrint: TMenuItem;
    Panel1: TPanel;
    cmbFreqList: TComboBox;

    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure mmFilePlotCreateClick(Sender: TObject);
    procedure mmFilePlotLoadFromFileClick(Sender: TObject);
    procedure mmFilePlotLoadFromWorkspaceClick(Sender: TObject);
    procedure mmFilePlotSaveClick(Sender: TObject);
    procedure mmFilePlotSaveAsClick(Sender: TObject);

    procedure mmFileGraphsLoadFromFileClick(Sender: TObject);
    procedure mmFileGraphsLoadFromWorkspaceClick(Sender: TObject);

    procedure mmFilePrintClick(Sender: TObject);

    procedure mmFileExitClick(Sender: TObject);

    procedure mmSetupPlotClick(Sender: TObject);
    procedure mmSetupWorkspaceClick(Sender: TObject);

    procedure mmAboutClick(Sender: TObject);

    procedure trbScaleViewChange(Sender: TObject);
    procedure cmbFreqListChange(Sender: TObject);

  public
    procedure UpdateControlsState(const v: TwndViewForm; action: TvfAction);

  private
    workspace: TStringList;
  end;

var
  wndMainForm: TwndMainForm;

implementation

{$R *.dfm}

uses
  WorkspaceDlg, AboutDlg;

/////////////////////////////////////
// load workspace on form creation //
/////////////////////////////////////
procedure TwndMainForm.FormCreate(Sender: TObject);
var
  fullFileName: String;
begin
  workspace := TStringList.Create;
  fullFileName := ExtractFilePath(Application.ExeName) + 'workspace.txt';
  if FileExists(fullFileName) = True then workspace.LoadFromFile(fullFileName);
end;

//////////////////////////
// set status bar width //
//////////////////////////
procedure TwndMainForm.FormResize(Sender: TObject);
begin
  sbStatusBar.Panels.Items[0].Width := Self.Width div 2;
end;

//////////////////////////////////
// save workspace on form close //
//////////////////////////////////
procedure TwndMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  fullFileName: String;
  i: Integer;
begin
  for i := 0 to Self.MDIChildCount - 1 do Self.MDIChildren[i].Close;
  fullFileName := ExtractFilePath(Application.ExeName) + 'workspace.txt';
  if FileExists(fullFileName) = False then
  begin
    AssignFile(OUTPUT, fullFileName);
    ReWrite(OUTPUT);
    CloseFile(OUTPUT);
  end;
  workspace.SaveToFile(fullFileName);
end;

/////////////////////
// create new plot //
/////////////////////
procedure TwndMainForm.mmFilePlotCreateClick(Sender: TObject);
var
 a: integer;
begin
  TwndViewForm.Create(Self);
end;

//////////////////////////////////
// load plot from existing file //
//////////////////////////////////
procedure TwndMainForm.mmFilePlotLoadFromFileClick(Sender: TObject);
var
  child: TwndViewForm;
begin
  child := TwndViewForm.Create(Self);
  child.LoadPlotFromFile;
end;

//////////////////////////////////////
// load plot from file in workspace //
//////////////////////////////////////
procedure TwndMainForm.mmFilePlotLoadFromWorkspaceClick(Sender: TObject);
var
  child: TwndViewForm;
begin
  child := TwndViewForm.Create(Self);
  child.LoadPlotFromWorkspace(workspace);
end;

////////////////////////////////
// save plot to existing file //
////////////////////////////////
procedure TwndMainForm.mmFilePlotSaveClick(Sender: TObject);
begin
  TwndViewForm(Self.ActiveMDIChild).SavePlotToFile(True, False);
end;

///////////////////////////
// save plot to new file //
///////////////////////////
procedure TwndMainForm.mmFilePlotSaveAsClick(Sender: TObject);
begin
  TwndViewForm(Self.ActiveMDIChild).SavePlotToFile(True, True);
end;

////////////////////////////////////
// load graphs from existing file //
////////////////////////////////////
procedure TwndMainForm.mmFileGraphsLoadFromFileClick(Sender: TObject);
begin
  TwndViewForm(Self.ActiveMDIChild).LoadGraphsFromFile;
end;

////////////////////////////////////////
// load graphs from file in workspace //
////////////////////////////////////////
procedure TwndMainForm.mmFileGraphsLoadFromWorkspaceClick(Sender: TObject);
begin
  TwndViewForm(Self.ActiveMDIChild).LoadGraphsFromWorkspace(workspace);
end;

////////////////
// print plot //
////////////////
procedure TwndMainForm.mmFilePrintClick(Sender: TObject);
begin
  TwndViewForm(Self.ActiveMDIChild).DrawOnPrinter;
end;

////////////////////////////////////////////
// save all changes and close application //
////////////////////////////////////////////
procedure TwndMainForm.mmFileExitClick(Sender: TObject);
begin
  Self.Close;
end;

////////////////////////////////////
// open plot configuration dialog //
////////////////////////////////////
procedure TwndMainForm.mmSetupPlotClick(Sender: TObject);
begin
  TwndViewForm(Self.ActiveMDIChild).OpenPlotDialog;
end;

/////////////////////////////////////////
// open workspace configuration dialog //
/////////////////////////////////////////
procedure TwndMainForm.mmSetupWorkspaceClick(Sender: TObject);
var
  dlg: TwndWorkspaceDlg;
begin
  dlg := TwndWorkspaceDlg.Create(nil);
  dlg.OpenDialog(workspace);
  dlg.Free;
end;

///////////////////////
// open About dialog //
///////////////////////
procedure TwndMainForm.mmAboutClick(Sender: TObject);
var
  dlg: TdlgAbout;
begin
  dlg := TdlgAbout.Create(nil);
  dlg.ShowModal;
  dlg.Free;
end;

///////////////////////////
// update controls stare //
///////////////////////////
procedure TwndMainForm.UpdateControlsState(const v: TwndViewForm; action: TvfAction);
var
  fn, plotConfigStr, graphSeriesStr: String;
begin
  if action = vfActive then
  begin
    pnlScaleView.Enabled := True;
    trbScaleView.Position := Round(v.scale * 100);
    cmbFreqList.Items.Clear;
    cmbFreqList.Items.Add('<все>');
    cmbFreqList.Items.AddStrings(v.GetFreqs);

    mmFilePlotSave.Enabled := True;
    mmFilePlotSaveAs.Enabled := True;
    mmFileGraphs.Enabled := True;
    mmFilePrint.Enabled := True;
    mmSetupPlot.Enabled := True;

    fn := ExtractFileName(v.plotFileName.name);
    if fn <> '' then plotConfigStr := fn else plotConfigStr := '<безымянный>';
    if v.modPlot = True then plotConfigStr := plotConfigStr + '*';
    sbStatusBar.Panels.Items[0].Text := 'Конфигурация чертежа: ' + plotConfigStr;
    fn := ExtractFileName(v.graphsFileName.name);
    if fn <> '' then graphSeriesStr := fn else graphSeriesStr := '<безымянный>';
    if v.modGraphs = True then graphSeriesStr := graphSeriesStr + '*';
    sbStatusBar.Panels.Items[1].Text := 'Набор графиков: ' + graphSeriesStr;
    v.Caption := plotConfigStr + ' (' + graphSeriesStr + ')';
  end else
  begin
    pnlScaleView.Enabled := False;
    trbScaleView.Position := 100;
    mmFilePlotSave.Enabled := False;
    mmFilePlotSaveAs.Enabled := False;
    mmFileGraphs.Enabled := False;
    mmFilePrint.Enabled := False;
    mmSetupPlot.Enabled := False;
    sbStatusBar.Panels.Items[0].Text := 'Конфигурация чертежа: <нет>';
    sbStatusBar.Panels.Items[1].Text := 'Набор графиков: <нет>';
  end;
end;

///////////////////////////////
// change scale of view form //
///////////////////////////////
procedure TwndMainForm.trbScaleViewChange(Sender: TObject);
var
  p: Word;
begin
  p := trbScaleView.Position;
  lblScaleView.Caption := IntToStr(p) + '%';
  TwndViewForm(Self.ActiveMDIChild).SetScale(p / 100);
end;

procedure TwndMainForm.cmbFreqListChange(Sender: TObject);
begin
  if cmbFreqList.ItemIndex = 0 then
    TwndViewForm(Self.ActiveMDIChild).SetFreq(0) else
    TwndViewForm(Self.ActiveMDIChild).SetFreq(StrToFloat(cmbFreqList.Text));
end;

end.
