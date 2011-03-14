unit HorColCm;

{$I ttg.inc}

interface

uses
  Classes, Dialogs, Db, DBGrids, SysUtils, Variants;

function ComposicionADuracion(const s: string): Integer;
function NullToZero(A: Variant): Variant;
procedure EqualSpaced(Strings: TStrings; ini, fin: Integer; delim: string);
procedure LoadStringsFromDataSet(Strings: TStrings; DataSet: TDataSet;
  FieldNames: string; Title, Column: Boolean);
function DisplayLabels(ADataSet: TDataSet; const AFieldNames: string): string;
procedure LoadNames(Source, Destination: TStrings);
procedure SearchInField(AField: TField; AValue: Variant);
procedure SearchInDBGrid(DBGrid: TDBGrid);
function VarArrToStr(v: Variant; Separator: string = '; '): string;
function ExtractString(const Strings: string; var Pos: Integer; Separator:
  Char): string;

implementation

function ComposicionADuracion(const s: string): Integer;
var
  VPos, d: Integer;
begin
  VPos := 1;
  Result := 0;
  while VPos <= Length(s) do
  begin
    d := StrToInt(ExtractString(s, VPos, '.'));
    if d <= 0 then
      raise Exception.Create('Composicion Erroea');
    Inc(Result, d);
  end;
end;

function VarArrToStr(v: Variant; Separator: string = '; '): string;
var
  i: Integer;
begin
  Result := '';
  if VarIsArray(v) then begin
    for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do begin
      if Result = '' then
        Result := v[i]
      else
        Result := Result + Separator + VarToStr(v[i]);
    end;
  end
  else
    Result := VarToStr(v);
end;

function DisplayLabels(ADataSet: TDataSet; const AFieldNames: string): string;
var
  iPos: Integer;
begin
  iPos := 1;
  Result := '';
  while iPos <= Length(AFieldNames) do
  begin
    if Result <> '' then
      Result := Result + ';';
    Result := Result + ADataSet.FindField(ExtractFieldName(AFieldNames, iPos)).DisplayLabel;
  end;
end;

procedure LoadStringsFromDataSet(Strings: TStrings; DataSet: TDataSet;
  FieldNames: string; Title, Column: Boolean);
var
  k: Variant;
  VMin, VMax: Integer;
begin
  with DataSet do begin
    First;
    VMin := Strings.Count;
    if Title then Strings.Add(DisplayLabels(DataSet, FieldNames));
    while not EOF do begin
      k := FieldValues[FieldNames];
      Strings.Add(VarArrToStr(k));
      Next;
    end;
    First;
    VMax := Strings.Count - 1;
  end;
  if Column then EqualSpaced(Strings, VMin, VMax, ';');
end;

procedure EqualSpaced(Strings: TStrings; ini, fin: Integer; delim: string);
var
  Max, Com, i, k: Integer;
  s, d: string;
begin
  Com := 1;
  while True do begin
//    if Finalice then Exit;
    Max := -MaxLongint - 1;
    for i := ini to fin do begin
      s := Copy(Strings[i], Com, Length(Strings[i]) - Com + 1);
      if Pos(delim, s) = 0 then exit;
      if Max < Pos(delim, s) then Max := Pos(delim, s);
    end;
    for i := ini to fin do begin
      s := Copy(Strings[i], Com, Length(Strings[i]) - Com + 1);
      k := Pos(delim, s);
      SetLength(d, Max - k + 1);
      FillChar(d[1], Length(d), ' ');
      s := Strings[i];
      Insert(d, s, Com + k);
      Strings[i] := s;
    end;
    Com := Com + Max + 1;
  end;
end;

function NullToZero(A: Variant): Variant;
begin
  if VarIsNull(A) then
    Result := 0
  else
    Result := A;
end;

procedure LoadNames(Source, Destination: TStrings);
var
  i: Integer;
begin
  Destination.Clear;
  for i := 0 to Source.Count - 1 do
    Destination.Add(Source.Names[i]);
end;

procedure SearchInDBGrid(DBGrid: TDBGrid);
var
  s: string;
begin
  if Assigned(DBGrid.DataSource) and Assigned(DBGrid.SelectedField) then
    with DBGrid.SelectedField do
    begin
      s := AsString;
      if InputQuery('Buscar por ' + DisplayLabel, DisplayName, s) then
        SearchInField(DBGrid.SelectedField, s);
    end;
end;

procedure SearchInField(AField: TField; AValue: Variant);
var
  v: Variant;
begin
  if Assigned(AField) then
  begin
    with AField do
    begin
      if FieldKind = fkData then
        DataSet.Locate(FieldName, AValue, [loCaseInsensitive, loPartialKey])
      else if FieldKind = fkLookup then
      begin
        if LookupDataSet.Locate(LookupResultField, AValue, [loCaseInsensitive,
          loPartialKey]) then
        begin
          v := LookupDataSet.FieldByName(LookupKeyFields).Value;
          DataSet.Locate(KeyFields, v, []);
        end;
      end;
    end;
  end;
end;

function ExtractString(const Strings: string; var Pos: Integer; Separator:
  Char): string;
var
  I: Integer;
begin
  I := Pos;
  while (I <= Length(Strings)) and (Strings[I] <> Separator) do Inc(I);
  Result := Trim(Copy(Strings, Pos, I - Pos));
  if (I <= Length(Strings)) and (Strings[I] = Separator) then Inc(I);
  Pos := I;
end;

end.

