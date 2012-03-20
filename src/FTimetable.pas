{ -*- mode: Delphi -*- }
unit FTimetable;

{$I ttg.inc}

interface

uses
  LResources, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, FSingleEditor, Grids, Buttons, FEditor, DBCtrls, ExtCtrls, ComCtrls,
  ActnList, StdCtrls, DBGrids, ZDataset, FCrossManytoManyEditorR, DMaster,
  FCrossManyToManyEditor1, FConfig, DSource, FMasterDetailEditor,
  FTimetableResource;

type

  { TTimetableForm }

  TTimetableForm = class(TSingleEditorForm)
    TBRestrictionNonSatisfied: TToolButton;
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
    QuClashActivityNaTheme: TStringField;
    QuClashActivityDetail: TZQuery;
    QuClashActivityDetailIdTimetable: TLongintField;
    QuClashActivityDetailIdActivity: TLongintField;
    QuClashActivityDetailIdTheme: TLongintField;
    QuClashActivityDetailIdDay: TLongintField;
    QuClashActivityDetailIdHour: TLongintField;
    QuClashActivityDetailNaDay: TStringField;
    QuClashActivityDetailNaHour: TStringField;
    QuTimetableDetailRestriction: TZQuery;
    QuTimetableDetailRestrictionIdTimetable: TLongintField;
    QuTimetableDetailRestrictionIdActivity: TLongintField;
    QuTimetableDetailRestrictionNaResourceType: TStringField;
    QuTimetableDetailRestrictionIdRestrictionType: TLongintField;
    QuTimetableDetailRestrictionNaResource: TStringField;
    QuTimetableDetailRestrictionIdDay: TLongintField;
    QuTimetableDetailRestrictionIdHour: TLongintField;
    QuTimetableDetailRestrictionNaRestrictionType: TStringField;
    QuTimetableDetailRestrictionNaDay: TStringField;
    QuTimetableDetailRestrictionNaHour: TStringField;
    
    Panel2: TPanel;
    DBMSummary: TDBMemo;
    TBBrokenSessionDay: TToolButton;
    QuBrokenSessionDay: TZQuery;
    QuBrokenSessionDayIdDay: TLongintField;
    QuBrokenSessionDayIdHour: TLongintField;
    QuBrokenSessionDayIdActivity: TLongintField;
    QuBrokenSessionDayNaActivity: TStringField;
    QuBrokenSessionDayNaDay: TStringField;
    QuBrokenSessionDayNaHour: TStringField;
    TBBrokenSessionHour: TToolButton;
    DSBrokenSessionHour: TDataSource;
    QuBrokenSessionHour: TZQuery;
    QuBrokenSessionHourIdTimetable: TLongintField;
    QuBrokenSessionHourIdDay: TLongintField;
    QuBrokenSessionHourIdHour: TLongintField;
    QuBrokenSessionHourNaDay: TStringField;
    QuBrokenSessionHourNaHour: TStringField;
    QuBrokenSessionHourDetail: TZQuery;
    QuBrokenSessionHourDetailIdDay: TLongintField;
    QuBrokenSessionHourDetailIdHour: TLongintField;
    QuBrokenSessionHourDetailIdHour0: TLongintField;
    QuBrokenSessionHourDetailIdActivity: TLongintField;
    QuBrokenSessionHourDetailNaDay: TStringField;
    QuBrokenSessionHourDetailNaHour: TStringField;
    QuBrokenSessionHourDetailNaActivity: TStringField;
    Splitter1: TSplitter;
    ActTimetableResource: TAction;
    ActClashResource: TAction;
    ActClashActivity: TAction;
    ActRestrictionNonSatisfied: TAction;
    ActBrokenSessionDay: TAction;
    ActBrokenSessionHour: TAction;
    DSClashResource: TDataSource;
    QuClashResourceIdTimetable: TLongintField;
    QuBrokenSessionDayIdTimetable: TLongintField;
    QuClashResourceNaResourceType: TStringField;
    QuClashResourceNaResource: TStringField;
    QuClashResourceOccupied: TLongintField;
    QuClashResourceClashes: TLongintField;
    QuClashResourceDetailIdTimetable: TLongintField;
    DSClashActivity: TDataSource;
    QuBrokenSessionHourDetailIdTimetable: TLongintField;
    QuClashResourceDetailIdDay: TLongintField;
    QuClashResourceDetailIdHour: TLongintField;
    BtImproveTimetable: TToolButton;
    ActImproveTimeTable: TAction;
    procedure ActClashResourceExecute(Sender: TObject);
    procedure ActClashActivityExecute(Sender: TObject);
    procedure ActTimetableResourceExecute(Sender: TObject);
    procedure ActRestrictionNonSatisfiedExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActBrokenSessionDayExecute(Sender: TObject);
    procedure ActBrokenSessionHourExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure ActFindExecute(Sender: TObject);
    procedure ActImproveTimeTableExecute(Sender: TObject);
  private
    { Private declarations }
    FClashActivityForm, FBrokenSessionHourForm,
      FBrokenSessionDayForm, FClashResourceForm: TMasterDetailEditorForm;
    FRestrictionNonSatisfiedForm: TSingleEditorForm;
    FTimetableResourceForm: TTimetableResourceForm;
    procedure ImproveTimetable;
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

procedure TTimetableForm.ImproveTimetable;
var
  IdTimetableSource, IdTimetableTarget: Integer;
  SNewIdTimetable: string;
begin
  IdTimetableSource := SourceDataModule.TbTimetable.FindField('IdTimetable').AsInteger;
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
      SourceDataModule.TbTimetableDetail.Refresh;
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
    QuTimetableDetailRestriction.Close;
    QuTimetableDetailRestriction.Open;
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
  QuTimetableDetailRestrictionNaDay.DisplayLabel
    := SFlTimetableDetail_IdDay;
  QuTimetableDetailRestrictionNaRestrictionType.DisplayLabel
    := SFlRestriction_IdRestrictionType;
  QuTimetableDetailRestrictionNaHour.DisplayLabel
    := SFlTimetableDetail_IdHour;
  QuBrokenSessionDayIdTimetable.DisplayLabel := SFlTimetableDetail_IdTimeTable;
  QuBrokenSessionDayNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuBrokenSessionDayNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuBrokenSessionDayNaActivity.DisplayLabel := SFlTimetableDetail_IdActivity;
  QuBrokenSessionHourNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuBrokenSessionHourNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuBrokenSessionHourDetailNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuBrokenSessionHourDetailNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuBrokenSessionHourDetailNaActivity.DisplayLabel := SFlTimetableDetail_IdActivity;
end;

procedure TTimetableForm.ActBrokenSessionDayExecute(Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self, FBrokenSessionDayForm,
    ConfigStorage, ActBrokenSessionDay, QuBrokenSessionDay) then
  begin
    QuBrokenSessionDay.Close;
    QuBrokenSessionDay.Open;
  end;
end;

procedure TTimetableForm.ActBrokenSessionHourExecute(Sender: TObject);
begin
  inherited;
  if TMasterDetailEditorForm.ToggleMasterDetailEditor
       (Self, FBrokenSessionHourForm, ConfigStorage, ActBrokenSessionHour,
        QuBrokenSessionHour, QuBrokenSessionHourDetail) then
  begin
    QuBrokenSessionHour.Close;
    QuBrokenSessionHour.Open;
    QuBrokenSessionHourDetail.Close;
    QuBrokenSessionHourDetail.Open;
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
