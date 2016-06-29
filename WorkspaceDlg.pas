unit WorkspaceDlg;

interface

uses
  System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.FileCtrl, Vcl.Controls;

type
  TwndWorkspaceDlg = class(TForm)
    btnApply: TButton;
    btnCancel: TButton;
    lstWorkspace: TListBox;
    btnAdd: TButton;
    dlbDirectories: TDirectoryListBox;
    dcbDrives: TDriveComboBox;
    lblDriveName: TLabel;
    btnDelete: TButton;
    btnClear: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure OpenDialog(var workspace: TStringList);
  end;

implementation

{$R *.dfm}

uses
  Dialogs;

procedure TwndWorkspaceDlg.btnAddClick(Sender: TObject);
begin
  lstWorkspace.Items.Add(dlbDirectories.Directory);
end;

procedure TwndWorkspaceDlg.btnDeleteClick(Sender: TObject);
var
  i: Integer;
begin
  i := lstWorkspace.ItemIndex;
  if i < 0 then ShowMessage('Выберите элемент для удаления.') else
  lstWorkspace.Items.Delete(i);
end;

procedure TwndWorkspaceDlg.btnClearClick(Sender: TObject);
begin
  lstWorkspace.Clear;
end;

procedure TwndWorkspaceDlg.OpenDialog(var workspace: TStringList);
begin
  lstWorkspace.Clear;
  lstWorkspace.Items.AddStrings(workspace);
  if ShowModal() = mrOK then
  begin
    workspace.Clear;
    workspace.AddStrings(lstWorkspace.Items);
  end;
end;

end.
