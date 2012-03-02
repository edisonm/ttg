{ -*- mode: Delphi -*- }
unit UTTGBasics;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, Variants;

type
  TDynamicBooleanArray = array of Boolean;
  TDynamicBooleanArrayArray = array of TDynamicBooleanArray;
  TDynamicDoubleArray = array of Double;
  TDynamicIntegerArray = array of Integer;
  TDynamicIntegerArrayArray = array of TDynamicIntegerArray;
  TDynamicIntegerArrayArrayArray = array of TDynamicIntegerArrayArray;
  TDynamicStringArray = array of string;
  PIntegerArray = ^TIntegerArray;
  TIntegerArray = array [0 .. 16383] of Integer;
  PIntegerArrayArray = ^TIntegerArrayArray;
  TIntegerArrayArray = array [0 .. 0] of PIntegerArray;
  PBooleanArray = ^TBooleanArray;
  TBooleanArray = array [0 .. 16383] of Boolean;
  
type
  generic TArrayToString<T,E> = class
  public
    class function ValueToString(const Value: array of T; const Separator: string = ' '): string;
  end;
  
  TIntToString = class
  public
    class function ValueToString(const Value: Integer; const Separator: string): string;
  end;
  
  TIntArrayToString = specialize TArrayToString<Integer,TIntToString>;
  TIntArrayArrayToString = specialize TArrayToString<TDynamicIntegerArray,TIntArrayToString>;

procedure EqualSpaced(Strings: TStrings; ini, fin: Integer; const delim: string);
function ExtractString(const Strings: string; var Pos: Integer; Separator: Char): string;
procedure LoadNames(Source, Destination: TStrings);
function NullToZero(A: Variant): Variant;
function VarArrToStr(v: Variant; Separator: string = '; '): string;
function RandomIndexes(Length: Integer): TDynamicIntegerArray;

implementation

procedure EqualSpaced(Strings: TStrings; ini, fin: Integer; const delim: string);
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

procedure LoadNames(Source, Destination: TStrings);
var
  i: Integer;
begin
  Destination.Clear;
  for i := 0 to Source.Count - 1 do
    Destination.Add(Source.Names[i]);
end;

function NullToZero(A: Variant): Variant;
begin
  if VarIsNull(A) then
    Result := 0
  else
    Result := A;
end;
  
class function TIntToString.ValueToString(const Value: Integer; const Separator: string): string;
begin
  Result := IntToStr(Value);
end;

class function TArrayToString.ValueToString(const Value: array of T; const Separator: string = ' '): string;
var
  i: Integer;
  SElement: string;
begin
  Result := '';
  begin
    for i := Low(Value) to High(Value) do
    begin
      SElement := E.ValueToString(Value[i], Separator);
      if Result = '' then
        Result := SElement
      else
        Result := Result + Separator + SElement;
    end;
    Result := '[' + Result + ']';
  end
end;

function VarArrToStr(v: Variant; Separator: string = '; '): string;
var
  i: Integer;
begin
  Result := '';
  if VarIsArray(v) then
  begin
    for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
    begin
      if Result = '' then
        Result := VarArrToStr(v[i])
      else
        Result := Result + Separator + VarArrToStr(v[i]);
    end;
    Result := '[' + Result + ']';
  end
  else
    Result := VarToStr(v);
end;

function RandomIndexes(Length: Integer): TDynamicIntegerArray;
var
  I, N, Tmp: Integer;
begin
  SetLength(Result, Length);
  for I := 0 to Length - 1 do
    Result[I] := I;
  for I := 0 to Length - 1 do
  begin
    N := Random(Length - I);
    if N <> 0 then
    begin
      Tmp := Result[I];
      Result[I] := Result[N + I];
      Result[N + I] := Tmp;
    end;
  end;
end;

end.

