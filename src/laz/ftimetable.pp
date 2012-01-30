{ -*- mode: Delphi -*- }
unit FTimeTable;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, FSingleEditor, Grids, Buttons, FEditor, DBCtrls,
  ExtCtrls, ComCtrls, ActnList, ZConnection, ZDataset, FCrossManytoManyEditorR, DMaster, FCrossManyToManyEditor1,
  FConfiguracion, DSource, FMasterDetailEditor, FTimeTableTeacher, FTimeTableRoomType, FTimeTableClass;

type

  { TTimeTableForm }

  TTimeTableForm = class(TSingleEditorForm)
    BtnSubjectRestrictionNoRespetada: TToolButton;
    BtnTeacherRestrictionNoRespetada: TToolButton;
    BtnTimeTableClass: TToolButton;
    BtnTimeTableTeacher: TToolButton;
    BtnClashTeacher: TToolButton;
    BtnClashSubject: TToolButton;
    BtnClashRoom: TToolButton;
    QuClashRoom: TZQuery;
    QuClashRoomIdDay: TLongintField;
    QuClashRoomIdHour: TLongintField;
    QuClashRoomIdRoomType: TLongintField;
    QuClashRoomNaDay: TStringField;
    QuClashRoomNaHour: TStringField;
    QuClashRoomDetalle: TZQuery;
    QuClashRoomDetalleIdLevel: TLongintField;
    QuClashRoomDetalleIdSpecialization: TLongintField;
    QuClashRoomDetalleIdGroupId: TLongintField;
    QuClashRoomDetalleNaSubject: TStringField;
    QuClashRoomDetalleAbLevel: TStringField;
    QuClashRoomDetalleAbSpecialization: TStringField;
    QuClashRoomDetalleNaGroupId: TStringField;
    DSClashRoom: TDataSource;
    QuClashTeacherDetalle: TZQuery;
    QuClashTeacherDetalleIdTeacher: TLongintField;
    QuClashTeacherDetalleIdLevel: TLongintField;
    QuClashTeacherDetalleIdSpecialization: TLongintField;
    QuClashTeacherDetalleIdGroupId: TLongintField;
    QuClashTeacherDetalleIdSubject: TLongintField;
    QuClashTeacherDetalleAbLevel: TStringField;
    QuClashTeacherDetalleAbSpecialization: TStringField;
    QuClashTeacherDetalleNaGroupId: TStringField;
    QuClashTeacherDetalleNaSubject: TStringField;
    QuClashTeacher: TZQuery;
    QuClashTeacherIdTeacher: TLongintField;
    QuClashTeacherIdDay: TLongintField;
    QuClashTeacherIdHour: TLongintField;
    QuClashTeacherNaDay: TStringField;
    QuClashTeacherNaHour: TStringField;
    QuClashSubject: TZQuery;
    QuClashSubjectIdSubject: TLongintField;
    QuClashSubjectNaSubject: TStringField;
    QuClashSubjectDetalle: TZQuery;
    QuTimeTableDetailSubjectRestriction: TZQuery;
    QuTimeTableDetailSubjectRestrictionNaSubject: TStringField;
    QuTimeTableDetailSubjectRestrictionIdDay: TLongintField;
    QuTimeTableDetailSubjectRestrictionIdHour: TLongintField;
    QuTimeTableDetailSubjectRestrictionIdSubjectRestrictionType: TLongintField;
    QuTimeTableDetailSubjectRestrictionIdLevel: TLongintField;
    QuTimeTableDetailSubjectRestrictionIdSpecialization: TLongintField;
    QuTimeTableDetailSubjectRestrictionIdGroupId: TLongintField;
    QuTimeTableDetailSubjectRestrictionNaDay: TStringField;
    QuTimeTableDetailSubjectRestrictionNaHour: TStringField;
    QuTimeTableDetailSubjectRestrictionNaSubjectRestrictionType: TStringField;
    QuTimeTableDetailSubjectRestrictionAbLevel: TStringField;
    QuTimeTableDetailSubjectRestrictionAbSpecialization: TStringField;
    QuTimeTableDetailSubjectRestrictionNaGroupId: TStringField;
    QuTimeTableDetailTeacherRestriction: TZQuery;
    QuTimeTableDetailTeacherRestrictionIdDay: TLongintField;
    QuTimeTableDetailTeacherRestrictionIdHour: TLongintField;
    QuTimeTableDetailTeacherRestrictionIdTeacherRestrictionType: TLongintField;
    QuTimeTableDetailTeacherRestrictionIdLevel: TLongintField;
    QuTimeTableDetailTeacherRestrictionIdSpecialization: TLongintField;
    QuTimeTableDetailTeacherRestrictionIdGroupId: TLongintField;
    QuTimeTableDetailTeacherRestrictionNaTeacherRestrictionType: TStringField;
    QuTimeTableDetailTeacherRestrictionNaLevel: TStringField;
    QuTimeTableDetailTeacherRestrictionNaSpecialization: TStringField;
    QuTimeTableDetailTeacherRestrictionNaGroupId: TStringField;
    QuTimeTableDetailTeacherRestrictionNaDay: TStringField;
    QuTimeTableDetailTeacherRestrictionNaHour: TStringField;
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
    QuSubjectCortadaHourDetalle: TZQuery;
    DSSubjectCortadaHour: TDataSource;
    BtnTimeTableRoomType: TToolButton;
    QuClashRoomNumber: TLongintField;
    QuSubjectCortadaHourNaDay: TStringField;
    QuSubjectCortadaHourNaHour: TStringField;
    QuClashSubjectDetalleIdSubject: TLongintField;
    QuClashSubjectDetalleIdLevel: TLongintField;
    QuClashSubjectDetalleIdSpecialization: TLongintField;
    QuClashSubjectDetalleIdGroupId: TLongintField;
    QuClashSubjectDetalleIdDay: TLongintField;
    QuClashSubjectDetalleIdHour: TLongintField;
    QuClashSubjectDetalleAbLevel: TStringField;
    QuClashSubjectDetalleAbSpecialization: TStringField;
    QuClashSubjectDetalleNaGroupId: TStringField;
    QuClashSubjectDetalleNaDay: TStringField;
    QuClashSubjectDetalleNaHour: TStringField;
    QuSubjectCortadaHourDetalleIdLevel: TLongintField;
    QuSubjectCortadaHourDetalleIdSpecialization: TLongintField;
    QuSubjectCortadaHourDetalleIdGroupId: TLongintField;
    QuSubjectCortadaHourDetalleIdDay: TLongintField;
    QuSubjectCortadaHourDetalleIdHour0: TLongintField;
    QuSubjectCortadaHourDetalleIdSubject: TLongintField;
    QuSubjectCortadaHourDetalleAbLevel: TStringField;
    QuSubjectCortadaHourDetalleAbSpecialization: TStringField;
    QuSubjectCortadaHourDetalleNaGroupId: TStringField;
    QuSubjectCortadaHourDetalleNaDay: TStringField;
    QuSubjectCortadaHourDetalleNaHour: TStringField;
    QuSubjectCortadaHourDetalleNaSubject: TStringField;
    QuSubjectCortadaHourDetalleIdHour: TLongintField;
    Splitter1: TSplitter;
    ActTimeTableClass: TAction;
    ActTimeTableTeacher: TAction;
    ActClashTeacher: TAction;
    ActClashSubject: TAction;
    ActClashAula: TAction;
    ActSubjectRestrictionNoRespetada: TAction;
    ActTeacherRestrictionNoRespetada: TAction;
    ActSubjectCortadaDay: TAction;
    ActSubjectCortadaHour: TAction;
    ActTimeTableRoomType: TAction;
    DSClashTeacher: TDataSource;
    QuClashTeacherIdTimeTable: TLongintField;
    QuSubjectCortadaDayIdTimeTable: TLongintField;
    QuSubjectCortadaHourIdTimeTable: TLongintField;
    QuTimeTableDetailSubjectRestrictionIdTimeTable: TLongintField;
    QuTimeTableDetailTeacherRestrictionIdTimeTable: TLongintField;
    QuTimeTableDetailTeacherRestrictionLnTeacher: TStringField;
    QuTimeTableDetailTeacherRestrictionNaTeacher: TStringField;
    QuClashRoomIdTimeTable: TLongintField;
    QuClashRoomAbRoomType: TStringField;
    QuClashTeacherLnTeacher: TStringField;
    QuClashTeacherNaTeacher: TStringField;
    QuClashTeacherClashes: TStringField;
    QuClashRoomDetalleIdTimeTable: TLongintField;
    QuClashRoomDetalleIdRoomType: TLongintField;
    QuClashRoomDetalleIdDay: TLongintField;
    QuClashRoomDetalleIdHour: TLongintField;
    QuClashTeacherDetalleIdTimeTable: TLongintField;
    QuClashSubjectIdTimeTable: TLongintField;
    DSClashSubject: TDataSource;
    QuClashSubjectDetalleIdTimeTable: TLongintField;
    QuSubjectCortadaHourDetalleIdTimeTable: TLongintField;
    QuClashRoomClashes: TStringField;
    QuClashRoomUsadas: TStringField;
    QuClashTeacherDetalleIdDay: TLongintField;
    QuClashTeacherDetalleIdHour: TLongintField;
    BtnMejorarTimeTable: TToolButton;
    ActMejorarTimeTable: TAction;
    procedure ActTimeTableClassExecute(Sender: TObject);
    procedure ActClashTeacherExecute(Sender: TObject);
    procedure ActClashSubjectExecute(Sender: TObject);
    procedure ActTimeTableTeacherExecute(Sender: TObject);
    procedure ActSubjectRestrictionNoRespetadaExecute(Sender: TObject);
    procedure ActTeacherRestrictionNoRespetadaExecute(Sender: TObject);
    procedure ActClashAulaExecute(Sender: TObject);
    procedure QuClashTeacherAfterScroll(DataSet: TDataSet);
    procedure QuClashSubjectAfterScroll(DataSet: TDataSet);
    procedure ActSubjectCortadaDayExecute(Sender: TObject);
    procedure ActSubjectCortadaHourExecute(Sender: TObject);
    procedure ActTimeTableRoomTypeExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure ActFindExecute(Sender: TObject);
    procedure ActMejorarTimeTableExecute(Sender: TObject);
  private
    { Private declarations }
    FClashRoomForm, FClashSubjectForm, FSubjectCortadaHourForm,
      FSubjectCortadaDayForm, FClashTeacherForm: TMasterDetailEditorForm;
    FSubjectRestrictionNoRespetadaForm,
      FTeacherRestrictionNoRespetadaForm: TSingleEditorForm;
    FTimeTableTeacherForm: TTimeTableTeacherForm;
    FTimeTableRoomTypeForm: TTimeTableRoomTypeForm;
    FTimeTableClassForm: TTimeTableClassForm;
    {$IFNDEF FREEWARE}
    procedure MejorarTimeTable;
    {$ENDIF}
  protected
    procedure doLoadConfig; override;
    procedure doSaveConfig; override;
  public
    { Public declarations }
  end;

var
  TimeTableForm: TTimeTableForm;

implementation

uses
  Variants, UTTModel, UMakeTT;
{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TTimeTableForm.ActTimeTableClassExecute(Sender: TObject);
begin
  inherited;
  if TTimeTableClassForm.ToggleEditor(Self, FTimeTableClassForm,
    ConfigStorage, ActTimeTableClass) then
  begin
    with SourceDataModule do
      FTimeTableClassForm.LoadHints(TbDay, TbHour, TbSubject);
    FTimeTableClassForm.BtnMostrarClick(nil);
  end;
end;

procedure TTimeTableForm.ActClashTeacherExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, MasterDataModule do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FClashTeacherForm, ConfigStorage, ActClashTeacher,
      QuClashTeacher, QuClashTeacherDetalle) then
    begin
      QuClashTeacher.Close;
      QuClashTeacherDetalle.Close;
      QuClashTeacher.Open;
      QuClashTeacherDetalle.Open;
    end;
  end;
end;

procedure TTimeTableForm.ActFindExecute(Sender: TObject);
begin
  inherited ActFindExecute(Sender);
end;

procedure TTimeTableForm.ActTimeTableTeacherExecute(Sender: TObject);
begin
  inherited;
  if TTimeTableTeacherForm.ToggleEditor(Self, FTimeTableTeacherForm,
    ConfigStorage, ActTimeTableTeacher) then
  begin
    with SourceDataModule do
      FTimeTableTeacherForm.LoadHints(TbDay, TbHour, TbTeacher);
    FTimeTableTeacherForm.BtnMostrarClick(nil);
  end
end;

procedure TTimeTableForm.ActClashSubjectExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FClashSubjectForm, ConfigStorage, ActClashSubject, QuClashSubject,
      QuClashSubjectDetalle) then
    begin
      QuClashSubject.Close;
      QuClashSubject.Open;
      QuClashSubjectDetalle.Close;
      QuClashSubjectDetalle.Open;
    end;
  end;
end;

procedure TTimeTableForm.ActSubjectRestrictionNoRespetadaExecute(Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self,
    FSubjectRestrictionNoRespetadaForm, ConfigStorage,
    ActSubjectRestrictionNoRespetada, QuTimeTableDetailSubjectRestriction) then
  begin
    QuTimeTableDetailSubjectRestriction.Close;
    QuTimeTableDetailSubjectRestriction.Open;
  end;
end;

procedure TTimeTableForm.ActMejorarTimeTableExecute(Sender: TObject);
begin
  ActMejorarTimeTable.Enabled := False;
  try
{$IFNDEF FREEWARE}
    MejorarTimeTable;
{$ENDIF}
  finally
    ActMejorarTimeTable.Enabled := True;
    ActMejorarTimeTable.Checked := False;
  end;
end;

{$IFNDEF FREEWARE}
procedure TTimeTableForm.MejorarTimeTable;
var
  IdTimeTableFuente, IdTimeTableDestino: Integer;
  SNewIdTimeTable: string;
begin
  IdTimeTableFuente := SourceDataModule.TbTimeTable.FindField('IdTimeTable').AsInteger;
  SNewIdTimeTable := IntToStr(MasterDataModule.NewIdTimeTable);
  if not InputQuery(Format('Mejorando TimeTable %d: ', [IdTimeTableFuente]),
    'Idigo del horario mejorado', SNewIdTimeTable) then
    Exit;
  IdTimeTableDestino := StrToInt(SNewIdTimeTable);
  with SourceDataModule do
  begin
    ActMejorarTimeTable.Enabled := False;
    try
      {$IFDEF THREADED}
      TImproveTimeTableThread.Create(IdTimeTableFuente, IdTimeTableDestino, False);
      {$ELSE}
      with TImproveTimeTableThread.Create(IdTimeTableFuente, IdTimeTableDestino, True) do
      try
        Execute;
      finally
        Free;
      end;
      {$ENDIF}
    finally
      ActMejorarTimeTable.Enabled := True;
      TbTimeTableDetail.Refresh;
    end;
  end;
end;
{$ENDIF}

procedure TTimeTableForm.ActTeacherRestrictionNoRespetadaExecute
  (Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self,
    FTeacherRestrictionNoRespetadaForm, ConfigStorage,
    ActTeacherRestrictionNoRespetada, QuTimeTableDetailTeacherRestriction) then
  begin
    QuTimeTableDetailTeacherRestriction.Close;
    QuTimeTableDetailTeacherRestriction.Open;
  end;
end;

procedure TTimeTableForm.ActClashAulaExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, QuClashRoom do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FClashRoomForm, ConfigStorage, ActClashAula, QuClashRoom,
      QuClashRoomDetalle) then
    begin
      QuClashRoom.Close;
      QuClashRoom.Open;
      QuClashRoomDetalle.Close;
      QuClashRoomDetalle.Open;
    end;
  end;
end;

procedure TTimeTableForm.QuClashTeacherAfterScroll(DataSet: TDataSet);
begin
  inherited;
  QuClashTeacherDetalle.Filter := Format(
    'IdDay=%d and IdHour=%d and IdTeacher=%d',
    [QuClashTeacherIdDay.Value, QuClashTeacherIdHour.Value,
    QuClashTeacherIdTeacher.Value]);
end;

procedure TTimeTableForm.QuClashSubjectAfterScroll(DataSet: TDataSet);
begin
  inherited;
  QuClashSubjectDetalle.Filter := Format('IdSubject=%d',
    [QuClashSubjectIdSubject.Value]);
end;

procedure TTimeTableForm.ActSubjectCortadaDayExecute(Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self, FSubjectCortadaDayForm,
    ConfigStorage, ActSubjectCortadaDay, QuSubjectCortadaDay) then
  begin
    QuSubjectCortadaDay.Close;
    QuSubjectCortadaDay.Open;
  end;
end;

procedure TTimeTableForm.ActSubjectCortadaHourExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, QuSubjectCortadaHour do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FSubjectCortadaHourForm, ConfigStorage, ActSubjectCortadaHour,
      QuSubjectCortadaHour, QuSubjectCortadaHourDetalle) then
    begin
      QuSubjectCortadaHour.Close;
      QuSubjectCortadaHour.Open;
      QuSubjectCortadaHourDetalle.Close;
      QuSubjectCortadaHourDetalle.Open;
    end;
  end;
end;

procedure TTimeTableForm.ActTimeTableRoomTypeExecute(Sender: TObject);
begin
  inherited;
  if TTimeTableRoomTypeForm.ToggleEditor(Self, FTimeTableRoomTypeForm,
    ConfigStorage, ActTimeTableRoomType) then
  begin
    with SourceDataModule do
    begin
      FTimeTableRoomTypeForm.LoadHints(TbDay, TbHour, TbSubject);
    end;
    FTimeTableRoomTypeForm.BtnMostrarClick(nil);
  end;
end;

procedure TTimeTableForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited DataSourceDataChange(Sender, Field);
end;

procedure TTimeTableForm.DataSourceStateChange(Sender: TObject);
begin
  inherited DataSourceStateChange(Sender);
end;

procedure TTimeTableForm.DBGridDblClick(Sender: TObject);
begin
  inherited DBGridDblClick(Sender);
end;

procedure TTimeTableForm.doLoadConfig;
begin
  inherited;
  Panel2.Width := ConfigIntegers['Panel2_Width'];
end;

procedure TTimeTableForm.doSaveConfig;
begin
  inherited;
  ConfigIntegers['Panel2_Width'] := Panel2.Width;
end;

initialization

{$IFDEF FPC}
{$I ftimetable.lrs}
{$ENDIF}

end.
