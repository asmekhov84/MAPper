unit PlotFilesDlg;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls,
  Vcl.Grids;

type
  TdlgPlotFiles = class(TForm)
    btnApply: TButton;
    btnCancel: TButton;
    sgrPlotFilesList: TStringGrid;
    function OpenDialog(const workspace: TStringList; var fullFileName: String): Boolean;
  end;

implementation

{$R *.dfm}

uses
  Utilities, PlotConfig;

function TdlgPlotFiles.OpenDialog(const workspace: TStringList; var fullFileName: String): Boolean;
var
  fl: TFilesList;
  i: Byte;
  mask: TStringList;
begin
  sgrPlotFilesList.Cells[0, 0] := 'Имя файла';
  sgrPlotFilesList.Cells[1, 0] := 'Дата изменения';
  mask := TStringList.Create;
  mask.Add('*.' + PC_NATIVE_PC_FILE_EXT);
  mask.Add('*.' + PC_GRNOS_PC_FILE_EXT);
  fl := FindFilesInWorkspace(workspace, mask);
  if fl.count >= 1 then
  begin
    sgrPlotFilesList.RowCount := fl.count + 1;
    for i := 1 to fl.count do
    begin
      sgrPlotFilesList.Cells[0, i] := fl.files[i].name;
      sgrPlotFilesList.Cells[1, i] := DateTimeToStr(fl.files[i].time);
    end;
    if ShowModal() = mrOK then
    begin
      i := sgrPlotFilesList.Row;
      fullFileName := fl.files[i].path + '\' + fl.files[i].name;
      OpenDialog := True;
    end else OpenDialog := False;
  end else
  begin
    sgrPlotFilesList.Enabled := False;
    ShowModal;
    OpenDialog := False;
  end;
end;

end.
