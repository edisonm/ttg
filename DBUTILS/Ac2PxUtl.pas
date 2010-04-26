unit Ac2PxUtl;
{
  Unidad que provee de los métodos esenciales para realizar la conversión de
  Access a Paradox.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, DBCtrls, DAO_TLB, Variants;

type
  EInitAc2PxUtl = class(Exception);

// Field Types constants

//procedure InitAc2PxUtl;
procedure AccessToParadox(AccessFileName, ParadoxDirName: string;
  Msgs: TStrings);
procedure CopyStructAccessToParadox(DBAcc: Database; DBPdx: TDatabase;
  Msgs: TStrings);
procedure CopyDataAccessToParadox(DBAcc: Database; DBPdx: TDatabase;
  Msgs: TStrings; TableList: TStrings);
procedure CopyAllAccessToParadox(DBAcc: Database; DBPdx: TDatabase;
  Msgs: TStrings);

implementation

uses
  BDE, AccUtl, ArDBUtls;

const
  Acc2PdxFieldType: array[1..$17] of ShortInt = (
    fldBOOL, {dbBoolean}
    fldINT16, {dbByte}
    fldINT16, {dbInteger}
    fldINT32, {dbLong}
    fldFLOAT, {dbCurrency}
    fldFLOAT, {dbSingle}
    fldFLOAT, {dbDouble}
    fldDATE, {dbDate}
    fldBYTES, {dbBinary}
    fldZSTRING, {dbText}
    fldBLOB, {dbLongBinary}
    fldBLOB, {dbMemo}
    fldUNKNOWN,
    fldUNKNOWN,
    fldUNKNOWN, {dbGUID}
    fldINT64, {dbBigInt}
    fldVARBYTES, {dbVarBinary}
    fldZSTRING, {dbChar}
    fldUNKNOWN, {dbNumeric}
    fldUNKNOWN, {dbDecimal}
    fldUNKNOWN, {dbFloat}
    fldTIME, {dbTime}
    fldTIMESTAMP {dbTimeStamp}
    );
  Acc2PdxFieldSubType: array[1..$17] of ShortInt = (
    fldUNKNOWN, {dbBoolean}
    fldUNKNOWN, {dbByte}
    fldUNKNOWN, {dbInteger}
    fldUNKNOWN, {dbLong}
    fldstMONEY, {dbCurrency}
    fldUNKNOWN, {dbSingle}
    fldFLOAT, {dbDouble}
    fldDATE, {dbDate}
    fldstFIXED, {dbBinary}
    fldstFIXED, {dbText}
    fldstBINARY, {dbLongBinary}
    fldstMEMO, {dbMemo}
    fldUNKNOWN,
    fldUNKNOWN,
    fldUNKNOWN, {dbGUID}
    fldUNKNOWN, {dbBigInt}
    fldstFIXED, {dbVarBinary}
    fldstFIXED, {dbChar}
    fldUNKNOWN, {dbNumeric}
    fldUNKNOWN, {dbDecimal}
    fldUNKNOWN, {dbFloat}
    fldUNKNOWN, {dbTime}
    fldUNKNOWN {dbTimeStamp}
    );

resourcestring
  SInitAc2PxUtl = 'Imposible inicializar Ac2PxUtl';

procedure LoadFields(ATableDef: TableDef; var aFLDDesc: array of FLDDesc;
  var v: Integer; var aVCHKDesc: array of VCHKDesc; Msgs: TStrings);
var
  vi: Smallint;
  vl: Longint;
  vd: Double;
  vs: string;
  vv: Variant;
  j: Integer;
  t: DataTypeEnum;
  HasVCHK: Boolean;
begin
  v := 0;
  with ATableDef.Fields do
    for j := 0 to Count - 1 do
      with aFLDDesc[j], Item[j] do
      begin
        iFldNum := j + 1;
        //OrdPos2FldNum[OrdinalPosition] := iFldNum;
        StrPCopy(szName, Copy(Name, 1, 25));
        t := Type_;
        if (Size = 8) and ((t = dbDate) or (t = dbTime)) then
          iFldType := fldTIMESTAMP
        else
          iFldType := Acc2PdxFieldType[t];
        {
        if (Attributes and dbAutoIncrField) <> 0 then
          iSubType := fldstAUTOINC
        else}
        iSubType := Acc2PdxFieldSubType[t];
        if t = dbMemo then
          iUnits1 := 1
        else
          iUnits1 := Size;
        HasVCHK := False;
        aVCHKDesc[v].iFldNum := iFldNum;
        if Required { or not VarIsEmpty(DefaultValue)} then
        begin
          HasVCHK := True;
          aVCHKDesc[v].bRequired := Required;
          aVCHKDesc[v].szPict[0] := #0;
        end;
        vv := DefaultValue;
        if not VarIsNull(vv) and (vv <> '') then
        begin
          case t of
            dbInteger, dbByte:
              begin
                HasVCHK := True;
                aVCHKDesc[v].bHasDefVal := True;
                vi := StrToInt(vv);
                Move(vi, aVCHKDesc[v].aDefVal, sizeof(vi));
              end;
            dbLong:
              begin
                HasVCHK := True;
                aVCHKDesc[v].bHasDefVal := True;
                vl := StrToInt(vv);
                Move(vl, aVCHKDesc[v].aDefVal, sizeof(vl));
              end;
            dbDouble:
              begin
                HasVCHK := True;
                aVCHKDesc[v].bHasDefVal := True;
                vd := StrToFloat(DefaultValue);
                Move(vd, aVCHKDesc[v].aDefVal, sizeof(vd));
              end;
            dbText:
              begin
                HasVCHK := True;
                aVCHKDesc[v].bHasDefVal := True;
                vs := vv;
                if (vs[1] = '"') and (vs[Length(vs)] = '"') then
                  vs := Copy(vs, 2, Length(vs) - 2);
                Move(vs[1], aVCHKDesc[v].aDefVal, Length(vs));
              end;
          end;
        end;
        if HasVCHK then Inc(v);
      end;
end;

procedure LoadIndexes(ATableDef: TableDef; out l: Integer;
  var aIDXDesc: array of IDXDesc; Msgs: TStrings);
var
  i, j, k, c: Integer;
  s: string;
  eq: Boolean;
begin
  c := 0;
  l := 0;
  with ATableDef, Indexes do
  begin
    for i := 0 to Count - 1 do
      with Item[i] do
      begin
        if not Foreign then
        begin
          j := 0;
          if not Primary then
          begin
            Inc(c);
            j := c;
          end;
          Inc(l);
          with aIDXDesc[j] do
          begin
            if Primary then
            begin
              bPrimary := True;
              //bUnique := True;
            end
            else
            begin
              try
                ATableDef.Fields.Item[Name];
                s := 'ix' + Name;
              except
                s := Name;
              end;
              s := Copy(s, 1, 25);
              StrPCopy(szName, s);
              bDescending := (Fields.Item[0].Attributes = dbDescending);
              bCaseInsensitive := True;
            end;
            iIndexId := j;
            bMaintained := True;
            bUnique := Unique;
            iFldsInKey := Fields.Count;
            for k := 0 to Fields.Count - 1 do
            begin
              aiKeyFld[k] := IndexOfFieldName(ATableDef.Fields,
                Fields.Item[k].Name) + 1;
              if (k <> 0) and (Fields.Item[k].Attributes = dbDescending) then
              begin
                Msgs.Add(Format('Table: %s Index: %s Field: %s dbDescending',
                  [ATableDef.Name, Name, Fields.Item[k].Name]));
              end;
            end;
          end;
        end;
      end;
    for i := 0 to Count - 1 do
    begin
      with Item[i] do
      begin
        if Foreign then
        begin
          with aIDXDesc[l] do
          begin
            iFldsInKey := Fields.Count;
            for k := 0 to Fields.Count - 1 do
            begin
              aiKeyFld[k] := IndexOfFieldName(ATableDef.Fields,
                Fields.Item[k].Name) + 1;
            end;
            eq := True;
            for j := 0 to l - 1 do
            begin
              eq := (iFldsInKey = aIDXDesc[j].iFldsInKey);
              for k := 0 to iFldsInKey - 1 do
              begin
                if not eq then break;
                eq := eq and (aiKeyFld[k] = aIDXDesc[j].aiKeyFld[k]);
              end;
              if eq then break;
            end;
            if eq then Continue;
            iIndexId := l;
            s := Copy(Name, 1, 25);
            StrPCopy(szName, s);
            bMaintained := True;
            bUnique := Unique;
            bDescending := (Fields.Item[0].Attributes = dbDescending);
            bCaseInsensitive := True;
            Inc(l);
          end;
        end;
      end;
    end;
  end;
end;

procedure LoadRelations(ADB: Database; AList: TStrings;
  var VpRINTDesc: array of RINTDesc; Msgs: TStrings);
const
  dbModOp: array[Boolean] of RINTQual = (rintRESTRICT, rintCASCADE);
var
  n, j, k: Integer;
  s: string;
begin
  n := AList.Count;
  if n <> 0 then
  begin
    for j := 0 to n - 1 do
    begin
      with ADB.Relations.Item[AList.Strings[j]], VpRINTDesc[j] do
      begin
        iRintNum := j + 1;
        s := Copy(Name, 1, 31);
        StrPCopy(szRintName, s);
        StrPCopy(szTblName, Table);
        eType := rintDEPENDENT;
        eModOp := dbModOp[(Attributes and dbRelationUpdateCascade) <> 0];
        if (Attributes and dbRelationDeleteCascade) <> 0 then
          Msgs.Add(Format('Relation: %s (%s -> %s) dbRelationDeleteCascade',
            [Name, Table, ForeignTable]));
        //eDelOp := dbModOp[(Attributes and dbRelationDeleteCascade) <> 0];
        eDelOp := rintRESTRICT;
        iFldCount := Fields.Count;
        for k := 0 to iFldCount - 1 do
        begin
          aiThisTabFld[k] :=
            IndexOfFieldName(ADB.TableDefs[ForeignTable].Fields,
            Fields.Item[k].ForeignName) + 1;
          aiOthTabFld[k] :=
            IndexOfFieldName(ADB.TableDefs[Table].Fields,
            Fields.Item[k].Name) + 1;
        end;
      end;
    end;
  end
end;

procedure SaveQueryDefs(AQueryDefs: QueryDefs; ADBPdx: TDatabase);
var
  i: Integer;
begin
  with AQueryDefs do
  begin
    for i := 0 to Count - 1 do
    begin
      with Item[i], TStringList.Create do
      try
        Add(SQL);
        SaveToFile(ADBPDx.Directory + Name + '.sql');
      finally
        Free;
      end;
    end;
  end;
end;

procedure SaveExtraInfo(DBAcc: Database; ADBPdx: TDatabase; ATableList:
  TStrings);
var
  i, j: Integer;
  n, s, t: string;
  VList: TStrings;
begin
  VList := TStringList.Create;
  try
    for i := 0 to ATableList.Count - 1 do
    begin
      with DBAcc.TableDefs[ATableList.Strings[i]] do
      begin
        n := Name;
        try
          t := Properties['Description'].Value;
        except
          t := n;
        end;
        VList.Add(Format('Table[%s].%s=%s', [n, 'Description', t]));
        for j := 0 to Fields.Count - 1 do
        begin
          with Fields[j] do
          begin
            try
              s := VarToStr(Fields[j].Properties['Caption']);
            except
              s := Name;
            end;
            VList.Add(Format('Table[%s].Field[%s].%s=%s', [n, Name, 'Caption', s]));
          end;
        end;
      end;
    end;
    VList.SaveToFile(ADBPdx.Directory + 'PROPERTY.TXT');
  finally
    VList.Free;
  end;
end;

procedure CopyDataAccessToParadox(DBAcc: Database; DBPdx: TDatabase;
  Msgs: TStrings; TableList: TStrings);
var
  i, k: Integer;
  TableListDestroy: Boolean;
  Tb1: TTable;
  VRecordset: Recordset;
begin
  if not assigned(TableList) then
  begin
    TableList := TStringList.Create;
    GetAccTableNamesByRefIntOrder(DBAcc, TableList);
    TableListDestroy := True;
  end
  else
    TableListDestroy := False;
  SaveExtraInfo(DBAcc, DBPdx, TableList);
  Tb1 := TTable.Create(nil);
  try
    Tb1.DatabaseName := DBPdx.DatabaseName;
    for i := 0 to TableList.Count - 1 do
    begin
      Tb1.TableName := TableList.Strings[i];
      VRecordset := DBAcc.OpenRecordset(TableList.Strings[i], dbOpenDynaset,
        dbReadOnly, dbReadOnly);
      Tb1.Open;
      try
        while not VRecordset.EOF do
        begin
          Tb1.Insert;
          for k := 0 to Tb1.Fields.Count - 1 do
          begin
            if not Tb1.Fields[k].ReadOnly then
              Tb1.Fields[k].Value := VRecordset.Fields[k].Value;
          end;
          VRecordset.MoveNext;
        end;
        VRecordset.Close;
        Tb1.CheckBrowseMode;
      finally
        Tb1.Close;
      end;
    end;
  finally
    if TableListDestroy then
    begin
      SecureFree(TableList);
    end;
    Tb1.Free;
  end;
end;

procedure ConvertAccessToParadox(DBAcc: Database; DBPdx: TDatabase;
  Msgs: TStrings; IncludeData: Boolean);
var
  VpFLDDesc: pFLDDescArray;
  VpVCHKDesc: pVCHKDescArray;
  VpIDXDesc: pIDXDescArray;
  VpRINTDesc: pRINTDescArray;
  VCRTblDesc: CRTblDesc;
  i, j, l, n, v: Integer;
  LvlFLDDesc: FLDDesc;
  Level: DBINAME;
  VTableDef: TableDef;
  VList: TStrings;
  VDBIResult: DBIResult;
  s: string;
begin
  FillChar(LvlFLDDesc, sizeof(FLDDesc), #0);
  StrCopy(@Level, PChar(IntToStr(prvINSERT)));
  StrCopy(LvlFLDDesc.szName, szCFGDRVLEVEL);
  LvlFldDesc.iLen := StrLen(Level);
  LvlFldDesc.iOffset := 0;
  DBPdx.Connected := True;
  // Campos e Indices:
  Msgs.Clear;
  Msgs.BeginUpdate;
  VList := TStringList.Create;
  try
    GetAccTableNamesByRefIntOrder(DBAcc, VList);
    with DBAcc do
    begin
      for i := 0 to VList.Count - 1 do
      begin
        VTableDef := TableDefs.Item[VList.Strings[i]];
        n := (VList.Objects[i] as TStrings).Count;
        GetMem(VpFLDDesc, VTableDef.Fields.Count * sizeof(FLDDesc));
        GetMem(VpVCHKDesc, VTableDef.Fields.Count * sizeof(VCHKDesc));
        GetMem(VpIDXDesc, VTableDef.Indexes.Count * sizeof(IDXDesc));
        GetMem(VpRINTDesc, n * sizeof(RINTDesc));
        try
          FillChar(VpFLDDesc^, VTableDef.Fields.Count * sizeof(FLDDesc), #0);
          FillChar(VpVCHKDesc^, VTableDef.Fields.Count * sizeof(VCHKDesc), #0);
          FillChar(VpIDXDesc^, VTableDef.Indexes.Count * sizeof(IDXDesc), #0);
          FillChar(VpRINTDesc^, n * sizeof(RINTDesc), #0);
          LoadFields(VTableDef, VpFLDDesc^, v, VpVCHKDesc^, Msgs);
          //GenerateFormDefs(VTableDef, DBPdx.Directory);
          LoadIndexes(VTableDef, l, VpIDXDesc^, Msgs);
          LoadRelations(DBAcc, VList.Objects[i] as TStrings, VpRINTDesc^, Msgs);
          FillChar(VCRTblDesc, sizeof(CRTblDesc), #0);
          with VCRTblDesc do
          begin
            StrPCopy(szTblName, VTableDef.Name);
            szTblType := szPARADOX;
            iFLDCount := VTableDef.Fields.Count;
            pFLDDesc := Pointer(VpFLDDesc);
            iValChkCount := v;
            pvchkDesc := Pointer(VpVCHKDesc);
            iIdxCount := l;
            pidxDesc := Pointer(VpIdxDesc);
            iRintCount := n;
            printDesc := Pointer(VpRINTDesc);
            bPack := True;
            iOptParams := 1;
            pOptData := @Level;
            pfldOptParams := @LvlFldDesc;
          end;
          VDBIResult := DbiCreateTable(DBPdx.Handle, True, VCRTblDesc);
          try
            Check(VDBIResult);
          except
            on E: EDBEngineError do
            begin
              case VDBIResult of
                DBIERR_MULTILEVELCASCADE:
                  begin
                    for j := 0 to n - 1 do
                      VpRINTDesc[j].eModOp := rintRESTRICT;
                    s := '[';
                    for j := 0 to n - 1 do
                    begin
                      s := s + Format('[%s](%s->)', [VpRINTDesc[j].szRintName,
                        VpRINTDesc[j].szTblName]); ;
                    end;
                    s := s + ']';
                    Msgs.Add(Format('Table: %s Relations: %s not traslated.' +
                      ' DBIERR_MULTILEVELCASCADE',
                      [VCRTblDesc.szTblName, s]));
                    Check(DbiCreateTable(DBPdx.Handle, True, VCRTblDesc));
                    Msgs.Add(E.Message);
                  end;
                DBIERR_MASTEREXISTS:
                  begin
                    s := '[';
                    for j := 0 to VCRTblDesc.iRintCount - 1 do
                    begin
                      s := s + '[' + VpRINTDesc[j].szRintName + ']('
                        + VpRINTDesc[j].szTblName + '->)';
                    end;
                    s := s + ']';
                    Msgs.Add(Format('Table: %s Relations: %s not traslated.' +
                      '  Tables may be corrupt DBIERR_MASTEREXISTS',
                      [VCRTblDesc.szTblName, s]));
                    VCRTblDesc.iRintCount := 0;
                    VCRTblDesc.printDesc := nil;
                    Check(DbiCreateTable(DBPdx.Handle, True, VCRTblDesc));
                    Msgs.Add(E.Message);
                  end;
                DBIERR_OUTOFRANGE:
                  begin
                    s := '[';
                    for j := 0 to VCRTblDesc.iRintCount - 1 do
                      s := s + VpRintDesc[j].szRintName + ' ';
                    s := s + ']';
                    Msgs.Add(Format('Table: %s Relations: %s not traslated' +
                      ' DBIERR_OUTOFRANGE', [VCRTblDesc.szTblName, s]));
                    s := '[';
                    for j := 0 to VCRTblDesc.iIdxCount - 1 do
                      s := s + VpIDXDesc[j].szName + ' ';
                    s := s + ']';
                    Msgs.Add(Format('Table: %s Indexes: %s not traslated ' +
                      'DBIERR_OUTOFRANGE', [VCRTblDesc.szTblName, s]));
                    VCRTblDesc.iRintCount := 0;
                    VCRTblDesc.printDesc := nil;
                    VCRTblDesc.iIdxCount := 0;
                    VCRTblDesc.pidxDesc := nil;
                    Check(DbiCreateTable(DBPdx.Handle, True, VCRTblDesc));
                    Msgs.Add(E.Message);
                  end
              else
                raise;
              end;
            end;
          end;
        finally
          FreeMem(VpFLDDesc);
          FreeMem(VpVCHKDesc);
          FreeMem(VpIDXDesc);
          FreeMem(VpRINTDesc);
        end;
      end;
      SaveQueryDefs(QueryDefs, DBPdx);
    end;
    if IncludeData then
      CopyDataAccessToParadox(DBAcc, DBPdx, Msgs, VList);
  finally
    SecureFree(VList);
    Msgs.EndUpdate;
  end;
end;

procedure CopyStructAccessToParadox(DBAcc: Database; DBPdx: TDatabase;
  Msgs: TStrings);
begin
  ConvertAccessToParadox(DBAcc, DBPdx, Msgs, False);
end;

procedure CopyAllAccessToParadox(DBAcc: Database; DBPdx: TDatabase;
  Msgs: TStrings);
begin
  ConvertAccessToParadox(DBAcc, DBPdx, Msgs, True);
end;

procedure AccessToParadox(AccessFileName, ParadoxDirName: string;
  Msgs: TStrings);
var
  DBAcc: Database;
  DBPdx: TDatabase;
begin
  if not Assigned(Engine) then
    Engine := CoDBEngine.Create;
  DBPdx := TDatabase.Create(nil);
  try
    DBAcc := Engine.OpenDatabase(AccessFileName, 0, true, '');
    try
      with DBPdx do
      begin
        DatabaseName := ChangeFileExt(ExtractFileName(AccessFileName), '');
        DriverName := 'STANDARD';
        LoginPrompt := false;
        with Params do
        begin
          Add(Format('PATH=%s', [ParadoxDirName]));
          Add('DEFAULT DRIVER=PARADOX');
          Add('ENABLE BCD=false');
        end;
      end;
      //DBPdx.SessionName := 'Default';
      CopyAllAccessToParadox(DBAcc, DBPdx, Msgs);
    finally
      DBAcc.Close;
    end;
  finally
    DBPdx.Free;
  end;
end;

end.
