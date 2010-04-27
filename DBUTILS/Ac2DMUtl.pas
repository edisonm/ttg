unit Ac2DMUtl;
{
  Unidad que provee de los métodos esenciales para realizar la conversión de
  Access a Módulo de datos de tablas en memoria.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, DBCtrls, DAO_TLB, dbf;

type
  EInitAc2PxUtl = class(Exception);

// Field Types constants

//procedure InitAc2PxUtl;
procedure AccessToDataModule(AccessFileName, DataModuleName, DataModuleFileName:
  string; ACreateDataSource: Boolean; Msgs: TStrings);

implementation

uses
  ArDBUtls, AccUtl, Variants;

const
  Acc2DMFieldClassName: array[1..$17] of string = (
    'TBooleanField', {dbBoolean}
    'TSmallintField', {dbByte}
    'TSmallintField', {dbInteger}
    'TIntegerField', {dbLong}
    'TCurrencyField', {dbCurrency}
    'TFloatField', {dbSingle}
    'TFloatField', {dbDouble}
    'TDateTimeField', {dbDate}
    'TBytesField', {dbBinary}
    'TStringField', {dbText}
    'TLargeintField', {dbLongBinary}
    'TMemoField', {dbMemo}
    '',
    '',
    'TGuidField', {dbGUID}
    'TLargeIntField', {dbBigInt}
    'TVarBytesField', {dbVarBinary}
    'TStringField', {dbChar}
    'TFloatField', {dbNumeric}
    'TFloatField', {dbDecimal}
    'TFloatField', {dbFloat}
    'TTimeField', {dbTime}
    'TDateTimeField' {dbTimeStamp}
    );
  Acc2DMFieldType: array[1..$17] of TFieldType = (
    ftBoolean, {dbBoolean}
    ftSmallint, {dbByte}
    ftSmallint, {dbInteger}
    ftInteger, {dbLong}
    ftCurrency, {dbCurrency}
    ftFloat, {dbSingle}
    ftFloat, {dbDouble}
    ftDateTime, {dbDate}
    ftBytes, {dbBinary}
    ftString, {dbText}
    ftLargeint, {dbLongBinary}
    ftMemo, {dbMemo}
    ftUnknown,
    ftUnknown,
    ftGuid, {dbGUID}
    ftLargeInt, {dbBigInt}
    ftVarBytes, {dbVarBinary}
    ftString, {dbChar}
    ftFloat, {dbNumeric}
    ftFloat, {dbDecimal}
    ftFloat, {dbFloat}
    ftTime, {dbTime}
    ftDateTime {dbTimeStamp}
    );
  Acc2DMFieldTypeName: array[1..$17] of string = (
    'ftBoolean', {dbBoolean}
    'ftSmallint', {dbByte}
    'ftSmallint', {dbInteger}
    'ftInteger', {dbLong}
    'ftCurrency', {dbCurrency}
    'ftFloat', {dbSingle}
    'ftFloat', {dbDouble}
    'ftDateTime', {dbDate}
    'ftBytes', {dbBinary}
    'ftString', {dbText}
    'ftLargeint', {dbLongBinary}
    'ftMemo', {dbMemo}
    'ftUnknown',
    'ftUnknown',
    'ftGuid', {dbGUID}
    'ftLargeInt', {dbBigInt}
    'ftVarBytes', {dbVarBinary}
    'ftString', {dbChar}
    'ftFloat', {dbNumeric}
    'ftFloat', {dbDecimal}
    'ftFloat', {dbFloat}
    'ftTime', {dbTime}
    'ftDateTime' {dbTimeStamp}
    );
  sBoolean: array[Boolean] of string = ('False', 'True');

resourcestring
  SInitAc2PxUtl = 'Imposible inicializar Ac2PxUtl';

function EscapeStrForm(const s : String): string;
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

procedure ConvertAccessToDataModule(DBAcc: Database;
                                    const DataModuleName,
                                    DataModuleFileName: string;
                                    ACreateDataSource: Boolean;
                                    ACreateSrcIndexes: Boolean; // Code in .pas
                                    ACreateIndexDefs: Boolean;  // Code in .dfm
                                    ACreateSrcFields: Boolean;  // Code in .pas
                                    ACreateFieldDefs: Boolean;  // Code in .dfm
                                    ACreateDfmFields: Boolean;  // Code in .dfm
                                    StringDFM, StringPAS, Msgs: TStrings);
var
  VTableDef: TableDef;
  DataTypeName, VFieldClassName, VTableName: string;
  VStringList: TStrings;
  vv: Variant;
  procedure CreateFieldDefs;
  var
    j: Integer;
  begin
    StringDFM.Add('    FieldDefs = <');
    with VTableDef.Fields do
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
          StringDFM.Add(Format('        DataType = %s', [DataTypeName]));
          case Acc2DMFieldType[type_] of
            ftString, ftBytes, ftVarBytes:
              begin
//                StringDFM.Add('        Precision = -1');
                StringDFM.Add(Format('        Size = %d', [Size]));
              end
          end;
          if Required then
            StringDFM.Add('        Attributes = [faRequired]');
          StringDFM.Add('      end');
        end;
      end;
    with StringDFM do Strings[Count - 1] := Strings[Count - 1] + '>';
  end;
  procedure CreateSrcFields;
  var
    j: Integer;
  begin
    StringPAS.Add(Format('  with Tb%s.FieldDefs do', [VTableName]));
    StringPAS.Add('  begin');
    with VTableDef.Fields do
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
  procedure CreateFields;
  var
    j: Integer;
    s: string;
  begin
    with VTableDef.Fields do
      for j := 0 to Count - 1 do
      begin
        with Item[j] do
        begin
          if (Attributes and dbAutoIncrField) <> 0 then
            VFieldClassName := 'TAutoIncField'
          else
            VFieldClassName := Acc2DMFieldClassName[type_];
          StringDFM.Add(Format('    object Tb%s%s: %s', [VTableName, name, VFieldClassName]));
          try
            s := VarToStr(Properties['Caption']);
          except
            s := Name;
          end;
          StringDFM.Add('      DisplayLabel = ''' + EscapeStrForm(s) + '''');
          StringDFM.Add('      FieldName = ''' + name + '''');
          if Required then
            StringDFM.Add('      Required = True');
          vv := DefaultValue;
          if not VarIsNull(vv) and (vv <> '') then
            StringDFM.Add(Format('      DefaultExpression = ''%s''', [VarToStr(vv)]));
          case Acc2DMFieldType[type_] of
            ftString, ftBytes, ftVarBytes:
              StringDFM.Add(Format('      Size = %d', [Size]));
          end;
          StringDFM.Add('    end');
          StringPAS.Add(Format('    Tb%s%s:%s;', [VTableName, name, VFieldClassName]));
        end;
      end;
  end;
  procedure CreateSrcIndexes;
  var
    s, d, o: string;
    k, n, i: Smallint;
  begin
    with VTableDef, Indexes do
    begin
      n := Count;
      if n <> 0 then
      begin
        StringPAS.Add(Format('  with Tb%s do', [VTableDef.name]));
        StringPAS.Add('  begin');
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
              StringPAS.Add(Format('    AddIndex(''Tb%s%s'', ''%s'', [%s], %s);',
                                   [VTableDef.name, Name, s, o, d]))
            else
              StringPAS.Add(Format('    AddIndex(''Tb%s%s'', ''%s'', [%s]);',
                                   [VTableDef.name, Name, s, o]));
          end;
        StringPAS.Add('  end;');
      end;
    end;
  end;
  procedure CreateIndexDefs;
  var
    s, d, o: string;
    k, n, i: Smallint;
  begin
    with VTableDef, Indexes do
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
            StringDFM.Add(Format('        Name = ''Tb%s%s''', [VTableDef.name, s]));
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
            if s <> '' then StringDFM.Add(Format('        Fields = ''%s''', [s]));
            if d <> '' then StringDFM.Add(Format('        DescFields = ''%s''', [d]));
            if o <> '' then StringDFM.Add(Format('        Options = [%s]', [o]));
            if i <> n - 1 then
              StringDFM.Add('      end')
            else
              StringDFM.Add('      end>');
          end;
      end;
    end;
  end;
var
  i, j, k: Smallint;
  s, d: string;
  ProcDefs, ProcImpl: TStrings;
  MasterRels, DetailRels: array of TList; // TList used as Integer list
begin
  // Creando encabezado:
  with StringPAS do
  begin
    Add(Format('unit %s;', [ExtractFileName(DataModuleFileName)]));
    Add('(*');
    Add('  ' + FormatDateTime(LongDateFormat + ' ' + LongTimeFormat, Now));
    Add('');
    Add('  Warning:');
    Add('');
    Add('    This module has been created automatically.');
    Add('    Do not modify it manually or the changes will be lost the next update');
    Add('');
    Add('');
    Add('*)');
    Add('');
    Add('interface');
    Add('');
    Add('uses');
    Add('  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, dbf,');
    Add('  DBase;');
    Add('');
    Add('type');
    Add(Format('  T%s = class(TBaseDataModule)', [DataModuleName]));
  end;
  StringDFM.Add(Format('inherited %s: T%s', [DataModuleName, DataModuleName]));
  Msgs.Clear;
  Msgs.BeginUpdate;
  VStringList := TStringList.Create;
  ProcDefs := TStringList.Create;
  ProcImpl := TStringList.Create;
  try
    GetAccTableNamesByRefIntOrder(DBAcc, VStringList);
    with DBAcc do
    begin
      SetLength(MasterRels, VStringList.Count);
      SetLength(DetailRels, VStringList.Count);
      for i := 0 to VStringList.Count - 1 do
      begin
        MasterRels[i] := TList.Create;
        DetailRels[i] := TList.Create;
      end;
      try
        with Relations do
        begin
          for i := 0 to Count - 1 do
          begin
            MasterRels[VStringList.IndexOf(Item[i].Table)].Add(Pointer(i));
            DetailRels[VStringList.IndexOf(Item[i].ForeignTable)].Add(Pointer(i));
          end;
        end;
        for i := 0 to VStringList.Count - 1 do
        begin
          VTableName := VStringList.Strings[i];
          VTableDef := TableDefs.Item[VTableName];
          //VTableDef := TableDefs.Item[i];
          //VTableName := VTableDef.Name;
          StringPAS.Add(Format('    Tb%s: TDbf;', [VTableName]));
          StringDFM.Add(Format('  object Tb%s: TDbf', [VTableName]));
          StringDFM.Add(Format('    Tag = %d', [i]));
	  if ACreateFieldDefs then
            CreateFieldDefs
          else
            StringDFM.Add('    FieldDefs = <>');
          if ACreateIndexDefs then
            CreateIndexDefs;
          if (DetailRels[i].Count > 0) or (MasterRels[i].Count > 0) then
          begin
            StringDFM.Add('    BeforePost = DataSetBeforePost');
          end;
          with MasterRels[i] do
            if Count > 0 then
	      StringDFM.Add('    BeforeDelete = DataSetBeforeDelete');
          StringDFM.Add(Format('    Left = %d', [48 + 96 * (i mod 5)]));
          StringDFM.Add(Format('    Top = %d', [48 + 96 * (i div 5) + 12 * ((i mod 5) mod 2)]));
          CreateFields;
          StringDFM.Add('  end');
          if ACreateDataSource then
          begin
            StringDFM.Add(Format('  object DS%s: TDataSource', [VTableName]));
            StringDFM.Add(Format('    DataSet = Tb%s', [VTableName]));
            StringDFM.Add(Format('    Left = %d', [48 + 8 + 96 * (i mod 5)]));
            StringDFM.Add(Format('    Top = %d', [48 - 8 + 96 * (i div 5) + 12 * ((i mod 5) mod 2)]));
            StringDFM.Add('  end');
            StringPAS.Add(Format('    DS%s: TDataSource;', [VTableName]));
          end;
        //LoadIndexes(VTableDef);
        //LoadRelations
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
      Add('{$R *.DFM}');
      Add('');
      Add('uses RelUtils;');
      Add('');
      AddStrings(ProcImpl);
      Add('');
      Add(Format('procedure T%s.DataModuleCreate(Sender: TObject);', [DataModuleName]));
      Add('begin');
      Add('  inherited;');
      Add(Format('  SetLength(FTables, %d);', [VStringList.Count]));
      Add(Format('  SetLength(FMasterRels, %d);', [VStringList.Count]));
      Add(Format('  SetLength(FDetailRels, %d);', [VStringList.Count]));
      Add(Format('  SetLength(FBeforePostLocks, %d);', [VStringList.Count]));
      for i := 0 to VStringList.Count - 1 do
      begin
        d := VStringList[i];
        Add(Format('  Tables[%d] := Tb%s;', [i, d]));
      end;
      for i := 0 to VStringList.Count - 1 do
      begin
        VTableName := VStringList.Strings[i];
        VTableDef := TableDefs.Item[VTableName];
        if ACreateSrcFields then
          CreateSrcFields;
        if ACreateSrcIndexes then
          CreateSrcIndexes;
      end;
      for i := 0 to VStringList.Count - 1 do
      begin
	with MasterRels[i] do
	begin
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
      for i := 0 to VStringList.Count - 1 do
      begin
        d := VStringList[i];
        Add(Format('    Add(''Tb%s=%s'');', [d, d]));
      end;
      Add('  end;');
      Add('  with DataSetDescList do');
      Add('  begin');
      for i := 0 to VStringList.Count - 1 do
      begin
        d := VStringList[i];
        try
          s := DbAcc.TableDefs[d].Properties['Description'].Value;
        except
          s := d;
        end;
        Add(Format('    Add(''Tb%s=%s'');', [d, s]));
      end;
      Add('  end;');
      Add('end;');
      Add('');
      Add('end.');
      Add('');
    end;
      finally
        for i := VStringList.Count - 1 downto 0 do
        begin
          DetailRels[i].Free;
          MasterRels[i].Free;
        end;
      end;
    end;
  finally
    SecureFree(VStringList);
    ProcDefs.Free;
    ProcImpl.Free;
    Msgs.EndUpdate;
  end;
end;

procedure AccessToDataModule(AccessFileName, DataModuleName, DataModuleFileName:
  string; ACreateDataSource: Boolean; Msgs: TStrings);
var
  DBAcc: Database;
  StringDFM, StringPAS: TStrings;
begin
  if not Assigned(Engine) then
    Engine := CoDBEngine.Create;
  StringDFM := TStringList.Create;
  StringPAS := TStringList.Create;
  try
    DBAcc := Engine.OpenDatabase(AccessFileName, 0, true, '');
    try
      ConvertAccessToDataModule(DBAcc, DataModuleName,
                                DataModuleFileName, ACreateDataSource,
                                True, False, False, True, True,
                                StringDFM, StringPAS, Msgs);
    finally
      DBAcc.Close;
    end;
    StringDFM.SaveToFile(DataModuleFileName + '.dfm');
    StringPAS.SaveToFile(DataModuleFileName + '.pas');
  finally
    StringDFM.Free;
    StringPAS.Free;
  end;
end;

end.
