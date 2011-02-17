unit Ac2SQUtl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, DBCtrls, DAO_TLB;

procedure AccessToSQL(AccessFileName, SQLFileName: string; Msgs: TStrings);

implementation

uses
  ArDBUtls, AccUtl, Variants;

const
  Acc2SQLDataType: array [1 .. $17] of string = (
    'bool_int', { dbBoolean }
    'integer', { dbByte }
    'integer', { dbInteger }
    'integer', { dbLong }
    'currency', { dbCurrency }
    'float', { dbSingle }
    'float', { dbDouble }
    'datetime', { dbDate }
    'text', { dbBinary }
    'varchar', { dbText }
    'text', { dbLongBinary }
    'text', { dbMemo }
    'none', 'none', 'text', { dbGUID }
    'integer', { dbBigInt }
    'text', { dbVarBinary }
    'varchar', { dbChar }
    'float', { dbNumeric }
    'float', { dbDecimal }
    'float', { dbFloat }
    'time', { dbTime }
    'datetime' { dbTimeStamp }
  );


procedure ConvertAccessToSQL(DBAcc: Database; StringSQL, Msgs: TStrings);
  procedure CreateFields(VTableDef: TableDef);
  var
    j, k: Integer;
    DataTypeName, S: string;
  begin
    with VTableDef.Fields do
      for j := 0 to Count - 1 do
      begin
        with Item[j] do
        begin
          if (Attributes and dbAutoIncrField) <> 0 then
            {DataTypeName := 'AUTOINC_INT'}
            DataTypeName := 'integer'
          else
            DataTypeName := Acc2SQLDataType[type_];
          S := Format('    ''%s'' %s', [name, DataTypeName]);
          case type_ of
            dbText, dbChar:
              begin
                S := S + Format('(%d)', [Size]);
              end
          end;
          if Required or ((Attributes and dbAutoIncrField) <> 0) then
            S := S + ' not null';
          for k := 0 to VTableDef.Indexes.Count - 1 do
          begin
            if (VTableDef.Indexes[k].Fields.Count = 1) and (VTableDef.Indexes[k].Fields.Item[0].Name = Name) then
            begin
              if VTableDef.Indexes[k].Primary then
              begin
                S := S + ' primary key';
                if VTableDef.Indexes[j].Fields.Item[0].Attributes = dbDescending then
                  S := S + ' DESC';
                if (Attributes and dbAutoIncrField) <> 0 then
                  S := S + ' autoincrement'
              end
              else if VTableDef.Indexes[k].Unique then
              begin
                S := S + ' unique';
              end;
            end;
          end;
          if j <> Count - 1 then
            S := S + ',';
          StringSQL.Add(S);
        end;
      end;
  end;
  
  procedure CreateIndexes(VTableDef: TableDef);
  var
    s, r: string;
    k, n, i: Smallint;
  begin
    with VTableDef, Indexes do
    begin
      n := Count;
      if n <> 0 then
      begin
        for i := 0 to n - 1 do
          with Item[i] do if (Fields.Count > 1) and (Primary or Unique) then
          begin
            r := '  CONSTRAINT ' + Name;
            if Primary then
            begin
              r := r + ' PRIMARY KEY';
            end
            else if Unique then
            begin
              r := r + ' UNIQUE';
            end;
            s := '';
            for k := 0 to Fields.Count - 1 do
            begin
              if s = '' then
                s := Fields.Item[k].Name
              else
                s := s + ',' + Fields.Item[k].Name;
            end;
            StringSQL[StringSQL.Count-1] := StringSQL[StringSQL.Count-1] + ',';
            StringSQL.Add(r + '(' + s + ')');
          end;
      end;
    end;
  end;
  procedure CreateForeignKeys(ARelations: Relations; AMasterRel: TList);
  var
    j, k: Smallint;
    s, d, r: string;
  begin
    with AMasterRel do
    begin
      for j := 0 to Count - 1 do
      begin
	with ARelations.Item[Integer(Items[j])] do
	begin
	  s := Fields.Item[0].Name;
	  d := Fields.Item[0].ForeignName;
	  for k := 1 to Fields.Count - 1 do
	  begin
	    s := s + ',' + Fields.Item[k].Name;
	    d := d + ',' + Fields.Item[k].ForeignName;
	  end;
	  r := Format('  CONSTRAINT %s FOREIGN KEY (%s)'#13#10'    REFERENCES %s(%s)',
		      [Name, s, ForeignTable, d]);
	  if Attributes and dbRelationUpdateCascade <> 0 then
	    r := r + ' ON UPDATE CASCADE'
	  else
	    r := r + ' ON UPDATE RESTRICT';
          if Attributes and dbRelationDeleteCascade <>0 then
       	    r := r + ' ON DELETE CASCADE'
	  else
	    r := r + ' ON DELETE RESTRICT';
          StringSQL[StringSQL.Count-1] := StringSQL[StringSQL.Count-1] + ',';
	  StringSQL.Add(r);
	end;
      end;
    end;
  end;
var
  VTableDef: TableDef;
  VTableName: string;
  i: Smallint;
  VTableList, ProcDefs, ProcImpl: TStrings;
  DetailRels: array of TList; // TList used as Integer list
begin
  // Creando encabezado:
  with StringSQL do
  begin
    Add('/* Header');
    Add('');
    Add('  ' + FormatDateTime(LongDateFormat + ' ' + LongTimeFormat, Now));
    Add('');
    Add('  Warning:');
    Add('');
    Add('    This module has been created automatically.');
    Add('    Do not modify it manually or the changes will be lost the next update');
    Add('');
    Add('');
    Add('*/');
  end;
  Msgs.Clear;
  Msgs.BeginUpdate;
  VTableList := TStringList.Create;
  ProcDefs := TStringList.Create;
  ProcImpl := TStringList.Create;
  try
    GetAccTableNamesByRefIntOrder(DBAcc, VTableList);
    with DBAcc do
    begin
      SetLength(DetailRels, VTableList.Count);
      for i := 0 to VTableList.Count - 1 do
      begin
        DetailRels[i] := TList.Create;
      end;
      try
        with Relations do
        begin
          for i := 0 to Count - 1 do
          begin
            DetailRels[VTableList.IndexOf(Item[i].ForeignTable)].Add(Pointer(i));
          end;
        end;
        for i := 0 to VTableList.Count - 1 do
        begin
          VTableName := VTableList.Strings[i];
          VTableDef := TableDefs.Item[VTableName];
          // StringSQL.Add(Format('DROP TABLE %s;', [VTableName]));
          StringSQL.Add(Format('CREATE TABLE %s(', [VTableName]));
          CreateFields(VTableDef);
          CreateIndexes(VTableDef);
          CreateForeignKeys(DBAcc.Relations, DetailRels[i]);
          StringSQL.Add(');');
        end;
      finally
        for i := VTableList.Count - 1 downto 0 do
        begin
          DetailRels[i].Free;
        end;
      end;
    end;
  finally
    SecureFree(VTableList);
    ProcDefs.Free;
    ProcImpl.Free;
    Msgs.EndUpdate;
  end;
end;

procedure AccessToSQL(AccessFileName, SQLFileName: string; Msgs: TStrings);
var
  DBAcc: Database;
  StringSQL: TStrings;
begin
  if not Assigned(Engine) then
    Engine := CoDBEngine.Create;
  StringSQL := TStringList.Create;
  try
    DBAcc := Engine.OpenDatabase(AccessFileName, 0, true, '');
    try
      ConvertAccessToSQL(DBAcc, StringSQL, Msgs);
    finally
      DBAcc.Close;
    end;
    StringSQL.SaveToFile(SQLFileName);
  finally
    StringSQL.Free;
  end;
end;

end.
