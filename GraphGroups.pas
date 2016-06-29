unit GraphGroups;

// Author: Artemiy Smekhov
// Created: 1.1.15
// Modifyed: 1.1.15

interface

uses
  Utilities, Classes, Generics.Collections, Graphics, SysUtils;

type
  TGraphMarker = (gmNone, gmRound, gmSquare, gmTriangle, gmCross);

const
  GRAPH_MARKER_STR: array[gmNone..gmCross] of String = ('нет', 'круг', 'квадрат', 'треугольник', 'крест');

type
  TGraphGroup = class
    name: String; // group's name
    visible: Boolean; // graph is visible if True
    noteXPos: Real; // position of graph title on X axis
    marker: TGraphMarker; // type of graph marker
    line: TLineStyle; // width and color of line
    graphs: TStringList; // list og graph names that are included into this group
    constructor Create;
  end;

  PGraphGroup = ^TGraphGroup;

  TGraphGroups = class
  private
    FGroups: TList<TGraphGroup>;
    FActive: PGraphGroup;
    function GetCount: Byte;
    function GetName: String;
    procedure SetName(s: String);
    function GetVisible: Boolean;
    procedure SetVisible(b: Boolean);
    function GetNoteXPos: Real;
    procedure SetNoteXPos(r: Real);
    function GetMarker: TGraphMarker;
    procedure SetMarker(m: TGraphMarker);
    function GetLineColor: TColor;
    procedure SetLineColor(c: TColor);
    function GetLineWidth: Byte;
    procedure SetLineWidth(b: Byte);
    function GetGraphs: TStringList;
  public
    constructor Create;
    procedure CopyGraphGroups(const obj: TGraphGroups);
    procedure SetActiveByNumber(i: Byte); // zero-indexing
    procedure SetActiveByGraphName(name: String);
    // проверяет, входит ли график с именем name в какую-либо из групп и, если нет,
    // добавляет его в группу по-умолчанию
    procedure CheckGraphAndAdd(name: String);
    procedure AddDefaultGroup;
    procedure AddGroup(const group: TGraphGroup);
    procedure DeleteRange(i: Byte; cnt: Byte);
    procedure IncludeGraph(name: String);
    procedure ExcludeGraph(name: String);
    function IsInGroup(name: String): Boolean;
    procedure ClearList;
    property count: Byte read GetCount;
    property name: String read GetName write SetName;
    property visible: Boolean read GetVisible write SetVisible;
    property noteXPos: Real read GetNoteXPos write SetNoteXPos;
    property marker: TGraphMarker read GetMarker write SetMarker;
    property lineColor: TColor read GetLineColor write SetLineColor;
    property lineWidth: Byte read GetLineWidth write SetLineWidth;
    property graphs: TStringList read GetGraphs;
  end;

implementation

{------------------------------[ TGraphGroup ]---------------------------------}

constructor TGraphGroup.Create;
begin
  Self.name := 'default';
  Self.visible := True;
  Self.noteXPos := 0;
  Self.marker := gmNone;
  Self.line.color := clBlack;
  Self.line.width := 1;
  Self.graphs := TStringList.Create;
end;

{------------------------------[ TGraphGroups ]--------------------------------}

constructor TGraphGroups.Create;
var
  group: TGraphGroup;
begin
  FGroups := TList<TGraphGroup>.Create;
  FGroups.Add(TGraphGroup.Create);
  FActive := nil;
end;

procedure TGraphGroups.CopyGraphGroups(const obj: TGraphGroups);
var
  i: Integer;
begin
  FGroups.Clear;
  for i := 0 to obj.FGroups.Count - 1 do FGroups.Add(obj.FGroups.List[i]);
  FActive := obj.FActive;
end;

procedure TGraphGroups.SetActiveByNumber(i: Byte);
begin
  if i > FGroups.Count - 1 then raise Exception.Create('Group index out of range.');
  FActive := @(FGroups.List[i]);
end;

procedure TGraphGroups.SetActiveByGraphName(name: string);
var
  i: Integer;
begin
  FActive := nil;
  for i := 0 to FGroups.Count - 1 do
  begin
    if FGroups.List[i].graphs.IndexOf(name) >= 0 then
    begin
      FActive := @(FGroups.List[i]);
      Break;
    end;
  end;
  if FActive = nil then raise Exception.Create('Graph with name ' + name + ' not in any group.');
end;

///////////////////////////////////////////////////
// in graph 'name' not included no one of groups //
// include it into default (zero) gropup         //
///////////////////////////////////////////////////
procedure TGraphGroups.CheckGraphAndAdd(name: string);
var
  i: Byte;
  added: Boolean;
begin
  added := False;
  for i := 0 to FGroups.Count - 1 do
  begin
    if FGroups.List[i].graphs.IndexOf(name) >= 0 then
    begin
      added := True;
      Break;
    end;
  end;
  if not added then FGroups.List[0].graphs.Add(name);
end;

procedure TGraphGroups.AddDefaultGroup;
begin
  FGroups.Add(TGraphGroup.Create);
end;

procedure TGraphGroups.AddGroup(const group: TGraphGroup);
var
  pGroup: PGraphGroup;
begin
  New(pGroup);
  pGroup^ := TGraphGroup.Create;
  pGroup^.name := group.name;
  pGroup^.visible := group.visible;
  pGroup^.noteXPos := group.noteXPos;
  pGroup^.marker := group.marker;
  pGroup^.line := group.line;
  pGroup^.graphs.Clear;
  pGroup^.graphs.AddStrings(group.graphs);
  FGroups.Add(pGroup^);
end;

procedure TGraphGroups.DeleteRange(i: Byte; cnt: Byte);
begin
  FGroups.DeleteRange(i, cnt);
end;

/////////////////////////////////////////////////////////
// includes graph 'name' into the current active group //
// ang excludes it from previous group                 //
/////////////////////////////////////////////////////////
procedure TGraphGroups.IncludeGraph(name: String);
var
  i, n: Integer;
begin
  if FActive = nil then raise Exception.Create('Active group not selected.');
  for i := 0 to FGroups.Count - 1 do
  repeat
    n := FGroups[i].graphs.IndexOf(name);
    if n >= 0 then FGroups[i].graphs.Delete(n);
  until n < 0;
  FActive.graphs.Add(name);
end;

/////////////////////////////////////////////////////////
// excludes graph 'name' from the current active group //
// and includes it to zero group                       //
/////////////////////////////////////////////////////////
procedure TGraphGroups.ExcludeGraph(name: String);
var
  n: Integer;
begin
  if FActive = nil then raise Exception.Create('Active group not selected.');
  n := FActive.graphs.IndexOf(name);
  if n >= 0 then
  begin
    FActive.graphs.Delete(n);
    FGroups[0].graphs.Add(name);
  end;
end;

//////////////////////////////////////////////////////
// returns True is graph 'name' included to current //
// active group, False - otherwise                  //
//////////////////////////////////////////////////////
function TGraphGroups.IsInGroup(name: String): Boolean;
begin
  if FActive = nil then raise Exception.Create('Active group not selected.');
  Result := (FActive.graphs.IndexOf(name) >= 0);
end;

procedure TGraphGroups.ClearList;
begin
  FGroups.Clear;
  FActive := nil;
end;

function TGraphGroups.GetCount: Byte;
begin
  Result := FGroups.Count;
end;

function TGraphGroups.GetName: String;
begin
  if FActive = nil then Result := '' else Result := FActive.name;
end;

procedure TGraphGroups.SetName(s: String);
begin
  if FActive = nil then raise Exception.Create('Active group not selected.');
  FActive.name := s;
end;

function TGraphGroups.GetVisible: Boolean;
begin
  if FActive = nil then Result := True else Result := FActive.visible;
end;

procedure TGraphGroups.SetVisible(b: Boolean);
begin
  if FActive = nil then raise Exception.Create('Active group not selected.');
  FActive.visible := b;
end;

function TGraphGroups.GetNoteXPos: Real;
begin
  if FActive = nil then Result := 0 else Result := FActive.noteXPos;
end;

procedure TGraphGroups.SetNoteXPos(r: Real);
begin
  if FActive = nil then raise Exception.Create('Active group not selected.');
  FActive.noteXPos := r;
end;

function TGraphGroups.GetMarker: TGraphMarker;
begin
  if FActive = nil then Result := gmNone else Result := FActive.marker;
end;

procedure TGraphGroups.SetMarker(m: TGraphMarker);
begin
  if FActive = nil then raise Exception.Create('Active group not selected.');
  FActive.marker := m;
end;

function TGraphGroups.GetLineColor: TColor;
begin
  if FActive = nil then Result := clBlack else Result := FActive.line.color;
end;

procedure TGraphGroups.SetLineColor(c: TColor);
begin
  if FActive = nil then raise Exception.Create('Active group not selected.');
  FActive.line.color := c;
end;

function TGraphGroups.GetLineWidth: Byte;
begin
  if FActive = nil then Result := 1 else Result := FActive.line.width;
end;

procedure TGraphGroups.SetLineWidth(b: Byte);
begin
  if FActive = nil then raise Exception.Create('Active group not selected.');
  FActive.line.width := b;
end;

function TGraphGroups.GetGraphs: TStringList;
var
  res: TStringList;
begin
  if FActive = nil then raise Exception.Create('Active group not selected.');
  res := TStringList.Create;
  res.AddStrings(FActive.graphs);
  Result := res;
end;


end.
