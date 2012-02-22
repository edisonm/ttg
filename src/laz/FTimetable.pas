{ -*- mode: Delphi -*- }
unit FTimetable;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, FSingleEditor, Grids, Buttons, FEditor, DBCtrls,
  ExtCtrls, ComCtrls, ActnList, ZDataset, FCrossManytoManyEditorR,
  DMaster, FCrossManyToManyEditor1, FConfig, DSource, FMasterDetailEditor,
  FTimetableResource, FTimetableCluster;

type

  { TTimetableForm }

  TTimetableForm = class(TSingleEditorForm)
    BtThemeRestrictionNonSatisfied: TToolButton;
    TBResourceRestrictionNoRespetada: TToolButton;
    BtTimetableCluster: TToolButton;
    BtTimetableResource: TToolButton;
    BtClashResource: TToolButton;
    BtClashActivity: TToolButton;
    QuClashResourceDetail: TZQuery;
    QuClashResourceDetailIdResource: TLongintField;
    QuClashResourceDetailIdCategory: TLongintField;
    QuClashResourceDetailIdParallel: TLongintField;
    QuClashResourceDetailAbCategory: TStringField;
    QuClashResourceDetailNaParallel: TStringField;
    QuClashResourceDetailNaTheme: TStringField;
    QuClashResource: TZQuery;
    QuClashResourceIdResource: TLongintField;
    QuClashResourceIdDay: TLongintField;
    QuClashResourceIdHour: TLongintField;
    QuClashResourceIdResourceType: TLongintField;
    QuClashResourceNaDay: TStringField;
    QuClashResourceNaHour: TStringField;
    QuClashActivity: TZQuery;
    QuClashActivityIdTheme: TLongintField;
    QuClashActivityNaTheme: TStringField;
    QuClashActivityDetail: TZQuery;
    QuTimetableDetailThemeRestriction: TZQuery;
    QuTimetableDetailThemeRestrictionNaTheme: TStringField;
    QuTimetableDetailThemeRestrictionIdDay: TLongintField;
    QuTimetableDetailThemeRestrictionIdHour: TLongintField;
    QuTimetableDetailThemeRestrictionIdThemeRestrictionType: TLongintField;
    QuTimetableDetailThemeRestrictionIdCategory: TLongintField;
    QuTimetableDetailThemeRestrictionIdParallel: TLongintField;
    QuTimetableDetailThemeRestrictionNaDay: TStringField;
    QuTimetableDetailThemeRestrictionNaHour: TStringField;
    QuTimetableDetailThemeRestrictionNaThemeRestrictionType: TStringField;
    QuTimetableDetailThemeRestrictionAbCategory: TStringField;
    QuTimetableDetailThemeRestrictionNaParallel: TStringField;
    QuTimetableDetailResourceRestriction: TZQuery;
    QuTimetableDetailResourceRestrictionIdDay: TLongintField;
    QuTimetableDetailResourceRestrictionIdHour: TLongintField;
    QuTimetableDetailResourceRestrictionIdResourceRestrictionType: TLongintField;
    QuTimetableDetailResourceRestrictionIdCategory: TLongintField;
    QuTimetableDetailResourceRestrictionIdParallel: TLongintField;
    QuTimetableDetailResourceRestrictionNaResourceRestrictionType: TStringField;
    QuTimetableDetailResourceRestrictionNaCategory: TStringField;
    QuTimetableDetailResourceRestrictionNaParallel: TStringField;
    QuTimetableDetailResourceRestrictionNaDay: TStringField;
    QuTimetableDetailResourceRestrictionNaHour: TStringField;
    Panel2: TPanel;
    dbmSummary: TDBMemo;
    BtThemeCutDay: TToolButton;
    QuThemeCutDay: TZQuery;
    QuThemeCutDayIdCategory: TLongintField;
    QuThemeCutDayIdParallel: TLongintField;
    QuThemeCutDayIdDay: TLongintField;
    QuThemeCutDayIdHour: TLongintField;
    QuThemeCutDayIdTheme: TLongintField;
    QuThemeCutDayAbCategory: TStringField;
    QuThemeCutDayNaParallel: TStringField;
    QuThemeCutDayNaTheme: TStringField;
    QuThemeCutDayNaDay: TStringField;
    QuThemeCutDayNaHour: TStringField;
    BtThemeCutHour: TToolButton;
    QuThemeCutHour: TZQuery;
    QuThemeCutHourIdDay: TLongintField;
    QuThemeCutHourIdHour: TLongintField;
    QuThemeCutHourDetail: TZQuery;
    DSThemeCutHour: TDataSource;
    QuThemeCutHourNaDay: TStringField;
    QuThemeCutHourNaHour: TStringField;
    QuClashActivityDetailIdTheme: TLongintField;
    QuClashActivityDetailIdCategory: TLongintField;
    QuClashActivityDetailIdParallel: TLongintField;
    QuClashActivityDetailIdDay: TLongintField;
    QuClashActivityDetailIdHour: TLongintField;
    QuClashActivityDetailAbCategory: TStringField;
    QuClashActivityDetailNaParallel: TStringField;
    QuClashActivityDetailNaDay: TStringField;
    QuClashActivityDetailNaHour: TStringField;
    QuThemeCutHourDetailIdCategory: TLongintField;
    QuThemeCutHourDetailIdParallel: TLongintField;
    QuThemeCutHourDetailIdDay: TLongintField;
    QuThemeCutHourDetailIdHour0: TLongintField;
    QuThemeCutHourDetailIdTheme: TLongintField;
    QuThemeCutHourDetailAbCategory: TStringField;
    QuThemeCutHourDetailNaParallel: TStringField;
    QuThemeCutHourDetailNaDay: TStringField;
    QuThemeCutHourDetailNaHour: TStringField;
    QuThemeCutHourDetailNaTheme: TStringField;
    QuThemeCutHourDetailIdHour: TLongintField;
    Splitter1: TSplitter;
    ActTimetableCluster: TAction;
    ActTimetableResource: TAction;
    ActClashResource: TAction;
    ActClashActivity: TAction;
    ActThemeRestrictionNonSatisfied: TAction;
    ActResourceRestrictionNoRespetada: TAction;
    ActThemeCutDay: TAction;
    ActThemeCutHour: TAction;
    DSClashResource: TDataSource;
    QuClashResourceIdTimetable: TLongintField;
    QuThemeCutDayIdTimetable: TLongintField;
    QuThemeCutHourIdTimetable: TLongintField;
    QuTimetableDetailThemeRestrictionIdTimetable: TLongintField;
    QuTimetableDetailResourceRestrictionIdTimetable: TLongintField;
    QuTimetableDetailResourceRestrictionNaResource: TStringField;
    QuClashResourceNaResourceType: TStringField;
    QuClashResourceNaResource: TStringField;
    QuClashResourceOccupied: TLongintField;
    QuClashResourceClashes: TLongintField;
    QuClashResourceDetailIdTimetable: TLongintField;
    QuClashActivityIdTimetable: TLongintField;
    DSClashActivity: TDataSource;
    QuClashActivityDetailIdTimetable: TLongintField;
    QuThemeCutHourDetailIdTimetable: TLongintField;
    QuClashResourceDetailIdDay: TLongintField;
    QuClashResourceDetailIdHour: TLongintField;
    BtMejorarTimetable: TToolButton;
    ActImproveTimeTable: TAction;
    procedure ActTimetableClusterExecute(Sender: TObject);
    procedure ActClashResourceExecute(Sender: TObject);
    procedure ActClashActivityExecute(Sender: TObject);
    procedure ActTimetableResourceExecute(Sender: TObject);
    procedure ActThemeRestrictionNonSatisfiedExecute(Sender: TObject);
    procedure ActResourceRestrictionNoRespetadaExecute(Sender: TObject);
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
    FThemeRestrictionNonSatisfiedForm,
      FResourceRestrictionNoRespetadaForm: TSingleEditorForm;
    FTimetableResourceForm: TTimetableResourceForm;
    FTimetableClusterForm: TTimetableClusterForm;
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

procedure TTimetableForm.ActTimetableClusterExecute(Sender: TObject);
begin
  inherited;
  if TTimetableClusterForm.ToggleEditor(Self, FTimetableClusterForm,
    ConfigStorage, ActTimetableCluster) then
  begin
    with SourceDataModule do
      FTimetableClusterForm.LoadHints(TbDay, TbHour, TbTheme);
    FTimetableClusterForm.TBShowClick(nil);
  end;
end;

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

procedure TTimetableForm.ActThemeRestrictionNonSatisfiedExecute(Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self,
    FThemeRestrictionNonSatisfiedForm, ConfigStorage,
    ActThemeRestrictionNonSatisfied, QuTimetableDetailThemeRestriction) then
  begin
    QuTimetableDetailThemeRestriction.Close;
    QuTimetableDetailThemeRestriction.Open;
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

procedure TTimetableForm.ActResourceRestrictionNoRespetadaExecute
  (Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self,
    FResourceRestrictionNoRespetadaForm, ConfigStorage,
    ActResourceRestrictionNoRespetada, QuTimetableDetailResourceRestriction) then
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
  QuClashResourceDetailIdParallel.DisplayLabel := SFlTimetableDetail_IdParallel;
  QuClashResourceDetailAbCategory.DisplayLabel := SFlTimetableDetail_IdCategory;
  QuClashResourceDetailNaParallel.DisplayLabel := SFlTimetableDetail_IdParallel;
  QuClashResourceDetailNaTheme.DisplayLabel := SFlTimetableDetail_IdTheme;
  QuClashActivityNaTheme.DisplayLabel := SFlTimetableDetail_IdTheme;
  QuClashActivityDetailAbCategory.DisplayLabel := SFlTimetableDetail_IdCategory;
  QuClashActivityDetailNaParallel.DisplayLabel := SFlTimetableDetail_IdParallel;
  QuClashActivityDetailNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuClashActivityDetailNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuTimetableDetailThemeRestrictionNaThemeRestrictionType.DisplayLabel
    := SFlThemeRestriction_IdThemeRestrictionType;
  QuTimetableDetailThemeRestrictionNaTheme.DisplayLabel
    := SFlTimetableDetail_IdTheme;
  QuTimetableDetailThemeRestrictionNaDay.DisplayLabel
    := SFlTimetableDetail_IdDay;
  QuTimetableDetailThemeRestrictionNaHour.DisplayLabel
    := SFlTimetableDetail_IdHour;
  QuTimetableDetailThemeRestrictionAbCategory.DisplayLabel
    := SFlTimetableDetail_IdCategory;
  QuTimetableDetailThemeRestrictionNaParallel.DisplayLabel
    := SFlTimetableDetail_IdParallel;
  QuTimetableDetailResourceRestrictionNaDay.DisplayLabel
    := SFlTimetableDetail_IdDay;
  QuTimetableDetailResourceRestrictionNaResourceRestrictionType.DisplayLabel
    := SFlResourceRestriction_IdResourceRestrictionType;
  QuTimetableDetailResourceRestrictionNaHour.DisplayLabel
    := SFlTimetableDetail_IdHour;
  QuTimetableDetailResourceRestrictionNaCategory.DisplayLabel
    := SFlTimetableDetail_IdCategory;
  QuTimetableDetailResourceRestrictionNaParallel.DisplayLabel
    := SFlTimetableDetail_IdParallel;
  QuThemeCutDayIdTimetable.DisplayLabel := SFlTimetableDetail_IdTimeTable;
  QuThemeCutDayAbCategory.DisplayLabel := SFlTimetableDetail_IdCategory;
  QuThemeCutDayNaParallel.DisplayLabel := SFlTimetableDetail_IdParallel;
  QuThemeCutDayNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuThemeCutDayNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuThemeCutDayNaTheme.DisplayLabel := SFlTimetableDetail_IdTheme;
  QuThemeCutHourNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuThemeCutHourNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuThemeCutHourDetailAbCategory.DisplayLabel := SFlTimetableDetail_IdCategory;
  QuThemeCutHourDetailNaParallel.DisplayLabel := SFlTimetableDetail_IdParallel;
  QuThemeCutHourDetailNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuThemeCutHourDetailNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuThemeCutHourDetailNaTheme.DisplayLabel := SFlTimetableDetail_IdTheme;
  
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
    ConfigStorage, ActThemeCutDay, QuThemeCutDay) then
  begin
    QuThemeCutDay.Close;
    QuThemeCutDay.Open;
  end;
end;

procedure TTimetableForm.ActThemeCutHourExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, QuThemeCutHour do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FThemeCutHourForm, ConfigStorage, ActThemeCutHour,
      QuThemeCutHour, QuThemeCutHourDetail) then
    begin
      QuThemeCutHour.Close;
      QuThemeCutHour.Open;
      QuThemeCutHourDetail.Close;
      QuThemeCutHourDetail.Open;
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
