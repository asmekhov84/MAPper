unit CharactersDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids;

type
  TdlgCharacters = class(TForm)
    lblCurChar: TLabel;
    procedure sgrCharactersMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    character: Char;
  public
    function GetCharacter: Char;
  published
    sgrCharacters: TStringGrid;
    pnlBottom: TPanel;
    btnApply: TButton;
    procedure FormActivate(Sender: TObject);

    procedure btnApplyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgCharacters: TdlgCharacters;

implementation

{$R *.dfm}

const
  ROW_CNT = 64;
  COL_CNT = 16;

procedure TdlgCharacters.FormActivate(Sender: TObject);
var
  i, j: Word;
begin
  sgrCharacters.RowCount := ROW_CNT;
  sgrCharacters.ColCount := COL_CNT;
  for i := 0 to ROW_CNT - 1 do
  begin
    for j := 0 to COL_CNT - 1 do
    begin
      sgrCharacters.Cells[j, i] := Chr(i * COL_CNT + j);
    end;
  end;
end;

procedure TdlgCharacters.sgrCharactersMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  row, col, code: Integer;
  sym: Char;
  s: String;
begin
  sgrCharacters.MouseToCell(X, Y, col, row);
  if (col >= 0) and (col <= COL_CNT - 1) and (row >= 0) and (row <= ROW_CNT - 1) then
  begin
    code := row * COL_CNT + col;
    sym := sgrCharacters.Cells[col, row][1];
    s := IntToStr(row + 1) + ', ' + IntToStr(col + 1) + ': "' + sym + '" (' + IntToStr(code) + ')'
  end else s := '';
  lblCurChar.Caption := s;
end;

procedure TdlgCharacters.btnApplyClick(Sender: TObject);
var
  r: TGridRect;
begin
  r := sgrCharacters.Selection;
  character := sgrCharacters.Cells[r.Left, r.Top][1];
  Self.Close;
end;

function TdlgCharacters.GetCharacter: Char;
begin
  Self.ShowModal;
  Result := character;
end;

end.
