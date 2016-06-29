unit GraphsFilesDlg;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Grids, Vcl.CheckLst;

type
  TdlgGraphsFiles = class(TForm)
    sgrGraphsFilesList: TStringGrid;
    btnOK: TButton;
    btnClose: TButton;

    procedure sgrGraphsFilesListDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgrGraphsFilesListTopLeftChanged(Sender: TObject);
    procedure chkLoadFileClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  public
    function OpenDialog(const workspace: TStringList; var fullFileName: TStringList): Boolean;

  private
    chkLoadFile: array of TCheckBox;
  end;

implementation

{$R *.dfm}

uses
  Utilities, PlotConfig;

procedure TdlgGraphsFiles.sgrGraphsFilesListDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (chkLoadFile = nil) or (sgrGraphsFilesList.RowCount < 2) then Exit;
  if (ACol = 0) and (ARow > 0) then chkLoadFile[ARow - 1].BoundsRect := Rect;
end;

procedure TdlgGraphsFiles.sgrGraphsFilesListTopLeftChanged(Sender: TObject);
var
  i, i1, i2, i3: Integer;
begin
  if (chkLoadFile = nil) or (sgrGraphsFilesList.RowCount < 2) then Exit;
  i1 := sgrGraphsFilesList.TopRow;
  i2 := sgrGraphsFilesList.TopRow + sgrGraphsFilesList.VisibleRowCount;
  i3 := sgrGraphsFilesList.RowCount;
  for i := 1 to i1 - 1 do chkLoadFile[i - 1].Visible := False;
  for i := i1 to i2 - 1 do chkLoadFile[i - 1].Visible := True;
  for i := i2 to i3 - 1 do chkLoadFile[i - 1].Visible := False;
  sgrGraphsFilesList.Repaint;
end;

procedure TdlgGraphsFiles.chkLoadFileClick(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbLeft then Exit;
  TCheckBox(Sender).Checked := not TCheckBox(Sender).Checked;
end;

function TdlgGraphsFiles.OpenDialog(const workspace: TStringList; var fullFileName: TStringList): Boolean;
var
  fl: TFilesList;
  i: Integer;
  masks: TStringList;
begin
  sgrGraphsFilesList.Cells[0, 0] := 'Имя файла';
  sgrGraphsFilesList.Cells[1, 0] := 'Дата изменения';
  masks := TStringList.Create;
  masks.Add('*.' + PC_GRNOS_GS_FILE_EXT);
  fl := FindFilesInWorkspace(workspace, masks);
  if fl.count > 0 then
  begin
    sgrGraphsFilesList.RowCount := fl.count + 1;
    // init check box array
    SetLength(chkLoadFile, fl.count);
    for i := 0 to fl.count - 1 do
    begin
      chkLoadFile[i] := TCheckBox.Create(nil);
      chkLoadFile[i].Parent := sgrGraphsFilesList;
      chkLoadFile[i].Caption := fl.files[i + 1].name;
      chkLoadFile[i].OnMouseUp := chkLoadFileClick;
      sgrGraphsFilesList.Cells[1, i + 1] := DateTimeToStr(fl.files[i + 1].time);
    end;
    sgrGraphsFilesList.OnTopLeftChanged(Self);
  end else btnOK.Enabled := False;
  if (ShowModal() = mrOK) and (fl.count > 0) then
  begin
    for i := 1 to fl.count do
    begin
      if chkLoadFile[i - 1].Checked = True then
        fullFileName.Add(fl.files[i].path + '\' + fl.files[i].name);
    end;
    OpenDialog := True;
  end else OpenDialog := False;
  chkLoadFile := nil;
end;

end.
