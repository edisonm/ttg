{ -*- mode: Delphi -*- }
unit DSource;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, DSourceBase, DBase, Db, ZDataset;

type

  { TSourceDataModule }

  TSourceDataModule = class(TSourceBaseDataModule)
    QuCluster: TZReadOnlyQuery;
    ZTables: TZReadOnlyQuery;
    QuResource: TZReadOnlyQuery;
    procedure TbDistributionBeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TbDistributionCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure SetFieldCaption(ADataSet: TDataSet);
    procedure PrepareLookupFields;
    procedure HideFields;
  protected
    procedure LoadDataSetFromStrings(const ATableName: string;
                                     AStrings: TStrings; var APosition: Integer); override;
    procedure EmptyDataSet(ADataSet: TDataSet); override;
    procedure UpdateDetailFields(ADetail: TDataSet;
                                 const ADetailFields: string;
                                 const OldValues, CurValues: Variant); override;
    procedure DeleteDetailFields(ADetail: TDataSet;
                                 const AMasterFields: string;
                                 const AMasterValues: Variant); override;
    procedure CheckDetailRelation(AMaster, ADetail: TDataSet;
                                  const AMasterFields, ADetailFields: string); override;
  public
    { Public declarations }
    procedure EmptyTables; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    procedure PrepareTables;
    procedure FillDefaultData;
  end;

var
  SourceDataModule: TSourceDataModule;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  Variants, FConfig, UTTGDBUtils, URelUtils, uttgconsts, dsourcebaseconsts;

procedure TSourceDataModule.TbDistributionBeforePost(DataSet: TDataSet);
var
  s: string;
begin
  inherited DataSetBeforePost(DataSet);
  with DataSet do
  begin
    s := FindField('Composition').AsString;
    if CompositionToDuration(s) <= 0 then
      raise Exception.CreateFmt(SInvalidComposition, [s]);
    with FindField('IdTheme') do DefaultExpression := AsString;
    with FindField('IdCategory') do DefaultExpression := AsString;
    with FindField('IdParallel') do DefaultExpression := AsString;
    with FindField('IdRoomType') do DefaultExpression := AsString;
  end;
end;

procedure TSourceDataModule.TbDistributionCalcFields(DataSet: TDataSet);
var
  v: Variant;
begin
  try
    v := DataSet['Composition'];
    if VarIsNull(v) then
      DataSet['Duration'] := 0
    else
      DataSet['Duration'] := CompositionToDuration(v);
  except
    DataSet['Duration'] := 0;
  end
end;

procedure TSourceDataModule.DataModuleCreate(Sender: TObject);
begin
  inherited;
end;

procedure TSourceDataModule.DataModuleDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TSourceDataModule.FillDefaultData;
const
  SNaHour: array[1..9] of string = (
    SHour1,
    SHour2,
    SHour3,
    SHour4,
    SHourF,
    SHour5,
    SHour6,
    SHour7,
    SHour8);
  SNaThemeRestrictionType: array[0..1] of string = (
    SInadequate,
    SImpossible);
  SNaResourceRestrictionType: array[0..1] of string = (
    SInadequate,
    SImpossible);
  EColThemeRestrictionType: array[0..1] of TColor = (
    clLime,
    clRed);
  EColResourceRestrictionType: array[0..1] of TColor = (
    clLime,
    clRed);
  EValThemeRestrictionType: array[0..1] of Integer = (
    50,
    500);
  EValResourceRestrictionType: array[0..1] of Integer = (
    50,
    500);
var
  t: TDateTime;
  i: Integer;
  s: string;
  DayNames: array[0..6] of string =
    (SDay0, SDay1, SDay2, SDay3, SDay4, SDay5, SDay6);
begin
  CheckRelations := False;
  try
    with TbDay do
    begin
      for i := Low(DayNames) + 1 to High(DayNames) - 1 do
      begin
        Append;
        Fields[0].AsInteger := i;
        Fields[1].AsString := DayNames[i];
        Post;
      end;
    end;
    with TbHour do
    begin
      t := 7 / 24;
      for i := Low(SNaHour) to High(SNaHour) do
      begin
        s := FormatDateTime(ShortTimeFormat, t);
        if i = 5 then
          t := t + 1 / 48
        else
          t := t + 1 / 32;
        s := s + '-' + FormatDateTime(ShortTimeFormat, t);
        Append;
        Fields[0].AsInteger := i;
        Fields[1].AsString := SNaHour[i];
        Fields[2].AsString := s;
        Post;
      end;
    end;
    with TbTimeSlot do
    begin
      TbDay.First;
      while not TbDay.Eof do
      begin
        TbHour.First;
        while not TbHour.Eof do
        begin
          if TbHour.FindField('NaHour').AsString <> SHourF then
          begin
            Append;
            Fields[0].AsInteger := TbDay.FindField('IdDay').AsInteger;
            Fields[1].AsInteger := TbHour.FindField('IdHour').AsInteger;
            Post;
          end;
          TbHour.Next;
        end;
        TbDay.Next;
      end;
    end;
    with TbThemeRestrictionType do
    begin
      for i := Low(SNaThemeRestrictionType) to High(SNaThemeRestrictionType) do
      begin
        Append;
        Fields[0].AsInteger := i;
        Fields[1].AsString := SNaThemeRestrictionType[i];
        Fields[2].AsInteger := EColThemeRestrictionType[i];
        Fields[3].AsFloat := EValThemeRestrictionType[i];
        Post;
      end;
    end;
    with TbResourceRestrictionType do
    begin
      for i := Low(SNaResourceRestrictionType) to High(SNaResourceRestrictionType) do
      begin
        Append;
        Fields[0].AsInteger := i;
        Fields[1].AsString := SNaResourceRestrictionType[i];
        Fields[2].AsInteger := EColResourceRestrictionType[i];
        Fields[3].AsFloat := EValResourceRestrictionType[i];
        Post;
      end;
    end;
  finally
    CheckRelations := True;
  end;
end;

procedure TSourceDataModule.PrepareLookupFields;
var
  Field: TField;
begin
  Field := TStringField.Create(TbCluster);
  with Field do
  begin
    DisplayLabel := SFlCluster_IdCategory;
    FieldKind := fkLookup;
    FieldName := 'AbCategory';
    LookupDataSet := TbCategory;
    LookupKeyFields := 'IdCategory';
    LookupResultField := 'AbCategory';
    KeyFields := 'IdCategory';
    Size := 5;
    Lookup := True;
    DataSet := TbCluster;
  end;
  Field := TStringField.Create(TbCluster);
  with Field do
  begin
    DisplayLabel := SFlCluster_IdParallel;
    FieldKind := fkLookup;
    FieldName := 'NaParallel';
    LookupDataSet := TbParallel;
    LookupKeyFields := 'IdParallel';
    LookupResultField := 'NaParallel';
    KeyFields := 'IdParallel';
    Size := 5;
    Lookup := True;
    DataSet := TbCluster;
  end;
  Field := TStringField.Create(TbThemeRestriction);
  with Field do
  begin
    DisplayLabel := SFlThemeRestriction_IdThemeRestrictionType;
    DisplayWidth := 10;
    FieldKind := fkLookup;
    FieldName := 'NaThemeRestrictionType';
    LookupDataSet := TbThemeRestrictionType;
    LookupKeyFields := 'IdThemeRestrictionType';
    LookupResultField := 'NaThemeRestrictionType';
    KeyFields := 'IdThemeRestrictionType';
    Size := 10;
    Lookup := True;
    DataSet := TbThemeRestriction;
  end;
  Field := TStringField.Create(TbTimetableDetail);
  with Field do
  begin
    DisplayLabel := SFlThemeRestriction_IdTheme;
    DisplayWidth := 15;
    FieldKind := fkLookup;
    FieldName := 'NaTheme';
    LookupDataSet := TbTheme;
    LookupKeyFields := 'IdTheme';
    LookupResultField := 'NaTheme';
    KeyFields := 'IdTheme';
    Size := 15;
    Lookup := True;
    DataSet := TbTimetableDetail;
  end;
  Field := TStringField.Create(TbResourceRestriction);
  with Field do
  begin
    DisplayLabel := SFlResourceRestriction_IdResourceRestrictionType;
    DisplayWidth := 10;
    FieldKind := fkLookup;
    FieldName := 'NaResourceRestrictionType';
    LookupDataSet := TbResourceRestrictionType;
    LookupKeyFields := 'IdResourceRestrictionType';
    LookupResultField := 'NaResourceRestrictionType';
    KeyFields := 'IdResourceRestrictionType';
    Size := 10;
    Lookup := True;
    DataSet := TbResourceRestriction;
  end;
  Field := TStringField.Create(TbDistribution.Owner);
  with Field do
  begin
    DisplayLabel := SFlDistribution_IdCategory;
    DisplayWidth := 4;
    FieldKind := fkLookup;
    FieldName := 'AbCategory';
    LookupDataSet := SourceDataModule.TbCategory;
    LookupKeyFields := 'IdCategory';
    LookupResultField := 'AbCategory';
    KeyFields := 'IdCategory';
    Size := 5;
    Lookup := True;
    DataSet := TbDistribution;
  end;
  Field := TStringField.Create(TbDistribution.Owner);
  with Field do
  begin
    DisplayLabel := SFlDistribution_IdParallel;
    DisplayWidth := 4;
    FieldKind := fkLookup;
    FieldName := 'NaParallel';
    LookupDataSet := SourceDataModule.TbParallel;
    LookupKeyFields := 'IdParallel';
    LookupResultField := 'NaParallel';
    KeyFields := 'IdParallel';
    Size := 5;
    Lookup := True;
    DataSet := TbDistribution;
  end;
  Field := TStringField.Create(TbDistribution.Owner);
  with Field do
  begin
    DisplayLabel := SFlDistribution_IdTheme;
    DisplayWidth := 10;
    FieldKind := fkLookup;
    FieldName := 'NaTheme';
    LookupDataSet := SourceDataModule.TbTheme;
    LookupKeyFields := 'IdTheme';
    LookupResultField := 'NaTheme';
    KeyFields := 'IdTheme';
    Size := 15;
    Lookup := True;
    DataSet := TbDistribution;
  end;
  Field := TStringField.Create(TbDistribution.Owner);
  with Field do
  begin
    DisplayLabel := SFlDistribution_IdRoomType;
    DisplayWidth := 6;
    FieldKind := fkLookup;
    FieldName := 'AbRoomType';
    LookupDataSet := SourceDataModule.TbRoomType;
    LookupKeyFields := 'IdRoomType';
    LookupResultField := 'AbRoomType';
    KeyFields := 'IdRoomType';
    Size := 10;
    Lookup := True;
    DataSet := TbDistribution;
  end;
  Field := TLongintField.Create(TbDistribution.Owner);
  with Field do
  begin
    FieldKind := fkCalculated;
    DisplayWidth := 5;
    FieldName := 'Duration';
    DataSet := TbDistribution;
  end;
  Field := TStringField.Create(TbAssistance.Owner);
  with Field do
  begin
    DisplayLabel := SFlAssistance_IdResource;
    DisplayWidth := 31;
    FieldKind := fkLookup;
    FieldName := 'NameResource';
    LookupDataSet := QuResource;
    LookupKeyFields := 'IdResource';
    LookupResultField := 'NameResource';
    KeyFields := 'IdResource';
    Size := 31;
    Lookup := True;
    DataSet := TbAssistance;
  end;
  Field := TStringField.Create(TbJoinedCluster.Owner);
  with Field do
  begin
    DisplayLabel := 'Cluster Name';
    DisplayWidth := 4;
    FieldKind := fkLookup;
    FieldName := 'NameCluster';
    LookupDataSet := SourceDataModule.QuCluster;
    LookupKeyFields := 'IdCategory;IdParallel';
    LookupResultField := 'NameCluster';
    KeyFields := 'IdCategory;IdParallel1';
    Size := 5;
    Lookup := True;
    DataSet := TbJoinedCluster;
  end;
end;

procedure TSourceDataModule.HideFields;
begin
  TbRoomType.FindField('IdRoomType').Visible := False;
  TbDay.FindField('IdDay').Visible := False;
  TbTheme.FindField('IdTheme').Visible := False;
  TbHour.FindField('IdHour').Visible := False;
  TbCategory.FindField('IdCategory').Visible := False;
  TbParallel.FindField('IdParallel').Visible := False;
  TbThemeRestrictionType.FindField('IdThemeRestrictionType').Visible := False;
  TbTimeSlot.FindField('IdDay').Visible := False;
  TbTimeSlot.FindField('IdHour').Visible := False;
  TbCluster.FindField('IdCategory').Visible := False;
  TbCluster.FindField('IdParallel').Visible := False;
  TbResource.FindField('IdResource').Visible := False;
  with TbTimetableDetail do
  begin
    FindField('IdTimetable').Visible := False;
    FindField('IdTheme').Visible := False;
    FindField('IdCategory').Visible := False;
    FindField('IdParallel').Visible := False;
    FindField('IdDay').Visible := False;
    FindField('IdHour').Visible := False;
  end;
  TbResourceRestrictionType.FindField('IdResourceRestrictionType').Visible := False;
  with TbDistribution do
  begin
    FindField('IdTheme').Visible := False;
    FindField('IdCategory').Visible := False;
    FindField('IdResource').Visible := False;
    FindField('IdRoomType').Visible := False;
  end;
  with TbAssistance do
  begin
    FindField('IdTheme').Visible := False;
    FindField('IdCategory').Visible := False;
    FindField('IdParallel').Visible := False;
    FindField('IdResource').Visible := False;
  end;
  with TbJoinedCluster do
  begin
    FindField('IdTheme').Visible := False;
    FindField('IdCategory').Visible := False;
    FindField('IdParallel').Visible := False;
    FindField('IdCategory1').Visible := False;
    FindField('IdParallel1').Visible := False;
  end;
end;

procedure TSourceDataModule.EmptyDataSet(ADataSet: TDataSet);
begin
  DbZConnection.ExecuteDirect(Format('DELETE FROM %s', [NameDataSet[ADataSet]]));
  ADataSet.Refresh;
end;

procedure TSourceDataModule.LoadDataSetFromStrings(const ATableName: string;
  AStrings: TStrings; var APosition: Integer);
var
  RecordCount: Integer;
  procedure StringsToSQL(ASQL: TStrings; var Position: Integer; RecordCount: Integer);
  var
    FieldNames, FieldValues: string;
    j, Pos, Limit: Integer;
    Value, Values, Fields: string;
    ZTable: TZTable;
    FieldArray: TFieldArray;
  begin
    ZTable := TZTable.Create(nil);
    try
      ZTable.Connection := DbZConnection;
      ZTable.TableName := ATableName;
      PrepareDataSetFields(ZTable);
      FieldNames := AStrings.Strings[Position];
      Inc(Position);
      FieldArray := FieldNamesToFieldArray(ZTable, FieldNames);
      Fields := '';
      for j := 0 to High(FieldArray) do
      begin
        if Assigned(FieldArray[j]) then
        begin
          if Fields = '' then
            Fields := FieldArray[j].FieldName
          else
            Fields := Fields + ',' + FieldArray[j].FieldName;
        end;
      end;
      if Fields = '' then
      begin
        Inc(Position, RecordCount);
      end
      else
      begin
        Limit := Position + RecordCount;
        while Position < Limit do
        begin
          Pos := 2;
          FieldValues := AStrings[Position];
          Values := '';
          for j := 0 to High(FieldArray) do
          begin
            Value := ScapedToString(FieldValues, Pos);
            if Assigned(FieldArray[j]) then
            begin
              if Values = '' then
                Values := '"' + Value + '"'
              else
                Values := Values + ',"' + Value + '"';
            end;
            Inc(Pos, 3);
          end;
          ASQL.Add(Format('INSERT INTO %s (%s) VALUES (%s);',
                          [ATableName, Fields, Values]));
          Inc(Position);
        end;
      end;
    finally
      ZTable.Free;
    end;
  end;
  procedure LoadTableFromStrings0;
  var
    SQL: TStrings;
  begin
    SQL := TStringList.Create;
    DbZConnection.ExecuteDirect('pragma foreign_keys=off');
    try
      StringsToSQL(SQL, APosition, RecordCount);
      DbZConnection.ExecuteDirect(SQL.Text);
    finally
      SQL.Free;
      DbZConnection.ExecuteDirect('pragma foreign_keys=off');
    end;
  end;
begin
  RecordCount := StrToInt(AStrings.Strings[APosition]);
  Inc(APosition);
  LoadTableFromStrings0;
end;

procedure TSourceDataModule.EmptyTables;
begin
  try
    DbZConnection.StartTransaction;
    inherited EmptyTables;
    DbZConnection.Commit;
  except
    DbZConnection.Rollback;
    raise;
  end;
end;

procedure TSourceDataModule.SaveToStrings(AStrings: TStrings);
var
  ZTable: TZTable;
  Field: TField;
begin
  ZTables.Close;
  ZTables.Open;
  ZTable := TZTable.Create(nil);
  try
    // sqlite_sequence is a system table that must not be saved:
    AStrings.Add(IntToStr(ZTables.RecordCount - 1));
    ZTable.Connection := ZTables.Connection;
    Field := ZTables.Fields[0];
    while not ZTables.EOF do
    begin
      if Field.AsString <> 'sqlite_sequence' then
      begin
        ZTable.TableName := Field.AsString;
        ZTable.Open;
        AStrings.Add(Field.AsString);
        SaveDataSetToStrings(ZTable, AStrings);
        ZTable.Close;
      end;
      ZTables.Next;
    end;
  finally
    ZTable.Free;
  end;
end;

procedure TSourceDataModule.PrepareTables;
begin
  PrepareFields;
  TbDistribution.FindField('Composition').DisplayWidth := 10;
  ApplyOnTables(SetFieldCaption);
  PrepareLookupFields;
  HideFields;
end;

procedure TSourceDataModule.SetFieldCaption(ADataSet: TDataSet);
var
  i: Integer;
  DisplayLabel: string;
begin
  for i := 0 to ADataSet.Fields.Count - 1 do
  begin
    DisplayLabel := FieldCaption[ADataSet.Fields[i]];
    if DisplayLabel <> '' then
      ADataSet.Fields[i].DisplayLabel := DisplayLabel;
  end;
end;

function GetFieldAssignments(const Fields: string; const Values: Variant): string;
var
  Pos, l: Integer;
  Field, Assignment: string;
begin
  Result := '';
  if VarIsArray(Values) then
  begin
    l := 0;
    Pos := 2;
    while True do
    begin
      Field := ScapedToString(Fields, Pos);
      if Field = '' then
        break;
      Assignment := Format('%s="%s"', [Field, Values[l]]);
      if l = 0 then
        Result := Assignment
      else
        Result := Result + ' and ' + Assignment;
      Inc(l);
      Inc(Pos, 3);
    end;
  end
  else
    Result := Format('%s="%s"', [Fields, VarToStr(Values)]);
end;

procedure TSourceDataModule.UpdateDetailFields(ADetail: TDataSet;
                             const ADetailFields: string;
                             const OldValues, CurValues: Variant);
begin
  with TZTable(ADetail) do
  begin
    Connection.ExecuteDirect(
    Format('UPDATE %s SET %s WHERE %s', [TableName,
      GetFieldAssignments(ADetailFields, CurValues),
      GetFieldAssignments(ADetailFields, OldValues)]));
    Refresh;
  end
end;

procedure TSourceDataModule.DeleteDetailFields(ADetail: TDataSet;
                             const AMasterFields: string;
                             const AMasterValues: Variant);
begin
  with TZTable(ADetail) do
  begin
    DbZConnection.ExecuteDirect(Format('DELETE FROM %s WHERE %s;',
      [TableName, GetFieldAssignments(AMasterFields, AMasterValues)]));
    Refresh;
  end
end;

procedure TSourceDataModule.CheckDetailRelation(AMaster, ADetail: TDataSet;
                                                const AMasterFields, ADetailFields: string);
  function SkipCheckDetailRelation(ADataSet: TZTable): Boolean;
  begin
    Result := Assigned(ADataSet.MasterSource) and ADataSet.MasterSource.Enabled
      and Assigned(ADataSet.MasterSource.DataSet)
      and (ADataSet.MasterSource.DataSet = AMaster);
  end;
begin
  if not SkipCheckDetailRelation(ADetail as TZTable)
  then // this condition avoids an undesirable loop in DoBeforePost
       // that causes a key violation, and also is an optimization:
       // We do not need to verify master-detail relationship if the tables
       // are already linked using the MasterSource property.
    inherited CheckDetailRelation(AMaster, ADetail,
                                  AMasterFields, ADetailFields);
end;

initialization
{$IFDEF FPC}
  {$i dsource.lrs}
{$ENDIF}

end.
