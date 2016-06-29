unit GraphSeries;

// Author: Artemiy Smekhov
// Created: 1.1.15
// Modifyed: 1.1.15

interface

uses
  Utilities, Generics.Collections;

const
  INTERP_POINTS_CNT = 100;

type
  // data from GRNOS file
  TGraph = class
  private
    FSrcN: Byte; // number of source data points
    FSrcX, FSrcY: TRealVector; // source data
  public
    FName: String; // unique graph's name
    FNote: String; // graphs note
    FYAxisName: String; // name of the axis on which graph will be displayed
    FN: Real; // частота нагрузочной характеристики
    FGraphType: Byte; // тип графика: 0 - ВСХ [№], 1 - нагр. хар-ка [Pe]
    FIntN: Byte; // number of interpolated data points
    FIntX, FIntY: TRealVector; // interpolated data
    constructor Create;
    procedure CopyGraph(const obj: TGraph);
    procedure SetData(x, y: TRealVector; n: Byte);
  end;

  PGraph = ^TGraph;

  TGraphSeries = class
  private
    FGraphs: TList<TGraph>;
    FActive: PGraph; // pointer to current selected graph
    function GetCount: Word;
    function GetName: String;
    procedure SetName(s: String);
    function GetNote: String;
    procedure SetNote(s: String);
    function GetYAxisName: String;
    procedure SetYAxisName(s: String);
    function GetN: Real;
    procedure SetN(n: Real);
    function GetGraphType: Byte;
    procedure SetGraphType(t: Byte);
    function GetNI: Word;
    function GetXI: TRealVector;
    function GetYI: TRealVector;
  public
    freqList: TList<Real>;
    constructor Create;
    procedure CopyGraphSeries(const obj: TGraphSeries);
    procedure AddGraph(const graph: TGraph);
    procedure DeleteGraphs(i, count: Byte);
    procedure SetActive(i: Word);
    // interface to active graph
    property count: Word read GetCount;
    property name: String read GetName write SetName;
    property note: String read GetNote write SetNote;
    property yAxisName: String read GetYAxisName write SetYAxisName;
    property N: Real read GetN write SetN;
    property graphType: Byte read GetGraphType write SetGraphType;
    property NI: Word read GetNI;
    property XI: TRealVector read GetXI;
    property YI: TRealVector read GetYI;
  end;

implementation

uses
  SysUtils;

{---------------------------------[ TGraph ]-----------------------------------}

constructor TGraph.Create;
begin
  FName := '';
  FNote := '';
  FYAxisName := '';
  FN := 0;
  FGraphType := 0;
  FSrcN := 0;
  FSrcX := nil;
  FSrcY := nil;
  FIntN := 0;
  FIntX := nil;
  FIntY := nil;
end;

procedure TGraph.CopyGraph(const obj: TGraph);
begin
  FName := obj.FName;
  FNote := obj.FNote;
  FYAxisName := obj.FYAxisName;
  FN := obj.FN;
  FGraphType := obj.FGraphType;
  FSrcN := obj.FSrcN;
  FSrcX := Copy(obj.FSrcX, 0, obj.FSrcN);
  FSrcY := Copy(obj.FSrcY, 0, obj.FSrcN);
  FIntN := obj.FIntN;
  FIntX := Copy(obj.FIntX, 0, obj.FIntN);
  FIntY := Copy(obj.FIntY, 0, obj.FIntN);
end;

procedure TGraph.SetData(x, y: TRealVector; n: Byte);
begin
  FSrcN := n;
  FSrcX := nil;
  FSrcX := Copy(x, 0, FSrcN);
  FSrcY := nil;
  FSrcY := Copy(y, 0, FSrcN);
  FIntN := INTERP_POINTS_CNT;
  InterpNewton(FSrcX, FSrcY, FSrcN, FIntX, FIntY, FIntN);
  n := 5;
end;

{-------------------------------[ TGraphs ]------------------------------------}

constructor TGraphSeries.Create;
begin
  FGraphs := TList<TGraph>.Create;
  FActive := nil;
  freqList := TList<Real>.Create;
end;

procedure TGraphSeries.CopyGraphSeries(const obj: TGraphSeries);
var
  i: Integer;
begin
  FGraphs.Clear;
  for i := 0 to obj.FGraphs.Count - 1 do FGraphs.Add(obj.FGraphs.List[i]);
  FActive := obj.FActive;
end;

procedure TGraphSeries.AddGraph(const graph: TGraph);
var
  newGraph: PGraph;
  i, p1, p2, num: Integer;
  s: String;
  isUniqueName: Boolean;
begin
  New(newGraph);
  newGraph^ := TGraph.Create;
  newGraph^.CopyGraph(graph);
  if newGraph.FNote <> '' then
    newGraph^.FName := newGraph.FNote else
    newGraph.FName := 'graph';
  // check name for unique and generate new name if it needed
  repeat
    isUniqueName := True;
    for i := 0 to FGraphs.Count - 1 do
    begin
      if FGraphs.List[i].FName = newGraph^.FName then // name must be unique
      begin
        p2 := Length(newGraph^.FName);
        if newGraph^.FName[p2] = ')' then
        begin
          p1 := p2;
          while (newGraph^.FName[p1] <> '(') and (p1 > 1) do p1 := p1 - 1;
          if newGraph^.FName[p1] = '(' then
          begin
            s := Copy(newGraph^.FName, p1 + 1, p2 - p1 - 1);
            if IsIntegerNumber(s) then
            begin
              num := StrToInt(s);
              newGraph^.FName := Copy(newGraph^.FName, 1, p1) + IntToStr(num + 1) + ')';
            end else newGraph^.FName := newGraph^.FName + '(1)';
          end else newGraph^.FName := newGraph^.FName + '(1)';
        end else newGraph^.FName := newGraph^.FName + '(1)';
        isUniqueName := False;
        Break;
      end;
    end;
  until isUniqueName;
  FGraphs.Add(newGraph^);
  if freqList.IndexOf(graph.FN) < 0 then
  begin
    freqList.Add(graph.FN);
    freqList.Sort;
  end;
end;

procedure TGraphSeries.DeleteGraphs(i, count: Byte);
begin
  FGraphs.DeleteRange(i, count);
  FActive := nil;
end;

procedure TGraphSeries.SetActive(i: Word);
begin
  FActive := @(FGraphs.List[i]);
end;

function TGraphSeries.GetCount: Word;
begin
  Result := FGraphs.Count;
end;

function TGraphSeries.GetName: String;
begin
  if FActive = nil then raise Exception.Create('Graphs list is empty.');
  Result := FActive.FName;
end;

procedure TGraphSeries.SetName(s: String);
begin
  if FActive = nil then raise Exception.Create('Graphs list is empty.');
  FActive.FName := s;
end;

function TGraphSeries.GetNote: String;
begin
  if FActive = nil then raise Exception.Create('Graphs list is empty.');
  Result := FActive.FNote;
end;

procedure TGraphSeries.SetNote(s: String);
begin
  if FActive = nil then raise Exception.Create('Graphs list is empty.');
  FActive.FNote := s;
end;

function TGraphSeries.GetYAxisName: String;
begin
  if FActive = nil then raise Exception.Create('Graphs list is empty.');
  Result := FActive.FYAxisName;
end;

procedure TGraphSeries.SetYAxisName(s: String);
begin
  if FActive = nil then raise Exception.Create('Graphs list is empty.');
  FActive.FYAxisName := s;
end;

function TGraphSeries.GetN: Real;
begin
  if FActive = nil then raise Exception.Create('Graphs list is empty.');
  Result := FActive.FN;
end;

procedure TGraphSeries.SetN(n: Real);
begin
  if FActive = nil then raise Exception.Create('Graphs list is empty.');
  FActive.FN := n;
end;

function TGraphSeries.GetGraphType: Byte;
begin
  if FActive = nil then raise Exception.Create('Graphs list is empty.');
  Result := FActive.FGraphType;
end;

procedure TGraphSeries.SetGraphType(t: Byte);
begin
  if FActive = nil then raise Exception.Create('Graphs list is empty.');
  FActive.FGraphType := t;
end;

function TGraphSeries.GetNI: Word;
begin
  if FActive = nil then raise Exception.Create('Graphs list is empty.');
  Result := FActive.FIntN;
end;

function TGraphSeries.GetXI: TRealVector;
begin
  if FActive = nil then raise Exception.Create('Graphs list is empty.');
  Result := Copy(FActive.FIntX);
end;

function TGraphSeries.GetYI: TRealVector;
begin
  if FActive = nil then raise Exception.Create('Graphs list is empty.');
  Result := Copy(FActive.FIntY);
end;

end.
