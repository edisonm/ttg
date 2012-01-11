unit Ac2DMUtl;
{
  Unidad que provee de los métodos esenciales para realizar la conversión de
  Access a Módulo de datos de tablas en memoria.
}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, Messages, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, Db, StdCtrls, DBCtrls, DAO_TLB;

type
  EInitAc2PxUtl = class(Exception);

procedure AccessToDataModule(AccessFileName, DataModuleName,
  DataModuleFileName, ADataSetClass, AUnits: string;
  ACreateDataSource, // Create TDataSource components
  ACreateSrcIndexes, // Code in .pas
  ACreateIndexDefs,  // Code in .dfm
  ACreateSrcFields,  // Code in .pas
  ACreateFieldDefs,  // Code in .dfm
  ACreateDfmFields,   // Code in .dfm
  ACreateSrcRels,
  ALazarusFrm: Boolean;
  Msgs: TStrings);

implementation

uses
  ArDBUtls, AccUtl, Variants;

const
  Acc2DMFieldClassName: array [1 .. $17] of string = (
    'TBooleanField', { dbBoolean }
    'TSmallintField', { dbByte }
    'TLargeintField', { dbInteger }
    'TLargeintField', { dbLong }
    'TCurrencyField', { dbCurrency }
    'TFloatField', { dbSingle }
    'TFloatField', { dbDouble }
    'TDateTimeField', { dbDate }
    'TBytesField', { dbBinary }
    'TStringField', { dbText }
    'TLargeintField', { dbLongBinary }
    'TMemoField', { dbMemo }
    '', '', 'TGuidField', { dbGUID }
    'TLargeintField', { dbBigInt }
    'TVarBytesField', { dbVarBinary }
    'TStringField', { dbChar }
    'TFloatField', { dbNumeric }
    'TFloatField', { dbDecimal }
    'TFloatField', { dbFloat }
    'TTimeField', { dbTime }
    'TDateTimeField' { dbTimeStamp }
  );
  Acc2DMFieldType: array [1 .. $17] of TFieldType = (
    ftBoolean, { dbBoolean }
    ftSmallint, { dbByte }
    ftLargeint, { dbInteger }
    ftLargeint, { dbLong }
    ftCurrency, { dbCurrency }
    ftFloat, { dbSingle }
    ftFloat, { dbDouble }
    ftDateTime, { dbDate }
    ftBytes, { dbBinary }
    ftString, { dbText }
    ftLargeint, { dbLongBinary }
    ftMemo, { dbMemo }
    ftUnknown, ftUnknown, ftGuid, { dbGUID }
    ftLargeint, { dbBigInt }
    ftVarBytes, { dbVarBinary }
    ftString, { dbChar }
    ftFloat, { dbNumeric }
    ftFloat, { dbDecimal }
    ftFloat, { dbFloat }
    ftTime, { dbTime }
    ftDateTime { dbTimeStamp }
  );
  Acc2DMFieldTypeName: array [1 .. $17] of string = (
    'ftBoolean', { dbBoolean }
    'ftSmallint', { dbByte }
    'ftLargeint', { dbInteger }
    'ftLargeint', { dbLong }
    'ftCurrency', { dbCurrency }
    'ftFloat', { dbSingle }
    'ftFloat', { dbDouble }
    'ftDateTime', { dbDate }
    'ftBytes', { dbBinary }
    'ftString', { dbText }
    'ftLargeint', { dbLongBinary }
    'ftMemo', { dbMemo }
    'ftUnknown', 'ftUnknown', 'ftGuid', { dbGUID }
    'ftLargeint', { dbBigInt }
    'ftVarBytes', { dbVarBinary }
    'ftString', { dbChar }
    'ftFloat', { dbNumeric }
    'ftFloat', { dbDecimal }
    'ftFloat', { dbFloat }
    'ftTime', { dbTime }
    'ftDateTime' { dbTimeStamp }
                                                    );
  sBoolean: array [Boolean] of string = ('False', 'True');

resourcestring
  SInitAc2PxUtl = 'Imposible inicializar Ac2PxUtl';

function EscapeStrForm(const s: String): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(s) do
  begin
    if (31 < Ord(s[i])) and (Ord(s[i]) < 128) then
      Result := Result + s[i]
    else
      Result := Result + '''#' + IntToStr(Ord(s[i])) + ''''
  end
end;

procedure ConvertAccessToDataModule(DBAcc: Database; const DataModuleName,
  DataModuleFileName, ADataSetClass, AUnits: string;
  ACreateDataSource, // Create TDataSource components
  ACreateSrcIndexes, // Code in .pas
  ACreateIndexDefs,  // Code in .dfm
  ACreateSrcFields,  // Code in .pas
  ACreateFieldDefs,  // Code in .dfm
  ACreateDfmFields,  // Code in .dfm
  ACreateSrcRels,
  ALazarusFrm: Boolean;
  StringDFM, StringPAS, Msgs: TStrings);
  procedure CreateFieldDefs(ATableDef: TableDef);
  var
    j: Integer;
    DataTypeName: string;
  begin
    StringDFM.Add('    FieldDefs = <');
    with ATableDef.Fields do
      for j := 0 to Count - 1 do
      begin
        with Item[j] do
        begin
          StringDFM.Add('      item');
          StringDFM.Add(Format('        Name = ''%s''', [name]));
          if (Attributes and dbAutoIncrField) <> 0 then
            DataTypeName := 'ftAutoInc'
          else
            DataTypeName := Acc2DMFieldTypeName[type_];
          if Required then
            StringDFM.Add('        Attributes = [faRequired]');
          StringDFM.Add(Format('        DataType = %s', [DataTypeName]));
          case Acc2DMFieldType[type_] of
            ftString, ftBytes, ftVarBytes:
              begin
                StringDFM.Add('        Precision = -1');
                StringDFM.Add(Format('        Size = %d', [Size]));
              end
          end;
          StringDFM.Add('      end');
        end;
      end;
    with StringDFM do
      Strings[Count - 1] := Strings[Count - 1] + '>';
  end;
  procedure CreateSrcFields(ATableDef: TableDef);
  var
    j: Integer;
    DataTypeName: string;
  begin
    StringPAS.Add(Format('  with Tb%s.FieldDefs do', [ATableDef.Name]));
    StringPAS.Add('  begin');
    with ATableDef.Fields do
      for j := 0 to Count - 1 do
      begin
        with Item[j] do
        begin
          if (Attributes and dbAutoIncrField) <> 0 then
            DataTypeName := 'ftAutoInc'
          else
            DataTypeName := Acc2DMFieldTypeName[type_];
          StringPAS.Add(Format('    add(''%s'', ''%s'', ''%s'', %s)',
              [name, DataTypeName, Size, sBoolean[Required]]));
        end;
      end;
    StringPAS.Add('  end;');
  end;
  procedure SetExtraFieldProps(ATableDef: TableDef);
  var
    j: Integer;
    s: string;
  begin
    with ATableDef.Fields do
      for j := 0 to Count - 1 do
      begin
        with Item[j] do
        begin
          try
            s := VarToStr(Properties['Caption']);
          except
            s := Name;
          end;
          if s <> Name then
            StringPAS.Add(Format('    Add(''Tb%s.%s=%s'');', [ATableDef.Name,
              Name, s]));
        end;
      end;
  end;
  procedure CreateDfmFields(ATableDef: TableDef);
  var
    j: Integer;
    VFieldClassName, s: string;
    vv: Variant;
  begin
    with ATableDef.Fields do
      for j := 0 to Count - 1 do
      begin
        with Item[j] do
        begin
          {if not ALazarusFrm and ((Attributes and dbAutoIncrField) <> 0) then
            VFieldClassName := 'TAutoIncField'}
          if Attributes and dbAutoIncrField <> 0 then
            VFieldClassName := 'TLargeIntField'
          else
            VFieldClassName := Acc2DMFieldClassName[type_];
          StringDFM.Add(Format('    object Tb%s%s: %s', [ATableDef.Name, Name,
              VFieldClassName]));
          try
            s := VarToStr(Properties['Caption']);
          except
            s := Name;
          end;
          if s <> Name then
            StringDFM.Add('      DisplayLabel = ''' + EscapeStrForm(s) + '''');
          StringDFM.Add('      FieldName = ''' + Name + '''');
          if Required then
            StringDFM.Add('      Required = True');
          vv := DefaultValue;
          if not VarIsNull(vv) and (vv <> '') then
            StringDFM.Add
              (Format('      DefaultExpression = ''%s''', [VarToStr(vv)]));
          case Acc2DMFieldType[type_] of
            ftString, ftBytes, ftVarBytes:
              if Size <> 20 then
                StringDFM.Add(Format('      Size = %d', [Size]));
          end;
          StringDFM.Add('    end');
          StringPAS.Add(Format('    Tb%s%s:%s;', [ATableDef.Name, Name,
              VFieldClassName]));
        end;
      end;
  end;
  procedure CreateSrcIndexes(ATableDef: TableDef);
  var
    s, d, o: string;
    k, n, i: Smallint;
  begin
    with ATableDef, Indexes do
    begin
      n := Count;
      if n <> 0 then
      begin
        StringPAS.Add(Format('  with Tb%s do', [ATableDef.Name]));
        StringPAS.Add('  begin');
//        StringPAS.Add(Format('    IndexDefs.Capacity := %d;', [n]));
        for i := 0 to n - 1 do
          with Item[i] do
          begin
            s := '';
            d := '';
            for k := 0 to Fields.Count - 1 do
            begin
              if s = '' then
                s := Fields.Item[k].Name
              else
                s := s + ';' + Fields.Item[k].Name;
              if Fields.Item[k].Attributes = dbDescending then
              begin
                if d = '' then
                  d := Fields.Item[k].Name
                else
                  d := d + ';' + Fields.Item[k].Name;
              end;
            end;
            o := '';
            if d <> '' then
            begin
              if o = '' then
                o := 'ixDescending'
              else
                o := o + ', ' + 'ixDescending';
            end;
            if Primary then
            begin
              if o = '' then
                o := 'ixPrimary'
              else
                o := o + ', ' + 'ixPrimary';
            end;
            if Unique then
            begin
              if o = '' then
                o := 'ixUnique'
              else
                o := o + ', ' + 'ixUnique';
            end;
            if d <> '' then
              StringPAS.Add
                (Format('    AddIndex(''Tb%s%s'', ''%s'', [%s], %s);',
                  [ATableDef.name, Name, s, o, d]))
            else
              StringPAS.Add(Format('    AddIndex(''Tb%s%s'', ''%s'', [%s]);',
                  [ATableDef.name, Name, s, o]));
          end;
        StringPAS.Add('  end;');
      end;
    end;
  end;

  function GetFields(Item: Index): string;
  var
    k: Integer;
  begin
    Result := '';
    with Item do if Primary then
    begin
      for k := 0 to Fields.Count - 1 do
      begin
        if Result = '' then
          Result := Fields.Item[k].Name
        else
          Result := Result + ';' + Fields.Item[k].Name;
      end;
    end;
  end;

  function GetDescFields(Item: Index): string;
  var
    k: Integer;
  begin
    Result := '';
    with Item do for k := 0 to Fields.Count - 1 do
    begin
      if Fields.Item[k].Attributes = dbDescending then
      begin
        if Result = '' then
          Result := Fields.Item[k].Name
        else
          Result := Result + ';' + Fields.Item[k].Name;
      end;
    end;
  end;

  procedure CreateIndexDefs(ATableDef: TableDef);
  var
    s, d, o: string;
    n, i: Smallint;
  begin
    with ATableDef, Indexes do
    begin
      n := Count;
      if n <> 0 then
      begin
        StringDFM.Add('    IndexDefs = <');
        for i := 0 to n - 1 do
          with Item[i] do
          begin
            StringDFM.Add('      item');
            (*
              try
              VTableDef.Fields.Item[Name];
              s := 'ix' + Name;
              except
              s := Name;
              end;
              *)
            s := Name;
            StringDFM.Add(Format('        Name = ''Tb%s%s''', [ATableDef.Name, s]));
            s := GetFields(Item[i]);
            d := GetDescFields(Item[i]);
            o := '';
            if d <> '' then
            begin
              if o = '' then
                o := 'ixDescending'
              else
                o := o + ', ' + 'ixDescending';
            end;
            if Primary then
            begin
              if o = '' then
                o := 'ixPrimary'
              else
                o := o + ', ' + 'ixPrimary';
            end;
            if Unique then
            begin
              if o = '' then
                o := 'ixUnique'
              else
                o := o + ', ' + 'ixUnique';
            end;
            if s <> '' then
              StringDFM.Add(Format('        Fields = ''%s''', [s]));
            if d <> '' then
              StringDFM.Add(Format('        DescFields = ''%s''', [d]));
            if o <> '' then
              StringDFM.Add(Format('        Options = [%s]', [o]));
            if i <> n - 1 then
              StringDFM.Add('      end')
            else
              StringDFM.Add('      end>');
          end;
      end;
    end;
  end;
  function GetPrimaryKey(ATableDef: TableDef): Index;
  var
    n, i: Smallint;
  begin
    with ATableDef, Indexes do
    begin
      n := Count;
      if n <> 0 then
      begin
        for i := 0 to n - 1 do
          with Item[i] do
          begin
            if Primary then
            begin
              Result := Item[i];
              Break;
            end;
          end;
      end;
    end;
  end;
  function GetPrimaryKeyFields(ATableDef: TableDef): string;
  begin
    Result := GetFields(GetPrimaryKey(ATableDef));
  end;

var
  i, j, k: Smallint;
  s, d, PrimaryKeyFields, VTableName: string;
  ProcDefs, ProcImpl: TStrings;
  MasterRels, DetailRels: array of TList; // TList used as Integer list
  VTableDef: TableDef;
  VTableList: TStrings;
begin
  // Creando encabezado:
  with StringPAS do
  begin
    Add(Format('unit %s;', [ExtractFileName(DataModuleFileName)]));
    Add('');
    Add('(*');
    Add('  ' + FormatDateTime(ShortDateFormat + ' ' + ShortTimeFormat, Now));
    Add('');
    Add('  Warning:');
    Add('');
    Add('    This module has been created automatically.');
    Add('    Do not modify it manually or the changes will be lost the next update');
    Add('');
    Add('');
    Add('*)');
    Add('');
    Add('{$IFDEF FPC}');
    Add('{$MODE Delphi}');
    Add('{$ENDIF}');
    Add('');
    Add('interface');
    Add('');
    Add('uses');
    Add('  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF},');
    Add('  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,');
    if AUnits <> '' then
      Add('  DBase, ' + AUnits + ';')
    else
      Add('  DBase;');
    Add('');
    Add('type');
    Add(Format('  T%s = class(TBaseDataModule)', [DataModuleName]));
  end;
  StringDFM.Add(Format('inherited %s: T%s', [DataModuleName, DataModuleName]));
  StringDFM.Add('  OnCreate = DataModuleCreate');
  StringDFM.Add('  OnDestroy = nil');
  Msgs.Clear;
  Msgs.BeginUpdate;
  VTableList := TStringList.Create;
  ProcDefs := TStringList.Create;
  ProcImpl := TStringList.Create;
  try
    GetAccTableNamesByRefIntOrder(DBAcc, VTableList);
    with DBAcc do
    begin
      SetLength(MasterRels, VTableList.Count);
      SetLength(DetailRels, VTableList.Count);
      for i := 0 to VTableList.Count - 1 do
      begin
        MasterRels[i] := TList.Create;
        DetailRels[i] := TList.Create;
      end;
      try
        if ACreateSrcRels then with Relations do
        begin
          for i := 0 to Count - 1 do
          begin
            MasterRels[VTableList.IndexOf(Item[i].Table)].Add(Pointer(i));
            DetailRels[VTableList.IndexOf(Item[i].ForeignTable)].Add(Pointer(i));
          end;
        end;
        for i := 0 to VTableList.Count - 1 do
        begin
          VTableName := VTableList.Strings[i];
          VTableDef := TableDefs.Item[VTableName];
          StringPAS.Add(Format('    Tb%s: T%s;', [VTableName, ADataSetClass]));
          StringDFM.Add(Format('  object Tb%s: T%s', [VTableName, ADataSetClass]));
          if i <> 0 then
            StringDFM.Add(Format('    Tag = %d', [i]));
          StringDFM.Add('    Connection = Database');
          StringDFM.Add(Format('    TableName = ''%s''', [VTableName]));
          //if ASetPrimaryKey then
          begin
            PrimaryKeyFields := GetPrimaryKeyFields(VTableDef);
            if PrimaryKeyFields <> '' then
              StringDFM.Add(Format('    IndexFieldNames = ''%s''', [PrimaryKeyFields]));
          end;
          if ACreateFieldDefs then
            CreateFieldDefs(VTableDef);
          {else
            StringDFM.Add('    FieldDefs = <>');}
          if ACreateIndexDefs then
            CreateIndexDefs(VTableDef);
          StringDFM.Add(Format('    Left = %d', [48 + 96 * (i mod 5)]));
          StringDFM.Add
            (Format('    Top = %d', [48 + 96 * (i div 5) + 12 *
                ((i mod 5) mod 2)]));
          if ACreateDfmFields then
            CreateDfmFields(VTableDef);
          StringDFM.Add('  end');
          if ACreateDataSource then
          begin
            StringDFM.Add(Format('  object DS%s: TDataSource', [VTableName]));
            StringDFM.Add(Format('    DataSet = Tb%s', [VTableName]));
            StringDFM.Add(Format('    Left = %d', [48 + 8 + 96 * (i mod 5)]));
            StringDFM.Add
              (Format('    Top = %d', [48 - 8 + 96 * (i div 5) + 12 *
                  ((i mod 5) mod 2)]));
            StringDFM.Add('  end');
            StringPAS.Add(Format('    DS%s: TDataSource;', [VTableName]));
          end;
          // LoadIndexes(VTableDef);
          // LoadRelations
        end;
        StringDFM.Add('end');
        with StringPAS do
        begin
          Add('');
          AddStrings(ProcDefs);
          Add('    procedure DataModuleCreate(Sender: TObject);');
          Add('  private');
          Add('  public');
          Add('  end;');
          Add('var');
          Add(Format('  %s: T%s;', [DataModuleName, DataModuleName]));
          Add('');
          Add('implementation');
          Add('');
          Add('{$IFNDEF FPC}');
          Add('{$R *.DFM}');
          Add('{$ENDIF}');
          Add('');
          AddStrings(ProcImpl);
          Add('');
          Add(Format('procedure T%s.DataModuleCreate(Sender: TObject);',
              [DataModuleName]));
          Add('begin');
          Add('  inherited;');
          Add('  OnDestroy := DataModuleDestroy;');
          Add(Format('  SetLength(FTables, %d);', [VTableList.Count]));
          if ACreateSrcRels then
          begin
            Add(Format('  SetLength(FMasterRels, %d);', [VTableList.Count]));
            Add(Format('  SetLength(FDetailRels, %d);', [VTableList.Count]));
            Add(Format('  SetLength(FBeforePostLocks, %d);', [VTableList.Count]));
          end;
          for i := 0 to VTableList.Count - 1 do
          begin
            d := VTableList[i];
            Add(Format('  Tables[%d] := Tb%s;', [i, d]));
            if (DetailRels[i].Count > 0) or (MasterRels[i].Count > 0) then
            begin
              Add(Format('  Tb%s.BeforePost := DataSetBeforePost;', [d]));
            end;
            with MasterRels[i] do
              if Count > 0 then
                StringPAS.Add(Format('  Tb%s.BeforeDelete := DataSetBeforeDelete;', [d]));
          end;
          if ACreateSrcFields then
            for i := 0 to VTableList.Count - 1 do
              CreateSrcFields(TableDefs.Item[VTableList.Strings[i]]);
          if ACreateSrcIndexes then
            for i := 0 to VTableList.Count - 1 do
              CreateSrcIndexes(TableDefs.Item[VTableList.Strings[i]]);
          for i := 0 to VTableList.Count - 1 do
          begin
            with MasterRels[i] do
            begin
              if Count > 0 then
                StringPAS.Add(Format('  SetLength(FMasterRels[%d], %d);', [i, Count]));
              for j := 0 to Count - 1 do
              begin
                with Relations.Item[Integer(Items[j])] do
                begin
                  s := Fields.Item[0].Name;
                  d := Fields.Item[0].ForeignName;
                  for k := 1 to Fields.Count - 1 do
                  begin
                    s := s + ';' + Fields.Item[k].Name;
                    d := d + ';' + Fields.Item[k].ForeignName;
                  end;
                  StringPAS.Add(Format('  with FMasterRels[%d, %d] do', [i, j]));
                  StringPAS.Add('  begin');
                  StringPAS.Add(Format('    DetailDataSet := Tb%s;', [ForeignTable]));
                  StringPAS.Add(Format('    MasterFields := ''%s'';', [d]));
                  StringPAS.Add(Format('    DetailFields := ''%s'';', [s]));
                  StringPAS.Add(Format('    Cascade := %s;',
                    [sBoolean[(Attributes and dbRelationUpdateCascade) <> 0]]));
                  StringPAS.Add('  end;');
                end;
              end;
            end;
            with DetailRels[i] do
            begin
              if Count > 0 then
                StringPAS.Add(Format('  SetLength(FDetailRels[%d], %d);', [i, Count]));
              for j := 0 to Count - 1 do
              begin
                with Relations.Item[Integer(Items[j])] do
                begin
                  s := Fields.Item[0].Name;
                  d := Fields.Item[0].ForeignName;
                  for k := 1 to Fields.Count - 1 do
                  begin
                    s := s + ';' + Fields.Item[k].Name;
                    d := d + ';' + Fields.Item[k].ForeignName;
                  end;
                  StringPAS.Add(Format('  with FDetailRels[%d, %d] do', [i, j]));
                  StringPAS.Add('  begin');
                  StringPAS.Add(Format('    MasterDataSet := Tb%s;', [Table]));
                  StringPAS.Add(Format('    MasterFields := ''%s'';', [s]));
                  StringPAS.Add(Format('    DetailFields := ''%s'';', [d]));
                  StringPAS.Add('  end;');
                end;
              end;
            end;
          end;
          Add('  with DataSetNameList do');
          Add('  begin');
          for i := 0 to VTableList.Count - 1 do
          begin
            d := VTableList[i];
            Add(Format('    Add(''Tb%s=%s'');', [d, d]));
          end;
          Add('  end;');
          Add('  with FieldCaptionList do');
          Add('  begin');
          for i := 0 to VTableList.Count - 1 do
            SetExtraFieldProps(TableDefs.Item[VTableList[i]]);
          Add('  end;');
          Add('  with DataSetDescList do');
          Add('  begin');
          for i := 0 to VTableList.Count - 1 do
          begin
            d := VTableList[i];
            try
              s := DBAcc.TableDefs[d].Properties['Description'].Value;
            except
              s := d;
            end;
            Add(Format('    Add(''Tb%s=%s'');', [d, s]));
          end;
          Add('  end;');
          Add('end;');
          Add('');
          Add('initialization');
          Add('{$IFDEF FPC}');
          Add(Format('  {$i %s.lrs}', [ExtractFileName(DataModuleFileName)]));
          Add('{$ENDIF}');
          Add('end.');
          Add('');
        end;
      finally
        for i := VTableList.Count - 1 downto 0 do
        begin
          DetailRels[i].Free;
          MasterRels[i].Free;
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

procedure AccessToDataModule(AccessFileName, DataModuleName,
  DataModuleFileName, ADataSetClass, AUnits: string;
  ACreateDataSource, // Create TDataSource components
  ACreateSrcIndexes, // Code in .pas
  ACreateIndexDefs,  // Code in .dfm
  ACreateSrcFields,  // Code in .pas
  ACreateFieldDefs,  // Code in .dfm
  ACreateDfmFields,  // Code in .dfm
  ACreateSrcRels,
  ALazarusFrm: Boolean;
  Msgs: TStrings);
var
  DBAcc: Database;
  StringDFM, StringPAS: TStrings;
  FormExtension, UnitExtension: string;
begin
  if not Assigned(Engine) then
    Engine := CoDBEngine.Create;
  StringDFM := TStringList.Create;
  StringPAS := TStringList.Create;
  try
    DBAcc := Engine.OpenDatabase(AccessFileName, 0, true, '');
    try
      ConvertAccessToDataModule(DBAcc, DataModuleName, DataModuleFileName,
        ADataSetClass, AUnits, ACreateDataSource, ACreateSrcIndexes, ACreateIndexDefs,
        ACreateSrcFields, ACreateFieldDefs, ACreateDfmFields, ACreateSrcRels, ALazarusFrm,
        StringDFM, StringPAS, Msgs);
    finally
      DBAcc.Close;
    end;
    if ALazarusFrm then
    begin
      FormExtension := '.lfm';
      UnitExtension := '.pp';
    end
    else
    begin
      FormExtension := '.dfm';
      UnitExtension := '.pas';
    end;
    StringDFM.SaveToFile(DataModuleFileName + FormExtension);
    StringPAS.SaveToFile(DataModuleFileName + UnitExtension);
  finally
    StringDFM.Free;
    StringPAS.Free;
  end;
end;

end.
