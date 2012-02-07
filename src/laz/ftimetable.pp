{ -*- mode: Delphi -*- }
unit FTimetable;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, FSingleEditor, Grids, Buttons, FEditor, DBCtrls,
  ExtCtrls, ComCtrls, ActnList, ZConnection, ZDataset, FCrossManytoManyEditorR,
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
    QuClashRoomDetailIdGroupId: TLongintField;
    QuClashRoomDetailNaSubject: TStringField;
    QuClashRoomDetailAbLevel: TStringField;
    QuClashRoomDetailAbSpecialization: TStringField;
    QuClashRoomDetailNaGroupId: TStringField;
    DSClashRoom: TDataSource;
    QuClashTeacherDetail: TZQuery;
    QuClashTeacherDetailIdTeacher: TLongintField;
    QuClashTeacherDetailIdLevel: TLongintField;
    QuClashTeacherDetailIdSpecialization: TLongintField;
    QuClashTeacherDetailIdGroupId: TLongintField;
    QuClashTeacherDetailIdSubject: TLongintField;
    QuClashTeacherDetailAbLevel: TStringField;
    QuClashTeacherDetailAbSpecialization: TStringField;
    QuClashTeacherDetailNaGroupId: TStringField;
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
    QuTimetableDetailSubjectRestrictionIdGroupId: TLongintField;
    QuTimetableDetailSubjectRestrictionNaDay: TStringField;
    QuTimetableDetailSubjectRestrictionNaHour: TStringField;
    QuTimetableDetailSubjectRestrictionNaSubjectRestrictionType: TStringField;
    QuTimetableDetailSubjectRestrictionAbLevel: TStringField;
    QuTimetableDetailSubjectRestrictionAbSpecialization: TStringField;
    QuTimetableDetailSubjectRestrictionNaGroupId: TStringField;
    QuTimetableDetailTeacherRestriction: TZQuery;
    QuTimetableDetailTeacherRestrictionIdDay: TLongintField;
    QuTimetableDetailTeacherRestrictionIdHour: TLongintField;
    QuTimetableDetailTeacherRestrictionIdTeacherRestrictionType: TLongintField;
    QuTimetableDetailTeacherRestrictionIdLevel: TLongintField;
    QuTimetableDetailTeacherRestrictionIdSpecialization: TLongintField;
    QuTimetableDetailTeacherRestrictionIdGroupId: TLongintField;
    QuTimetableDetailTeacherRestrictionNaTeacherRestrictionType: TStringField;
    QuTimetableDetailTeacherRestrictionNaLevel: TStringField;
    QuTimetableDetailTeacherRestrictionNaSpecialization: TStringField;
    QuTimetableDetailTeacherRestrictionNaGroupId: TStringField;
    QuTimetableDetailTeacherRestrictionNaDay: TStringField;
    QuTimetableDetailTeacherRestrictionNaHour: TStringField;
    Panel2: TPanel;
    dbmSummary: TDBMemo;
    BtnSubjectCortadaDay: TToolButton;
    QuSubjectCortadaDay: TZQuery;
    QuSubjectCortadaDayIdLevel: TLongintField;
    QuSubjectCortadaDayIdSpecialization: TLongintField;
    QuSubjectCortadaDayIdGroupId: TLongintField;
    QuSubjectCortadaDayIdDay: TLongintField;
    QuSubjectCortadaDayIdHour: TLongintField;
    QuSubjectCortadaDayIdSubject: TLongintField;
    QuSubjectCortadaDayAbLevel: TStringField;
    QuSubjectCortadaDayAbSpecialization: TStringField;
    QuSubjectCortadaDayNaGroupId: TStringField;
    QuSubjectCortadaDayNaSubject: TStringField;
    QuSubjectCortadaDayNaDay: TStringField;
    QuSubjectCortadaDayNaHour: TStringField;
    BtnSubjectCortadaHour: TToolButton;
    QuSubjectCortadaHour: TZQuery;
    QuSubjectCortadaHourIdDay: TLongintField;
    QuSubjectCortadaHourIdHour: TLongintField;
    QuSubjectCortadaHourDetail: TZQuery;
    DSSubjectCortadaHour: TDataSource;
    BtnTimetableRoomType: TToolButton;
    QuClashRoomNumber: TLongintField;
    QuSubjectCortadaHourNaDay: TStringField;
    QuSubjectCortadaHourNaHour: TStringField;
    QuClashSubjectDetailIdSubject: TLongintField;
    QuClashSubjectDetailIdLevel: TLongintField;
    QuClashSubjectDetailIdSpecialization: TLongintField;
    QuClashSubjectDetailIdGroupId: TLongintField;
    QuClashSubjectDetailIdDay: TLongintField;
    QuClashSubjectDetailIdHour: TLongintField;
    QuClashSubjectDetailAbLevel: TStringField;
    QuClashSubjectDetailAbSpecialization: TStringField;
    QuClashSubjectDetailNaGroupId: TStringField;
    QuClashSubjectDetailNaDay: TStringField;
    QuClashSubjectDetailNaHour: TStringField;
    QuSubjectCortadaHourDetailIdLevel: TLongintField;
    QuSubjectCortadaHourDetailIdSpecialization: TLongintField;
    QuSubjectCortadaHourDetailIdGroupId: TLongintField;
    QuSubjectCortadaHourDetailIdDay: TLongintField;
    QuSubjectCortadaHourDetailIdHour0: TLongintField;
    QuSubjectCortadaHourDetailIdSubject: TLongintField;
    QuSubjectCortadaHourDetailAbLevel: TStringField;
    QuSubjectCortadaHourDetailAbSpecialization: TStringField;
    QuSubjectCortadaHourDetailNaGroupId: TStringField;
    QuSubjectCortadaHourDetailNaDay: TStringField;
    QuSubjectCortadaHourDetailNaHour: TStringField;
    QuSubjectCortadaHourDetailNaSubject: TStringField;
    QuSubjectCortadaHourDetailIdHour: TLongintField;
    Splitter1: TSplitter;
    ActTimetableClass: TAction;
    ActTimetableTeacher: TAction;
    ActClashTeacher: TAction;
    ActClashSubject: TAction;
    ActClashRoom: TAction;
    ActSubjectRestrictionNonSatisfied: TAction;
    ActTeacherRestrictionNoRespetada: TAction;
    ActSubjectCutDay: TAction;
    ActSubjectCortadaHour: TAction;
    ActTimetableRoomType: TAction;
    DSClashTeacher: TDataSource;
    QuClashTeacherIdTimetable: TLongintField;
    QuSubjectCortadaDayIdTimetable: TLongintField;
    QuSubjectCortadaHourIdTimetable: TLongintField;
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
    QuSubjectCortadaHourDetailIdTimetable: TLongintField;
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
    procedure ActSubjectCortadaHourExecute(Sender: TObject);
    procedure ActTimetableRoomTypeExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure ActFindExecute(Sender: TObject);
    procedure ActImproveTimeTableExecute(Sender: TObject);
  private
    { Private declarations }
    FClashRoomForm, FClashSubjectForm, FSubjectCortadaHourForm,
      FSubjectCortadaDayForm, FClashTeacherForm: TMasterDetailEditorForm;
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
  QuClashRoomNaDay.DisplayLabel := SFlTimeSlot_IdDay;
  QuClashRoomNaHour.DisplayLabel := SFlTimeSlot_IdHour;
  
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
  if TSingleEditorForm.ToggleSingleEditor(Self, FSubjectCortadaDayForm,
    ConfigStorage, ActSubjectCutDay, QuSubjectCortadaDay) then
  begin
    QuSubjectCortadaDay.Close;
    QuSubjectCortadaDay.Open;
  end;
end;

procedure TTimetableForm.ActSubjectCortadaHourExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, QuSubjectCortadaHour do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FSubjectCortadaHourForm, ConfigStorage, ActSubjectCortadaHour,
      QuSubjectCortadaHour, QuSubjectCortadaHourDetail) then
    begin
      QuSubjectCortadaHour.Close;
      QuSubjectCortadaHour.Open;
      QuSubjectCortadaHourDetail.Close;
      QuSubjectCortadaHourDetail.Open;
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
