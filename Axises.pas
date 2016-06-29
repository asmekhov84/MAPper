unit Axises;

// Author: Artemiy Smekhov
// Created: 1.1.15
// Modifyed: 1.1.15

interface

uses
  Utilities, Graphics, Generics.Collections;

type
  TYAxisSide = (yasLeft, yasRight);

const
  Y_AXIS_SIDE_STR: array[yasLeft..yasRight] of String = ('левая', 'правая');

type
  TAxis = class abstract
  private
    FName: String;
    FMin, FMax: Real; // axis range
    FUnits: Byte; // axis lenght in units
    FGap: Byte; // distance from axis to grid [mm]
    FLine: TLineStyle;
    procedure SetName(s: String);
    procedure SetUnits(a: Byte);
    procedure SetGap(a: Byte);
    function GetLineColor: TColor;
    procedure SetLineColor(c: TColor);
    function GetLineWidth: Byte;
    procedure SetLineWidth(a: Byte);
  public
    constructor Create; virtual;
    property name: String read FName write SetName;
    property min: Real read FMin write FMin;
    property max: Real read FMax write FMax;
    property units: Byte read FUnits write SetUnits;
    property gap: Byte read FGap write SetGap;
    property lineColor: TColor read GetLineColor write SetLineColor;
    property lineWidth: Byte read GetLineWidth write SetLineWidth;
  end;

  TXAxis = class(TAxis)
  public
    constructor Create; override;
  end;

  PYAxis = ^TYAxis;

  TYAxis = class(TAxis)
  private
    FIndent: Byte; // number of units from bottom to axis, ONLY FOR Y AXIS
    FSide: TYAxisSide; // left or righe side, ONLY FOR Y AXIS
    procedure SetIndent(a: Byte);
  public
    constructor Create; override;
    procedure CopyAxis(const obj: TYAxis);
    property indent: Byte read FIndent write SetIndent;
    property side: TYAxisSide read FSide write FSide;
  end;

  TYAxises = class
  private
    FYAxises: TList<TYAxis>;
    FActive: PYAxis;
    function GetCount: Byte;
    function GetName: String;
    procedure SetName(s: String);
    function GetMin: Real;
    procedure SetMin(v: Real);
    function GetMax: Real;
    procedure SetMax(v: Real);
    function GetUnits: Byte;
    procedure SetUnits(n: Byte);
    function GetGap: Byte;
    procedure SetGap(n: Byte);
    function GetIndent: Byte;
    procedure SetIndent(n: Byte);
    function GetYAxisSide: TYAxisSide;
    procedure SetYAxisSide(n: TYAxisSide);
    function GetLineColor: TColor;
    procedure SetLineColor(c: TColor);
    function GetLineWidth: Byte;
    procedure SetLineWidth(n: Byte);
  public
    constructor Create;
    procedure CopyAxises(const obj: TYAxises);
    procedure AddAxis(const obj: TYAxis);
    procedure AddDefaultAxis;
    procedure DeleteRange(i, cnt: Byte);
    procedure Clear;
    procedure SetActive(i: Byte);
    property count: Byte read GetCount;
    property name: String read GetName write SetName;
    property min: Real read GetMin write SetMin;
    property max: Real read GetMax write SetMax;
    property units: Byte read GetUnits write SetUnits;
    property gap: Byte read GetGap write SetGap;
    property indent: Byte read GetIndent write SetIndent;
    property side: TYAxisSide read GetYAxisSide write SetYAxisSide;
    property lineColor: TColor read GetLineColor write SetLineColor;
    property lineWidth: Byte read GetLineWidth write SetLineWidth;
  end;

implementation

uses
  SysUtils;

{--------------------------------[ TAxis ]-------------------------------------}

constructor TAxis.Create;
begin
  // default values
  Self.FMin := 0;
  Self.FMax := 1;
  Self.FGap := 3; // [mm]
  Self.FLine.color := clBlack;
  Self.FLine.width := 1; // [points]
end;

procedure TAxis.SetName(s: string);
begin
  if s = '' then raise Exception.Create('Axis name can not be empty.');
  FName := s;
end;

procedure TAxis.SetUnits(a: Byte);
begin
  if a < 1 then raise Exception.Create('Axis units value out of range.');
  FUnits := a;
end;

procedure TAxis.SetGap(a: Byte);
begin
  FGap := a;
end;

function TAxis.GetLineColor: TColor;
begin
  Result := Self.FLine.color;
end;

procedure TAxis.SetLineColor(c: TColor);
begin
  Self.FLine.color := c;
end;

function TAxis.GetLineWidth: Byte;
begin
  Result := Self.FLine.width;
end;

procedure TAxis.SetLineWidth(a: Byte);
begin
  Self.FLine.width := a;
end;

{--------------------------------[ TXAxis ]------------------------------------}

constructor TXAxis.Create;
begin
  inherited Create;
  Self.FName := 'X';
  Self.FUnits := 1;
end;

{--------------------------------[ TYAxis ]------------------------------------}

constructor TYAxis.Create;
begin
  inherited Create;
  Self.FName := 'Y';
  Self.FUnits := 1;
  Self.FIndent := 0;
  Self.FSide := yasLeft;
end;

procedure TYAxis.CopyAxis(const obj: TYAxis);
begin
  Self.FName := obj.FName;
  Self.FMin := obj.FMin;
  Self.FMax := obj.FMax;
  Self.FUnits := obj.FUnits;
  Self.FGap := obj.FGap;
  Self.FLine := obj.FLine;
  Self.FIndent := obj.FIndent;
  Self.FSide := obj.FSide;
end;

procedure TYAxis.SetIndent(a: Byte);
begin
  FIndent := a;
end;

{-------------------------------[ TYAxises ]-----------------------------------}

constructor TYAxises.Create;
begin
  FYAxises := TList<TYAxis>.Create;
  FYAxises.Add(TYAxis.Create);
end;

procedure TYAxises.CopyAxises(const obj: TYAxises);
var
  i: Integer;
begin
  FYAxises.Clear;
  for i := 0 to obj.FYAxises.Count - 1 do FYAxises.Add(obj.FYAxises.List[i]);
end;

procedure TYAxises.AddAxis(const obj: TYAxis);
var
  axis: TYAxis;
begin
  axis := TYAxis.Create;
  axis.CopyAxis(obj);
  FYAxises.Add(axis);
end;

procedure TYAxises.AddDefaultAxis;
var
  axis: TYAxis;
begin
  axis := TYAxis.Create;
  FYAxises.Add(axis);
end;

procedure TYAxises.DeleteRange(i, cnt: Byte);
begin
  if i > FYAxises.Count - 1 then raise Exception.Create('Y axis index out of range.');
  if (cnt = 0) or (i + cnt > FYAxises.Count) then raise Exception.Create('Y axis index out of range.');
  FYAxises.DeleteRange(i, cnt);
end;

procedure TYAxises.Clear;
begin
  FYAxises.Clear;
end;

procedure TYAxises.SetActive(i: Byte);
begin
  if i > FYAxises.Count - 1 then raise Exception.Create('Y axis index out of range.');
  FActive := @(FYAxises.List[i]);
end;

function TYAxises.GetCount: Byte;
begin
  Result := FYAxises.Count;
end;

function TYAxises.GetName: String;
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  Result := FActive.name;
end;

procedure TYAxises.SetName(s: String);
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  FActive.name := s;
end;

function TYAxises.GetMin: Real;
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  Result := FActive.min;
end;

procedure TYAxises.SetMin(v: Real);
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  FActive.min := v;
end;

function TYAxises.GetMax: Real;
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  Result := FActive.max;
end;

procedure TYAxises.SetMax(v: Real);
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  FActive.max := v;
end;

function TYAxises.GetUnits: Byte;
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  Result := FActive.units;
end;

procedure TYAxises.SetUnits(n: Byte);
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  FActive.units := n;
end;

function TYAxises.GetGap: Byte;
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  Result := FActive.gap;
end;

procedure TYAxises.SetGap(n: Byte);
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  FActive.gap := n;
end;

function TYAxises.GetIndent: Byte;
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  Result := FActive.indent;
end;

procedure TYAxises.SetIndent(n: Byte);
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  FActive.indent := n;
end;

function TYAxises.GetYAxisSide: TYAxisSide;
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  Result := FActive.side;
end;

procedure TYAxises.SetYAxisSide(n: TYAxisSide);
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  FActive.side := n;
end;

function TYAxises.GetLineColor: TColor;
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  Result := FActive.lineColor;
end;

procedure TYAxises.SetLineColor(c: TColor);
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  FActive.lineColor := c;
end;

function TYAxises.GetLineWidth: Byte;
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  Result := FActive.lineWidth;
end;

procedure TYAxises.SetLineWidth(n: Byte);
begin
  if FActive = nil then raise Exception.Create('Y axis not selected.');
  FActive.lineWidth := n;
end;

end.
