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
    ZTables: TZReadOnlyQuery;
    QuResource: TZReadOnlyQuery;
    procedure DSResourceTypeDataChange(Sender: TObject; Field: TField);
    procedure TbThemeBeforePost(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TbThemeCalcFields(DataSet: TDataSet);
    procedure TbTimetableCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure SetFieldCaption(ADataSet: TDataSet);
    procedure PrepareLookupFields;
    procedure PrepareCalcFields;
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
  Variants, FConfig, UTTGDBUtils, URelUtils, UTTGConsts;

procedure TSourceDataModule.TbThemeBeforePost(DataSet: TDataSet);
var
  s: string;
begin
  with DataSet do
  begin
    s := FindField('Composition').AsString;
    if CompositionToDuration(s) <= 0 then
      raise Exception.CreateFmt(SInvalidComposition, [s]);
    // with FindField('IdTheme') do DefaultExpression := AsString;
    // with FindField('IdCategory') do DefaultExpression := AsString;
    // with FindField('IdParallel') do DefaultExpression := AsString;
  end;
end;

procedure TSourceDataModule.DSResourceTypeDataChange(Sender: TObject;
  Field: TField);
begin
  TbParticipant.Filter := 'IdResourceType='
    + IntToStr(TbResourceType.FindField('IdResourceType').AsInteger);
  TbAvailability.Filter := TbParticipant.Filter;
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
  SNaResourceType: array[0..2] of string = (
    SSupervisor,
    SRoom,
    SAttendant);
  EValResourceType: array[0..2] of Integer = (
    300,
    120,
    50);
  SNaRestrictionType: array[0..1] of string = (
    SInadequate,
    SImpossible);
  EColRestrictionType: array[0..1] of TColor = (
    clLime,
    clRed);
  EValRestrictionType: array[0..1] of Integer = (
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
        FindField('IdDay').AsInteger := i;
        FindField('NaDay').AsString := DayNames[i];
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
        FindField('IdHour').AsInteger := i;
        FindField('NaHour').AsString := SNaHour[i];
        FindField('Interval').AsString := s;
        Post;
      end;
    end;
    with TbPeriod do
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
            FindField('IdDay').AsInteger := TbDay.FindField('IdDay').AsInteger;
            FindField('IdHour').AsInteger := TbHour.FindField('IdHour').AsInteger;
            Post;
          end;
          TbHour.Next;
        end;
        TbDay.Next;
      end;
    end;
    with TbResourceType do
    begin
      for i := Low(SNaResourceType) to High(SNaResourceType) do
      begin
        Append;
        FindField('IdResourceType').AsInteger := i;
        FindField('NaResourceType').AsString := SNaResourceType[i];
        FindField('NumResourceLimit').AsInteger := 1;
        FindField('ValResourceType').AsFloat := EValResourceType[i];
        Post;
      end;
    end;
    with TbRestrictionType do
    begin
      for i := Low(SNaRestrictionType) to High(SNaRestrictionType) do
      begin
        Append;
        Fields[0].AsInteger := i;
        Fields[1].AsString := SNaRestrictionType[i];
        Fields[2].AsInteger := EColRestrictionType[i];
        Fields[3].AsFloat := EValRestrictionType[i];
        Post;
      end;
    end;
  finally
    CheckRelations := True;
  end;
end;

procedure TSourceDataModule.PrepareLookupFields;
  procedure NewLookupField(ADataSet, ALookupDataSet: TDataSet;
                            const AKeyFields, AFieldName: string);
  var
    Field: TField;
  begin
    Field := TStringField.Create(ADataSet.Owner);
    with Field do
    begin
      DisplayLabel := FieldCaptionList.Values[ADataSet.Name + '.' + AKeyFields];
      DisplayWidth := ALookupDataSet.FindField(AFieldName).DisplayWidth;
      FieldKind := fkLookup;
      FieldName := AFieldName;
      LookupDataSet := ALookupDataSet;
      LookupKeyFields := AKeyFields;
      LookupResultField := AFieldName;
      KeyFields := AKeyFields;
      Size := ALookupDataSet.FindField(AFieldName).Size;
      Lookup := True;
      DataSet := ADataSet;
      Index := ADataSet.FindField(AKeyFields).Index;
    end;
    ADataSet.FindField(AKeyFields).Index := ADataSet.FieldCount - 1;
  end;
begin
  NewLookupField(TbResource, TbResourceType, 'IdResourceType', 'NaResourceType');
  NewLookupField(TbRestriction, TbRestrictionType, 'IdRestrictionType', 'NaRestrictionType');
  NewLookupField(TbParticipant, TbResource, 'IdResource', 'NaResource');
  NewLookupField(TbResourceTypeLimit, TbResourceType, 'IdResourceType', 'NaResourceType');
  NewLookupField(TbAvailability, TbResource, 'IdResource', 'NaResource');
end;

procedure TSourceDataModule.PrepareCalcFields;
var
  Field: TField;
begin
  Field := TLongintField.Create(TbTheme.Owner);
  with Field do
  begin
    FieldKind := fkCalculated;
    DisplayWidth := 5;
    FieldName := 'Duration';
    DataSet := TbTheme;
  end;
  Field := TTimeField.Create(TbTimetable.Owner);
  with Field do
  begin
    FieldKind := fkCalculated;
    DisplayWidth := 5;
    FieldName := 'Elapsed';
    DisplayLabel := SElapsedTime;
    DataSet := TbTimetable;
  end;
end;

procedure TSourceDataModule.TbThemeCalcFields(DataSet: TDataSet);
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

procedure TSourceDataModule.TbTimetableCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
  if not (FindField('TimeEnd').IsNull or FindField('TimeIni').IsNull) then
    FindField('Elapsed').AsDateTime
      := FindField('TimeEnd').AsDateTime
      - FindField('TimeIni').AsDateTime;
  end;
end;

procedure TSourceDataModule.HideFields;
begin
  TbDay.FindField('IdDay').Visible := False;
  TbTheme.FindField('IdTheme').Visible := False;
  TbHour.FindField('IdHour').Visible := False;
  TbPeriod.FindField('IdDay').Visible := False;
  TbPeriod.FindField('IdHour').Visible := False;
  TbResourceType.FindField('IdResourceType').Visible := False;
  TbResource.FindField('IdResource').Visible := False;
  TbResource.FindField('IdResourceType').Visible := False;
  TbTimetable.FindField('Summary').Visible := False;
  with TbTimetableDetail do
  begin
    FindField('IdTimetable').Visible := False;
    FindField('IdActivity').Visible := False;
    FindField('IdDay').Visible := False;
    FindField('IdHour').Visible := False;
  end;
  TbRestrictionType.FindField('IdRestrictionType').Visible := False;
  with TbActivity do
  begin
    FindField('IdActivity').Visible := False;
    FindField('IdTheme').Visible := False;
  end;
  with TbParticipant do
  begin
    FindField('IdActivity').Visible := False;
    FindField('IdResource').Visible := False;
  end;
  with TbResourceTypeLimit do
  begin
    FindField('IdTheme').Visible := False;
    FindField('IdResourceType').Visible := False;
  end;
  with TbAvailability do
  begin
    FindField('IdTheme').Visible := False;
    FindField('IdResource').Visible := False;
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
      if ZTable.Exists then
      begin
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
      end
      else
      begin
        Inc(Position, RecordCount + 1);
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
    // DbZConnection.ExecuteDirect('pragma foreign_keys=off');
    try
      StringsToSQL(SQL, APosition, RecordCount);
      DbZConnection.ExecuteDirect(SQL.Text);
    finally
      SQL.Free;
      // DbZConnection.ExecuteDirect('pragma foreign_keys=on');
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
  TbTheme.FindField('Composition').DisplayWidth := 10;
  ApplyOnTables(SetFieldCaption);
  PrepareLookupFields;
  PrepareCalcFields;
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

function GetFieldAvailabilities(const Fields: string; const Values: Variant): string;
var
  Pos, l: Integer;
  Field, Availability: string;
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
      Availability := Format('%s="%s"', [Field, Values[l]]);
      if l = 0 then
        Result := Availability
      else
        Result := Result + ' and ' + Availability;
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
      GetFieldAvailabilities(ADetailFields, CurValues),
      GetFieldAvailabilities(ADetailFields, OldValues)]));
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
      [TableName, GetFieldAvailabilities(AMasterFields, AMasterValues)]));
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
  {$i DSource.lrs}
{$ENDIF}

end.
