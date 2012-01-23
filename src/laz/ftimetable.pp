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
    BtnCruceTeacher: TToolButton;
    BtnCruceSubject: TToolButton;
    BtnCruceAula: TToolButton;
    QuCruceAula: TZQuery;
    QuCruceAulaIdDay: TLongintField;
    QuCruceAulaIdHour: TLongintField;
    QuCruceAulaIdRoomType: TLongintField;
    QuCruceAulaNaDay: TStringField;
    QuCruceAulaNaHour: TStringField;
    QuCruceAulaDetalle: TZQuery;
    QuCruceAulaDetalleIdLevel: TLongintField;
    QuCruceAulaDetalleIdSpecialization: TLongintField;
    QuCruceAulaDetalleIdGroupId: TLongintField;
    QuCruceAulaDetalleNaSubject: TStringField;
    QuCruceAulaDetalleAbLevel: TStringField;
    QuCruceAulaDetalleAbSpecialization: TStringField;
    QuCruceAulaDetalleNaGroupId: TStringField;
    DSCruceAula: TDataSource;
    QuCruceTeacherDetalle: TZQuery;
    QuCruceTeacherDetalleIdTeacher: TLongintField;
    QuCruceTeacherDetalleIdLevel: TLongintField;
    QuCruceTeacherDetalleIdSpecialization: TLongintField;
    QuCruceTeacherDetalleIdGroupId: TLongintField;
    QuCruceTeacherDetalleIdSubject: TLongintField;
    QuCruceTeacherDetalleAbLevel: TStringField;
    QuCruceTeacherDetalleAbSpecialization: TStringField;
    QuCruceTeacherDetalleNaGroupId: TStringField;
    QuCruceTeacherDetalleNaSubject: TStringField;
    QuCruceTeacher: TZQuery;
    QuCruceTeacherIdTeacher: TLongintField;
    QuCruceTeacherIdDay: TLongintField;
    QuCruceTeacherIdHour: TLongintField;
    QuCruceTeacherNaDay: TStringField;
    QuCruceTeacherNaHour: TStringField;
    QuCruceSubject: TZQuery;
    QuCruceSubjectIdSubject: TLongintField;
    QuCruceSubjectNaSubject: TStringField;
    QuCruceSubjectDetalle: TZQuery;
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
    QuCruceAulaNumber: TLongintField;
    QuSubjectCortadaHourNaDay: TStringField;
    QuSubjectCortadaHourNaHour: TStringField;
    QuCruceSubjectDetalleIdSubject: TLongintField;
    QuCruceSubjectDetalleIdLevel: TLongintField;
    QuCruceSubjectDetalleIdSpecialization: TLongintField;
    QuCruceSubjectDetalleIdGroupId: TLongintField;
    QuCruceSubjectDetalleIdDay: TLongintField;
    QuCruceSubjectDetalleIdHour: TLongintField;
    QuCruceSubjectDetalleAbLevel: TStringField;
    QuCruceSubjectDetalleAbSpecialization: TStringField;
    QuCruceSubjectDetalleNaGroupId: TStringField;
    QuCruceSubjectDetalleNaDay: TStringField;
    QuCruceSubjectDetalleNaHour: TStringField;
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
    ActCruceTeacher: TAction;
    ActCruceSubject: TAction;
    ActCruceAula: TAction;
    ActSubjectRestrictionNoRespetada: TAction;
    ActTeacherRestrictionNoRespetada: TAction;
    ActSubjectCortadaDay: TAction;
    ActSubjectCortadaHour: TAction;
    ActTimeTableRoomType: TAction;
    DSCruceTeacher: TDataSource;
    QuCruceTeacherIdTimeTable: TLongintField;
    QuSubjectCortadaDayIdTimeTable: TLongintField;
    QuSubjectCortadaHourIdTimeTable: TLongintField;
    QuTimeTableDetailSubjectRestrictionIdTimeTable: TLongintField;
    QuTimeTableDetailTeacherRestrictionIdTimeTable: TLongintField;
    QuTimeTableDetailTeacherRestrictionApeTeacher: TStringField;
    QuTimeTableDetailTeacherRestrictionNaTeacher: TStringField;
    QuCruceAulaIdTimeTable: TLongintField;
    QuCruceAulaAbRoomType: TStringField;
    QuCruceTeacherApeTeacher: TStringField;
    QuCruceTeacherNaTeacher: TStringField;
    QuCruceTeacherCruces: TStringField;
    QuCruceAulaDetalleIdTimeTable: TLongintField;
    QuCruceAulaDetalleIdRoomType: TLongintField;
    QuCruceAulaDetalleIdDay: TLongintField;
    QuCruceAulaDetalleIdHour: TLongintField;
    QuCruceTeacherDetalleIdTimeTable: TLongintField;
    QuCruceSubjectIdTimeTable: TLongintField;
    DSCruceSubject: TDataSource;
    QuCruceSubjectDetalleIdTimeTable: TLongintField;
    QuSubjectCortadaHourDetalleIdTimeTable: TLongintField;
    QuCruceAulaCruces: TStringField;
    QuCruceAulaUsadas: TStringField;
    QuCruceTeacherDetalleIdDay: TLongintField;
    QuCruceTeacherDetalleIdHour: TLongintField;
    BtnMejorarTimeTable: TToolButton;
    ActMejorarTimeTable: TAction;
    procedure ActTimeTableClassExecute(Sender: TObject);
    procedure ActCruceTeacherExecute(Sender: TObject);
    procedure ActCruceSubjectExecute(Sender: TObject);
    procedure ActTimeTableTeacherExecute(Sender: TObject);
    procedure ActSubjectRestrictionNoRespetadaExecute(Sender: TObject);
    procedure ActTeacherRestrictionNoRespetadaExecute(Sender: TObject);
    procedure ActCruceAulaExecute(Sender: TObject);
    procedure QuCruceTeacherAfterScroll(DataSet: TDataSet);
    procedure QuCruceSubjectAfterScroll(DataSet: TDataSet);
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
    FCruceAulaForm, FCruceSubjectForm, FSubjectCortadaHourForm,
      FSubjectCortadaDayForm, FCruceTeacherForm: TMasterDetailEditorForm;
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

procedure TTimeTableForm.ActCruceTeacherExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, MasterDataModule do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FCruceTeacherForm, ConfigStorage, ActCruceTeacher,
      QuCruceTeacher, QuCruceTeacherDetalle) then
    begin
      QuCruceTeacher.Close;
      QuCruceTeacherDetalle.Close;
      QuCruceTeacher.Open;
      QuCruceTeacherDetalle.Open;
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

procedure TTimeTableForm.ActCruceSubjectExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FCruceSubjectForm, ConfigStorage, ActCruceSubject, QuCruceSubject,
      QuCruceSubjectDetalle) then
    begin
      QuCruceSubject.Close;
      QuCruceSubject.Open;
      QuCruceSubjectDetalle.Close;
      QuCruceSubjectDetalle.Open;
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

procedure TTimeTableForm.ActCruceAulaExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, QuCruceAula do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FCruceAulaForm, ConfigStorage, ActCruceAula, QuCruceAula,
      QuCruceAulaDetalle) then
    begin
      QuCruceAula.Close;
      QuCruceAula.Open;
      QuCruceAulaDetalle.Close;
      QuCruceAulaDetalle.Open;
    end;
  end;
end;

procedure TTimeTableForm.QuCruceTeacherAfterScroll(DataSet: TDataSet);
begin
  inherited;
  QuCruceTeacherDetalle.Filter := Format(
    'IdDay=%d and IdHour=%d and IdTeacher=%d',
    [QuCruceTeacherIdDay.Value, QuCruceTeacherIdHour.Value,
    QuCruceTeacherIdTeacher.Value]);
end;

procedure TTimeTableForm.QuCruceSubjectAfterScroll(DataSet: TDataSet);
begin
  inherited;
  QuCruceSubjectDetalle.Filter := Format('IdSubject=%d',
    [QuCruceSubjectIdSubject.Value]);
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
