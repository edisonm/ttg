{ -*- mode: Delphi -*- }
unit DSource;

{$I ttg.inc}

interface

uses
  LResources, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, ZDataset,
  ZConnection, DSourceConsts;

type

  { TSourceDataModule }

  TSourceDataModule = class(TDataModule)
    DbZConnection: TZConnection;
    QuTimetable: TZQuery;
    QuTimetableResource: TZQuery;
    QuTimetableDetail: TZQuery;
    ZConnection1: TZConnection;
    ZTable1IdDay1: TAutoIncField;
    ZTable1NaHour1: TVariantField;
    ZTables: TZReadOnlyQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FDataSetNameList: TStrings;
    FDataSetDescList: TStrings;
    FFieldCaptionList: TStrings;
    function GetDescription(ADataSet: TDataSet): string;
    function GetNameDataSet(ADataSet: TDataSet): string;
    function GetFieldCaption(ADataSet: TDataSet; AField: TField): string; overload;
    function GetFieldCaption(AField: TField): string; overload;

  protected
    property DataSetNameList: TStrings read FDataSetNameList;
    property DataSetDescList: TStrings read FDataSetDescList;
    property FieldCaptionList: TStrings read FFieldCaptionList;
    procedure LoadDataSetFromStrings(const ATableName: string;
                                     AStrings: TStrings; var APosition: Integer);
    procedure UpdateDetailFields(ADetail: TDataSet;
                                 const ADetailFields: string;
                                 const OldValues, CurValues: Variant);
    procedure DeleteDetailFields(ADetail: TDataSet;
                                 const AMasterFields: string;
                                 const AMasterValues: Variant);
    procedure SetFieldCaption(ADataSet: TDataSet); overload;
  public
    { Public declarations }
    procedure EmptyTables;
    procedure LoadFromStrings(AStrings: TStrings; var APosition: Integer);
    procedure SaveToStrings(AStrings: TStrings);
    procedure PrepareTable(ADataSet: TDataSet);
    function NewTable(const ATableName: string; AOwner: TComponent): TZTable;
    property Description[ADataSet: TDataSet]: string read GetDescription;
    property NameDataSet[ADataSet: TDataSet]: string read GetNameDataSet;
    property FieldCaption[AField: TField]: string read GetFieldCaption;
  end;

var
  SourceDataModule: TSourceDataModule;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  Variants, FConfig, UTTGDBUtils, URelUtils, UTTGConsts;

function TSourceDataModule.NewTable(const ATableName: string; AOwner: TComponent): TZTable;
begin
  Result := TZTable.Create(AOwner);
  Result.TableName := ATableName;
  Result.Connection := SourceDataModule.DbZConnection;
  PrepareTable(Result);
end;

procedure TSourceDataModule.PrepareTable(ADataSet: TDataSet);
begin
  PrepareDataSetFields(ADataSet);
  SetFieldCaption(ADataSet);
  HideAutoIncFields(ADataSet);
end;

procedure TSourceDataModule.DataModuleCreate(Sender: TObject);
begin
  FDataSetNameList := TStringList.Create;
  FDataSetDescList := TStringList.Create;
  FFieldCaptionList := TStringList.Create;
  with DataSetNameList do
  begin
    Add('TbTheme=Theme');
    Add('TbResourceType=ResourceType');
    Add('TbDay=Day');
    Add('TbHour=Hour');
    Add('TbResource=Resource');
    Add('TbPeriod=Period');
    Add('TbActivity=Activity');
    Add('TbAvailability=Availability');
    Add('TbResourceTypeLimit=ResourceTypeLimit');
    Add('TbRestrictionType=RestrictionType');
    Add('TbRestriction=Restriction');
    Add('TbParticipant=Participant');
    Add('TbTimetable=Timetable');
    Add('TbTimetableDetail=TimetableDetail');
    Add('TbTimetableResource=TimetableResource');
  end;
  with FieldCaptionList do
  begin
    Add('TbTheme.IdTheme=' + SFlTheme_IdTheme);
    Add('TbTheme.NaTheme=' + SFlTheme_NaTheme);
    Add('TbTheme.Composition=' + SFlTheme_Composition);
    Add('TbResourceType.IdResourceType=' + SFlResourceType_IdResourceType);
    Add('TbResourceType.NaResourceType=' + SFlResourceType_NaResourceType);
    Add('TbResourceType.NumResourceLimit=' + SFlResourceType_NumResourceLimit);
    Add('TbResourceType.ValResourceType=' + SFlResourceType_ValResourceType);
    Add('TbResourceType.MaxWorkLoad=' + SFlResourceType_MaxWorkLoad);
    Add('TbDay.IdDay=' + SFlDay_IdDay);
    Add('TbDay.NaDay=' + SFlDay_NaDay);
    Add('TbHour.IdHour=' + SFlHour_IdHour);
    Add('TbHour.NaHour=' + SFlHour_NaHour);
    Add('TbHour.Interval=' + SFlHour_Interval);
    Add('TbResource.IdResourceType=' + SFlResource_IdResourceType);
    Add('TbResource.IdResource=' + SFlResource_IdResource);
    Add('TbResource.NaResource=' + SFlResource_NaResource);
    Add('TbResource.AbResource=' + SFlResource_AbResource);
    Add('TbResource.NumResource=' + SFlResource_NumResource);
    Add('TbPeriod.IdDay=' + SFlPeriod_IdDay);
    Add('TbPeriod.IdHour=' + SFlPeriod_IdHour);
    Add('TbActivity.IdActivity=' + SFlActivity_IdActivity);
    Add('TbActivity.IdTheme=' + SFlActivity_IdTheme);
    Add('TbActivity.NaActivity=' + SFlActivity_NaActivity);
    Add('TbAvailability.IdTheme=' + SFlAvailability_IdTheme);
    Add('TbAvailability.IdResource=' + SFlAvailability_IdResource);
    Add('TbAvailability.NumResource=' + SFlAvailability_NumResource);
    Add('TbResourceTypeLimit.IdTheme=' + SFlResourceTypeLimit_IdTheme);
    Add('TbResourceTypeLimit.IdResourceType=' + SFlResourceTypeLimit_IdResourceType);
    Add('TbResourceTypeLimit.NumResourceLimit=' + SFlResourceTypeLimit_NumResourceLimit);
    Add('TbRestrictionType.IdRestrictionType=' + SFlRestrictionType_IdRestrictionType);
    Add('TbRestrictionType.NaRestrictionType=' + SFlRestrictionType_NaRestrictionType);
    Add('TbRestrictionType.ColRestrictionType=' + SFlRestrictionType_ColRestrictionType);
    Add('TbRestrictionType.ValRestrictionType=' + SFlRestrictionType_ValRestrictionType);
    Add('TbRestriction.IdResource=' + SFlRestriction_IdResource);
    Add('TbRestriction.IdDay=' + SFlRestriction_IdDay);
    Add('TbRestriction.IdHour=' + SFlRestriction_IdHour);
    Add('TbRestriction.IdRestrictionType=' + SFlRestriction_IdRestrictionType);
    Add('TbParticipant.IdActivity=' + SFlParticipant_IdActivity);
    Add('TbParticipant.IdResource=' + SFlParticipant_IdResource);
    Add('TbParticipant.NumResource=' + SFlParticipant_NumResource);
    Add('TbTimetable.IdTimetable=' + SFlTimetable_IdTimetable);
    Add('TbTimetable.TimeIni=' + SFlTimetable_TimeIni);
    Add('TbTimetable.TimeEnd=' + SFlTimetable_TimeEnd);
    Add('TbTimetable.Summary=' + SFlTimetable_Summary);
    Add('TbTimetableDetail.IdTimetable=' + SFlTimetableDetail_IdTimetable);
    Add('TbTimetableDetail.IdActivity=' + SFlTimetableDetail_IdActivity);
    Add('TbTimetableDetail.IdDay=' + SFlTimetableDetail_IdDay);
    Add('TbTimetableDetail.IdHour=' + SFlTimetableDetail_IdHour);
    Add('TbTimetableDetail.Session=' + SFlTimetableDetail_Session);
    Add('TbTimetableResource.IdTimetable=' + SFlTimetableResource_IdTimetable);
    Add('TbTimetableResource.IdActivity=' + SFlTimetableResource_IdActivity);
    Add('TbTimetableResource.IdResource=' + SFlTimetableResource_IdResource);
    Add('TbTimetableResource.NumResource=' + SFlTimetableResource_NumResource);
  end;
  with DataSetDescList do
  begin
    Add('TbTheme=' + STbTheme);
    Add('TbResourceType=' + STbResourceType);
    Add('TbDay=' + STbDay);
    Add('TbHour=' + STbHour);
    Add('TbResource=' + STbResource);
    Add('TbPeriod=' + STbPeriod);
    Add('TbActivity=' + STbActivity);
    Add('TbAvailability=' + STbAvailability);
    Add('TbResourceTypeLimit=' + STbResourceTypeLimit);
    Add('TbRestrictionType=' + STbRestrictionType);
    Add('TbRestriction=' + STbRestriction);
    Add('TbParticipant=' + STbParticipant);
    Add('TbTimetable=' + STbTimetable);
    Add('TbTimetableDetail=' + STbTimetableDetail);
    Add('TbTimetableResource=' + STbTimetableResource);
  end;
end;

procedure TSourceDataModule.DataModuleDestroy(Sender: TObject);
begin
  FDataSetNameList.Free;
  FDataSetDescList.Free;
  FFieldCaptionList.Free;
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
var
  Field: TField;
begin
  ZTables.Close;
  ZTables.Open;
  try
    DbZConnection.StartTransaction;
    Field := ZTables.Fields[0];
    while not ZTables.EOF do
    begin
      if Field.AsString <> 'sqlite_sequence' then
      begin
        DbZConnection.ExecuteDirect(Format('DELETE FROM %s', [Field.AsString]));
      end;
      ZTables.Next;
    end;
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

procedure TSourceDataModule.LoadFromStrings(AStrings: TStrings; var APosition: Integer);
var
  i, NumTables: Integer;
  TableName: string;
begin
  NumTables := StrToInt(AStrings[APosition]);
  Inc(APosition);
  for i := 0 to NumTables - 1 do
  begin
    TableName := AStrings[APosition];
    Inc(APosition);
    try
      try
        LoadDataSetFromStrings(TableName, AStrings, APosition);
      except
        MessageDlg(Format(SWhenProcessing, [TableName]), mtError, [mbOk], 0);
        raise;
      end;
    finally
    end;
  end;
  // RefreshTables;
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

(*
procedure TSourceDataModule.PrepareTables;
begin
  // PrepareFields;
  // ApplyOnTables(SetFieldCaption);
  // PrepareLookupFields;
  // PrepareCalcFields;
  // HideFields;
end;
*)
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


function TSourceDataModule.GetDescription(ADataSet: TDataSet): string;
begin
  Result := DataSetDescList.Values[ADataSet.Name];
  if Result = '' then
    Result := ADataSet.Name;
end;

function TSourceDataModule.GetFieldCaption(ADataSet: TDataSet; AField: TField): string;
var
  ValueName: string;
begin
  if ADataSet is TZTable then
    ValueName := 'Tb' + TZTable(ADataSet).TableName + '.' + AField.FieldName
  else
    ValueName := ADataSet.Name + '.' + AField.FieldName;
  Result := FieldCaptionList.Values[ValueName];
end;

function TSourceDataModule.GetFieldCaption(AField: TField): string;
begin
  Result := GetFieldCaption(AField.DataSet, AField);
  if Result = '' then
    Result := AField.FieldName;
end;

function TSourceDataModule.GetNameDataSet(ADataSet: TDataSet): string;
begin
  Result := DataSetNameList.Values[ADataSet.Name];
  if Result = '' then
    Result := ADataSet.Name;
end;

initialization
{$IFDEF FPC}
  {$i DSource.lrs}
{$ENDIF}

end.
