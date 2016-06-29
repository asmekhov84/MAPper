program MAPper;



uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {wndMainForm},
  ViewForm in 'ViewForm.pas',
  WorkspaceDlg in 'WorkspaceDlg.pas',
  GraphsFilesDlg in 'GraphsFilesDlg.pas' {dlgGraphsFiles},
  PlotSetupDlg in 'PlotSetupDlg.pas' {dlgPlotSettings},
  PlotFilesDlg in 'PlotFilesDlg.pas' {dlgPlotFiles},
  Utilities in 'Utilities.pas',
  PlotConfig in 'PlotConfig.pas',
  AboutDlg in 'AboutDlg.pas' {dlgAbout},
  CharactersDlg in 'CharactersDlg.pas' {dlgCharacters},
  Axises in 'Axises.pas',
  GraphGroups in 'GraphGroups.pas',
  GraphSeries in 'GraphSeries.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'MAPper';
  Application.CreateForm(TwndMainForm, wndMainForm);
  Application.Run;
end.
