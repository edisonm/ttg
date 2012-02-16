{ -*- mode: Delphi -*- }
unit FTimetable;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, FSingleEditor, Grids, Buttons, FEditor, DBCtrls,
  ExtCtrls, ComCtrls, ActnList, ZDataset, FCrossManytoManyEditorR,
  DMaster, FCrossManyToManyEditor1, FConfig, DSource, FMasterDetailEditor,
  FTimetableTeacher, FTimetableRoomType, FTimetableCluster;

type

  { TTimetableForm }

  TTimetableForm = class(TSingleEditorForm)
    BtThemeRestrictionNonSatisfied: TToolButton;
    TBTeacherRestrictionNoRespetada: TToolButton;
    BtTimetableCluster: TToolButton;
    BtTimetableTeacher: TToolButton;
    BtClashTeacher: TToolButton;
    BtClashTheme: TToolButton;
    BtClashRoom: TToolButton;
    QuClashRoom: TZQuery;
    QuClashRoomIdDay: TLongintField;
    QuClashRoomIdHour: TLongintField;
    QuClashRoomIdRoomType: TLongintField;
    QuClashRoomNaDay: TStringField;
    QuClashRoomNaHour: TStringField;
    QuClashRoomDetail: TZQuery;
    QuClashRoomDetailIdCategory: TLongintField;
    QuClashRoomDetailIdParallel: TLongintField;
    QuClashRoomDetailNaTheme: TStringField;
    QuClashRoomDetailAbCategory: TStringField;
    QuClashRoomDetailNaParallel: TStringField;
    DSClashRoom: TDataSource;
    QuClashTeacherDetail: TZQuery;
    QuClashTeacherDetailIdTeacher: TLongintField;
    QuClashTeacherDetailIdCategory: TLongintField;
    QuClashTeacherDetailIdParallel: TLongintField;
    QuClashTeacherDetailIdTheme: TLongintField;
    QuClashTeacherDetailAbCategory: TStringField;
    QuClashTeacherDetailNaParallel: TStringField;
    QuClashTeacherDetailNaTheme: TStringField;
    QuClashTeacher: TZQuery;
    QuClashTeacherIdTeacher: TLongintField;
    QuClashTeacherIdDay: TLongintField;
    QuClashTeacherIdHour: TLongintField;
    QuClashTeacherNaDay: TStringField;
    QuClashTeacherNaHour: TStringField;
    QuClashTheme: TZQuery;
    QuClashThemeIdTheme: TLongintField;
    QuClashThemeNaTheme: TStringField;
    QuClashThemeDetail: TZQuery;
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
    QuTimetableDetailTeacherRestriction: TZQuery;
    QuTimetableDetailTeacherRestrictionIdDay: TLongintField;
    QuTimetableDetailTeacherRestrictionIdHour: TLongintField;
    QuTimetableDetailTeacherRestrictionIdTeacherRestrictionType: TLongintField;
    QuTimetableDetailTeacherRestrictionIdCategory: TLongintField;
    QuTimetableDetailTeacherRestrictionIdParallel: TLongintField;
    QuTimetableDetailTeacherRestrictionNaTeacherRestrictionType: TStringField;
    QuTimetableDetailTeacherRestrictionNaCategory: TStringField;
    QuTimetableDetailTeacherRestrictionNaParallel: TStringField;
    QuTimetableDetailTeacherRestrictionNaDay: TStringField;
    QuTimetableDetailTeacherRestrictionNaHour: TStringField;
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
    BtTimetableRoomType: TToolButton;
    QuClashRoomNumber: TLongintField;
    QuThemeCutHourNaDay: TStringField;
    QuThemeCutHourNaHour: TStringField;
    QuClashThemeDetailIdTheme: TLongintField;
    QuClashThemeDetailIdCategory: TLongintField;
    QuClashThemeDetailIdParallel: TLongintField;
    QuClashThemeDetailIdDay: TLongintField;
    QuClashThemeDetailIdHour: TLongintField;
    QuClashThemeDetailAbCategory: TStringField;
    QuClashThemeDetailNaParallel: TStringField;
    QuClashThemeDetailNaDay: TStringField;
    QuClashThemeDetailNaHour: TStringField;
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
    ActTimetableTeacher: TAction;
    ActClashTeacher: TAction;
    ActClashTheme: TAction;
    ActClashRoom: TAction;
    ActThemeRestrictionNonSatisfied: TAction;
    ActTeacherRestrictionNoRespetada: TAction;
    ActThemeCutDay: TAction;
    ActThemeCutHour: TAction;
    ActTimetableRoomType: TAction;
    DSClashTeacher: TDataSource;
    QuClashTeacherIdTimetable: TLongintField;
    QuThemeCutDayIdTimetable: TLongintField;
    QuThemeCutHourIdTimetable: TLongintField;
    QuTimetableDetailThemeRestrictionIdTimetable: TLongintField;
    QuTimetableDetailTeacherRestrictionIdTimetable: TLongintField;
    QuTimetableDetailTeacherRestrictionLnTeacher: TStringField;
    QuTimetableDetailTeacherRestrictionNaTeacher: TStringField;
    QuClashRoomIdTimetable: TLongintField;
    QuClashRoomAbRoomType: TStringField;
    QuClashTeacherLnTeacher: TStringField;
    QuClashTeacherNaTeacher: TStringField;
    QuClashTeacherClashes: TStringField;
    QuClashRoomDetailIdTimetable: TLongintField;
    QuClashRoomDetailIdRoomType: TLongintField;
    QuClashRoomDetailIdDay: TLongintField;
    QuClashRoomDetailIdHour: TLongintField;
    QuClashTeacherDetailIdTimetable: TLongintField;
    QuClashThemeIdTimetable: TLongintField;
    DSClashTheme: TDataSource;
    QuClashThemeDetailIdTimetable: TLongintField;
    QuThemeCutHourDetailIdTimetable: TLongintField;
    QuClashRoomClashes: TStringField;
    QuClashRoomOccupied: TStringField;
    QuClashTeacherDetailIdDay: TLongintField;
    QuClashTeacherDetailIdHour: TLongintField;
    BtMejorarTimetable: TToolButton;
    ActImproveTimeTable: TAction;
    procedure ActTimetableClusterExecute(Sender: TObject);
    procedure ActClashTeacherExecute(Sender: TObject);
    procedure ActClashThemeExecute(Sender: TObject);
    procedure ActTimetableTeacherExecute(Sender: TObject);
    procedure ActThemeRestrictionNonSatisfiedExecute(Sender: TObject);
    procedure ActTeacherRestrictionNoRespetadaExecute(Sender: TObject);
    procedure ActClashRoomExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QuClashTeacherAfterScroll(DataSet: TDataSet);
    procedure QuClashThemeAfterScroll(DataSet: TDataSet);
    procedure ActThemeCutDayExecute(Sender: TObject);
    procedure ActThemeCutHourExecute(Sender: TObject);
    procedure ActTimetableRoomTypeExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure ActFindExecute(Sender: TObject);
    procedure ActImproveTimeTableExecute(Sender: TObject);
  private
    { Private declarations }
    FClashRoomForm, FClashThemeForm, FThemeCutHourForm,
      FThemeCutDayForm, FClashTeacherForm: TMasterDetailEditorForm;
    FThemeRestrictionNonSatisfiedForm,
      FTeacherRestrictionNoRespetadaForm: TSingleEditorForm;
    FTimetableTeacherForm: TTimetableTeacherForm;
    FTimetableRoomTypeForm: TTimetableRoomTypeForm;
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

procedure TTimetableForm.ActClashTeacherExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, MasterDataModule do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FClashTeacherForm, ConfigStorage, ActClashTeacher,
      QuClashTeacher, QuClashTeacherDetail) then
    begin
      QuClashTeacher.Close;
      QuClashTeacherDetail.Close;
      QuClashTeacher.Open;
      QuClashTeacherDetail.Open;
    end;
  end;
end;

procedure TTimetableForm.ActFindExecute(Sender: TObject);
begin
  inherited ActFindExecute(Sender);
end;

procedure TTimetableForm.ActTimetableTeacherExecute(Sender: TObject);
begin
  inherited;
  if TTimetableTeacherForm.ToggleEditor(Self, FTimetableTeacherForm,
    ConfigStorage, ActTimetableTeacher) then
  begin
    with SourceDataModule do
      FTimetableTeacherForm.LoadHints(TbDay, TbHour, TbTeacher);
    FTimetableTeacherForm.TBShowClick(nil);
  end
end;

procedure TTimetableForm.ActClashThemeExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FClashThemeForm, ConfigStorage, ActClashTheme, QuClashTheme,
      QuClashThemeDetail) then
    begin
      QuClashTheme.Close;
      QuClashTheme.Open;
      QuClashThemeDetail.Close;
      QuClashThemeDetail.Open;
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

procedure TTimetableForm.ActTeacherRestrictionNoRespetadaExecute
  (Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self,
    FTeacherRestrictionNoRespetadaForm, ConfigStorage,
    ActTeacherRestrictionNoRespetada, QuTimetableDetailTeacherRestriction) then
  begin
    QuTimetableDetailTeacherRestriction.Close;
    QuTimetableDetailTeacherRestriction.Open;
  end;
end;

procedure TTimetableForm.ActClashRoomExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, QuClashRoom do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FClashRoomForm, ConfigStorage, ActClashRoom, QuClashRoom,
      QuClashRoomDetail) then
    begin
      QuClashRoom.Close;
      QuClashRoom.Open;
      QuClashRoomDetail.Close;
      QuClashRoomDetail.Open;
    end;
  end;
end;

procedure TTimetableForm.FormCreate(Sender: TObject);
begin
  QuClashRoomClashes.DisplayLabel := SClashes;
  QuClashRoomNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuClashRoomNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuClashRoomDetailNaTheme.DisplayLabel := SFlTimetableDetail_IdTheme;
  QuClashRoomDetailAbCategory.DisplayLabel := SFlTimetableDetail_IdCategory;
  QuClashRoomDetailNaParallel.DisplayLabel := SFlTimetableDetail_IdParallel;
  QuClashTeacherClashes.DisplayLabel := SClashes;
  QuClashTeacherLnTeacher.DisplayLabel := SFlTeacher_LnTeacher;
  QuClashTeacherNaTeacher.DisplayLabel := SFlTeacher_NaTeacher;
  QuClashTeacherNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuClashTeacherNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuClashTeacherDetailIdParallel.DisplayLabel := SFlTimetableDetail_IdParallel;
  QuClashTeacherDetailIdTheme.DisplayLabel := SFlTimetableDetail_IdTheme;
  QuClashTeacherDetailAbCategory.DisplayLabel := SFlTimetableDetail_IdCategory;
  QuClashTeacherDetailNaParallel.DisplayLabel := SFlTimetableDetail_IdParallel;
  QuClashTeacherDetailNaTheme.DisplayLabel := SFlTimetableDetail_IdTheme;
  QuClashThemeNaTheme.DisplayLabel := SFlTimetableDetail_IdTheme;
  QuClashThemeDetailAbCategory.DisplayLabel := SFlTimetableDetail_IdCategory;
  QuClashThemeDetailNaParallel.DisplayLabel := SFlTimetableDetail_IdParallel;
  QuClashThemeDetailNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuClashThemeDetailNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
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
  QuTimetableDetailTeacherRestrictionNaDay.DisplayLabel
    := SFlTimetableDetail_IdDay;
  QuTimetableDetailTeacherRestrictionNaTeacherRestrictionType.DisplayLabel
    := SFlTeacherRestriction_IdTeacherRestrictionType;
  QuTimetableDetailTeacherRestrictionNaHour.DisplayLabel
    := SFlTimetableDetail_IdHour;
  QuTimetableDetailTeacherRestrictionNaCategory.DisplayLabel
    := SFlTimetableDetail_IdCategory;
  QuTimetableDetailTeacherRestrictionNaParallel.DisplayLabel
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

procedure TTimetableForm.QuClashTeacherAfterScroll(DataSet: TDataSet);
begin
  inherited;
  QuClashTeacherDetail.Filter := Format(
    'IdDay=%d and IdHour=%d and IdTeacher=%d',
    [QuClashTeacherIdDay.Value, QuClashTeacherIdHour.Value,
    QuClashTeacherIdTeacher.Value]);
end;

procedure TTimetableForm.QuClashThemeAfterScroll(DataSet: TDataSet);
begin
  inherited;
  QuClashThemeDetail.Filter := Format('IdTheme=%d',
    [QuClashThemeIdTheme.Value]);
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

procedure TTimetableForm.ActTimetableRoomTypeExecute(Sender: TObject);
begin
  inherited;
  if TTimetableRoomTypeForm.ToggleEditor(Self, FTimetableRoomTypeForm,
    ConfigStorage, ActTimetableRoomType) then
  begin
    with SourceDataModule do
    begin
      FTimetableRoomTypeForm.LoadHints(TbDay, TbHour, TbTheme);
    end;
    FTimetableRoomTypeForm.TBShowClick(nil);
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
{$I ftimetable.lrs}
{$ENDIF}

end.
