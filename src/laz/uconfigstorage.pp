unit UConfigStorage;

{$I ttg.inc}

interface

uses
   SysUtils, Classes;

type
   TConfigStorage = class(TComponent)
   private
      FConfigStrings: TStrings;
      function GetValues(const Index: string): string;
      procedure SetValues(const Index, Value: string);
      function GetTexts(const Index: string): string;
      procedure SetTexts(const Index, Value: string);
      function GetIntegers(const Index: string): Integer;
      procedure SetIntegers(const Index: string; Value: Integer);
      function GetBooleans(const Index: string): Boolean;
      procedure SetBooleans(const Index: string; Value: Boolean);
      function GetFloats(const Index: string): Extended;
      procedure SetFloats(const Index: string; Value: Extended);
   public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      property ConfigStrings: TStrings read FConfigStrings;
      property Values[const Index: string]: string
                                               read GetValues
                                               write SetValues;
      property Integers[const Index: string]: Integer
                                                 read GetIntegers
                                                 write SetIntegers;
      property Booleans[const Index: string]: Boolean
                                                 read GetBooleans
                                                 write SetBooleans;
      property Texts[const Index: string]: string
                                              read GetTexts
                                              write SetTexts;
      property Floats[const Index: string]: Extended
                                               read GetFloats
                                               write SetFloats;
   end;
   
implementation

uses
  URelUtils;

constructor TConfigStorage.Create(AOwner: TComponent);
begin
   inherited;
   FConfigStrings := TStringList.Create;
end;

destructor TConfigStorage.Destroy;
begin
   FConfigStrings.Free;
   inherited;
end;

function TConfigStorage.GetValues(const Index: string): string;
begin
  Result := ConfigStrings.Values[Index];
end;

procedure TConfigStorage.SetValues(const Index: string; const Value: string);
begin
  ConfigStrings.Values[Index] := Value;
end;

function TConfigStorage.GetIntegers(const Index: string): Integer;
var
  s: string;
begin
  s := Values[Index];
  if s = '' then
    Result := 0
  else
    Result := StrToInt(s);
end;

procedure TConfigStorage.SetIntegers(const Index: string; Value: Integer);
begin
  Values[Index] := IntToStr(Value);
end;

function TConfigStorage.GetBooleans(const Index: string): Boolean;
var
  s: string;
begin
  s := Values[Index];
  if s = '' then
    Result := False
  else
    Result := StrToBool(s);
end;

procedure TConfigStorage.SetBooleans(const Index: string; Value: Boolean);
begin
  Values[Index] := BoolToStr(Value);
end;

function TConfigStorage.GetTexts(const Index: string): string;
begin
  Result := ScapedToString(Values[Index]);
end;

procedure TConfigStorage.SetTexts(const Index: string; const Value: string);
begin
  Values[Index] := StringToScaped(Value);
end;


function TConfigStorage.GetFloats(const Index: string): Extended;
var
  s: string;
begin
  s := Values[Index];
  if s = '' then
    Result := 0
  else
    Result := StrToFloat(s);
end;

procedure TConfigStorage.SetFloats(const Index: string;
  Value: Extended);
begin
  Values[Index] := FloatToStr(Value);
end;

end.
