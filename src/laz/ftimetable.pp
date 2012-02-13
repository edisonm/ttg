{ -*- mode: Delphi -*- }
unit FTimetable;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, FSingleEditor, Grids, Buttons, FEditor, DBCtrls,
  ExtCtrls, ComCtrls, ActnList, ZDataset, FCrossManytoManyEditorR,
  DMaster, FCrossManyToManyEditor1, FConfig, DSource, FMasterDetailEditor,
  FTimetableTeacher, FTimetableRoomType, FTimetableClass;

type

  { TTimetableForm }

  TTimetableForm = class(TSingleEditorForm)
    BtnSubjectRestrictionNonSatisfied: TToolButton;
    BtnTeacherRestrictionNoRespetada: TToolButton;
    BtnTimetableClass: TToolButton;
    BtnTimetableTeacher: TToolButton;
    BtnClashTeacher: TToolButton;
    BtnClashSubject: TToolButton;
    BtnClashRoom: TToolButton;
    QuClashRoom: TZQuery;
    QuClashRoomIdDay: TLongintField;
    QuClashRoomIdHour: TLongintField;
    QuClashRoomIdRoomType: TLongintField;
    QuClashRoomNaDay: TStringField;
    QuClashRoomNaHour: TStringField;
    QuClashRoomDetail: TZQuery;
    QuClashRoomDetailIdLevel: TLongintField;
    QuClashRoomDetailIdSpecialization: TLongintField;
    QuClashRoomDetailIdGroup: TLongintField;
    QuClashRoomDetailNaSubject: TStringField;
    QuClashRoomDetailAbLevel: TStringField;
    QuClashRoomDetailAbSpecialization: TStringField;
    QuClashRoomDetailNaGroup: TStringField;
    DSClashRoom: TDataSource;
    QuClashTeacherDetail: TZQuery;
    QuClashTeacherDetailIdTeacher: TLongintField;
    QuClashTeacherDetailIdLevel: TLongintField;
    QuClashTeacherDetailIdSpecialization: TLongintField;
    QuClashTeacherDetailIdGroup: TLongintField;
    QuClashTeacherDetailIdSubject: TLongintField;
    QuClashTeacherDetailAbLevel: TStringField;
    QuClashTeacherDetailAbSpecialization: TStringField;
    QuClashTeacherDetailNaGroup: TStringField;
    QuClashTeacherDetailNaSubject: TStringField;
    QuClashTeacher: TZQuery;
    QuClashTeacherIdTeacher: TLongintField;
    QuClashTeacherIdDay: TLongintField;
    QuClashTeacherIdHour: TLongintField;
    QuClashTeacherNaDay: TStringField;
    QuClashTeacherNaHour: TStringField;
    QuClashSubject: TZQuery;
    QuClashSubjectIdSubject: TLongintField;
    QuClashSubjectNaSubject: TStringField;
    QuClashSubjectDetail: TZQuery;
    QuTimetableDetailSubjectRestriction: TZQuery;
    QuTimetableDetailSubjectRestrictionNaSubject: TStringField;
    QuTimetableDetailSubjectRestrictionIdDay: TLongintField;
    QuTimetableDetailSubjectRestrictionIdHour: TLongintField;
    QuTimetableDetailSubjectRestrictionIdSubjectRestrictionType: TLongintField;
    QuTimetableDetailSubjectRestrictionIdLevel: TLongintField;
    QuTimetableDetailSubjectRestrictionIdSpecialization: TLongintField;
    QuTimetableDetailSubjectRestrictionIdGroup: TLongintField;
    QuTimetableDetailSubjectRestrictionNaDay: TStringField;
    QuTimetableDetailSubjectRestrictionNaHour: TStringField;
    QuTimetableDetailSubjectRestrictionNaSubjectRestrictionType: TStringField;
    QuTimetableDetailSubjectRestrictionAbLevel: TStringField;
    QuTimetableDetailSubjectRestrictionAbSpecialization: TStringField;
    QuTimetableDetailSubjectRestrictionNaGroup: TStringField;
    QuTimetableDetailTeacherRestriction: TZQuery;
    QuTimetableDetailTeacherRestrictionIdDay: TLongintField;
    QuTimetableDetailTeacherRestrictionIdHour: TLongintField;
    QuTimetableDetailTeacherRestrictionIdTeacherRestrictionType: TLongintField;
    QuTimetableDetailTeacherRestrictionIdLevel: TLongintField;
    QuTimetableDetailTeacherRestrictionIdSpecialization: TLongintField;
    QuTimetableDetailTeacherRestrictionIdGroup: TLongintField;
    QuTimetableDetailTeacherRestrictionNaTeacherRestrictionType: TStringField;
    QuTimetableDetailTeacherRestrictionNaLevel: TStringField;
    QuTimetableDetailTeacherRestrictionNaSpecialization: TStringField;
    QuTimetableDetailTeacherRestrictionNaGroup: TStringField;
    QuTimetableDetailTeacherRestrictionNaDay: TStringField;
    QuTimetableDetailTeacherRestrictionNaHour: TStringField;
    Panel2: TPanel;
    dbmSummary: TDBMemo;
    BtnSubjectCutDay: TToolButton;
    QuSubjectCutDay: TZQuery;
    QuSubjectCutDayIdLevel: TLongintField;
    QuSubjectCutDayIdSpecialization: TLongintField;
    QuSubjectCutDayIdGroup: TLongintField;
    QuSubjectCutDayIdDay: TLongintField;
    QuSubjectCutDayIdHour: TLongintField;
    QuSubjectCutDayIdSubject: TLongintField;
    QuSubjectCutDayAbLevel: TStringField;
    QuSubjectCutDayAbSpecialization: TStringField;
    QuSubjectCutDayNaGroup: TStringField;
    QuSubjectCutDayNaSubject: TStringField;
    QuSubjectCutDayNaDay: TStringField;
    QuSubjectCutDayNaHour: TStringField;
    BtnSubjectCutHour: TToolButton;
    QuSubjectCutHour: TZQuery;
    QuSubjectCutHourIdDay: TLongintField;
    QuSubjectCutHourIdHour: TLongintField;
    QuSubjectCutHourDetail: TZQuery;
    DSSubjectCutHour: TDataSource;
    BtnTimetableRoomType: TToolButton;
    QuClashRoomNumber: TLongintField;
    QuSubjectCutHourNaDay: TStringField;
    QuSubjectCutHourNaHour: TStringField;
    QuClashSubjectDetailIdSubject: TLongintField;
    QuClashSubjectDetailIdLevel: TLongintField;
    QuClashSubjectDetailIdSpecialization: TLongintField;
    QuClashSubjectDetailIdGroup: TLongintField;
    QuClashSubjectDetailIdDay: TLongintField;
    QuClashSubjectDetailIdHour: TLongintField;
    QuClashSubjectDetailAbLevel: TStringField;
    QuClashSubjectDetailAbSpecialization: TStringField;
    QuClashSubjectDetailNaGroup: TStringField;
    QuClashSubjectDetailNaDay: TStringField;
    QuClashSubjectDetailNaHour: TStringField;
    QuSubjectCutHourDetailIdLevel: TLongintField;
    QuSubjectCutHourDetailIdSpecialization: TLongintField;
    QuSubjectCutHourDetailIdGroup: TLongintField;
    QuSubjectCutHourDetailIdDay: TLongintField;
    QuSubjectCutHourDetailIdHour0: TLongintField;
    QuSubjectCutHourDetailIdSubject: TLongintField;
    QuSubjectCutHourDetailAbLevel: TStringField;
    QuSubjectCutHourDetailAbSpecialization: TStringField;
    QuSubjectCutHourDetailNaGroup: TStringField;
    QuSubjectCutHourDetailNaDay: TStringField;
    QuSubjectCutHourDetailNaHour: TStringField;
    QuSubjectCutHourDetailNaSubject: TStringField;
    QuSubjectCutHourDetailIdHour: TLongintField;
    Splitter1: TSplitter;
    ActTimetableClass: TAction;
    ActTimetableTeacher: TAction;
    ActClashTeacher: TAction;
    ActClashSubject: TAction;
    ActClashRoom: TAction;
    ActSubjectRestrictionNonSatisfied: TAction;
    ActTeacherRestrictionNoRespetada: TAction;
    ActSubjectCutDay: TAction;
    ActSubjectCutHour: TAction;
    ActTimetableRoomType: TAction;
    DSClashTeacher: TDataSource;
    QuClashTeacherIdTimetable: TLongintField;
    QuSubjectCutDayIdTimetable: TLongintField;
    QuSubjectCutHourIdTimetable: TLongintField;
    QuTimetableDetailSubjectRestrictionIdTimetable: TLongintField;
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
    QuClashSubjectIdTimetable: TLongintField;
    DSClashSubject: TDataSource;
    QuClashSubjectDetailIdTimetable: TLongintField;
    QuSubjectCutHourDetailIdTimetable: TLongintField;
    QuClashRoomClashes: TStringField;
    QuClashRoomOccupied: TStringField;
    QuClashTeacherDetailIdDay: TLongintField;
    QuClashTeacherDetailIdHour: TLongintField;
    BtnMejorarTimetable: TToolButton;
    ActImproveTimeTable: TAction;
    procedure ActTimetableClassExecute(Sender: TObject);
    procedure ActClashTeacherExecute(Sender: TObject);
    procedure ActClashSubjectExecute(Sender: TObject);
    procedure ActTimetableTeacherExecute(Sender: TObject);
    procedure ActSubjectRestrictionNonSatisfiedExecute(Sender: TObject);
    procedure ActTeacherRestrictionNoRespetadaExecute(Sender: TObject);
    procedure ActClashRoomExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QuClashTeacherAfterScroll(DataSet: TDataSet);
    procedure QuClashSubjectAfterScroll(DataSet: TDataSet);
    procedure ActSubjectCutDayExecute(Sender: TObject);
    procedure ActSubjectCutHourExecute(Sender: TObject);
    procedure ActTimetableRoomTypeExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure ActFindExecute(Sender: TObject);
    procedure ActImproveTimeTableExecute(Sender: TObject);
  private
    { Private declarations }
    FClashRoomForm, FClashSubjectForm, FSubjectCutHourForm,
      FSubjectCutDayForm, FClashTeacherForm: TMasterDetailEditorForm;
    FSubjectRestrictionNonSatisfiedForm,
      FTeacherRestrictionNoRespetadaForm: TSingleEditorForm;
    FTimetableTeacherForm: TTimetableTeacherForm;
    FTimetableRoomTypeForm: TTimetableRoomTypeForm;
    FTimetableClassForm: TTimetableClassForm;
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

procedure TTimetableForm.ActTimetableClassExecute(Sender: TObject);
begin
  inherited;
  if TTimetableClassForm.ToggleEditor(Self, FTimetableClassForm,
    ConfigStorage, ActTimetableClass) then
  begin
    with SourceDataModule do
      FTimetableClassForm.LoadHints(TbDay, TbHour, TbSubject);
    FTimetableClassForm.btnShowClick(nil);
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
    FTimetableTeacherForm.btnShowClick(nil);
  end
end;

procedure TTimetableForm.ActClashSubjectExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FClashSubjectForm, ConfigStorage, ActClashSubject, QuClashSubject,
      QuClashSubjectDetail) then
    begin
      QuClashSubject.Close;
      QuClashSubject.Open;
      QuClashSubjectDetail.Close;
      QuClashSubjectDetail.Open;
    end;
  end;
end;

procedure TTimetableForm.ActSubjectRestrictionNonSatisfiedExecute(Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self,
    FSubjectRestrictionNonSatisfiedForm, ConfigStorage,
    ActSubjectRestrictionNonSatisfied, QuTimetableDetailSubjectRestriction) then
  begin
    QuTimetableDetailSubjectRestriction.Close;
    QuTimetableDetailSubjectRestriction.Open;
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
  QuClashRoomDetailNaSubject.DisplayLabel := SFlTimetableDetail_IdSubject;
  QuClashRoomDetailAbLevel.DisplayLabel := SFlTimetableDetail_IdLevel;
  QuClashRoomDetailAbSpecialization.DisplayLabel
    := SFlTimetableDetail_IdSpecialization;
  QuClashRoomDetailNaGroup.DisplayLabel := SFlTimetableDetail_IdGroup;
  QuClashTeacherClashes.DisplayLabel := SClashes;
  QuClashTeacherLnTeacher.DisplayLabel := SFlTeacher_LnTeacher;
  QuClashTeacherNaTeacher.DisplayLabel := SFlTeacher_NaTeacher;
  QuClashTeacherNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuClashTeacherNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuClashTeacherDetailIdSpecialization.DisplayLabel
    := SFlTimetableDetail_IdSpecialization;
  QuClashTeacherDetailIdGroup.DisplayLabel := SFlTimetableDetail_IdGroup;
  QuClashTeacherDetailIdSubject.DisplayLabel := SFlTimetableDetail_IdSubject;
  QuClashTeacherDetailAbLevel.DisplayLabel := SFlTimetableDetail_IdLevel;
  QuClashTeacherDetailAbSpecialization.DisplayLabel
    := SFlTimetableDetail_IdSpecialization;
  QuClashTeacherDetailNaGroup.DisplayLabel := SFlTimetableDetail_IdGroup;
  QuClashTeacherDetailNaSubject.DisplayLabel := SFlTimetableDetail_IdSubject;
  QuClashSubjectNaSubject.DisplayLabel := SFlTimetableDetail_IdSubject;
  QuClashSubjectDetailAbLevel.DisplayLabel := SFlTimetableDetail_IdLevel;
  QuClashSubjectDetailAbSpecialization.DisplayLabel
    := SFlTimetableDetail_IdSpecialization;
  QuClashSubjectDetailNaGroup.DisplayLabel := SFlTimetableDetail_IdGroup;
  QuClashSubjectDetailNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuClashSubjectDetailNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuTimetableDetailSubjectRestrictionNaSubjectRestrictionType.DisplayLabel
    := SFlSubjectRestriction_IdSubjectRestrictionType;
  QuTimetableDetailSubjectRestrictionNaSubject.DisplayLabel
    := SFlTimetableDetail_IdSubject;
  QuTimetableDetailSubjectRestrictionNaDay.DisplayLabel
    := SFlTimetableDetail_IdDay;
  QuTimetableDetailSubjectRestrictionNaHour.DisplayLabel
    := SFlTimetableDetail_IdHour;
  QuTimetableDetailSubjectRestrictionAbLevel.DisplayLabel
    := SFlTimetableDetail_IdLevel;
  QuTimetableDetailSubjectRestrictionAbSpecialization.DisplayLabel
    := SFlTimetableDetail_IdSpecialization;
  QuTimetableDetailSubjectRestrictionNaGroup.DisplayLabel
    := SFlTimetableDetail_IdGroup;
  QuTimetableDetailTeacherRestrictionNaDay.DisplayLabel
    := SFlTimetableDetail_IdDay;
  QuTimetableDetailTeacherRestrictionNaTeacherRestrictionType.DisplayLabel
    := SFlTeacherRestriction_IdTeacherRestrictionType;
  QuTimetableDetailTeacherRestrictionNaHour.DisplayLabel
    := SFlTimetableDetail_IdHour;
  QuTimetableDetailTeacherRestrictionNaLevel.DisplayLabel
    := SFlTimetableDetail_IdLevel;
  QuTimetableDetailTeacherRestrictionNaSpecialization.DisplayLabel
    := SFlTimetableDetail_IdSpecialization;
  QuTimetableDetailTeacherRestrictionNaGroup.DisplayLabel
    := SFlTimetableDetail_IdGroup;
  QuSubjectCutDayIdTimetable.DisplayLabel := SFlTimetableDetail_IdTimeTable;
  QuSubjectCutDayAbLevel.DisplayLabel := SFlTimetableDetail_IdLevel;
  QuSubjectCutDayAbSpecialization.DisplayLabel
    := SFlTimetableDetail_IdSpecialization;
  QuSubjectCutDayNaGroup.DisplayLabel := SFlTimetableDetail_IdGroup;
  QuSubjectCutDayNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuSubjectCutDayNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuSubjectCutDayNaSubject.DisplayLabel := SFlTimetableDetail_IdSubject;
  QuSubjectCutHourNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuSubjectCutHourNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuSubjectCutHourDetailAbLevel.DisplayLabel := SFlTimetableDetail_IdLevel;
  QuSubjectCutHourDetailAbSpecialization.DisplayLabel
    := SFlTimetableDetail_IdSpecialization;
  QuSubjectCutHourDetailNaGroup.DisplayLabel := SFlTimetableDetail_IdGroup;
  QuSubjectCutHourDetailNaDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuSubjectCutHourDetailNaHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuSubjectCutHourDetailNaSubject.DisplayLabel := SFlTimetableDetail_IdSubject;
  
end;

procedure TTimetableForm.QuClashTeacherAfterScroll(DataSet: TDataSet);
begin
  inherited;
  QuClashTeacherDetail.Filter := Format(
    'IdDay=%d and IdHour=%d and IdTeacher=%d',
    [QuClashTeacherIdDay.Value, QuClashTeacherIdHour.Value,
    QuClashTeacherIdTeacher.Value]);
end;

procedure TTimetableForm.QuClashSubjectAfterScroll(DataSet: TDataSet);
begin
  inherited;
  QuClashSubjectDetail.Filter := Format('IdSubject=%d',
    [QuClashSubjectIdSubject.Value]);
end;

procedure TTimetableForm.ActSubjectCutDayExecute(Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self, FSubjectCutDayForm,
    ConfigStorage, ActSubjectCutDay, QuSubjectCutDay) then
  begin
    QuSubjectCutDay.Close;
    QuSubjectCutDay.Open;
  end;
end;

procedure TTimetableForm.ActSubjectCutHourExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, QuSubjectCutHour do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FSubjectCutHourForm, ConfigStorage, ActSubjectCutHour,
      QuSubjectCutHour, QuSubjectCutHourDetail) then
    begin
      QuSubjectCutHour.Close;
      QuSubjectCutHour.Open;
      QuSubjectCutHourDetail.Close;
      QuSubjectCutHourDetail.Open;
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
      FTimetableRoomTypeForm.LoadHints(TbDay, TbHour, TbSubject);
    end;
    FTimetableRoomTypeForm.btnShowClick(nil);
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
