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
  Variants, RelUtils, KerModel, FProgres;
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
  VModeloHorario: TModeloHorario;
  TimeTable: TTimeTable;
  CodHorarioFuente, CodHorarioDestino: Integer;
  Report: TStrings;
  MomentoInicial, EndTime: TDateTime;
  d: string;
  va: Double;
begin
  CodHorarioFuente := SourceDataModule.TbHorario.FindField('CodHorario').AsInteger;
  if not InputQuery(Format('Mejorando Horario %d: ', [CodHorarioFuente]),
    'Codigo del horario mejorado', d) then
    Exit;
  CodHorarioDestino := StrToInt(d);
  ProgressForm.CloseClick := False;
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
      VModeloHorario.OnProgress := ProgressForm.OnProgress;
      MainForm.Step := 1;
      TimeTable := TTimeTable.CrearDesdeModelo(VModeloHorario);
      ProgressForm.Caption := Format('Mejorando Horario [%d] en [%d]',
         [CodHorarioFuente, CodHorarioDestino]);
      with VModeloHorario do
        ProgressForm.ShowProgressForm(SesionCantidadDoble);
      try
        {if s = '' then
          VObjetoModeloHorario.HacerAleatorio
        else}
        TimeTable.LoadFromDataModule(CodHorarioFuente);
        va := TimeTable.Valor;
        TimeTable.DescensoRapidoForzado;
        TimeTable.DescensoRapidoDobleForzado(SourceDataModule.NumIteraciones);
        if not ProgressForm.CancelClick then
        begin
          EndTime := Now;
          Report := TStringList.Create;
          try
            Report.Add('Algoritmo de Descenso Rapido Doble');
            Report.Add('==================================');
            Report.Add(Format('Horario base (Peso): %d (%f)',
              [CodHorarioFuente, va]));
            Report.Add('----------------------------------');
            // VModeloHorario.ReportParameters(Report);
            TimeTable.ReportValues(Report);
            TimeTable.SaveToDataModule(CodHorarioDestino, MomentoInicial,
              EndTime, Report);
            if SourceDataModule.TbHorario.Active then
              SourceDataModule.TbHorario.Refresh;
          finally
            Report.Free;
          end;
        end;
      finally
        ProgressForm.CloseProgressForm;
        TimeTable.Free;
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
