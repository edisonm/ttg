{ -*- mode: Delphi -*- }
unit UDataSetToStrings;

interface

uses
  Db, Classes, Forms, SysUtils;

type
  TFieldArray = array of TField;
  
function FieldNamesToFieldArray(ADataSet: TDataSet; const AFieldNames: string): TFieldArray;
function StringToScaped(const AString: string): string;
function ScapedToString(const AString: string): string; overload;
function ScapedToString(const AString: string; var i: Integer): string; overload;
procedure SaveDataSetToStrings(ADataSet:TDataSet; AStrings: TStrings);
procedure SaveDataSetToStrings0(ADataSet:TDataSet; AStrings: TSTrings);
procedure SaveDataSetToCSVFile(ADataSet: TDataSet; const AFileName: TFileName);

implementation

function StringToScaped(const AString: string): string;
var
  i, l: Integer;
begin
  Result := '"';
  l := Length(AString);
  i := 1;
  while i <= l do
  begin
    case AString[i] of
      #13 :
        if (i < l) and (AString[i+1] = #10) then
        begin
          Result := Result + '\n\r';
          inc(i);
        end
        else
          Result := Result + '\n';
      #10 : Result := Result + '\n\r';
      '\' : Result := Result + '\\';
      '''': Result := Result + '\''';
      '"' : Result := Result + '\"';
    else
      Result := Result + AString[i]
    end;
    inc(i);
  end;
  Result := Result + '"';
end;

function ScapedToString(const AString: string): string;
var
  i: Integer;
begin
  i := 2;
  Result := ScapedToString(AString, i);
end;

function ScapedToString(const AString: string; var i: Integer): string;
var
  l: Integer;
begin
  Result := '';
  l := Length(AString);
  while i <= l do
  begin
    case AString[i] of
    '\' :
    begin
      Inc(i);
      case AString[i] of
        'n': Result := Result + #13;
        'r': Result := Result + #10;
      else
        Result := Result + AString[i];
      end
    end;
    '"' : Exit;
    else
      Result := Result + AString[i];
    end;
    inc(i);
  end;
end;

function FieldNamesToFieldArray(ADataSet: TDataSet; const AFieldNames: string): TFieldArray;
var
  FieldName: string;
  l, Pos: Integer;
  Field: TField;
begin
  Pos := 2;
  l := 0;
  while True do
  begin
    FieldName := ScapedToString(AFieldNames, Pos);
    if FieldName = '' then
      break;
    Field := ADataSet.FindField(FieldName);
    Inc(l);
    SetLength(Result, l);
    Result[l - 1] := Field;
    Inc(Pos, 3);
  end;
end;

procedure SaveDataSetToStrings0(ADataSet:TDataSet; AStrings: TSTrings);
var
  s: string;
  i: Integer;
begin
  s := '';
  for i := 0 to ADataSet.FieldCount - 1 do
  begin
    if (ADataSet.Fields[i].FieldKind = fkData)
//      and (ADataSet.Fields[i].DataType <> ftAutoInc)
    then
    begin
      s := s + StringToScaped(ADataSet.Fields[i].FieldName) + ';';
    end
  end;
  AStrings.Add(s);
  ADataSet.DisableControls;
  try
    ADataSet.First;
    while not ADataSet.Eof do
    begin
      s := '';
      for i := 0 to ADataSet.FieldCount - 1 do
      begin
        if (ADataSet.Fields[i].FieldKind = fkData)
//          and (ADataSet.Fields[i].DataType <> ftAutoInc)
        then
        begin
          if ADataSet.Fields[i].DataType in [ftDate, ftDateTime, ftTime, ftTimeStamp] then
            s := s + StringToScaped(FormatDateTime('yyyy-mm-dd hh:nn:ss',
              ADataSet.Fields[i].AsDateTime)) + ';'
          else
            s := s + StringToScaped(ADataSet.Fields[i].AsString) + ';';
        end;
      end;
      AStrings.Add(s);
      ADataSet.Next;
    end;
  finally
    ADataSet.EnableControls;
  end;
end;

procedure SaveDataSetToStrings(ADataSet:TDataSet; AStrings: TStrings);
begin
  AStrings.Add(IntToStr(ADataSet.RecordCount));
  SaveDataSetToStrings0(ADataSet, AStrings);
end;

procedure SaveDataSetToCSVFile(ADataSet: TDataSet; const AFileName: TFileName);
var
  AStrings: TStrings;
begin
  AStrings := TStringList.Create;
  try
    SaveDataSetToStrings0(ADataSet, AStrings);
    AStrings.SaveToFile(AFileName);
  finally
    AStrings.Free;
  end;
end;

end.
