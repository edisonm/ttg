unit FHorario;
{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, FSingEdt, Grids, Buttons, FEditor, DBCtrls,
  ExtCtrls, ComCtrls, ActnList, ZConnection, ZDataset, FCrsMMER, DMaster, FCrsMME1,
  FConfig, DSource, FMain, FProgres, FMasDeEd, FHorProf, FHorAulT, FHorPara,
  KerEvolE;

type

  { THorarioForm }

  THorarioForm = class(TSingleEditorForm)
    BtnMateriaProhibicionNoRespetada: TToolButton;
    BtnProfesorProhibicionNoRespetada: TToolButton;
    BtnHorarioParalelo: TToolButton;
    BtnHorarioProfesor: TToolButton;
    BtnCruceProfesor: TToolButton;
    BtnCruceMateria: TToolButton;
    BtnCruceAula: TToolButton;
    QuCruceAula: TZQuery;
    QuCruceAulaCodDia: TLongintField;
    QuCruceAulaCodHora: TLongintField;
    QuCruceAulaCodAulaTipo: TLongintField;
    QuCruceAulaNomDia: TStringField;
    QuCruceAulaNomHora: TStringField;
    QuCruceAulaDetalle: TZQuery;
    QuCruceAulaDetalleCodNivel: TLongintField;
    QuCruceAulaDetalleCodEspecializacion: TLongintField;
    QuCruceAulaDetalleCodParaleloId: TLongintField;
    QuCruceAulaDetalleNomMateria: TStringField;
    QuCruceAulaDetalleAbrNivel: TStringField;
    QuCruceAulaDetalleAbrEspecializacion: TStringField;
    QuCruceAulaDetalleNomParaleloId: TStringField;
    DSCruceAula: TDataSource;
    QuCruceProfesorDetalle: TZQuery;
    QuCruceProfesorDetalleCodProfesor: TLongintField;
    QuCruceProfesorDetalleCodNivel: TLongintField;
    QuCruceProfesorDetalleCodEspecializacion: TLongintField;
    QuCruceProfesorDetalleCodParaleloId: TLongintField;
    QuCruceProfesorDetalleCodMateria: TLongintField;
    QuCruceProfesorDetalleAbrNivel: TStringField;
    QuCruceProfesorDetalleAbrEspecializacion: TStringField;
    QuCruceProfesorDetalleNomParaleloId: TStringField;
    QuCruceProfesorDetalleNomMateria: TStringField;
    QuCruceProfesor: TZQuery;
    QuCruceProfesorCodProfesor: TLongintField;
    QuCruceProfesorCodDia: TLongintField;
    QuCruceProfesorCodHora: TLongintField;
    QuCruceProfesorNomDia: TStringField;
    QuCruceProfesorNomHora: TStringField;
    QuCruceMateria: TZQuery;
    QuCruceMateriaCodMateria: TLongintField;
    QuCruceMateriaNomMateria: TStringField;
    QuCruceMateriaDetalle: TZQuery;
    QuHorarioDetalleMateriaProhibicion: TZQuery;
    QuHorarioDetalleMateriaProhibicionNomMateria: TStringField;
    QuHorarioDetalleMateriaProhibicionCodDia: TLongintField;
    QuHorarioDetalleMateriaProhibicionCodHora: TLongintField;
    QuHorarioDetalleMateriaProhibicionCodMateProhibicionTipo: TLongintField;
    QuHorarioDetalleMateriaProhibicionCodNivel: TLongintField;
    QuHorarioDetalleMateriaProhibicionCodEspecializacion: TLongintField;
    QuHorarioDetalleMateriaProhibicionCodParaleloId: TLongintField;
    QuHorarioDetalleMateriaProhibicionNomDia: TStringField;
    QuHorarioDetalleMateriaProhibicionNomHora: TStringField;
    QuHorarioDetalleMateriaProhibicionNomMateProhibicionTipo: TStringField;
    QuHorarioDetalleMateriaProhibicionAbrNivel: TStringField;
    QuHorarioDetalleMateriaProhibicionAbrEspecializacion: TStringField;
    QuHorarioDetalleMateriaProhibicionNomParaleloId: TStringField;
    QuHorarioDetalleProfesorProhibicion: TZQuery;
    QuHorarioDetalleProfesorProhibicionCodDia: TLongintField;
    QuHorarioDetalleProfesorProhibicionCodHora: TLongintField;
    QuHorarioDetalleProfesorProhibicionCodProfProhibicionTipo: TLongintField;
    QuHorarioDetalleProfesorProhibicionCodNivel: TLongintField;
    QuHorarioDetalleProfesorProhibicionCodEspecializacion: TLongintField;
    QuHorarioDetalleProfesorProhibicionCodParaleloId: TLongintField;
    QuHorarioDetalleProfesorProhibicionNomProfProhibicionTipo: TStringField;
    QuHorarioDetalleProfesorProhibicionNomNivel: TStringField;
    QuHorarioDetalleProfesorProhibicionNomEspecializacion: TStringField;
    QuHorarioDetalleProfesorProhibicionNomParaleloId: TStringField;
    QuHorarioDetalleProfesorProhibicionNomDia: TStringField;
    QuHorarioDetalleProfesorProhibicionNomHora: TStringField;
    Panel2: TPanel;
    dbmInforme: TDBMemo;
    BtnMateriaCortadaDia: TToolButton;
    QuMateriaCortadaDia: TZQuery;
    QuMateriaCortadaDiaCodNivel: TLongintField;
    QuMateriaCortadaDiaCodEspecializacion: TLongintField;
    QuMateriaCortadaDiaCodParaleloId: TLongintField;
    QuMateriaCortadaDiaCodDia: TLongintField;
    QuMateriaCortadaDiaCodHora: TLongintField;
    QuMateriaCortadaDiaCodMateria: TLongintField;
    QuMateriaCortadaDiaAbrNivel: TStringField;
    QuMateriaCortadaDiaAbrEspecializacion: TStringField;
    QuMateriaCortadaDiaNomParaleloId: TStringField;
    QuMateriaCortadaDiaNomMateria: TStringField;
    QuMateriaCortadaDiaNomDia: TStringField;
    QuMateriaCortadaDiaNomHora: TStringField;
    BtnMateriaCortadaHora: TToolButton;
    QuMateriaCortadaHora: TZQuery;
    QuMateriaCortadaHoraCodDia: TLongintField;
    QuMateriaCortadaHoraCodHora: TLongintField;
    QuMateriaCortadaHoraDetalle: TZQuery;
    DSMateriaCortadaHora: TDataSource;
    BtnHorarioAulaTipo: TToolButton;
    QuCruceAulaCantidad: TLongintField;
    QuMateriaCortadaHoraNomDia: TStringField;
    QuMateriaCortadaHoraNomHora: TStringField;
    QuCruceMateriaDetalleCodMateria: TLongintField;
    QuCruceMateriaDetalleCodNivel: TLongintField;
    QuCruceMateriaDetalleCodEspecializacion: TLongintField;
    QuCruceMateriaDetalleCodParaleloId: TLongintField;
    QuCruceMateriaDetalleCodDia: TLongintField;
    QuCruceMateriaDetalleCodHora: TLongintField;
    QuCruceMateriaDetalleAbrNivel: TStringField;
    QuCruceMateriaDetalleAbrEspecializacion: TStringField;
    QuCruceMateriaDetalleNomParaleloId: TStringField;
    QuCruceMateriaDetalleNomDia: TStringField;
    QuCruceMateriaDetalleNomHora: TStringField;
    QuMateriaCortadaHoraDetalleCodNivel: TLongintField;
    QuMateriaCortadaHoraDetalleCodEspecializacion: TLongintField;
    QuMateriaCortadaHoraDetalleCodParaleloId: TLongintField;
    QuMateriaCortadaHoraDetalleCodDia: TLongintField;
    QuMateriaCortadaHoraDetalleCodHora0: TLongintField;
    QuMateriaCortadaHoraDetalleCodMateria: TLongintField;
    QuMateriaCortadaHoraDetalleAbrNivel: TStringField;
    QuMateriaCortadaHoraDetalleAbrEspecializacion: TStringField;
    QuMateriaCortadaHoraDetalleNomParaleloId: TStringField;
    QuMateriaCortadaHoraDetalleNomDia: TStringField;
    QuMateriaCortadaHoraDetalleNomHora: TStringField;
    QuMateriaCortadaHoraDetalleNomMateria: TStringField;
    QuMateriaCortadaHoraDetalleCodHora: TLongintField;
    Splitter1: TSplitter;
    ActHorarioParalelo: TAction;
    ActHorarioProfesor: TAction;
    ActCruceProfesor: TAction;
    ActCruceMateria: TAction;
    ActCruceAula: TAction;
    ActMateriaProhibicionNoRespetada: TAction;
    ActProfesorProhibicionNoRespetada: TAction;
    ActMateriaCortadaDia: TAction;
    ActMateriaCortadaHora: TAction;
    ActHorarioAulaTipo: TAction;
    DSCruceProfesor: TDataSource;
    QuCruceProfesorCodHorario: TLongintField;
    QuMateriaCortadaDiaCodHorario: TLongintField;
    QuMateriaCortadaHoraCodHorario: TLongintField;
    QuHorarioDetalleMateriaProhibicionCodHorario: TLongintField;
    QuHorarioDetalleProfesorProhibicionCodHorario: TLongintField;
    QuHorarioDetalleProfesorProhibicionApeProfesor: TStringField;
    QuHorarioDetalleProfesorProhibicionNomProfesor: TStringField;
    QuCruceAulaCodHorario: TLongintField;
    QuCruceAulaAbrAulaTipo: TStringField;
    QuCruceProfesorApeProfesor: TStringField;
    QuCruceProfesorNomProfesor: TStringField;
    QuCruceProfesorCruces: TStringField;
    QuCruceAulaDetalleCodHorario: TLongintField;
    QuCruceAulaDetalleCodAulaTipo: TLongintField;
    QuCruceAulaDetalleCodDia: TLongintField;
    QuCruceAulaDetalleCodHora: TLongintField;
    QuCruceProfesorDetalleCodHorario: TLongintField;
    QuCruceMateriaCodHorario: TLongintField;
    DSCruceMateria: TDataSource;
    QuCruceMateriaDetalleCodHorario: TLongintField;
    QuMateriaCortadaHoraDetalleCodHorario: TLongintField;
    QuCruceAulaCruces: TStringField;
    QuCruceAulaUsadas: TStringField;
    QuCruceProfesorDetalleCodDia: TLongintField;
    QuCruceProfesorDetalleCodHora: TLongintField;
    BtnMejorarHorario: TToolButton;
    ActMejorarHorario: TAction;
    procedure ActHorarioParaleloExecute(Sender: TObject);
    procedure ActCruceProfesorExecute(Sender: TObject);
    procedure ActCruceMateriaExecute(Sender: TObject);
    procedure ActHorarioProfesorExecute(Sender: TObject);
    procedure ActMateriaProhibicionNoRespetadaExecute(Sender: TObject);
    procedure ActProfesorProhibicionNoRespetadaExecute(Sender: TObject);
    procedure ActCruceAulaExecute(Sender: TObject);
    procedure QuCruceProfesorAfterScroll(DataSet: TDataSet);
    procedure QuCruceMateriaAfterScroll(DataSet: TDataSet);
    procedure ActMateriaCortadaDiaExecute(Sender: TObject);
    procedure ActMateriaCortadaHoraExecute(Sender: TObject);
    procedure ActHorarioAulaTipoExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure ActFindExecute(Sender: TObject);
    procedure ActMejorarHorarioExecute(Sender: TObject);
  private
    { Private declarations }
    FCruceAulaForm, FCruceMateriaForm, FMateriaCortadaHoraForm,
      FMateriaCortadaDiaForm, FCruceProfesorForm: TMasterDetailEditorForm;
    FMateriaProhibicionNoRespetadaForm,
      FProfesorProhibicionNoRespetadaForm: TSingleEditorForm;
    FHorarioProfesorForm: THorarioProfesorForm;
    FHorarioAulaTipoForm: THorarioAulaTipoForm;
    FHorarioParaleloForm: THorarioParaleloForm;
    procedure MejorarHorario;
  protected
    procedure doLoadConfig; override;
    procedure doSaveConfig; override;
  public
    { Public declarations }
  end;

var
  HorarioForm: THorarioForm;

implementation

uses
  Variants, KerModel, UMakeTT;
{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure THorarioForm.ActHorarioParaleloExecute(Sender: TObject);
begin
  inherited;
  if THorarioParaleloForm.ToggleEditor(Self, FHorarioParaleloForm,
    ConfigStorage, ActHorarioParalelo) then
  begin
    with SourceDataModule do
      FHorarioParaleloForm.LoadHints(TbDia, TbHora, TbMateria);
    FHorarioParaleloForm.BtnMostrarClick(nil);
  end;
end;

procedure THorarioForm.ActCruceProfesorExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, MasterDataModule do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FCruceProfesorForm, ConfigStorage, ActCruceProfesor,
      QuCruceProfesor, QuCruceProfesorDetalle) then
    begin
      QuCruceProfesor.Close;
      QuCruceProfesorDetalle.Close;
      QuCruceProfesor.Open;
      QuCruceProfesorDetalle.Open;
    end;
  end;
end;

procedure THorarioForm.ActFindExecute(Sender: TObject);
begin
  inherited ActFindExecute(Sender);
end;

procedure THorarioForm.ActHorarioProfesorExecute(Sender: TObject);
begin
  inherited;
  if THorarioProfesorForm.ToggleEditor(Self, FHorarioProfesorForm,
    ConfigStorage, ActHorarioProfesor) then
  begin
    with SourceDataModule do
      FHorarioProfesorForm.LoadHints(TbDia, TbHora, TbProfesor);
    FHorarioProfesorForm.BtnMostrarClick(nil);
  end
end;

procedure THorarioForm.ActCruceMateriaExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FCruceMateriaForm, ConfigStorage, ActCruceMateria, QuCruceMateria,
      QuCruceMateriaDetalle) then
    begin
      QuCruceMateria.Close;
      QuCruceMateria.Open;
      QuCruceMateriaDetalle.Close;
      QuCruceMateriaDetalle.Open;
    end;
  end;
end;

procedure THorarioForm.ActMateriaProhibicionNoRespetadaExecute(Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self,
    FMateriaProhibicionNoRespetadaForm, ConfigStorage,
    ActMateriaProhibicionNoRespetada, QuHorarioDetalleMateriaProhibicion) then
  begin
    QuHorarioDetalleMateriaProhibicion.Close;
    QuHorarioDetalleMateriaProhibicion.Open;
  end;
end;

procedure THorarioForm.ActMejorarHorarioExecute(Sender: TObject);
begin
  ActMejorarHorario.Enabled := False;
  try
{$IFNDEF FREEWARE}
    MejorarHorario;
{$ENDIF}
  finally
    ActMejorarHorario.Enabled := True;
    ActMejorarHorario.Checked := False;
  end;
end;

{$IFNDEF FREEWARE}
procedure THorarioForm.MejorarHorario;
var
  CodHorarioFuente, CodHorarioDestino: Integer;
  SNewCodHorario: string;
begin
  CodHorarioFuente := SourceDataModule.TbHorario.FindField('CodHorario').AsInteger;
  SNewCodHorario := IntToStr(MasterDataModule.NewCodHorario);
  if not InputQuery(Format('Mejorando Horario %d: ', [CodHorarioFuente]),
    'Codigo del horario mejorado', SNewCodHorario) then
    Exit;
  CodHorarioDestino := StrToInt(SNewCodHorario);
  with SourceDataModule do
  begin
    ActMejorarHorario.Enabled := False;
    MainForm.Ejecutando := True;
    try
      {$IFDEF DEBUG}
      with TImproveTimeTableThread.Create(ValidCodes, True) do
      try
        Execute;
      finally
        Free;
      end;
      {$ELSE}
      TImproveTimeTableThread.Create(CodHorarioFuente, CodHorarioDestino, False);
      {$ENDIF}
    finally
      MainForm.Ejecutando := False;
      ActMejorarHorario.Enabled := True;
      TbHorarioDetalle.Refresh;
    end;
  end;
end;
{$ENDIF}

procedure THorarioForm.ActProfesorProhibicionNoRespetadaExecute
  (Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self,
    FProfesorProhibicionNoRespetadaForm, ConfigStorage,
    ActProfesorProhibicionNoRespetada, QuHorarioDetalleProfesorProhibicion) then
  begin
    QuHorarioDetalleProfesorProhibicion.Close;
    QuHorarioDetalleProfesorProhibicion.Open;
  end;
end;

procedure THorarioForm.ActCruceAulaExecute(Sender: TObject);
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

procedure THorarioForm.QuCruceProfesorAfterScroll(DataSet: TDataSet);
begin
  inherited;
  QuCruceProfesorDetalle.Filter := Format(
    'CodDia=%d and CodHora=%d and CodProfesor=%d',
    [QuCruceProfesorCodDia.Value, QuCruceProfesorCodHora.Value,
    QuCruceProfesorCodProfesor.Value]);
end;

procedure THorarioForm.QuCruceMateriaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  QuCruceMateriaDetalle.Filter := Format('CodMateria=%d',
    [QuCruceMateriaCodMateria.Value]);
end;

procedure THorarioForm.ActMateriaCortadaDiaExecute(Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self, FMateriaCortadaDiaForm,
    ConfigStorage, ActMateriaCortadaDia, QuMateriaCortadaDia) then
  begin
    QuMateriaCortadaDia.Close;
    QuMateriaCortadaDia.Open;
  end;
end;

procedure THorarioForm.ActMateriaCortadaHoraExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, QuMateriaCortadaHora do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor
      (Self, FMateriaCortadaHoraForm, ConfigStorage, ActMateriaCortadaHora,
      QuMateriaCortadaHora, QuMateriaCortadaHoraDetalle) then
    begin
      QuMateriaCortadaHora.Close;
      QuMateriaCortadaHora.Open;
      QuMateriaCortadaHoraDetalle.Close;
      QuMateriaCortadaHoraDetalle.Open;
    end;
  end;
end;

procedure THorarioForm.ActHorarioAulaTipoExecute(Sender: TObject);
begin
  inherited;
  if THorarioAulaTipoForm.ToggleEditor(Self, FHorarioAulaTipoForm,
    ConfigStorage, ActHorarioAulaTipo) then
  begin
    with SourceDataModule do
    begin
      FHorarioAulaTipoForm.LoadHints(TbDia, TbHora, TbMateria);
    end;
    FHorarioAulaTipoForm.BtnMostrarClick(nil);
  end;
end;

procedure THorarioForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited DataSourceDataChange(Sender, Field);
end;

procedure THorarioForm.DataSourceStateChange(Sender: TObject);
begin
  inherited DataSourceStateChange(Sender);
end;

procedure THorarioForm.DBGridDblClick(Sender: TObject);
begin
  inherited DBGridDblClick(Sender);
end;

procedure THorarioForm.doLoadConfig;
begin
  inherited;
  Panel2.Width := ConfigIntegers['Panel2_Width'];
end;

procedure THorarioForm.doSaveConfig;
begin
  inherited;
  ConfigIntegers['Panel2_Width'] := Panel2.Width;
end;

initialization

{$IFDEF FPC}
{$I FHorario.lrs}
{$ENDIF}

end.
