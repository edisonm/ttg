unit FHorario;
{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, Messages, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, Db, FSingEdt, Grids, DBGrids, StdCtrls,
  Buttons, FEditor, DBCtrls, ExtCtrls, ImgList, ComCtrls, ToolWin, ActnList,
  ZConnection, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset,
  FMasDeEd, FHorProf, FHorAulT, FHorPara;

type
  THorarioForm = class(TSingleEditorForm)
    BtnMateriaProhibicionNoRespetada: TToolButton;
    BtnProfesorProhibicionNoRespetada: TToolButton;
    BtnHorarioParalelo: TToolButton;
    BtnHorarioProfesor: TToolButton;
    BtnCruceProfesor: TToolButton;
    BtnCruceMateria: TToolButton;
    BtnCruceAula: TToolButton;
    QuCruceAula: TZQuery;
    QuCruceAulaCodDia: TIntegerField;
    QuCruceAulaCodHora: TIntegerField;
    QuCruceAulaCodAulaTipo: TIntegerField;
    QuCruceAulaNomDia: TWideStringField;
    QuCruceAulaNomHora: TWideStringField;
    QuCruceAulaDetalle: TZQuery;
    QuCruceAulaDetalleCodNivel: TIntegerField;
    QuCruceAulaDetalleCodEspecializacion: TIntegerField;
    QuCruceAulaDetalleCodParaleloId: TIntegerField;
    QuCruceAulaDetalleNomMateria: TWideStringField;
    QuCruceAulaDetalleAbrNivel: TWideStringField;
    QuCruceAulaDetalleAbrEspecializacion: TWideStringField;
    QuCruceAulaDetalleNomParaleloId: TWideStringField;
    DSCruceAula: TDataSource;
    QuCruceProfesorDetalle: TZQuery;
    QuCruceProfesorDetalleCodProfesor: TIntegerField;
    QuCruceProfesorDetalleCodNivel: TIntegerField;
    QuCruceProfesorDetalleCodEspecializacion: TIntegerField;
    QuCruceProfesorDetalleCodParaleloId: TIntegerField;
    QuCruceProfesorDetalleCodMateria: TIntegerField;
    QuCruceProfesorDetalleAbrNivel: TWideStringField;
    QuCruceProfesorDetalleAbrEspecializacion: TWideStringField;
    QuCruceProfesorDetalleNomParaleloId: TWideStringField;
    QuCruceProfesorDetalleNomMateria: TWideStringField;
    QuCruceProfesor: TZQuery;
    QuCruceProfesorCodProfesor: TIntegerField;
    QuCruceProfesorCodDia: TIntegerField;
    QuCruceProfesorCodHora: TIntegerField;
    QuCruceProfesorNomDia: TWideStringField;
    QuCruceProfesorNomHora: TWideStringField;
    QuCruceMateria: TZQuery;
    QuCruceMateriaCodMateria: TIntegerField;
    QuCruceMateriaNomMateria: TWideStringField;
    QuCruceMateriaDetalle: TZQuery;
    QuHorarioDetalleMateriaProhibicion: TZQuery;
    QuHorarioDetalleMateriaProhibicionNomMateria: TWideStringField;
    QuHorarioDetalleMateriaProhibicionCodDia: TIntegerField;
    QuHorarioDetalleMateriaProhibicionCodHora: TIntegerField;
    QuHorarioDetalleMateriaProhibicionCodMateProhibicionTipo: TIntegerField;
    QuHorarioDetalleMateriaProhibicionCodNivel: TIntegerField;
    QuHorarioDetalleMateriaProhibicionCodEspecializacion: TIntegerField;
    QuHorarioDetalleMateriaProhibicionCodParaleloId: TIntegerField;
    QuHorarioDetalleMateriaProhibicionNomDia: TWideStringField;
    QuHorarioDetalleMateriaProhibicionNomHora: TWideStringField;
    QuHorarioDetalleMateriaProhibicionNomMateProhibicionTipo: TWideStringField;
    QuHorarioDetalleMateriaProhibicionAbrNivel: TWideStringField;
    QuHorarioDetalleMateriaProhibicionAbrEspecializacion: TWideStringField;
    QuHorarioDetalleMateriaProhibicionNomParaleloId: TWideStringField;
    QuHorarioDetalleProfesorProhibicion: TZQuery;
    QuHorarioDetalleProfesorProhibicionCodDia: TIntegerField;
    QuHorarioDetalleProfesorProhibicionCodHora: TIntegerField;
    QuHorarioDetalleProfesorProhibicionCodProfProhibicionTipo: TIntegerField;
    QuHorarioDetalleProfesorProhibicionCodNivel: TIntegerField;
    QuHorarioDetalleProfesorProhibicionCodEspecializacion: TIntegerField;
    QuHorarioDetalleProfesorProhibicionCodParaleloId: TIntegerField;
    QuHorarioDetalleProfesorProhibicionNomProfProhibicionTipo: TWideStringField;
    QuHorarioDetalleProfesorProhibicionNomNivel: TWideStringField;
    QuHorarioDetalleProfesorProhibicionNomEspecializacion: TWideStringField;
    QuHorarioDetalleProfesorProhibicionNomParaleloId: TWideStringField;
    QuHorarioDetalleProfesorProhibicionNomDia: TWideStringField;
    QuHorarioDetalleProfesorProhibicionNomHora: TWideStringField;
    Panel2: TPanel;
    dbmInforme: TDBMemo;
    BtnMateriaCortadaDia: TToolButton;
    QuMateriaCortadaDia: TZQuery;
    QuMateriaCortadaDiaCodNivel: TIntegerField;
    QuMateriaCortadaDiaCodEspecializacion: TIntegerField;
    QuMateriaCortadaDiaCodParaleloId: TIntegerField;
    QuMateriaCortadaDiaCodDia: TIntegerField;
    QuMateriaCortadaDiaCodHora: TIntegerField;
    QuMateriaCortadaDiaCodMateria: TIntegerField;
    QuMateriaCortadaDiaAbrNivel: TWideStringField;
    QuMateriaCortadaDiaAbrEspecializacion: TWideStringField;
    QuMateriaCortadaDiaNomParaleloId: TWideStringField;
    QuMateriaCortadaDiaNomMateria: TWideStringField;
    QuMateriaCortadaDiaNomDia: TWideStringField;
    QuMateriaCortadaDiaNomHora: TWideStringField;
    BtnMateriaCortadaHora: TToolButton;
    QuMateriaCortadaHora: TZQuery;
    QuMateriaCortadaHoraCodDia: TIntegerField;
    QuMateriaCortadaHoraCodHora: TIntegerField;
    QuMateriaCortadaHoraDetalle: TZQuery;
    DSMateriaCortadaHora: TDataSource;
    BtnHorarioAulaTipo: TToolButton;
    QuCruceAulaCantidad: TIntegerField;
    QuMateriaCortadaHoraNomDia: TWideStringField;
    QuMateriaCortadaHoraNomHora: TWideStringField;
    QuCruceMateriaDetalleCodMateria: TIntegerField;
    QuCruceMateriaDetalleCodNivel: TIntegerField;
    QuCruceMateriaDetalleCodEspecializacion: TIntegerField;
    QuCruceMateriaDetalleCodParaleloId: TIntegerField;
    QuCruceMateriaDetalleCodDia: TIntegerField;
    QuCruceMateriaDetalleCodHora: TIntegerField;
    QuCruceMateriaDetalleAbrNivel: TWideStringField;
    QuCruceMateriaDetalleAbrEspecializacion: TWideStringField;
    QuCruceMateriaDetalleNomParaleloId: TWideStringField;
    QuCruceMateriaDetalleNomDia: TWideStringField;
    QuCruceMateriaDetalleNomHora: TWideStringField;
    QuMateriaCortadaHoraDetalleCodNivel: TIntegerField;
    QuMateriaCortadaHoraDetalleCodEspecializacion: TIntegerField;
    QuMateriaCortadaHoraDetalleCodParaleloId: TIntegerField;
    QuMateriaCortadaHoraDetalleCodDia: TIntegerField;
    QuMateriaCortadaHoraDetalleCodHora0: TIntegerField;
    QuMateriaCortadaHoraDetalleCodMateria: TIntegerField;
    QuMateriaCortadaHoraDetalleAbrNivel: TWideStringField;
    QuMateriaCortadaHoraDetalleAbrEspecializacion: TWideStringField;
    QuMateriaCortadaHoraDetalleNomParaleloId: TWideStringField;
    QuMateriaCortadaHoraDetalleNomDia: TWideStringField;
    QuMateriaCortadaHoraDetalleNomHora: TWideStringField;
    QuMateriaCortadaHoraDetalleNomMateria: TWideStringField;
    QuMateriaCortadaHoraDetalleCodHora: TIntegerField;
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
    QuCruceProfesorCodHorario: TIntegerField;
    QuMateriaCortadaDiaCodHorario: TIntegerField;
    QuMateriaCortadaHoraCodHorario: TIntegerField;
    QuHorarioDetalleMateriaProhibicionCodHorario: TIntegerField;
    QuHorarioDetalleProfesorProhibicionCodHorario: TIntegerField;
    QuHorarioDetalleProfesorProhibicionApeProfesor: TWideStringField;
    QuHorarioDetalleProfesorProhibicionNomProfesor: TWideStringField;
    QuCruceAulaCodHorario: TIntegerField;
    QuCruceAulaAbrAulaTipo: TWideStringField;
    QuCruceProfesorApeProfesor: TWideStringField;
    QuCruceProfesorNomProfesor: TWideStringField;
    QuCruceProfesorCruces: TWideStringField;
    QuCruceAulaDetalleCodHorario: TIntegerField;
    QuCruceAulaDetalleCodAulaTipo: TIntegerField;
    QuCruceAulaDetalleCodDia: TIntegerField;
    QuCruceAulaDetalleCodHora: TIntegerField;
    QuCruceProfesorDetalleCodHorario: TIntegerField;
    QuCruceMateriaCodHorario: TIntegerField;
    DSCruceMateria: TDataSource;
    QuCruceMateriaDetalleCodHorario: TIntegerField;
    QuMateriaCortadaHoraDetalleCodHorario: TIntegerField;
    QuCruceAulaCruces: TWideStringField;
    QuCruceAulaUsadas: TWideStringField;
    QuCruceProfesorDetalleCodDia: TIntegerField;
    QuCruceProfesorDetalleCodHora: TIntegerField;
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
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
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
  FCrsMMER, DMaster, TTGUtls, FCrsMME1, FConfig, Printers, DSource, FMain,
  Variants, RelUtils, KerModel;
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
      LoadHints(FHorarioParaleloForm, TbDia, TbHora, TbMateria);
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
      LoadHints(FHorarioProfesorForm, TbDia, TbHora, TbProfesor);
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
  inherited;
{$IFNDEF FREEWARE}
  MejorarHorario;
{$ENDIF}
end;

{$IFNDEF FREEWARE}
procedure THorarioForm.MejorarHorario;
var
  VModeloHorario: TModeloHorario;
  VObjetoModeloHorario: TObjetoModeloHorario;
  CodHorarioFuente, CodHorarioDestino: Integer;
  Informe: TStrings;
  MomentoInicial, MomentoFinal: TDateTime;
  d: string;
  va: Double;
begin
  CodHorarioFuente := SourceDataModule.TbHorario.FindField('CodHorario').AsInteger;
  if not InputQuery(Format('Mejorando Horario %d: ', [CodHorarioFuente]),
    'Codigo del horario mejorado', d) then
    Exit;
  CodHorarioDestino := StrToInt(d);
  MainForm.CloseClick := False;
  with SourceDataModule do
  begin
    InitRandom;
    MomentoInicial := Now;
    MainForm.Ejecutando := True;
    VModeloHorario :=
      TModeloHorario.CrearDesdeDataModule(
        CruceProfesor,
        ProfesorFraccionamiento,
        CruceAulaTipo,
        HoraHueca,
        SesionCortada,
        MateriaNoDispersa);
    MainForm.StatusBar.Panels[1].Style := psOwnerDraw;
    MainForm.Progress := 0;
    MainForm.Pasada := 0;
    try
      VModeloHorario.OnProgress := MainForm.ProgressDescensoDoble;
      MainForm.Step := 1;
      VObjetoModeloHorario := TObjetoModeloHorario.CrearDesdeModelo(VModeloHorario);
      try
        {if s = '' then
          VObjetoModeloHorario.HacerAleatorio
        else}
        VObjetoModeloHorario.LoadFromDataModule(CodHorarioFuente);
        va := VObjetoModeloHorario.Valor;
        VObjetoModeloHorario.DescensoRapidoForzado;
        VObjetoModeloHorario.DescensoRapidoDobleForzado;
        MomentoFinal := Now;
        Informe := TStringList.Create;
        try
          Informe.Add('Algoritmo de Descenso Rapido Doble');
          Informe.Add('==================================');
          Informe.Add(Format('Horario base (Peso): %d (%f)',
            [CodHorarioFuente, va]));
          VModeloHorario.ReportParameters(Informe);
          VObjetoModeloHorario.ReportValues(Informe);
          VObjetoModeloHorario.SaveToDataModule(CodHorarioDestino, MomentoInicial,
            MomentoFinal, Informe);
          if SourceDataModule.TbHorario.Active then
            SourceDataModule.TbHorario.Refresh;
        finally
          Informe.Free;
        end;
      finally
        VObjetoModeloHorario.Free;
      end;
    finally
      VModeloHorario.Free;
      MainForm.Ejecutando := False;
      MainForm.StatusBar.Panels[1].Style := psText;
      MainForm.StatusBar.Panels[2].Text := 'Listo';
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
      LoadHints(FHorarioAulaTipoForm, TbDia, TbHora, TbMateria);
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

procedure THorarioForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited FormClose(Sender, Action);
end;

procedure THorarioForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited FormCloseQuery(Sender, CanClose);
end;

procedure THorarioForm.FormCreate(Sender: TObject);
begin
  inherited;
  {PrepareQuery(QuHorarioDetalle, 'HorarioDetalle',
    'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia');
  PrepareQuery(QuCruceAula, 'CruceAula', 'CodAulaTipo;CodDia;CodHora');
  PrepareQuery(QuCruceAulaDetalle, 'CruceAulaDetalle',
    'CodAulaTipo;CodDia;CodHora');
  PrepareQuery(QuCruceProfesor, 'CruceProfesorInde',
    'CodProfesor;CodDia;CodHora');
  PrepareQuery(QuCruceMateria, 'CruceMateria', 'CodMateria');
  // QuCruceMateria.AddIndex('QuCruceMateriaIxNomMateria', 'NomMateria', []);
  PrepareQuery(QuCruceMateriaDetalle, 'CruceMateriaDetalle',
    'CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora');
  PrepareQuery(QuHorarioDetalleMateriaProhibicion,
    'HorarioDetalleMateriaProhibicion',
    'CodMateProhibicionTipo;NomMateria;CodDia;CodHora');
  }
  { with QuHorarioDetalleMateriaProhibicion.IndexDefs.AddIndexDef do
    begin
      Name := 'QuHorarioDetalleMateriaProhibicionIndex1';
      Fields := 'CodMateProhibicionTipo;NomMateria;CodDia;CodHora';
      Options := [ixDescending];
      DescFields := 'CodMateProhibicionTipo';
    end; }
  {
  PrepareQuery(QuMateriaCortadaHora, 'MateriaCortadaHora', 'CodDia');
  PrepareQuery(QuMateriaCortadaHoraDetalle, 'MateriaCortadaHoraDetalle',
    'CodDia;CodHora');
  }
end;

procedure THorarioForm.FormDestroy(Sender: TObject);
begin
  inherited FormDestroy(Sender);
end;

initialization

{$IFDEF FPC}
{$I FHorario.lrs}
{$ENDIF}

end.
