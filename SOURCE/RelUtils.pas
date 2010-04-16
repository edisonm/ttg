unit RelUtils;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DbUtils, kbmMemTable, Variants;

type ERelationUtils = class(Exception);

function StringToScaped(const AString: string): string;
function ScapedToString(const AString: string): string; overload;
function ScapedToString(const AString: string; var i: Integer): string; overload;
function GetOldFieldValues(ADataSet: TDataSet; const AFieldNames: string): Variant;
procedure CheckMasterRelationUpdate(AMaster: TDataSet; ADetail: TKbmMemTable;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
procedure CheckMasterRelationDelete(AMaster: TDataSet; ADetail: TKbmMemTable;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
procedure CheckDetailRelation(AMaster: TKbmMemTable; ADetail: TDataSet;
  const AMasterFields, ADetailFields: string);

function CheckRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string; AProblem: TDataSet): Boolean; overload;
function CheckRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string): Boolean; overload;
procedure doErrorRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string);
function CompareField(Field: TField; Value: Variant): Boolean;
function CompareRecord(Fields: TList; KeyValue: Variant): Boolean;
function CompareVarArray(v1, v2: Variant): Boolean;
procedure SaveDataSetToCSVFile(ADataSet: TDataSet; const AFileName: TFileName);
procedure SaveDataSetToStrings(ADataSet:TDataSet; AStrings: TStrings);
procedure LoadDataSetFromCSVFile(ADataSet: TDataSet; const AFileName: TFileName);

procedure LoadDataSetFromStrings(ADataSet: TDataSet; AStrings: TStrings;
  var Position: Integer);

implementation

function GetOldFieldValues(ADataSet: TDataSet; const AFieldNames: string): Variant;
var
  I: Integer;
  Fields: TList;
begin
  if Pos(';', AFieldNames) <> 0 then
  begin
    Fields := TList.Create;
    try
      ADataSet.GetFieldList(Fields, AFieldNames);
      Result := VarArrayCreate([0, Fields.Count - 1], varVariant);
      for I := 0 to Fields.Count - 1 do
        Result[I] := TField(Fields[I]).OldValue;
    finally
      Fields.Free;
    end;
  end else
    Result := ADataSet.FieldByName(AFieldNames).OldValue
end;

function CompareField(Field: TField; Value: Variant): Boolean;
var
  S: string;
begin
  if Field.DataType = ftString then begin
    S := Field.AsString;
    Result := AnsiCompareStr(S, Value) = 0;
  end
  else Result := (Field.Value = Value);
end;

function CompareVarArray(v1, v2: Variant): Boolean;
var
  i, min, max: Integer;
begin
  Result := True;
  if VarIsArray(v1) and VarIsArray(v2) then
  begin
    min := VarArrayLowBound(v1, 1);
    max := VarArrayHighBound(v1, 1);
    if (min = VarArrayLowBound(v2, 1)) and (max = VarArrayHighBound(v2, 1)) then
    begin
      for i := min to max do
      begin
        Result := Result and (v1[i] = v2[i]);
        if not Result then Exit;
      end;
    end
    else
      Result := False;
  end
  else
  begin
    try
      Result := (v1 = v2);
    except
      Result := False;
    end;
  end;
end;

function CompareRecord(Fields: TList; KeyValue: Variant): Boolean;
var
  I: Integer;
  FieldCount: Integer;
begin
  FieldCount := Fields.Count;
  if FieldCount = 1 then
    Result := CompareField(TField(Fields.First), KeyValue)
  else begin
    Result := True;
    for I := 0 to FieldCount - 1 do
      Result := Result and CompareField(TField(Fields[I]), KeyValue[I]);
  end;
end;

procedure CheckMasterRelationUpdate(AMaster: TDataSet; ADetail: TkbmMemTable;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
var
  vo, vn: Variant;
  bBookmark: TBookmark;
  OldIndexFieldNames: string;
  VFields: TList;
begin
  with ADetail do
    if not (Eof and Bof) then
    begin
      DisableControls;
      VFields := TList.Create;
      try
        GetFieldList(VFields, ADetailFields);
        vo := GetOldFieldValues(AMaster, AMasterFields);
        vn := AMaster.FieldValues[AMasterFields];
        if not CompareVarArray(vo, vn) then
        begin
          CheckBrowseMode;
          bBookmark := GetBookmark;
          try
            try
              OldIndexFieldNames := IndexFieldNames;
              IndexFieldNames := ADetailFields;
              try
                if Locate(ADetailFields, vo, []) then
                begin
                  if ACascade then
                  begin
                    repeat
                      Edit;
                      FieldValues[ADetailFields] := vn;
                      Post;
                      Next;
                    until not CompareRecord(VFields, vo);
                  end
                  else
                    raise ERelationUtils.CreateFmt('Ya existen campos relacionados en la tabla %s', [Name]);
                end;
              finally
                IndexFieldNames := OldIndexFieldNames;
              end;
            finally
              try
                if BookmarkValid(bBookmark) then
                  GotoBookmark(bBookmark);
              except
              end;
            end;
          finally
            FreeBookmark(bBookmark);
          end;
        end;
      finally
        EnableControls;
        VFields.Free;
      end;
    end;
end;

procedure CheckMasterRelationDelete(AMaster: TDataSet; ADetail: TKbmMemTable;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
var
  vo: Variant;
  bBookmark: TBookmark;
  OldIndexFieldNames: string;
  VFields: TList;
  DSDetail: TDataSource;
begin
  with ADetail do
  begin
    DisableControls;
    DSDetail := MasterSource;
    MasterSource := nil;
    try
      if not (Eof and Bof) then
      begin
        VFields := TList.Create;
        try
          GetFieldList(VFields, ADetailFields);
          vo := GetOldFieldValues(AMaster, AMasterFields);
          bBookmark := GetBookmark;
          try
            try
              OldIndexFieldNames := IndexFieldNames;
              IndexFieldNames := ADetailFields;
              try
                if Locate(ADetailFields, vo, []) then
                begin
                  if ACascade then
                  begin
                      // Se puede optimizar
                    while not (Eof and Bof) and CompareRecord(VFields, vo) do
                      Delete;
                  end
                  else
                    raise ERelationUtils.CreateFmt('Ya existen registros detalle en la tabla %s', [Name]);
                end;
              finally
                IndexFieldNames := OldIndexFieldNames;
              end;
            finally
              try
                if BookmarkValid(bBookmark) then
                  GotoBookmark(bBookmark);
              except
              end;
            end;
          finally
            FreeBookmark(bBookmark);
          end;
        finally
          VFields.Free;
        end;
      end;
    finally
      MasterSource := DSDetail;
      EnableControls;
    end;
  end;
end;

procedure CheckDetailRelation(AMaster: TKbmMemTable; ADetail: TDataSet;
  const AMasterFields, ADetailFields: string);
var
  bBookmark: TBookmark;
  DSMaster: TDataSource;
begin
  with AMaster do
  begin
    DisableControls;
    DSMaster := MasterSource;
    MasterSource := nil;
    try
      if not (Eof and Bof) then
      begin
        bBookmark := GetBookmark;
        try
          try
            if not Locate(AMasterFields, ADetail.FieldValues[ADetailFields], []) then
              raise ERelationUtils.CreateFmt('No existe registro maestro en la tabla %s', [AMaster.Name]);
          finally
            try
              if Assigned(bBookmark) and BookmarkValid(bBookmark) then
                GotoBookmark(bBookmark);
            except
            end;
          end;
        finally
          if Assigned(bBookmark) then
            FreeBookmark(bBookmark);
        end;
      end;
    finally
      MasterSource := DSMaster;
      EnableControls;
    end;
  end;
end;

//Retorna verdadero si hubo problemas

function CheckRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string;
  AProblem: TDataSet): Boolean;
var
  v: Variant;
  s: string;
  i: Integer;
begin
  Result := False;
  with ADetail do
  begin
    DisableControls;
    if AProblem.FieldCount = 0 then
      AProblem.FieldDefs.Assign(ADetail.FieldDefs);
    s := '';
    for i := 0 to AProblem.FieldDefs.Count - 1 do
    begin
      if s = '' then
        s := AProblem.FieldDefs[i].Name
      else
        s := s + ';' + AProblem.FieldDefs[i].Name;
    end;
    try
      First;
      while not Eof do
      begin
        v := FieldValues[ADetailFields];
        if not AMaster.Locate(AMasterFields, v, []) then
        begin
          AProblem.Append;
          AProblem.FieldValues[s] := FieldValues[s];
          Result := True;
        end;
        Next;
      end;
    finally
      EnableControls;
    end;
  end;
end;

function CheckRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string): Boolean;
var
  v: Variant;
begin
  Result := False;
  with ADetail do
  begin
    DisableControls;
    try
      First;
      while not Eof do
      begin
        v := FieldValues[ADetailFields];
        if not AMaster.Locate(AMasterFields, v, []) then
        begin
          Result := True;
          Exit;
        end;
        Next;
      end;
    finally
      EnableControls;
    end;
  end;
end;

procedure doErrorRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string);
begin
  if CheckRelation(AMaster, ADetail, AMasterFields, ADetailFields) then
    raise ERelationUtils.CreateFmt('Error verificando relación entre %s y %s.  Campos detallados no tienen maestro',
      [AMaster.Name, ADetail.Name]);
end;

function StringToScaped(const AString: string): string;
var
  i, l: Integer;
begin
  Result := '"';
  l := Length(AString);
  for i := 1 to l do
  begin
    case AString[i] of
      #13 : Result := Result + '\n';
      #10 : Result := Result + '\r';
      '\' : Result := Result + '\\';
      '''': Result := Result + '\''';
      '"' : Result := Result + '\"';
    else
      Result := Result + AString[i]
    end
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

procedure SaveDataSetToStrings0(ADataSet:TDataSet; AStrings: TSTrings);
var
  s, v: string;
  i: Integer;
begin
  for i := 0 to ADataSet.FieldCount - 1 do
  begin
    if ADataSet.Fields[i].FieldKind = fkData then
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
        if ADataSet.Fields[i].FieldKind = fkData then
        begin
          v := StringToScaped(ADataSet.Fields[i].AsString);
          s := s + v + ';';
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
  AStrings.Add('// ' + ADataSet.Name);
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

procedure LoadDataSetFromStrings0(ADataSet: TDataSet; AStrings: TStrings;
  var Position: Integer; RecordCount: Integer);
var
  s, v: string;
  j, l, Pos, Limit: Integer;
  Fields: array of TField;
  Field: TField;
begin
  s := AStrings.Strings[Position];
  Pos := 2;
  l := 0;
  Inc(Position);
  while True do
  begin
    v := ScapedToString(s, Pos);
    if v = '' then
      break;
    Field := ADataSet.FindField(v);
    if Assigned(Field) then
    begin
      Inc(l);
      SetLength(Fields, l);
      Fields[l - 1] := Field;
    end;
    Inc(Pos, 3);
  end;
  ADataSet.DisableControls;
  try
    Limit := Position + RecordCount;
    while Position < Limit do
    begin
      ADataSet.Append;
      Pos := 2;
      s := AStrings[Position];
      for j := 0 to l - 1 do
      begin
        v := ScapedToString(s, Pos);
        Fields[j].AsString := v;
        Inc(Pos, 3);
      end;
      ADataSet.Post;
      Inc(Position);
    end;
  finally
    ADataSet.EnableControls;
  end;
end;

procedure LoadDataSetFromStrings(ADataSet: TDataSet; AStrings: TStrings;
  var Position: Integer);
var
  RecordCount: Integer;
begin
  Inc(Position); // Skip Table Name
  RecordCount := StrToInt(AStrings.Strings[Position]);
  Inc(Position);
  LoadDataSetFromStrings0(ADataSet, AStrings, Position, RecordCount);
end;

procedure LoadDataSetFromCSVFile(ADataSet: TDataSet; const AFileName: TFileName);
var
  AStrings: TStrings;
  Position: Integer;
begin
  AStrings := TStringList.Create;
  try
    AStrings.LoadFromFile(AFileName);
    Position := 0;
    LoadDataSetFromStrings0(ADataSet, AStrings, Position, AStrings.Count - 1);
  finally
    AStrings.Free;
  end;
end;

end.

