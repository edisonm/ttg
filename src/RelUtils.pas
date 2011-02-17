unit RelUtils;

{$I TTG.inc}

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Dialogs, Db, SqlitePassDbo;

type ERelationUtils = class(Exception);

function StringToScaped(const AString: string): string;
function ScapedToString(const AString: string): string; overload;
function ScapedToString(const AString: string; var i: Integer): string; overload;
function GetOldFieldValues(ADataSet: TDataSet; const AFieldNames: string): Variant;
procedure CheckMasterRelationUpdate(AMaster: TDataSet; ADetail: TSqlitePassDataset;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
procedure CheckMasterRelationDelete(AMaster: TDataSet; ADetail: TSqlitePassDataset;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
procedure CheckDetailRelation(AMaster: TDataSet; ADetail: TSqlitePassDataset;
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
procedure LoadDataSetFromDataSet(ATarget, ASource: TDataSet);
procedure LoadDataSetFromStrings(ADataSet: TDataSet; AStrings: TStrings;
  var Position: Integer);
procedure PrepareQuery(const AQuery: TSqlitePassDataset; const ATableName, AIndexedBy: string);

implementation

uses
  Variants;

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

procedure CheckMasterRelationUpdate(AMaster: TDataSet; ADetail: TSqlitePassDataset;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
var
  vo, vn: Variant;
  bBookmark: TBookmark;
  OldIndexedBy: string;
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
              OldIndexedBy := IndexedBy;
              IndexedBy := ADetailFields;
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
                IndexedBy := OldIndexedBy;
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

procedure CheckMasterRelationDelete(AMaster: TDataSet; ADetail: TSqlitePassDataset;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
var
  vOld: Variant;
  bBookmark: TBookmark;
  OldIndexedBy: string;
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
          vOld := GetOldFieldValues(AMaster, AMasterFields);
          bBookmark := GetBookmark;
          try
            try
              OldIndexedBy := IndexedBy;
              IndexedBy := ADetailFields;
              try
                if Locate(ADetailFields, vOld, []) then
                begin
                  if ACascade then
                  begin
                      // Se puede optimizar
                    while not (Eof and Bof) and CompareRecord(VFields, vOld) do
                      Delete;
                  end
                  else
                    raise ERelationUtils.CreateFmt('Ya existen registros detalle en la tabla %s', [Name]);
                end;
              finally
                IndexedBy := OldIndexedBy;
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
{
function VarIsNull2(const Value: Variant): Boolean;
var
  i: Integer;
begin
  Result := VarIsNull(Value);
  if VarIsArray(Value) then
  begin
    Result := true;
    for i := VarArrayLowBound(Value, 1) to VarArrayHighBound(Value, 1) do
    begin
      Result := Result and VarIsNull(Value[i]);
    end;
  end;
end;
}
function VarToStr2(const Value: Variant): string;
var
  i: Integer;
begin
  Result := '';
  if VarIsArray(Value) then
  begin
    for i := VarArrayLowBound(Value, 1) to VarArrayHighBound(Value, 1) do
    begin
      Result := Result + ' ' + VarToStrDef(Value[i], '(Null)');
    end;
  end
  else
    Result := VarToStrDef(Value, '(Null)');
end;

procedure CheckDetailRelation(AMaster: TDataSet; ADetail: TSqlitePassDataset;
  const AMasterFields, ADetailFields: string);
var
  bBookmark: TBookmark;
  Value: Variant;
  s: string;
begin
  with AMaster do
  if not (Assigned(ADetail.MasterSource) and ADetail.MasterSource.Enabled
        and Assigned(ADetail.MasterSource.DataSet)
        and (ADetail.MasterSource.DataSet = AMaster))
    then // this condition avoids an undesirable loop in DoBeforePost
         // that causes a key violation, and also is an optimization:
         // We do not need to verify master-detail relationship if the tables
         // are already linked using the MasterSource property.
  begin
    DisableControls;
    try
      if not (Eof and Bof) then
      begin
        bBookmark := GetBookmark;
        try
          try
            Value := ADetail.FieldValues[ADetailFields];
            if not Locate(AMasterFields, Value, []) then
            begin
              s := VarToStr2(Value);
              raise ERelationUtils.CreateFmt('No existe registro maestro en %s para %s.[%s]=%s',
                [AMaster.Name, ADetail.Name, ADetailFields, S]);
            end;
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
      EnableControls;
    end;
  end;
end;

// Returns true in case of problems

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
    raise ERelationUtils.CreateFmt('Error verificando relacion entre %s y %s.  Campos detallados no tienen maestro',
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
          s := s + StringToScaped(ADataSet.Fields[i].AsString) + ';';
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

procedure LoadDataSetFromStrings0(ADataSet: TDataSet; AStrings: TStrings;
  var Position: Integer; RecordCount: Integer);
var
  s, v: string;
  i, j, l, m, Pos, Limit: Integer;
  Fields: array of TField;
  Field: TField;
  ExtraFields: array of TField;
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
  m := 0;
  for i := ADataSet.Fields.Count - 1  downto 0 do
  begin
    Field := ADataSet.Fields[i];
    if Field.Lookup or Field.Calculated then
    begin
      ADataSet.Fields.Remove(Field);
      Inc(m);
      SetLength(ExtraFields, m);
      ExtraFields[m - 1] := Field;
    end;
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
        Fields[j].Value := v;
        Inc(Pos, 3);
      end;
      ADataSet.Post;
      Inc(Position);
    end;
  finally
    for i := m - 1 downto 0 do
      ADataSet.Fields.Add(ExtraFields[i]);
    ADataSet.EnableControls;
  end;
end;

procedure LoadDataSetFromDataSet(ATarget, ASource: TDataSet);
var
  i, j, l: Integer;
  SourceFields, TargetFields: array of TField;
  SourceField, TargetField: TField;
begin
  l := 0;
  for i := 0 to ATarget.Fields.Count -1 do
  begin
    TargetField := ATarget.Fields[i];
    SourceField := ASource.FindField(TargetField.FieldName);
    if Assigned(SourceField) then
    begin
      Inc(l);
      SetLength(TargetFields, l);
      TargetFields[l - 1] := TargetField;
      SetLength(SourceFields, l);
      SourceFields[l - 1] := SourceField;
    end;
  end;
  ATarget.DisableControls;
  ASource.DisableControls;
  try
    ASource.First;
    while not ASource.Eof do
    begin
      ATarget.Append;
      for j := 0 to l - 1 do
      begin
        TargetFields[j].Value := SourceFields[j].Value;
      end;
      ATarget.Post;
      ASource.Next;
    end;
  finally
    ATarget.EnableControls;
    ASource.EnableControls;
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

procedure PrepareQuery(const AQuery: TSqlitePassDataset; const ATableName, AIndexedBy: string);
begin
  with AQuery do
  begin
    Close;
//    FileName := ':memory:';
    DatasetName := ATableName + 'Tmp';
    IndexedBy := AIndexedBy;
    //if not TableExists then CreateTable;
    Open;
  end;
end;

end.

