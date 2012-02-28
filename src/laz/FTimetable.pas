{ -*- mode: Delphi -*- }
unit FTimetable;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, FSingleEditor, Grids, Buttons, FEditor, DBCtrls,
  ExtCtrls, ComCtrls, ActnList, ZDataset, FCrossManytoManyEditorR,
  DMaster, FCrossManyToManyEditor1, FConfig, DSource, FMasterDetailEditor,
  FTimetableResource;

type

  { TTimetableForm }

  TTimetableForm = class(TSingleEditorForm)
    TBResourceRestrictionNonSatisfied: TToolButton;
    BtTimetableResource: TToolButton;
    BtClashResource: TToolButton;
    BtClashActivity: TToolButton;
    QuClashResource: TZQuery;
    QuClashResourceIdResource: TLongintField;
    QuClashResourceIdDay: TLongintField;
    QuClashResourceIdHour: TLongintField;
    QuClashResourceIdResourceType: TLongintField;
    QuClashResourceNaDay: TStringField;
    QuClashResourceNaHour: TStringField;
    QuClashResourceDetail: TZQuery;
    QuClashResourceDetailIdResource: TLongintField;
    QuClashResourceDetailIdActivity: TLongintField;
    QuClashResourceDetailNaTheme: TStringField;
    QuClashActivity: TZQuery;
    QuClashActivityIdTimetable: TLongintField;
    QuClashActivityIdActivity: TLongintField;
    QuClashActivityIdTheme: TLongintField;
    QuClashActivityNaTheme: TStringField;
    QuClashActivityDetail: TZQuery;
    QuClashActivityDetailIdTimetable: TLongintField;
    QuClashActivityDetailIdActivity: TLongintField;
    QuClashActivityDetailIdTheme: TLongintField;
    QuClashActivityDetailIdDay: TLongintField;
    QuClashActivityDetailIdHour: TLongintField;
    QuClashActivityDetailNaDay: TStringField;
    QuClashActivityDetailNaHour: TStringField;
    QuTimetableDetailResourceRestriction: TZQuery;
    QuTimetableDetailResourceRestrictionIdTimetable: TLongintField;
    QuTimetableDetailResourceRestrictionIdActivity: TLongintField;
    QuTimetableDetailResourceRestrictionNaResourceType: TStringField;
    QuTimetableDetailResourceRestrictionIdResourceRestrictionType: TLongintField;
    QuTimetableDetailResourceRestrictionNaResource: TStringField;
    QuTimetableDetailResourceRestrictionIdDay: TLongintField;
    QuTimetableDetailResourceRestrictionIdHour: TLongintField;
    QuTimetableDetailResourceRestrictionNaResourceRestrictionType: TStringField;
    QuTimetableDetailResourceRestrictionNaDay: TStringField;
    QuTimetableDetailResourceRestrictionNaHour: TStringField;
    
    Panel2: TPanel;
    dbmSummary: TDBMemo;
    BtThemeCutDay: TToolButton;
    QuBrokenSessionDay: TZQuery;
    QuBrokenSessionDayIdCategory: TLongintField;
    QuBrokenSessionDayIdParallel: TLongintField;
    QuBrokenSessionDayIdDay: TLongintField;
    QuBrokenSessionDayIdHour: TLongintField;
    QuBrokenSessionDayIdTheme: TLongintField;
    QuBrokenSessionDayAbCategory: TStringField;
    QuBrokenSessionDayNaParallel: TStringField;
    QuBrokenSessionDayNaTheme: TStringField;
    QuBrokenSessionDayNaDay: TStringField;
    QuBrokenSessionDayNaHour: TStringField;
    BtThemeCutHour: TToolButton;
    QuBrokenSessionHour: TZQuery;
    QuBrokenSessionHourIdDay: TLongintField;
    QuBrokenSessionHourIdHour: TLongintField;
    QuBrokenSessionHourDetail: TZQuery;
    DSThemeCutHour: TDataSource;
    QuBrokenSessionHourNaDay: TStringField;
    QuBrokenSessionHourNaHour: TStringField;
    QuBrokenSessionHourDetailIdCategory: TLongintField;
    QuBrokenSessionHourDetailIdParallel: TLongintField;
    QuBrokenSessionHourDetailIdDay: TLongintField;
    QuBrokenSessionHourDetailIdHour0: TLongintField;
    QuBrokenSessionHourDetailIdTheme: TLongintField;
    QuBrokenSessionHourDetailAbCategory: TStringField;
    QuBrokenSessionHourDetailNaParallel: TStringField;
    QuBrokenSessionHourDetailNaDay: TStringField;
    QuBrokenSessionHourDetailNaHour: TStringField;
    QuBrokenSessionHourDetailNaTheme: TStringField;
    QuBrokenSessionHourDetailIdHour: TLongintField;
    Splitter1: TSplitter;
    ActTimetableResource: TAction;
    ActClashResource: TAction;
    ActClashActivity: TAction;
    ActResourceRestrictionNonSatisfied: TAction;
    ActThemeCutDay: TAction;
    ActThemeCutHour: TAction;
    DSClashResource: TDataSource;
    QuClashResourceIdTimetable: TLongintField;
    QuBrokenSessionDayIdTimetable: TLongintField;
    QuBrokenSessionHourIdTimetable: TLongintField;
    QuClashResourceNaResourceType: TStringField;
    QuClashResourceNaResource: TStringField;
    QuClashResourceOccupied: TLongintField;
    QuClashResourceClashes: TLongintField;
    QuClashResourceDetailIdTimetable: TLongintField;
    DSClashActivity: TDataSource;
    QuBrokenSessionHourDetailIdTimetable: TLongintField;
    QuClashResourceDetailIdDay: TLongintField;
    QuClashResourceDetailIdHour: TLongintField;
    BtMejorarTimetable: TToolButton;
    ActImproveTimeTable: TAction;
    procedure ActClashResourceExecute(Sender: TObject);
    procedure ActClashActivityExecute(Sender: TObject);
    procedure ActTimetableResourceExecute(Sender: TObject);
    procedure ActResourceRestrictionNonSatisfiedExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QuClashResourceAfterScroll(DataSet: TDataSet);
    procedure QuClashActivityAfterScroll(DataSet: TDataSet);
    procedure ActThemeCutDayExecute(Sender: TObject);
    procedure ActThemeCutHourExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure ActFindExecute(Sender: TObject);
    procedure ActImproveTimeTableExecute(Sender: TObject);
  private
    { Private declarations }
    FClashActivityForm, FThemeCutHourForm,
      FThemeCutDayForm, FClashResourceForm: TMasterDetailEditorForm;
    FResourceRestrictionNonSatisfiedForm: TSingleEditorForm;
    FTimetableResourceForm: TTimetableResourceForm;
    {$IFNDEF FREEWARE}
    procedure MejorarTimetable;
    {$ENDIF}
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
  Variants, UTTModel, UMakeTT, UTTGConsts, dsourcebaseconsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TTimetableForm.ActClashResourceExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, MasterDataModule do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FClashResourceForm, ConfigStorage, ActClashResource,
      QuClashResource, QuClashResourceDetail) then
    begin
      QuClashResource.Close;
      QuClashResourceDetail.Close;
      QuClashResource.Open;
      QuClashResourceDetail.Open;
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
  if TTimetableResourceForm.ToggleEditor(Self, FTimetableResourceForm,
    ConfigStorage, ActTimetableResource) then
  begin
    with SourceDataModule do
      FTimetableResourceForm.LoadHints(TbDay, TbHour, TbResource);
    FTimetableResourceForm.TBShowClick(nil);
  end
end;

procedure TTimetableForm.ActClashActivityExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FClashActivityForm, ConfigStorage, ActClashActivity, QuClashActivity,
      QuClashActivityDetail) then
    begin
      QuClashActivity.Close;
      QuClashActivity.Open;
      QuClashActivityDetail.Close;
      QuClashActivityDetail.Open;
    end;
  end;
end;

procedure TTimetableForm.ActImproveTimeTableExecute(Sender: TObject);
begin
  ActImproveTimeTable.Enabled := False;
  try
{$IFNDEF FREEWARE}
    MejorarTimetable;
{$ENDIF}
  finally
    ActImproveTimeTable.Enabled := True;
    ActImproveTimeTable.Checked := False;
  end;
end;

{$IFNDEF FREEWARE}
procedure TTimetableForm.MejorarTimetable;
var
  IdTimetableFuente, IdTimetableDestino: Integer;
  SNewIdTimetable: string;
begin
  IdTimetableFuente := SourceDataModule.TbTimetable.FindField('IdTimetable').AsInteger;
  SNewIdTimetable := IntToStr(MasterDataModule.NewIdTimetable);
  if not InputQuery(Format(SImprovingTimetable, [IdTimetableFuente]),
    SImprovedTimetableId, SNewIdTimetable) then
    Exit;
  IdTimetableDestino := StrToInt(SNewIdTimetable);
  with SourceDataModule do
  begin
    ActImproveTimeTable.Enabled := False;
    try
      {$IFDEF THREADED}
      TImproveTimetableThread.Create(IdTimetableFuente, IdTimetableDestino, False);
      {$ELSE}
      with TImproveTimetableThread.Create(IdTimetableFuente, IdTimetableDestino, True) do
      try
        Execute;
      finally
        Free;
      end;
      {$ENDIF}
    finally
      ActImproveTimeTable.Enabled := True;
      TbTimetableDetail.Refresh;
    end;
  end;
end;
{$ENDIF}

procedure TTimetableForm.ActResourceRestrictionNonSatisfiedExecute
  (Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self,
    FResourceRestrictionNonSatisfiedForm, ConfigStorage,
    ActResourceRestrictionNonSatisfied, QuTimetableDetailResourceRestriction) then
  begin
    QuTimetableDetailResourceRestriction.Close;
    QuTimetableDetailResourceRestriction.Open;
  end;
end;

procedure TTimetableForm.FormCreate(Sender: TObject);
begin
  QuClashResourceClashes.DisplayLabel := SClashes;
  QuClashResourceNaResource.DisplayLabel := SFlResource_NaResource;
  QuClashResourceNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuClashResourceNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuClashResourceDetailNaTheme.DisplayLabel := SFlActivity_IdTheme;
  QuClashActivityNaTheme.DisplayLabel := SFlActivity_IdTheme;
  QuClashActivityDetailNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuClashActivityDetailNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuTimetableDetailResourceRestrictionNaDay.DisplayLabel
    := SFlTimetableDetail_IdDay;
  QuTimetableDetailResourceRestrictionNaResourceRestrictionType.DisplayLabel
    := SFlResourceRestriction_IdResourceRestrictionType;
  QuTimetableDetailResourceRestrictionNaHour.DisplayLabel
    := SFlTimetableDetail_IdHour;
  QuBrokenSessionDayIdTimetable.DisplayLabel := SFlTimetableDetail_IdTimeTable;
  QuBrokenSessionDayNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuBrokenSessionDayNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuBrokenSessionDayNaTheme.DisplayLabel := SFlActivity_IdTheme;
  QuBrokenSessionHourNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuBrokenSessionHourNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuBrokenSessionHourDetailNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuBrokenSessionHourDetailNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuBrokenSessionHourDetailNaTheme.DisplayLabel := SFlActivity_IdTheme;
  
end;

procedure TTimetableForm.QuClashResourceAfterScroll(DataSet: TDataSet);
begin
  inherited;
  QuClashResourceDetail.Filter := Format(
    'IdDay=%d and IdHour=%d and IdResource=%d',
    [QuClashResourceIdDay.Value, QuClashResourceIdHour.Value,
    QuClashResourceIdResource.Value]);
end;

procedure TTimetableForm.QuClashActivityAfterScroll(DataSet: TDataSet);
begin
  inherited;
  QuClashActivityDetail.Filter := Format('IdTheme=%d',
    [QuClashActivityIdTheme.Value]);
end;

procedure TTimetableForm.ActThemeCutDayExecute(Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self, FThemeCutDayForm,
    ConfigStorage, ActThemeCutDay, QuBrokenSessionDay) then
  begin
    QuBrokenSessionDay.Close;
    QuBrokenSessionDay.Open;
  end;
end;

procedure TTimetableForm.ActThemeCutHourExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, QuBrokenSessionHour do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FThemeCutHourForm, ConfigStorage, ActThemeCutHour,
      QuBrokenSessionHour, QuBrokenSessionHourDetail) then
    begin
      QuBrokenSessionHour.Close;
      QuBrokenSessionHour.Open;
      QuBrokenSessionHourDetail.Close;
      QuBrokenSessionHourDetail.Open;
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
