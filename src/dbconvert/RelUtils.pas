{ -*- mode: Delphi -*- }
unit RelUtils;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DbUtils;

type ERelationUtils = class(Exception);
function GetOldFieldValues(ADataSet: TDataSet; const AFieldNames: string): Variant;
procedure CheckMasterRelationUpdate(AMaster, ADetail: TDataSet;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
procedure CheckMasterRelationDelete(AMaster, ADetail: TDataSet;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
procedure CheckDetailRelation(AMaster, ADetail: TDataSet;
  const AMasterFields, ADetailFields: string);
function CheckRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string;
  AProblem: TDataSet): Boolean; overload;
function CheckRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string): Boolean; overload;
procedure doErrorRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string);

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

var
  CheckingRelations: Boolean = False;

procedure CheckMasterRelationUpdate(AMaster, ADetail: TDataSet;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
var
  vo, vn: Variant;
  bBookmark: TBookmark;
begin
  if not CheckingRelations then
    with ADetail do
    begin
      CheckingRelations := True;
      DisableControls;
      try
        vo := GetOldFieldValues(AMaster, AMasterFields);
        vn := AMaster.FieldValues[AMasterFields];
        if vo <> vn then
        begin
          CheckBrowseMode;
          bBookmark := GetBookmark;
          try
            try
              if Locate(ADetailFields, vo, []) then
              begin
              // Se puede optimizar
                if ACascade then
                begin
                  while Locate(ADetailFields, vo, []) do
                  begin
                    Edit;
                    FieldValues[ADetailFields] := vn;
                    Post;
                  end;
                end
                else
                  raise ERelationUtils.CreateFmt('Ya existen campos relacionados en la tabla %s', [Name]);
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
        CheckingRelations := False;
        EnableControls;
      end;
    end;
end;

//Retorna verdadero si hubo problemas

procedure doErrorRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string);
begin
  if CheckRelation(AMaster, ADetail, AMasterFields, ADetailFields) then
    raise ERelationUtils.CreateFmt('Error verificando relación entre %s y %s.  Campos detallados no tienen maestro', [AMaster.Name, ADetail.Name]);
end;

function CheckRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string;
  AProblem: TDataSet): Boolean;
var
  v: Variant;
  s: string;
  i: Integer;
begin
  Result := False;
  if not CheckingRelations then
    with ADetail do
    begin
      CheckingRelations := True;
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
        CheckingRelations := False;
        EnableControls;
      end;
    end;
end;

function CheckRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string): Boolean;
var
  v: Variant;
begin
  Result := False;
  if not CheckingRelations then
    with ADetail do
    begin
      CheckingRelations := True;
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
        CheckingRelations := False;
        EnableControls;
      end;
    end;
end;

procedure CheckMasterRelationDelete(AMaster, ADetail: TDataSet;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
var
  vo: Variant;
  bBookmark: TBookmark;
begin
  if not CheckingRelations then
    with ADetail do
    begin
      CheckingRelations := True;
      DisableControls;
      try
        vo := GetOldFieldValues(AMaster, AMasterFields);
        if Locate(ADetailFields, vo, []) then
        begin
          if ACascade then
          begin
            // Se puede optimizar
            bBookmark := GetBookmark;
            try
              try
                while Locate(ADetailFields, vo, []) do
                  Delete;
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
          end
          else
            raise ERelationUtils.CreateFmt('Ya existen registros detalle en la tabla %s', [Name]);
        end;
      finally
        CheckingRelations := False;
        EnableControls;
      end;
    end;
end;

procedure CheckDetailRelation(AMaster, ADetail: TDataSet;
  const AMasterFields, ADetailFields: string);
var
  bBookmark: TBookmark;
begin
  if not CheckingRelations then
    with AMaster do
    begin
      CheckingRelations := True;
      DisableControls;
      try
        bBookmark := GetBookmark;
        try
          try
            if not Locate(AMasterFields, ADetail.FieldValues[ADetailFields], []) then
              raise ERelationUtils.CreateFmt('No existe registro maestro en la tabla %s', [AMaster.Name]);
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
        CheckingRelations := False;
        EnableControls;
      end;
    end;
end;

end.

