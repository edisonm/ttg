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
  generic TArrayHandler<T,E> = class
  public
    type
      TArrayOfT = array of T;
      class function ValueToString(const Value: TArrayOfT; const Separator: string = ' '): string;
      class function Clone(const Value: TArrayOfT): TArrayOfT;
      class procedure Copy(const Source: TArrayOfT; var Target: TArrayOfT);
      class function IndexOf(const Source: TArrayOfT; const Value: T): Integer;
      class function Push(Vector: TArrayOfT; const Value: T): Integer;
      class procedure PushBack(Vector: TArrayOfT; const Value: T);
  end;
  
  TIntegerHandler = class
  public
    class function ValueToString(const Value: Integer; const Separator: string): string; inline;
    class function Clone(const Value: Integer): Integer; inline;
    class procedure Copy(const Source: Integer; var Target: Integer); inline;
  end;
  
  TIntegerArrayHandler = class(specialize TArrayHandler<Integer,TIntegerHandler>)
  public
    class function Product(const Vector1, Vector2: TDynamicIntegerArray): Integer;
  end;
  TIntegerArrayArrayHandler = specialize TArrayHandler<TDynamicIntegerArray,TIntegerArrayHandler>;
  
procedure EqualSpaced(Strings: TStrings; ini, fin: Integer; const delim: string);
function ExtractString(const Strings: string; var Pos: Integer; Separator: Char): string;
procedure LoadNames(Source, Destination: TStrings);
function NullToZero(A: Variant): Variant;
function VarArrToStr(v: Variant; Separator: string = '; '): string;
function RandomIndexes(Length: Integer): TDynamicIntegerArray; overload;
function RandomIndexes(Length, Limit: Integer): TDynamicIntegerArray; overload;
function RandomUniform(a, b: Integer): Integer;

implementation

uses
  Math;

class function TIntegerHandler.Clone(const Value: Integer): Integer; inline;
begin
  Result := Value;
end;

class procedure TIntegerHandler.Copy(const Source: Integer; var Target: Integer); inline;
begin
  Target := Source;
end;

class function TIntegerArrayHandler.Product(const Vector1, Vector2: TDynamicIntegerArray): Integer;
var
  i, n: Integer;
begin
  Result := 0;
  n := Min(High(Vector1), High(Vector2));
  for i := 0 to n do
    Result := Result + Vector1[i] * Vector2[i];
end;

class function TArrayHandler.Push(Vector: TArrayOfT; const Value: T): Integer;
begin
  Result := IndexOf(Vector, Value);
  if Result = -1 then
  begin
    PushBack(Vector, Value);
    Result := High(Vector);
  end;
end;

class procedure TArrayHandler.PushBack(Vector: TArrayOfT; const Value: T);
var
  Count: Integer;
begin
  Count := Length(Vector);
  SetLength(Vector, Count + 1);
  Vector[Count] := Value;
end;

class function TArrayHandler.Clone(const Value: TArrayOfT): TArrayOfT;
var
  i: Integer;
begin
  SetLength(Result, Length(Value));
  for i := 0 to High(Value) do
  begin
    Result[i] := E.Clone(Value[i]);
  end;
end;

class procedure TArrayHandler.Copy(const Source: TArrayOfT; var Target: TArrayOfT);
var
  i: Integer;
begin
  for i := 0 to High(Source) do
  begin
    E.Copy(Source[i], Target[i]);
  end;
end;

class function TArrayHandler.IndexOf(const Source: TArrayOfT; const Value: T): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to High(Source) do
  begin
    if Source[i] = Value then
    begin
      Result := i;
      exit;
    end;
  end;
end;

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
  
class function TIntegerHandler.ValueToString(const Value: Integer; const Separator: string): string;
begin
  Result := IntToStr(Value);
end;

class function TArrayHandler.ValueToString(const Value: TArrayOfT; const Separator: string = ' '): string;
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
        Result := VarToStr(v[i])
      else
        Result := Result + Separator + VarToStr(v[i]);
    end;
  end
  else
    Result := VarToStr(v);
end;

function RandomIndexes(Length, Limit: Integer): TDynamicIntegerArray;
var
  I, N: Integer;
  Numbers: TDynamicIntegerArray;
begin
  SetLength(Result, Length);
  SetLength(Numbers, Limit);
  for I := 0 to Limit - 1 do
    Numbers[I] := I;
  for I := 0 to Length - 1 do
  begin
    N := Random(Limit - I);
    if N <> 0 then
    begin
      Result[I] := Numbers[N + I];
      Numbers[N + I] := Numbers[I];
    end;
  end;
end;

function RandomIndexes(Length: Integer): TDynamicIntegerArray;
begin
  Result := RandomIndexes(Length, Length);
end;

function RandomUniform(a, b: Integer): Integer;
begin
  Result := a + Random(b - a + 1);
end;

end.

