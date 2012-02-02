{ -*- mode: Delphi -*- }
unit DSource;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, DSourceBase, DBase, Db, ZConnection;

type

  { TSourceDataModule }

  TSourceDataModule = class(TSourceBaseDataModule)
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
    procedure EmptyDataSet(ADataSet: TDataSet); override;
    procedure LoadTablesFromStrings(AStrings: TStrings; var APosition: Integer); override;
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
  Variants, FConfiguracion, UTTGDBUtils, URelUtils, ZDataSet;

procedure TSourceDataModule.TbDistributionBeforePost(DataSet: TDataSet);
var
  s: string;
begin
  inherited DataSetBeforePost(DataSet);
  with DataSet do
  begin
    s := FindField('Composition').AsString;
    if CompositionToDuration(s) <= 0 then
      raise Exception.CreateFmt('Composition no valida: "%s"', [s]);
    with FindField('IdSubject') do DefaultExpression := AsString;
    with FindField('IdLevel') do DefaultExpression := AsString;
    with FindField('IdSpecialization') do DefaultExpression := AsString;
    with FindField('IdGroupId') do DefaultExpression := AsString;
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
      DataSet['Duracion'] := 0
    else
      DataSet['Duracion'] := CompositionToDuration(v);
  except
    DataSet['Duracion'] := 0;
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
    'Primera',
    'Segunda',
    'Tercera',
    'Cuarta',
    'Recreo',
    'Quinta',
    'Sexta',
    'Septima',
    'Octava'
    );
  SNaSubjectRestrictionType: array[0..1] of string = (
    'Inadecuado',
    'Imposible'
    );
  SNaTeacherRestrictionType: array[0..1] of string = (
    'No gusta',
    'No puede'
    );
  EColSubjectRestrictionType: array[0..1] of TColor = (
    clLime,
    clRed
    );
  EColTeacherRestrictionType: array[0..1] of TColor = (
    clLime,
    clRed
    );
  EValSubjectRestrictionType: array[0..1] of Integer = (
    50,
    500
    );
  EValTeacherRestrictionType: array[0..1] of Integer = (
    50,
    500
    );
var
  t: TDateTime;
  i: Integer;
  s: string;
begin
  CheckRelations := False;
  try
    with TbDay do
    begin
      for i := Low(LongDayNames) + 1 to High(LongDayNames) - 1 do
      begin
        Append;
        Fields[0].AsInteger := i;
        Fields[1].AsString := LongDayNames[i];
        Post;
      end;
    end;
    // Hours por defecto:
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
    // Generar todos los periodos, exceptuando el sabado, domingo y el recreo:
    with TbTimeSlot do
    begin
      TbDay.First;
      while not TbDay.Eof do
      begin
        TbHour.First;
        while not TbHour.Eof do
        begin
          if TbHour.FindField('NaHour').AsString <> 'Recreo' then
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
    with TbSubjectRestrictionType do
    begin
      for i := Low(SNaSubjectRestrictionType) to High(SNaSubjectRestrictionType) do
      begin
        Append;
        Fields[0].AsInteger := i;
        Fields[1].AsString := SNaSubjectRestrictionType[i];
        Fields[2].AsInteger := EColSubjectRestrictionType[i];
        Fields[3].AsFloat := EValSubjectRestrictionType[i];
        Post;
      end;
    end;
    with TbTeacherRestrictionType do
    begin
      for i := Low(SNaTeacherRestrictionType) to High(SNaTeacherRestrictionType) do
      begin
        Append;
        Fields[0].AsInteger := i;
        Fields[1].AsString := SNaTeacherRestrictionType[i];
        Fields[2].AsInteger := EColTeacherRestrictionType[i];
        Fields[3].AsFloat := EValTeacherRestrictionType[i];
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
  Field := TStringField.Create(TbCourse);
  with Field do
  begin
    DisplayLabel := 'Level';
    DisplayWidth := 10;
    FieldKind := fkLookup;
    FieldName := 'AbLevel';
    LookupDataSet := TbLevel;
    LookupKeyFields := 'IdLevel';
    LookupResultField := 'AbLevel';
    KeyFields := 'IdLevel';
    Size := 10;
    Lookup := True;
    DataSet := TbCourse;
  end;
  Field := TStringField.Create(TbCourse);
  with Field do
  begin
    DisplayLabel := 'Espec.';
    DisplayWidth := 10;
    FieldKind := fkLookup;
    FieldName := 'AbSpecialization';
    LookupDataSet := TbSpecialization;
    LookupKeyFields := 'IdSpecialization';
    LookupResultField := 'AbSpecialization';
    KeyFields := 'IdSpecialization';
    Size := 10;
    Lookup := True;
    DataSet := TbCourse;
  end;
  Field := TStringField.Create(TbClass);
  with Field do
  begin
    DisplayLabel := 'Level';
    FieldKind := fkLookup;
    FieldName := 'AbLevel';
    LookupDataSet := TbLevel;
    LookupKeyFields := 'IdLevel';
    LookupResultField := 'AbLevel';
    KeyFields := 'IdLevel';
    Size := 5;
    Lookup := True;
    DataSet := TbClass;
  end;
  Field := TStringField.Create(TbClass);
  with Field do
  begin
    DisplayLabel := 'Specialization';
    FieldKind := fkLookup;
    FieldName := 'AbSpecialization';
    LookupDataSet := TbSpecialization;
    LookupKeyFields := 'IdSpecialization';
    LookupResultField := 'AbSpecialization';
    KeyFields := 'IdSpecialization';
    Size := 10;
    Lookup := True;
    DataSet := TbClass;
  end;
  Field := TStringField.Create(TbClass);
  with Field do
  begin
    DisplayLabel := 'Class';
    FieldKind := fkLookup;
    FieldName := 'NaGroupId';
    LookupDataSet := TbGroupId;
    LookupKeyFields := 'IdGroupId';
    LookupResultField := 'NaGroupId';
    KeyFields := 'IdGroupId';
    Size := 5;
    Lookup := True;
    DataSet := TbClass;
  end;
  Field := TStringField.Create(TbSubjectRestriction);
  with Field do
  begin
    DisplayLabel := 'Prohibicion';
    DisplayWidth := 10;
    FieldKind := fkLookup;
    FieldName := 'NaSubjectRestrictionType';
    LookupDataSet := TbSubjectRestrictionType;
    LookupKeyFields := 'IdSubjectRestrictionType';
    LookupResultField := 'NaSubjectRestrictionType';
    KeyFields := 'IdSubjectRestrictionType';
    Size := 10;
    Lookup := True;
    DataSet := TbSubjectRestriction;
  end;
  Field := TStringField.Create(TbTimeTableDetail);
  with Field do
  begin
    DisplayLabel := 'Subject';
    DisplayWidth := 15;
    FieldKind := fkLookup;
    FieldName := 'NaSubject';
    LookupDataSet := TbSubject;
    LookupKeyFields := 'IdSubject';
    LookupResultField := 'NaSubject';
    KeyFields := 'IdSubject';
    Size := 15;
    Lookup := True;
    DataSet := TbTimeTableDetail;
  end;
  Field := TStringField.Create(TbTeacherRestriction);
  with Field do
  begin
    DisplayLabel := 'Prohibicion';
    DisplayWidth := 10;
    FieldKind := fkLookup;
    FieldName := 'NaTeacherRestrictionType';
    LookupDataSet := TbTeacherRestrictionType;
    LookupKeyFields := 'IdTeacherRestrictionType';
    LookupResultField := 'NaTeacherRestrictionType';
    KeyFields := 'IdTeacherRestrictionType';
    Size := 10;
    Lookup := True;
    DataSet := TbTeacherRestriction;
  end;
  Field := TStringField.Create(TbDistribution.Owner);
  with Field do
  begin
    DisplayLabel := 'Level';
    DisplayWidth := 4;
    FieldKind := fkLookup;
    FieldName := 'AbLevel';
    LookupDataSet := SourceDataModule.TbLevel;
    LookupKeyFields := 'IdLevel';
    LookupResultField := 'AbLevel';
    KeyFields := 'IdLevel';
    Size := 5;
    Lookup := True;
    DataSet := TbDistribution;
  end;
  Field := TStringField.Create(TbDistribution.Owner);
  with Field do
  begin
    DisplayLabel := 'Espec.';
    DisplayWidth := 4;
    FieldKind := fkLookup;
    FieldName := 'AbSpecialization';
    LookupDataSet := SourceDataModule.TbSpecialization;
    LookupKeyFields := 'IdSpecialization';
    LookupResultField := 'AbSpecialization';
    KeyFields := 'IdSpecialization';
    Size := 10;
    Lookup := True;
    DataSet := TbDistribution;
  end;
  Field := TStringField.Create(TbDistribution.Owner);
  with Field do
  begin
    DisplayLabel := 'Par.';
    DisplayWidth := 4;
    FieldKind := fkLookup;
    FieldName := 'NaGroupId';
    LookupDataSet := SourceDataModule.TbGroupId;
    LookupKeyFields := 'IdGroupId';
    LookupResultField := 'NaGroupId';
    KeyFields := 'IdGroupId';
    Size := 5;
    Lookup := True;
    DataSet := TbDistribution;
  end;
  Field := TStringField.Create(TbDistribution.Owner);
  with Field do
  begin
    DisplayLabel := 'Subject';
    DisplayWidth := 10;
    FieldKind := fkLookup;
    FieldName := 'NaSubject';
    LookupDataSet := SourceDataModule.TbSubject;
    LookupKeyFields := 'IdSubject';
    LookupResultField := 'NaSubject';
    KeyFields := 'IdSubject';
    Size := 15;
    Lookup := True;
    DataSet := TbDistribution;
  end;
  Field := TStringField.Create(TbDistribution.Owner);
  with Field do
  begin
    DisplayLabel := 'Aula';
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
    FieldName := 'Duracion';
    DataSet := TbDistribution;
  end;
end;

procedure TSourceDataModule.HideFields;
begin
  TbRoomType.FindField('IdRoomType').Visible := False;
  TbSpecialization.FindField('IdSpecialization').Visible := False;
  TbDay.FindField('IdDay').Visible := False;
  TbSubject.FindField('IdSubject').Visible := False;
  TbLevel.FindField('IdLevel').Visible := False;
  TbHour.FindField('IdHour').Visible := False;
  TbCourse.FindField('IdLevel').Visible := False;
  TbCourse.FindField('IdSpecialization').Visible := False;
  TbGroupId.FindField('IdGroupId').Visible := False;
  TbSubjectRestrictionType.FindField('IdSubjectRestrictionType').Visible := False;
  TbTimeSlot.FindField('IdDay').Visible := False;
  TbTimeSlot.FindField('IdHour').Visible := False;
  TbClass.FindField('IdLevel').Visible := False;
  TbClass.FindField('IdSpecialization').Visible := False;
  TbClass.FindField('IdGroupId').Visible := False;
  TbTeacher.FindField('IdTeacher').Visible := False;
  with TbTimeTableDetail do
  begin
    FindField('IdTimeTable').Visible := False;
    FindField('IdSubject').Visible := False;
    FindField('IdLevel').Visible := False;
    FindField('IdSpecialization').Visible := False;
    FindField('IdGroupId').Visible := False;
    FindField('IdDay').Visible := False;
    FindField('IdHour').Visible := False;
  end;
  TbTeacherRestrictionType.FindField('IdTeacherRestrictionType').Visible := False;
  with TbDistribution do
  begin
    FindField('IdSubject').Visible := False;
    FindField('IdLevel').Visible := False;
    FindField('IdSpecialization').Visible := False;
    FindField('IdGroupId').Visible := False;
    FindField('IdTeacher').Visible := False;
    FindField('IdRoomType').Visible := False;
  end;
end;

procedure TSourceDataModule.EmptyDataSet(ADataSet: TDataSet);
begin
  DbZConnection.ExecuteDirect(Format('DELETE FROM %s', [NameDataSet[ADataSet]]));
  ADataSet.Refresh;
end;

procedure StringsToSQL(const ATableName: string;
  AStrings, ASQL: TStrings; var Position: Integer; RecordCount: Integer);
var
  s: string;
  j, l, Pos, Limit: Integer;
  Value, Values, Field, Fields: string;
begin
  s := AStrings.Strings[Position];
  l := 0;
  Inc(Position);
  Pos := 2;
  while True do
  begin
    Field := ScapedToString(s, Pos);
    if Field = '' then
      break;
    if l = 0 then
      Fields := Field
    else
      Fields := Fields + ',' + Field;
    Inc(l);
    Inc(Pos, 3);
  end;
  Limit := Position + RecordCount;
  while Position < Limit do
  begin
    Pos := 2;
    s := AStrings[Position];
    for j := 0 to l - 1 do
    begin
      Value := ScapedToString(s, Pos);
      if j = 0 then
        Values := Value
      else
        Values := Values + '","' + Value;
      Inc(Pos, 3);
    end;
    ASQL.Add(Format('INSERT INTO %s (%s) VALUES ("%s");',
                    [ATableName, Fields, Values]));
    Inc(Position);
  end;
end;

procedure TSourceDataModule.LoadTablesFromStrings(AStrings: TStrings;
                                                  var APosition: Integer);
var
  i: Integer;
  TableName: string;
  procedure LoadTableFromStrings(const ATableName: string);
  var
    RecordCount: Integer;
    procedure LoadTableFromStrings0;
    var
      SQL: TStrings;
    begin
      SQL := TStringList.Create;
      try
        StringsToSQL(ATableName, AStrings, SQL, APosition, RecordCount);
        DbZConnection.ExecuteDirect(SQL.Text);
      finally
        SQL.Free;
      end;
    end;
  begin
    RecordCount := StrToInt(AStrings.Strings[APosition]);
    Inc(APosition);
    LoadTableFromStrings0;
  end;
begin
  for i := Low(FTables) to High(FTables) do
  begin
    TableName := AStrings[APosition];
    Inc(APosition);
    try
      LoadTableFromStrings(TableName);
    except
      MessageDlg(Format(SWhenProcessing, [TableName]), mtError, [mbOk], 0);
      raise;
    end;
  end;
  for i := Low(FTables) to High(FTables) do
    FTables[i].Refresh;
  // inherited LoadTablesFromStrings(AStrings, APosition);
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
