{ -*- mode: Delphi -*- }
unit FTimetable;

{$I ttg.inc}

interface

uses
  LResources, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, FSingleEditor, Grids, Buttons, FEditor, DBCtrls, ExtCtrls, ComCtrls,
  ActnList, ZDataset, FCrossManytoManyEditorR, DMaster, FConfig, DSource,
  FCrossManyToManyEditor1, FMasterDetailEditor, FTimetableResource;

type

  { TTimetableForm }

  TTimetableForm = class(TSingleEditorForm)
    TBRestrictionNonSatisfied: TToolButton;
    BtTimetableResource: TToolButton;
    BtClashResource: TToolButton;
    BtClashActivity: TToolButton;
    QuClashResource: TZQuery;
    QuClashResourceDetail: TZQuery;
    QuClashActivity: TZQuery;
    QuClashActivityDetail: TZQuery;
    QuClashActivityDetailIdTheme: TLongintField;
    QuTimetableDetailRestriction: TZQuery;
    
    Panel2: TPanel;
    DBMSummary: TDBMemo;
    TBBrokenSessionDay: TToolButton;
    QuBrokenSessionDay: TZQuery;
    TBBrokenSessionHour: TToolButton;
    DSBrokenSessionHour: TDataSource;
    QuBrokenSessionHour: TZQuery;
    QuBrokenSessionHourDetail: TZQuery;
    Splitter1: TSplitter;
    ActTimetableResource: TAction;
    ActClashResource: TAction;
    ActClashActivity: TAction;
    ActRestrictionNonSatisfied: TAction;
    ActBrokenSessionDay: TAction;
    ActBrokenSessionHour: TAction;
    DSClashResource: TDataSource;
    DSClashActivity: TDataSource;
    BtImproveTimetable: TToolButton;
    ActImproveTimeTable: TAction;
    TbTimetable: TZTable;
    procedure ActClashResourceExecute(Sender: TObject);
    procedure ActClashActivityExecute(Sender: TObject);
    procedure ActTimetableResourceExecute(Sender: TObject);
    procedure ActRestrictionNonSatisfiedExecute(Sender: TObject);
    procedure ActBrokenSessionDayExecute(Sender: TObject);
    procedure ActBrokenSessionHourExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure ActFindExecute(Sender: TObject);
    procedure ActImproveTimeTableExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TbTimetableCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FClashActivityForm, FBrokenSessionHourForm,
      FBrokenSessionDayForm, FClashResourceForm: TMasterDetailEditorForm;
    FRestrictionNonSatisfiedForm: TSingleEditorForm;
    FTimetableResourceForm: TTimetableResourceForm;
    procedure ImproveTimetable;
    procedure PrepareCalcFields;
  protected
    procedure doLoadConfig; override;
    procedure doSaveConfig; override;
  public
    { Public declarations }
  end;

var
  TimetableForm: TTimetableForm;

implementation

uses
  Variants, UMakeTT, UTTGConsts, DSourceConsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TTimetableForm.ActClashResourceExecute(Sender: TObject);
begin
  inherited;
  if TMasterDetailEditorForm.ToggleMasterDetailEditor
       (Self, FClashResourceForm, ConfigStorage, ActClashResource,
        QuClashResource, QuClashResourceDetail) then
  begin
    with QuClashResource do
    begin
      Close;
      Open;
      FindField('IdTimetable').Visible := False;
      FindField('IdResource').Visible := False;
      FindField('IdDay').Visible := False;
      FindField('IdHour').Visible := False;
      FindField('IdResourceType').Visible := False;
      FindField('NaResourceType').DisplayLabel := SFlResource_IdResourceType;
      FindField('NaResource').DisplayLabel := SFlRestriction_IdResource;
      FindField('NaDay').DisplayLabel := SFlTimetableDetail_IdDay;
      FindField('NaHour').DisplayLabel := SFlTimetableDetail_IdHour;
    end;
    with QuClashResourceDetail do
    begin
      Close;
      Open;
      FindField('IdTimetable').Visible := False;
      FindField('IdResource').Visible := False;
      FindField('IdDay').Visible := False;
      FindField('IdHour').Visible := False;
      FindField('IdActivity').Visible := False;
      FindField('NaTheme').DisplayLabel := SFlActivity_IdTheme;
      FindField('NaActivity').DisplayLabel := SFlTimetableDetail_IdActivity;
    end;
  end;
end;

procedure TTimetableForm.ActFindExecute(Sender: TObject);
begin
  inherited ActFindExecute(Sender);
end;

procedure TTimetableForm.ActTimetableResourceExecute(Sender: TObject);
begin
  inherited;
  TTimetableResourceForm.ToggleEditor(Self, FTimetableResourceForm,
    ConfigStorage, ActTimetableResource);
end;

procedure TTimetableForm.ActClashActivityExecute(Sender: TObject);
begin
  inherited;
  if TMasterDetailEditorForm.ToggleMasterDetailEditor
       (Self, FClashActivityForm, ConfigStorage, ActClashActivity, QuClashActivity,
        QuClashActivityDetail) then
  begin
    with QuClashActivity do
    begin
      Close;
      Open;
      FindField('IdTimetable').Visible := False;
      FindField('IdActivity').Visible := False;
      FindField('NaTheme').DisplayLabel := SFlActivity_IdTheme;
    end;
    with QuClashActivityDetail do
    begin
      Close;
      Open;
      FindField('IdTimetable').Visible := False;
      FindField('IdActivity').Visible := False;
      FindField('IdDay').Visible := False;
      FindField('IdHour').Visible := False;
      FindField('NaDay').DisplayLabel := SFlTimetableDetail_IdDay;
      FindField('NaHour').DisplayLabel := SFlTimetableDetail_IdHour;
    end;
  end;
end;

procedure TTimetableForm.ActImproveTimeTableExecute(Sender: TObject);
begin
  ActImproveTimeTable.Enabled := False;
  try
    ImproveTimetable;
  finally
    ActImproveTimeTable.Enabled := True;
    ActImproveTimeTable.Checked := False;
  end;
end;

procedure TTimetableForm.PrepareCalcFields;
var
  Field: TField;
begin
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

procedure TTimetableForm.TbTimetableCalcFields(DataSet: TDataSet);
begin
  with DataSet do
  begin
  if not (FindField('TimeEnd').IsNull or FindField('TimeIni').IsNull) then
    FindField('Elapsed').AsDateTime
      := FindField('TimeEnd').AsDateTime
      - FindField('TimeIni').AsDateTime;
  end;
end;


procedure TTimetableForm.FormCreate(Sender: TObject);
begin
  SourceDataModule.PrepareTable(TbTimetable);
  PrepareCalcFields;
  TbTimetable.FindField('Summary').Visible := False;
  TbTimetable.FindField('IdTimetable').Visible := True;
  TbTimetable.Open;
end;

procedure TTimetableForm.ImproveTimetable;
var
  IdTimetableSource, IdTimetableTarget: Integer;
  SNewIdTimetable: string;
begin
  IdTimetableSource := TbTimetable.FindField('IdTimetable').AsInteger;
  SNewIdTimetable := IntToStr(MasterDataModule.NewIdTimetable);
  if not InputQuery(Format(SImprovingTimetable, [IdTimetableSource]),
    SImprovedTimetableId, SNewIdTimetable) then
    Exit;
  IdTimetableTarget := StrToInt(SNewIdTimetable);
  begin
    ActImproveTimeTable.Enabled := False;
    try
      {$IFDEF THREADED}
      TImproveTimetableThread.Create(IdTimetableSource, IdTimetableTarget, False);
      {$ELSE}
      with TImproveTimetableThread.Create(IdTimetableSource, IdTimetableTarget, True) do
      try
        Execute;
      finally
        Free;
      end;
      {$ENDIF}
    finally
      ActImproveTimeTable.Enabled := True;
    end;
  end;
end;

procedure TTimetableForm.ActRestrictionNonSatisfiedExecute
  (Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self,
    FRestrictionNonSatisfiedForm, ConfigStorage,
    ActRestrictionNonSatisfied, QuTimetableDetailRestriction) then
  begin
    with QuTimetableDetailRestriction do
    begin
      Close;
      Open;
      FindField('IdTimetable').Visible := False;
      FindField('IdActivity').Visible := False;
      FindField('IdRestrictionType').Visible := False;
      FindField('IdDay').Visible := False;
      FindField('IdHour').Visible := False;
      FindField('NaResourceType').DisplayLabel := SFlResource_IdResourceType;
      FindField('NaResource').DisplayLabel := SFlRestriction_IdResource;
      FindField('NaDay').DisplayLabel := SFlTimetableDetail_IdDay;
      FindField('NaHour').DisplayLabel := SFlTimetableDetail_IdHour;
      FindField('NaRestrictionType').DisplayLabel := SFlRestriction_IdRestrictionType;
    end;
  end;
end;

procedure TTimetableForm.ActBrokenSessionDayExecute(Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self, FBrokenSessionDayForm,
    ConfigStorage, ActBrokenSessionDay, QuBrokenSessionDay) then
  begin
    with QuBrokenSessionDay do
    begin
      Close;
      Open;
      FindField('IdTimetable').Visible := False;
      FindField('IdDay').Visible := False;
      FindField('IdHour').Visible := False;
      FindField('IdActivity').Visible := False;
      FindField('NaDay').DisplayLabel := SFlTimetableDetail_IdDay;
      FindField('NaHour').DisplayLabel := SFlTimetableDetail_IdHour;
      FindField('NaActivity').DisplayLabel := SFlTimetableDetail_IdActivity;
    end;
  end;
end;

procedure TTimetableForm.ActBrokenSessionHourExecute(Sender: TObject);
begin
  inherited;
  if TMasterDetailEditorForm.ToggleMasterDetailEditor
       (Self, FBrokenSessionHourForm, ConfigStorage, ActBrokenSessionHour,
        QuBrokenSessionHour, QuBrokenSessionHourDetail) then
  begin
    with QuBrokenSessionHour do
    begin
      Close;
      Open;
      FindField('IdTimetable').Visible := False;
      FindField('IdDay').Visible := False;
      FindField('IdHour').Visible := False;
      FindField('NaDay').DisplayLabel := SFlTimetableDetail_IdDay;
      FindField('NaHour').DisplayLabel := SFlTimetableDetail_IdHour;
    end;
    with QuBrokenSessionHourDetail do
    begin
      Close;
      Open;
      FindField('IdTimetable').Visible := False;
      FindField('IdDay').Visible := False;
      FindField('IdHour').Visible := False;
      FindField('IdHour0').Visible := False;
      FindField('IdActivity').Visible := False;
      FindField('NaDay').DisplayLabel := SFlTimetableDetail_IdDay;
      FindField('NaHour').DisplayLabel := SFlTimetableDetail_IdHour + '1';
      FindField('NaHour0').DisplayLabel := SFlTimetableDetail_IdHour + '2';
      FindField('NaActivity').DisplayLabel := SFlTimetableDetail_IdActivity;
    end;
  end;
end;

procedure TTimetableForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited DataSourceDataChange(Sender, Field);
end;

procedure TTimetableForm.DataSourceStateChange(Sender: TObject);
begin
  inherited DataSourceStateChange(Sender);
end;

procedure TTimetableForm.DBGridDblClick(Sender: TObject);
begin
  inherited DBGridDblClick(Sender);
end;

procedure TTimetableForm.doLoadConfig;
begin
  inherited;
  Panel2.Width := ConfigIntegers['Panel2_Width'];
end;

procedure TTimetableForm.doSaveConfig;
begin
  inherited;
  ConfigIntegers['Panel2_Width'] := Panel2.Width;
end;

initialization

{$IFDEF FPC}
{$I FTimetable.lrs}
{$ENDIF}

end.
