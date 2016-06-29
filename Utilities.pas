unit Utilities;

interface

uses
  Classes, Graphics;

type
  TLineStyle = record
    color: TColor;
    width: Byte; // line width in points (1 point = 0.25 mm)
  end;

  TFileRecord = record
    name, path: String;
    time: TDateTime;
  end;

  TFilesList = record
    files: array[1..500] of TFileRecord;
    count: Word;
  end;

  TRealPoint = record
    x, y: Real;
  end;

  TRealVector = array of Real;

function FindFilesInWorkspace(const workspace: TStringList; masks: TStringList): TFilesList;
procedure InterpNewton(srcX: TRealVector; srcY: TRealVector; srcN: Word; var intX: TRealVector; var intY: TRealVector; intN: Word);

function IsRealNumber(s: String): Boolean;
function IsIntegerNumber(s: String): Boolean;

function GetSystemDecimalSeparator: Char;
function GetPrec(r: Real): Byte;
function GetMin(v: TRealVector; n: Byte): Real;
function GetMax(v: TRealVector; n: Byte): Real;
function GetFileNameNoExt(s: String): String;

// conversion methods
procedure StrToRealVector(s: String; var v: TRealVector; var n: Word);
procedure RealVectorToStr(v: TRealVector; n: Word; var s: String);
function BoolToInt(b: Boolean): Integer;
function StrToReal(s: String): Real;

implementation

uses
  SysUtils;

function FindFilesInWorkspace(const workspace: TStringList; masks: TStringList): TFilesList;
var
  searchRect: TSearchRec;
  ws: TStringList;
  i: Byte;
begin
  ws := TStringList.Create;
  Result.count := 0;
  for i := 0 to masks.Count - 1 do
  begin
    ws.AddStrings(workspace);
    while ws.Count > 0 do
    begin
      if FindFirst(ws[0] + '\' + masks[i], faAnyFile, searchRect) = 0 then
      repeat
        Result.count := Result.count + 1;
        Result.files[Result.count].path := ws[0];
        Result.files[Result.count].name := searchRect.Name;
        Result.files[Result.count].time := searchRect.TimeStamp;
      until FindNext(searchRect) <> 0;
      FindClose(searchRect);
      if FindFirst(ws[0] + '\*', faDirectory, searchRect) = 0 then
      repeat
        if ((searchRect.Attr and faDirectory) = faDirectory) and
           (searchRect.Name <> '.') and (searchRect.Name <> '..') then
           ws.Add(ws[0] + '\' + searchRect.Name);
      until FindNext(searchRect) <> 0;
      FindClose(searchRect);
      ws.Delete(0);
    end;
  end;
end;

// https://ru.wikipedia.org/wiki/»нтерпол€ционные_формулы_Ќьютона
procedure InterpNewton(srcX: TRealVector; {in} srcY: TRealVector; {in} srcN: Word; {in}
                       var intX: TRealVector; {out} var intY: TRealVector; {out} intN: Word {in});
var
  tmp: array of array of Real48;
  dy0: array of Real48; // finite differences
  h, q, num, den: Real48;
  i, j, k: Integer;
begin
  // initialize arrays
  SetLength(intX, intN);
  SetLength(intY, intN);
  h := (srcX[srcN - 1] - srcX[0]) / (intN - 1);
  for i := 0 to intN - 1 do intX[i] := srcX[0] + i * h;
  // calculate finite differences d(n)_y(k) = d(n-1)_y(k+1) - d(n-1)_y(k)
  SetLength(tmp, srcN, srcN);
  for i := 0 to srcN - 1 do tmp[0, i] := srcY[i]; // copy source y array to 1-st line of tmp
  k := srcN;
  for i := 1 to srcN - 1 do
  begin
    for j := 0 to k - 2 do tmp[i, j] := tmp[i - 1, j + 1] - tmp[i - 1, j];
    k := k - 1;
  end;
  SetLength(dy0, srcN);
  for j := 0 to srcN - 1 do dy0[j] := tmp[j, 0];
  tmp := nil;
  // calculate all interpolated values
  k := 0;
  h := srcX[1] - srcX[0];
  for i := 0 to intN - 1 do
  begin
    // calculate q = (x - x0) / h
    q := (intX[i] - intX[0]) / h;
    // calculate interpolated values of function
    intY[i] := dy0[0];
    num := 1; // numerator
    den := 1; // denumerator
    for j := 1 to srcN - 1 do
    begin
      num := num * (q - j + 1);
      den := den * j;
      intY[i] := intY[i] + dy0[j] * num / den;
    end;
  end;
  dy0 := nil;
end;

function GetSystemDecimalSeparator: Char;
begin
  if Pos('.', FloatToStr(1.1)) > 0 then Result := '.' else Result := ',';
end;

function IsRealNumber(s: String): Boolean;
var
  i, sepCnt: Byte;
  sep: Char;
begin
  Result := True;
  if s = '' then
  begin
    Result := False;
    Exit;
  end;
  if not (s[1] in ['0'..'9', '-']) then
  begin
    Result := False;
    Exit;
  end;
  sep := GetSystemDecimalSeparator;
  sepCnt := 0;
  for i := 2 to Length(s) do
  begin
    if s[i] = sep then
    begin
      if (not (s[i - 1] in ['0'..'9'])) or (i = Length(s)) or (sepCnt > 1) then
      begin
        Result := False;
        Break;
      end;
      sepCnt := sepCnt + 1;
    end else
    if not (s[i] in ['0'..'9']) then
    begin
      IsRealNumber := False;
      Break;
    end;
  end;
end;

function IsIntegerNumber(s: String): Boolean;
var
  i: Byte;
begin
  Result := True;
  if s = '' then Result := False;
  for i := 1 to Length(s) do
  begin
    if not (s[i] in ['0'..'9']) then
    begin
      Result := False;
      Break;
    end;
  end;
end;

procedure StrToRealVector(s: String; var v: TRealVector; var n: Word);
var
  sep: Char;
  res: TRealVector;
  num: String;
  len, i, p1, p2: Word;
begin
  s := s + ' ';
  sep := GetSystemDecimalSeparator; // system decimal separator
  len := Length(s);
  for i := 1 to len do
    if (s[i] in ['.', ',']) and (s[i] <> sep) then s[i] := sep;
  SetLength(res, len div 2); // count of numbers in S string not more than half length of S
  p1 := 1;
  p2 := 1;
  n := 0;
  while p2 < len do
  begin
    while (not (s[p1] in ['0'..'9', '-', sep])) and (p1 < len) do p1 := p1 + 1;
    p2 := p1;
    while (s[p2] in ['0'..'9', '-', '.', sep]) and (p2 < len) do p2 := p2 + 1;
    num := Copy(s, p1, p2 - p1);
    p1 := p2;
    if IsRealNumber(num) = True then
    begin
      res[n] := StrToFloat(num);
      n := n + 1;
    end;
  end;
  SetLength(v, n);
  v := Copy(res, 0, n);
  res := nil;
end;

procedure RealVectorToStr(v: TRealVector; n: Word; var s: String);
var
  i: Byte;
begin
  s := '';
  for i := 0 to n - 1 do s := s + FloatToStr(v[i]) + ' ';
end;

function GetPrec(r: Real): Byte;
begin
  r := Abs(r);
  if (r >= 100) or (r = 0) then Result := 0 else
  if r >= 10 then Result := 1 else
  if r >= 1 then Result := 2 else
  if r >= 0.1 then Result := 3 else
  if r >= 0.01 then Result := 4 else Result := 5;
end;

function GetMin(v: TRealVector; n: Byte): Real;
var
  i: Byte;
begin
  Result := v[0];
  for i := 1 to n - 1 do
    if v[i] < Result then Result := v[i];
end;

function GetMax(v: TRealVector; n: Byte): Real;
var
  i: Byte;
begin
  Result := v[0];
  for i := 1 to n - 1 do
    if v[i] > Result then Result := v[i];
end;

function BoolToInt(b: Boolean): Integer;
begin
  if b = True then Result := 1 else Result := 0;
end;

function GetFileNameNoExt(s: String): String;
var
  sl, dt, i: Word;
begin
  for i := Length(S) downto 1 do
  begin
    if s[i] = '.' then
    begin
      dt := i;
      Break;
    end;
  end;
  for i := dt downto 1 do
  begin
    if s[i] = '\' then
    begin
      sl := i;
      Break;
    end;
  end;
  Result := Copy(s, sl + 1, dt - sl - 1);
end;

function StrToReal(s: String): Real;
var
  p: Byte;
  sep: Char;
begin
  sep := GetSystemDecimalSeparator;
  p := Pos('.', s);
  if (p <> 0) and (sep <> '.') then s[p] := sep;
  p := Pos(',', s);
  if (p <> 0) and (sep <> ',') then s[p] := sep;
  Result := StrToFloat(s);
end;

end.
