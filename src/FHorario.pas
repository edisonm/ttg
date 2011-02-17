unit FHorario;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  FSingEdt, Grids, DBGrids, StdCtrls, Buttons, FEditor, DBCtrls, ExtCtrls, ImgList,
  SqlitePassDbo, ComCtrls, ToolWin, FMasDeEd, ActnList, FHorProf, FHorAulT, FHorPara;

type
  THorarioForm = class(TSingleEditorForm)
    BtnMateriaProhibicionNoRespetada: TToolButton;
    BtnProfesorProhibicionNoRespetada: TToolButton;
    BtnHorarioParalelo: TToolButton;
    BtnHorarioProfesor: TToolButton;
    BtnCruceProfesor: TToolButton;
    BtnCruceMateria: TToolButton;
    BtnCruceAula: TToolButton;
    QuHorarioDetalle: TSqlitePassDataset;
    QuHorarioDetalleCodHorario: TLargeintField;
    QuHorarioDetalleCodMateria: TLargeintField;
    QuHorarioDetalleCodNivel: TLargeintField;
    QuHorarioDetalleCodEspecializacion: TLargeintField;
    QuHorarioDetalleCodParaleloId: TLargeintField;
    QuHorarioDetalleCodDia: TLargeintField;
    QuHorarioDetalleCodHora: TLargeintField;
    QuHorarioDetalleSesion: TLargeintField;
    QuCruceAula: TSqlitePassDataset;
    QuCruceAulaCodDia: TLargeintField;
    QuCruceAulaCodHora: TLargeintField;
    QuCruceAulaCodAulaTipo: TLargeintField;
    QuCruceAulaAbrAulaTipo: TStringField;
    QuCruceAulaNomDia: TStringField;
    QuCruceAulaNomHora: TStringField;
    QuCruceAulaUsadas: TLargeintField;
    QuCruceAulaCruces: TLargeintField;
    QuCruceAulaDetalle: TSqlitePassDataset;
    QuCruceAulaDetalleCodNivel: TLargeintField;
    QuCruceAulaDetalleCodEspecializacion: TLargeintField;
    QuCruceAulaDetalleCodParaleloId: TLargeintField;
    QuCruceAulaDetalleNomMateria: TStringField;
    QuCruceAulaDetalleAbrNivel: TStringField;
    QuCruceAulaDetalleAbrEspecializacion: TStringField;
    QuCruceAulaDetalleNomParaleloId: TStringField;
    DSCruceAula: TDataSource;
    QuCruceProfesorDetalle: TSqlitePassDataset;
    QuCruceProfesorDetalleCodProfesor: TLargeintField;
    QuCruceProfesorDetalleCodDia: TLargeintField;
    QuCruceProfesorDetalleCodHora: TLargeintField;
    QuCruceProfesorDetalleCodNivel: TLargeintField;
    QuCruceProfesorDetalleCodEspecializacion: TLargeintField;
    QuCruceProfesorDetalleCodParaleloId: TLargeintField;
    QuCruceProfesorDetalleCodMateria: TLargeintField;
    QuCruceProfesorDetalleAbrNivel: TStringField;
    QuCruceProfesorDetalleAbrEspecializacion: TStringField;
    QuCruceProfesorDetalleNomParaleloId: TStringField;
    QuCruceProfesorDetalleNomMateria: TStringField;
    QuCruceProfesor: TSqlitePassDataset;
    QuCruceProfesorCodProfesor: TLargeintField;
    QuCruceProfesorCodDia: TLargeintField;
    QuCruceProfesorCodHora: TLargeintField;
    QuCruceProfesorApeProfesor: TStringField;
    QuCruceProfesorNomProfesor: TStringField;
    QuCruceProfesorNomDia: TStringField;
    QuCruceProfesorNomHora: TStringField;
    QuCruceProfesorCruces: TLargeintField;
    QuCruceMateria: TSqlitePassDataset;
    QuCruceMateriaCodMateria: TLargeintField;
    QuCruceMateriaNomMateria: TStringField;
    QuCruceMateriaDetalle: TSqlitePassDataset;
    QuHorarioDetalleMateriaProhibicion: TSqlitePassDataset;
    QuHorarioDetalleMateriaProhibicionNomMateria: TStringField;
    QuHorarioDetalleMateriaProhibicionCodDia: TLargeintField;
    QuHorarioDetalleMateriaProhibicionCodHora: TLargeintField;
    QuHorarioDetalleMateriaProhibicionCodMateProhibicionTipo: TLargeintField;
    QuHorarioDetalleMateriaProhibicionCodNivel: TLargeintField;
    QuHorarioDetalleMateriaProhibicionCodEspecializacion: TLargeintField;
    QuHorarioDetalleMateriaProhibicionCodParaleloId: TLargeintField;
    QuHorarioDetalleMateriaProhibicionNomDia: TStringField;
    QuHorarioDetalleMateriaProhibicionNomHora: TStringField;
    QuHorarioDetalleMateriaProhibicionNomMateProhibicionTipo: TStringField;
    QuHorarioDetalleMateriaProhibicionAbrNivel: TStringField;
    QuHorarioDetalleMateriaProhibicionAbrEspecializacion: TStringField;
    QuHorarioDetalleMateriaProhibicionNomParaleloId: TStringField;
    QuHorarioDetalleProfesorProhibicion: TSqlitePassDataset;
    QuHorarioDetalleProfesorProhibicionApeNomProfesor: TStringField;
    QuHorarioDetalleProfesorProhibicionCodDia: TLargeintField;
    QuHorarioDetalleProfesorProhibicionCodHora: TLargeintField;
    QuHorarioDetalleProfesorProhibicionCodProfProhibicionTipo: TLargeintField;
    QuHorarioDetalleProfesorProhibicionCodNivel: TLargeintField;
    QuHorarioDetalleProfesorProhibicionCodEspecializacion: TLargeintField;
    QuHorarioDetalleProfesorProhibicionCodParaleloId: TLargeintField;
    QuHorarioDetalleProfesorProhibicionNomProfProhibicionTipo: TStringField;
    QuHorarioDetalleProfesorProhibicionNomNivel: TStringField;
    QuHorarioDetalleProfesorProhibicionNomEspecializacion: TStringField;
    QuHorarioDetalleProfesorProhibicionNomParaleloId: TStringField;
    QuHorarioDetalleProfesorProhibicionNomDia: TStringField;
    QuHorarioDetalleProfesorProhibicionNomHora: TStringField;
    Panel2: TPanel;
    dbmInforme: TDBMemo;
    BtnSeleccionarHorario: TToolButton;
    BtnMateriaCortadaDia: TToolButton;
    QuMateriaCortadaDia: TSqlitePassDataset;
    QuMateriaCortadaDiaCodNivel: TLargeintField;
    QuMateriaCortadaDiaCodEspecializacion: TLargeintField;
    QuMateriaCortadaDiaCodParaleloId: TLargeintField;
    QuMateriaCortadaDiaCodDia: TLargeintField;
    QuMateriaCortadaDiaCodHora: TLargeintField;
    QuMateriaCortadaDiaCodMateria: TLargeintField;
    QuMateriaCortadaDiaAbrNivel: TStringField;
    QuMateriaCortadaDiaAbrEspecializacion: TStringField;
    QuMateriaCortadaDiaNomParaleloId: TStringField;
    QuMateriaCortadaDiaNomMateria: TStringField;
    QuMateriaCortadaDiaNomDia: TStringField;
    QuMateriaCortadaDiaNomHora: TStringField;
    BtnMateriaCortadaHora: TToolButton;
    QuMateriaCortadaHora: TSqlitePassDataset;
    QuMateriaCortadaHoraCodDia: TLargeintField;
    QuMateriaCortadaHoraCodHora: TLargeintField;
    QuMateriaCortadaHoraDetalle: TSqlitePassDataset;
    DSMateriaCortadaHora: TDataSource;
    BtnHorarioAulaTipo: TToolButton;
    QuCruceAulaDetalleCodDia: TLargeintField;
    QuCruceAulaDetalleCodHora: TLargeintField;
    QuCruceAulaDetalleCodAulaTipo: TLargeintField;
    QuCruceAulaCantidad: TLargeintField;
    QuMateriaCortadaHoraNomDia: TStringField;
    QuMateriaCortadaHoraNomHora: TStringField;
    QuCruceMateriaDetalleCodMateria: TLargeintField;
    QuCruceMateriaDetalleCodNivel: TLargeintField;
    QuCruceMateriaDetalleCodEspecializacion: TLargeintField;
    QuCruceMateriaDetalleCodParaleloId: TLargeintField;
    QuCruceMateriaDetalleCodDia: TLargeintField;
    QuCruceMateriaDetalleCodHora: TLargeintField;
    QuCruceMateriaDetalleAbrNivel: TStringField;
    QuCruceMateriaDetalleAbrEspecializacion: TStringField;
    QuCruceMateriaDetalleNomParaleloId: TStringField;
    QuCruceMateriaDetalleNomDia: TStringField;
    QuCruceMateriaDetalleNomHora: TStringField;
    QuMateriaCortadaHoraDetalleCodNivel: TLargeintField;
    QuMateriaCortadaHoraDetalleCodEspecializacion: TLargeintField;
    QuMateriaCortadaHoraDetalleCodParaleloId: TLargeintField;
    QuMateriaCortadaHoraDetalleCodDia: TLargeintField;
    QuMateriaCortadaHoraDetalleCodHora0: TLargeintField;
    QuMateriaCortadaHoraDetalleCodMateria: TLargeintField;
    QuMateriaCortadaHoraDetalleAbrNivel: TStringField;
    QuMateriaCortadaHoraDetalleAbrEspecializacion: TStringField;
    QuMateriaCortadaHoraDetalleNomParaleloId: TStringField;
    QuMateriaCortadaHoraDetalleNomDia: TStringField;
    QuMateriaCortadaHoraDetalleNomHora: TStringField;
    QuMateriaCortadaHoraDetalleNomMateria: TStringField;
    QuMateriaCortadaHoraDetalleCodHora: TLargeintField;
    Splitter1: TSplitter;
    ActHorarioParalelo: TAction;
    ActHorarioProfesor: TAction;
    ActCruceProfesor: TAction;
    ActCruceMateria: TAction;
    ActCruceAula: TAction;
    ActMateriaProhibicionNoRespetada: TAction;
    ActProfesorProhibicionNoRespetada: TAction;
    ActSeleccionarHorario: TAction;
    ActMateriaCortadaDia: TAction;
    ActMateriaCortadaHora: TAction;
    ActHorarioAulaTipo: TAction;
    QuHorarioDetalleProfesorProhibicionCodProfesor: TLargeintField;
    procedure ActHorarioParaleloExecute(Sender: TObject);
    procedure ActCruceProfesorExecute(Sender: TObject);
    procedure ActCruceMateriaExecute(Sender: TObject);
    procedure ActHorarioProfesorExecute(Sender: TObject);
    procedure ActMateriaProhibicionNoRespetadaExecute(Sender: TObject);
    procedure ActProfesorProhibicionNoRespetadaExecute(Sender: TObject);
    procedure ActCruceAulaExecute(Sender: TObject);
    procedure QuCruceProfesorAfterScroll(DataSet: TDataSet);
    procedure QuCruceMateriaAfterScroll(DataSet: TDataSet);
    procedure ActSeleccionarHorarioExecute(Sender: TObject);
    procedure ActMateriaCortadaDiaExecute(Sender: TObject);
    procedure ActMateriaCortadaHoraExecute(Sender: TObject);
    procedure ActHorarioAulaTipoExecute(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ActFindExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
  private
    { Private declarations }
    FCruceAulaForm,
    FCruceMateriaForm,
    FMateriaCortadaHoraForm,
    FMateriaCortadaDiaForm,
    FCruceProfesorForm: TMasterDetailEditorForm;
    FMateriaProhibicionNoRespetadaForm,
    FProfesorProhibicionNoRespetadaForm: TSingleEditorForm;
    FHorarioProfesorForm: THorarioProfesorForm;
    FHorarioAulaTipoForm: THorarioAulaTipoForm;
    FHorarioParaleloForm: THorarioParaleloForm;
    procedure FillHorarioDetalleMateriaProhibicion;
    procedure FillCruceAula;
    procedure FillCruceAulaDetalle;
    procedure FillHorarioDetalleProfesorProhibicion;
    procedure FillCruceProfesor;
    procedure FillCruceProfesorDetalle;
    procedure FillMateriaCortadaDia;
    procedure FillCruceMateria;
    procedure FillMateriaCortadaHora;
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
  Variants, RelUtils;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure THorarioForm.ActHorarioParaleloExecute(Sender: TObject);
begin
  inherited;
  if THorarioParaleloForm.ToggleEditor(Self,
				       FHorarioParaleloForm,
				       ConfigStorage,
				       ActHorarioParalelo) then
  begin
    with SourceDataModule do
      LoadHints(FHorarioParaleloForm, TbDia, TbHora, TbMateria);
    FHorarioParaleloForm.BtnMostrarClick(nil);
  end;
end;

procedure THorarioForm.FillCruceProfesor;
var
  CodHorario, CodMateria, CodProfesor, CodNivel, CodEspecializacion,
    CodParaleloId, CodDia, CodHora: Integer;
  s, d: string;
begin
  with SourceDataModule do
  begin
    CodHorario := TbHorario.FindField('CodHorario').Value;
    TbHorarioDetalle.DisableControls;
    d := TbHorarioDetalle.IndexedBy;
    try
      TbHorarioDetalle.IndexedBy := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        QuCruceProfesor.DisableControls;
        TbDistributivo.DisableControls;
        s := TbDistributivo.IndexedBy;
        try
          TbDistributivo.IndexedBy := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
          TbDistributivo.First;
          QuCruceProfesor.Close;
          QuCruceProfesor.Open;
          while (TbHorarioDetalle.FindField('CodHorario').Value = CodHorario) and not TbHorarioDetalle.Eof do
          begin
            CodMateria := TbHorarioDetalle.FindField('CodMateria').Value;
            CodNivel := TbHorarioDetalle.FindField('CodNivel').Value;
            CodEspecializacion := TbHorarioDetalle.FindField('CodEspecializacion').Value;
            CodParaleloId := TbHorarioDetalle.FindField('CodParaleloId').Value;
            while ((TbDistributivo.FindField('CodMateria').AsInteger <> CodMateria)
              or (TbDistributivo.FindField('CodNivel').AsInteger <> CodNivel)
              or (TbDistributivo.FindField('CodEspecializacion').AsInteger <> CodEspecializacion)
              or (TbDistributivo.FindField('CodParaleloId').AsInteger <> CodParaleloId))
              and not TbDistributivo.Eof do
              TbDistributivo.Next;
            CodProfesor := TbDistributivo.FindField('CodProfesor').AsInteger;
            CodDia := TbHorarioDetalle.FindField('CodDia').AsInteger;
            CodHora := TbHorarioDetalle.FindField('CodHora').AsInteger;
	     if QuCruceProfesor.Locate('CodProfesor;CodDia;CodHora',
				       VarArrayOf([CodProfesor, CodDia, CodHora]), []) then
            begin
              QuCruceProfesor.Edit;
              with QuCruceProfesorCruces do Value := Value + 1;
            end
            else
            begin
              QuCruceProfesor.Append;
              QuCruceProfesorCodProfesor.Value := CodProfesor;
              QuCruceProfesorCodHora.Value := CodHora;
              QuCruceProfesorCodDia.Value := CodDia;
              QuCruceProfesorCruces.Value := 1;
            end;
            QuCruceProfesor.Post;
            TbHorarioDetalle.Next;
          end;
          QuCruceProfesor.First;
          while not QuCruceProfesor.Eof do
          begin
            if QuCruceProfesorCruces.Value > 1 then
              QuCruceProfesor.Next
            else
              QuCruceProfesor.Delete;
          end;
        finally
          TbDistributivo.IndexedBy := s;
          TbDistributivo.EnableControls;
          QuCruceProfesor.EnableControls;
        end;
      end;
    finally
      TbHorarioDetalle.IndexedBy := d;
      TbHorarioDetalle.EnableControls;
    end;
  end;
end;

procedure THorarioForm.FillCruceProfesorDetalle;
var
  CodHorario, CodMateria, CodProfesor, CodNivel, CodEspecializacion,
    CodParaleloId, CodDia, CodHora: Integer;
  s, d: string;
begin
  with SourceDataModule do
  begin
    QuCruceProfesorDetalle.Close;
    QuCruceProfesorDetalle.Open;
    CodHorario := TbHorario.FindField('CodHorario').AsInteger;
    TbHorarioDetalle.DisableControls;
    d := TbHorarioDetalle.IndexedBy;
    try
      TbHorarioDetalle.IndexedBy := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        s := TbDistributivo.IndexedBy;
        TbDistributivo.DisableControls;
        QuCruceProfesorDetalle.DisableControls;
        try
          TbDistributivo.IndexedBy := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
          TbDistributivo.First;
          while (TbHorarioDetalle.FindField('CodHorario').AsInteger = CodHorario) and not TbHorarioDetalle.Eof do
          begin
            CodMateria := TbHorarioDetalle.FindField('CodMateria').AsInteger;
            CodNivel := TbHorarioDetalle.FindField('CodNivel').AsInteger;
            CodEspecializacion := TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
            CodParaleloId := TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
            while ((TbDistributivo.FindField('CodMateria').AsInteger <> CodMateria)
		   or (TbDistributivo.FindField('CodNivel').AsInteger <> CodNivel)
		   or (TbDistributivo.FindField('CodEspecializacion').AsInteger <> CodEspecializacion)
		   or (TbDistributivo.FindField('CodParaleloId').AsInteger <> CodParaleloId))
                  and not TbDistributivo.Eof do
              TbDistributivo.Next;
            CodProfesor := TbDistributivo.FindField('CodProfesor').AsInteger;
            CodHora := TbHorarioDetalle.FindField('CodHora').AsInteger;
            CodDia := TbHorarioDetalle.FindField('CodDia').AsInteger;
            if QuCruceProfesor.Locate('CodProfesor;CodDia;CodHora',
                                      VarArrayOf([CodProfesor, CodDia, CodHora]), []) then
            begin
              QuCruceProfesorDetalle.Append;
              QuCruceProfesorDetalleCodProfesor.Value := CodProfesor;
              QuCruceProfesorDetalleCodDia.Value := CodDia;
              QuCruceProfesorDetalleCodHora.Value := CodHora;
              QuCruceProfesorDetalleCodNivel.Value := CodNivel;
              QuCruceProfesorDetalleCodEspecializacion.Value := CodEspecializacion;
              QuCruceProfesorDetalleCodParaleloId.Value := CodParaleloId;
              QuCruceProfesorDetalleCodMateria.Value := TbHorarioDetalle.FindField('CodMateria').AsInteger;
              QuCruceProfesorDetalle.Post;
            end;
            TbHorarioDetalle.Next;
	  end;
        finally
          TbDistributivo.IndexedBy := s;
          TbDistributivo.EnableControls;
          QuCruceProfesorDetalle.EnableControls;
        end;
      end;
    finally
      TbHorarioDetalle.IndexedBy := d;
      TbHorarioDetalle.EnableControls;
    end;
  end;
end;

procedure THorarioForm.ActCruceProfesorExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, MasterDataModule, QuCruceProfesor do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor(Self,
                                                        FCruceProfesorForm,
                                                        ConfigStorage,
                                                        ActCruceProfesor,
                                                        QuCruceProfesor,
                                                        QuCruceProfesorDetalle) then
    begin
      // TODO: Create dinamically QuCruceProfesor and QuCruceProfesorDetalle
      // QuCruceProfesor.Close;
      // QuCruceProfesorDetalle.Close;
      FillCruceProfesor;
      FillCruceProfesorDetalle;
      First;
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
  if THorarioProfesorForm.ToggleEditor(Self,
				       FHorarioProfesorForm,
				       ConfigStorage,
				       ActHorarioProfesor) then
  begin
    with SourceDataModule do
      LoadHints(FHorarioProfesorForm, TbDia, TbHora, TbProfesor);
    FHorarioProfesorForm.BtnMostrarClick(nil);
  end
end;

procedure THorarioForm.FillCruceMateria;
var
  CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId, CodDia,
  Sesion: Integer;
  s: string;
begin
  with SourceDataModule do
  begin
    QuCruceMateria.Close;
    QuCruceMateria.Open;
    QuCruceMateriaDetalle.Close;
    QuCruceMateriaDetalle.Open;
    CodHorario := TbHorario.FindField('CodHorario').AsInteger;
    TbHorarioDetalle.DisableControls;
    s := TbHorarioDetalle.IndexedBy;
    try
      TbHorarioDetalle.IndexedBy := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      TbHorarioDetalle.Filtered := True;
      TbHorarioDetalle.Filter := Format('CodHorario=%d', [CodHorario]);
      LoadDataSetFromDataSet(QuHorarioDetalle, TbHorarioDetalle);
      TbHorarioDetalle.First;
      QuCruceMateria.IndexedBy := 'CodMateria';
      while (TbHorarioDetalle.FindField('CodHorario').AsInteger = CodHorario) and not TbHorarioDetalle.Eof do
      begin
        QuHorarioDetalle.First;
        CodMateria := TbHorarioDetalle.FindField('CodMateria').AsInteger;
        CodNivel := TbHorarioDetalle.FindField('CodNivel').AsInteger;
        CodEspecializacion := TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
        CodParaleloId := TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
        CodDia := TbHorarioDetalle.FindField('CodDia').AsInteger;
        Sesion := TbHorarioDetalle.FindField('Sesion').Value;
        QuHorarioDetalle.Locate('CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia',
                                VarArrayOf([CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId, CodDia]), []);
        while (QuHorarioDetalleCodHorario.Value = CodHorario)
              and (QuHorarioDetalleCodMateria.Value = CodMateria)
              and (QuHorarioDetalleCodNivel.Value = CodNivel)
              and (QuHorarioDetalleCodEspecializacion.Value = CodEspecializacion)
              and (QuHorarioDetalleCodParaleloId.Value = CodParaleloId)
              and (QuHorarioDetalleCodDia.Value = CodDia)
              and not QuHorarioDetalle.Eof do
        begin
          if QuHorarioDetalleSesion.Value <> Sesion then
          begin
            if not QuCruceMateria.Locate('CodMateria', CodMateria, []) then
            begin
              QuCruceMateria.Append;
              QuCruceMateriaCodMateria.AsInteger := TbHorarioDetalle.FindField('CodMateria').AsInteger;
              QuCruceMateriaNomMateria.AsString := TbHorarioDetalle.FindField('NomMateria').AsString;
              QuCruceMateria.Post;
            end;
            QuCruceMateriaDetalle.Append;
            QuCruceMateriaDetalleCodMateria.Value := CodMateria;
            QuCruceMateriaDetalleCodNivel.Value := TbHorarioDetalle.FindField('CodNivel').AsInteger;
            QuCruceMateriaDetalleCodEspecializacion.Value := TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
            QuCruceMateriaDetalleCodParaleloId.Value := TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
            QuCruceMateriaDetalleCodDia.Value := TbHorarioDetalle.FindField('CodDia').AsInteger;
            QuCruceMateriaDetalleCodHora.Value := TbHorarioDetalle.FindField('CodHora').AsInteger;
            QuCruceMateriaDetalle.Post;
          end;
          QuHorarioDetalle.Next;
        end;
        TbHorarioDetalle.Next;
      end;
    finally
      TbHorarioDetalle.Filtered := False;
      TbHorarioDetalle.Filter := '';
      TbHorarioDetalle.IndexedBy := s;
      TbHorarioDetalle.EnableControls;
    end;
    QuCruceMateria.IndexedBy := 'NomMateria';
  end;
end;

procedure THorarioForm.ActCruceMateriaExecute(Sender: TObject);
begin			  
  inherited;
  with SourceDataModule do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor(Self,
                                                        FCruceMateriaForm,
                                                        ConfigStorage,
                                                        ActCruceMateria,
                                                        QuCruceMateria,
                                                        QuCruceMateriaDetalle) then
    begin
      // QuCruceMateria.Close;
      // QuCruceMateriaDetalle.Close;
      FillCruceMateria;
    end;
  end;
end;

procedure THorarioForm.FillHorarioDetalleMateriaProhibicion;
var
  CodHorario: Integer;
  s, d: string; 
begin
  with SourceDataModule do
  begin
    CodHorario := TbHorario.FindField('CodHorario').AsInteger;
    TbHorarioDetalle.DisableControls;
    d := TbHorarioDetalle.IndexedBy;
    try
      TbHorarioDetalle.IndexedBy := 'CodHorario';
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        TbMateriaProhibicion.DisableControls;
        s := TbMateriaProhibicion.IndexedBy;
        try
          TbMateriaProhibicion.IndexedBy := 'CodMateria;CodDia;CodHora';
          QuHorarioDetalleMateriaProhibicion.Close;
          QuHorarioDetalleMateriaProhibicion.Open;
          QuHorarioDetalleMateriaProhibicion.DisableControls;
          try
          while (TbHorarioDetalle.FindField('CodHorario').AsInteger = CodHorario)
      	    and not TbHorarioDetalle.Eof do
          begin
            if TbMateriaProhibicion.Locate('CodMateria;CodDia;CodHora',
                                           VarArrayOf([TbHorarioDetalle.FindField('CodMateria').AsInteger,
              TbHorarioDetalle.FindField('CodDia').AsInteger, TbHorarioDetalle.FindField('CodHora').AsInteger]), []) then
            begin
              QuHorarioDetalleMateriaProhibicion.Append;
              QuHorarioDetalleMateriaProhibicionNomMateria.AsString :=
                TbHorarioDetalle.FindField('NomMateria').AsString;
              QuHorarioDetalleMateriaProhibicionCodHora.Value :=
                TbHorarioDetalle.FindField('CodHora').AsInteger;
              QuHorarioDetalleMateriaProhibicionCodDia.Value :=
                TbHorarioDetalle.FindField('CodDia').AsInteger;
              QuHorarioDetalleMateriaProhibicionCodMateProhibicionTipo.Value :=
                TbMateriaProhibicion.FindField('CodMateProhibicionTipo').AsInteger;
              QuHorarioDetalleMateriaProhibicionCodNivel.Value :=
                TbHorarioDetalle.FindField('CodNivel').AsInteger;
              QuHorarioDetalleMateriaProhibicionCodEspecializacion.Value :=
                TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
              QuHorarioDetalleMateriaProhibicionCodParaleloId.Value :=
                TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
              QuHorarioDetalleMateriaProhibicion.Post;
            end;
            TbHorarioDetalle.Next;
          end;
          finally
            QuHorarioDetalleMateriaProhibicion.EnableControls;
          end;
        finally
          TbMateriaProhibicion.IndexedBy := s;
          TbMateriaProhibicion.EnableControls;
        end;
      end;
    finally
      s := TbMateriaProhibicion.IndexedBy;
      TbHorarioDetalle.EnableControls;
    end;
  end;
end;

procedure THorarioForm.ActMateriaProhibicionNoRespetadaExecute(Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self,
					  FMateriaProhibicionNoRespetadaForm,
					  ConfigStorage,
					  ActMateriaProhibicionNoRespetada,
					  QuHorarioDetalleMateriaProhibicion) then
  begin
   // QuHorarioDetalleMateriaProhibicion.Close;
    FillHorarioDetalleMateriaProhibicion;
  end;
end;

procedure THorarioForm.FillHorarioDetalleProfesorProhibicion;
var
  CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId: Integer;
  r, s, d: string;
begin
  with SourceDataModule do
  begin
    CodHorario := TbHorario.FindField('CodHorario').AsInteger;
    TbHorarioDetalle.DisableControls; 
    r := TbHorarioDetalle.IndexedBy;
    try
      TbHorarioDetalle.IndexedBy :=
        'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        TbDistributivo.DisableControls;
        s := TbDistributivo.IndexedBy;
        TbProfesorProhibicion.DisableControls;
        d := TbProfesorProhibicion.IndexedBy;
        QuHorarioDetalleProfesorProhibicion.DisableControls;
        try
          QuHorarioDetalleProfesorProhibicion.Close;
          QuHorarioDetalleProfesorProhibicion.Open;
          TbProfesorProhibicion.IndexedBy := 'CodProfesor;CodDia;CodHora';
          TbDistributivo.IndexedBy :=
            'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
          TbDistributivo.First;
          while (TbHorarioDetalle.FindField('CodHorario').AsInteger = CodHorario)
                and not TbHorarioDetalle.Eof do
          begin
            CodMateria := TbHorarioDetalle.FindField('CodMateria').AsInteger;
            CodNivel := TbHorarioDetalle.FindField('CodNivel').AsInteger;
            CodEspecializacion := TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
            CodParaleloId := TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
            while ((TbDistributivo.FindField('CodMateria').AsInteger <> CodMateria)
                   or (TbDistributivo.FindField('CodNivel').AsInteger <> CodNivel)
                   or (TbDistributivo.FindField('CodEspecializacion').AsInteger <> CodEspecializacion)
                   or (TbDistributivo.FindField('CodParaleloId').AsInteger <> CodParaleloId))
                  and not TbDistributivo.Eof do
              TbDistributivo.Next;
            if TbProfesorProhibicion.Locate('CodProfesor;CodDia;CodHora',
                                            VarArrayOf([TbDistributivo.FindField('CodProfesor').AsInteger,
                                                        TbHorarioDetalle.FindField('CodDia').AsInteger,
                                                        TbHorarioDetalle.FindField('CodHora').AsInteger]), []) then
            begin
              QuHorarioDetalleProfesorProhibicion.Append;
              QuHorarioDetalleProfesorProhibicionCodProfesor.Value :=
                TbDistributivo.FindField('CodProfesor').AsInteger;
              QuHorarioDetalleProfesorProhibicionCodHora.Value :=
                TbHorarioDetalle.FindField('CodHora').AsInteger;
              QuHorarioDetalleProfesorProhibicionCodDia.Value :=
                TbHorarioDetalle.FindField('CodDia').AsInteger;
              QuHorarioDetalleProfesorProhibicionCodProfProhibicionTipo.Value :=
                TbProfesorProhibicion.FindField('CodProfProhibicionTipo').AsInteger;
              QuHorarioDetalleProfesorProhibicionCodNivel.Value :=
                TbHorarioDetalle.FindField('CodNivel').AsInteger;
              QuHorarioDetalleProfesorProhibicionCodEspecializacion.Value :=
                TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
              QuHorarioDetalleProfesorProhibicionCodParaleloId.Value :=
                TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
              QuHorarioDetalleProfesorProhibicion.Post;
            end;
            TbHorarioDetalle.Next;
          end;
        finally
          TbDistributivo.IndexedBy := s;
          TbProfesorProhibicion.IndexedBy := d;
          TbDistributivo.EnableControls;
          TbProfesorProhibicion.EnableControls;
          QuHorarioDetalleProfesorProhibicion.EnableControls;
        end;
      end;
    finally
      TbHorarioDetalle.IndexedBy := r;
      TbHorarioDetalle.EnableControls;
    end;
  end;
end;

procedure THorarioForm.ActProfesorProhibicionNoRespetadaExecute(Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self,
					  FProfesorProhibicionNoRespetadaForm,
					  ConfigStorage,
					  ActProfesorProhibicionNoRespetada,
					  QuHorarioDetalleProfesorProhibicion) then
  begin
    // QuHorarioDetalleProfesorProhibicion.Close;
    FillHorarioDetalleProfesorProhibicion;
  end;
end;

procedure THorarioForm.FillCruceAula;
var
  CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId,
  CodAulaTipo, CodDia, CodHora: Integer;
  s, d: string;
begin
  with SourceDataModule do
  begin
    QuCruceAula.Close;
    QuCruceAula.Open;
    CodHorario := TbHorario.FindField('CodHorario').AsInteger;
    TbHorarioDetalle.DisableControls;
    d := TbHorarioDetalle.IndexedBy;
    try
      TbHorarioDetalle.IndexedBy := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      TbHorarioDetalle.First;
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        TbDistributivo.DisableControls;
        s := TbDistributivo.IndexedBy;
        TbDistributivo.IndexedBy :=
          'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
        TbDistributivo.First;
        QuCruceAula.DisableControls;
        try
          while (TbHorarioDetalle.FindField('CodHorario').AsInteger = CodHorario)
                and not TbHorarioDetalle.Eof do
          begin
            CodMateria := TbHorarioDetalle.FindField('CodMateria').AsInteger;
            CodNivel := TbHorarioDetalle.FindField('CodNivel').AsInteger;
            CodEspecializacion := TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
            CodParaleloId := TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
            while ((TbDistributivo.FindField('CodMateria').AsInteger <> CodMateria)
                   or (TbDistributivo.FindField('CodNivel').AsInteger <> CodNivel)
                   or (TbDistributivo.FindField('CodEspecializacion').AsInteger <> CodEspecializacion)
                   or (TbDistributivo.FindField('CodParaleloId').AsInteger <> CodParaleloId))
                  and not TbDistributivo.Eof do
              TbDistributivo.Next;
            CodAulaTipo := TbDistributivo.FindField('CodAulaTipo').AsInteger;
            CodHora := TbHorarioDetalle.FindField('CodHora').AsInteger;
            CodDia := TbHorarioDetalle.FindField('CodDia').AsInteger;
            if QuCruceAula.Locate('CodAulaTipo;CodDia;CodHora',
                                  VarArrayOf([CodAulaTipo, CodDia, CodHora]), []) then
            begin
              QuCruceAula.Edit;
              with QuCruceAulaUsadas do Value := Value + 1;
            end
            else
            begin
              QuCruceAula.Append;
              QuCruceAulaCodAulaTipo.Value := CodAulaTipo;
              QuCruceAulaCodHora.Value := CodHora;
              QuCruceAulaCodDia.Value := CodDia;
              QuCruceAulaUsadas.Value := 1;
            end;
            QuCruceAula.Post;
            TbHorarioDetalle.Next;
          end;
          QuCruceAula.First;
          while not QuCruceAula.Eof do
          begin
            if QuCruceAulaUsadas.Value > QuCruceAulaCantidad.Value then
            begin
              QuCruceAula.Edit;
              QuCruceAulaCruces.Value := QuCruceAulaUsadas.Value - QuCruceAulaCantidad.Value;
              QuCruceAula.Post;
              QuCruceAula.Next;
            end
            else
              QuCruceAula.Delete;
          end;
        finally
          TbDistributivo.IndexedBy := s;
          TbDistributivo.EnableControls;
          QuCruceAula.EnableControls;
        end;
      end;
    finally
      TbHorarioDetalle.IndexedBy := d;
      TbHorarioDetalle.EnableControls;
    end;
  end;
end;

procedure THorarioForm.FillCruceAulaDetalle;
var
  CodHorario, CodAulaTipo, CodDia, CodHora, CodMateria, CodNivel, CodEspecializacion: Integer;
  s, d: string;
begin
  with SourceDataModule do
  begin
    QuCruceAulaDetalle.Close;
    QuCruceAulaDetalle.Open;
    CodHorario := TbHorario.FindField('CodHorario').AsInteger;
    d := TbHorarioDetalle.IndexedBy;
    TbHorarioDetalle.IndexedBy := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    QuCruceAulaDetalle.DisableControls;
    //QuCruceAulaDetalle.EnableIndexes := False;
    try
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        s := TbDistributivo.IndexedBy;
        try
          TbDistributivo.DisableControls;
          TbDistributivo.IndexedBy := 'CodMateria;CodNivel;CodEspecializacion';
          TbDistributivo.First;
          while (TbHorarioDetalle.FindField('CodHorario').AsInteger = CodHorario) and not TbHorarioDetalle.Eof do
          begin
            CodMateria := TbHorarioDetalle.FindField('CodMateria').AsInteger;
            CodNivel := TbHorarioDetalle.FindField('CodNivel').AsInteger;
            CodEspecializacion := TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
            while ((TbDistributivo.FindField('CodMateria').AsInteger <> CodMateria)
                   or (TbDistributivo.FindField('CodNivel').AsInteger <> CodNivel)
                   or (TbDistributivo.FindField('CodEspecializacion').AsInteger <> CodEspecializacion))
                  and not TbDistributivo.Eof do
              TbDistributivo.Next;
            CodAulaTipo := TbDistributivo.FindField('CodAulaTipo').AsInteger;
            CodHora := TbHorarioDetalle.FindField('CodHora').AsInteger;
            CodDia := TbHorarioDetalle.FindField('CodDia').AsInteger;
            if QuCruceAula.Locate('CodAulaTipo;CodDia;CodHora',
                                  VarArrayOf([CodAulaTipo, CodDia, CodHora]), []) then
            begin
              QuCruceAulaDetalle.Append;
              QuCruceAulaDetalleCodAulaTipo.Value := CodAulaTipo;
              QuCruceAulaDetalleCodDia.Value := CodDia;
              QuCruceAulaDetalleCodHora.Value := CodHora;
              QuCruceAulaDetalleCodNivel.Value := TbHorarioDetalle.FindField('CodNivel').AsInteger;
              QuCruceAulaDetalleCodEspecializacion.Value := TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
              QuCruceAulaDetalleCodParaleloId.Value := TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
              QuCruceAulaDetalleNomMateria.AsString := TbHorarioDetalle.FindField('NomMateria').AsString;
              QuCruceAulaDetalle.Post;
            end;
            TbHorarioDetalle.Next;
          end;
        finally
          TbDistributivo.IndexedBy := s;
          TbDistributivo.EnableControls;
        end;
      end;
    finally
      TbHorarioDetalle.IndexedBy := d;
      //QuCruceAulaDetalle.EnableIndexes := True;
      //QuCruceAulaDetalle.UpdateIndexes;
      QuCruceAulaDetalle.EnableControls;
    end;
  end;
end;

procedure THorarioForm.ActCruceAulaExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, QuCruceAula do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor(Self,
                                                        FCruceAulaForm,
                                                        ConfigStorage,
                                                        ActCruceAula,
                                                        QuCruceAula,
                                                        QuCruceAulaDetalle) then
    begin
      // QuCruceAula.Close;
      // QuCruceAulaDetalle.Close;
      FillCruceAula;
      FillCruceAulaDetalle;
      Last;
      First;
    end;
  end;
end;

procedure THorarioForm.QuCruceProfesorAfterScroll(DataSet: TDataSet);
begin
  inherited;
  QuCruceProfesorDetalle.Filter :=
    Format('CodDia=%d and CodHora=%d and CodProfesor=%d',
           [QuCruceProfesorCodDia.Value, QuCruceProfesorCodHora.Value,
            QuCruceProfesorCodProfesor.Value]);
end;

procedure THorarioForm.QuCruceMateriaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  QuCruceMateriaDetalle.Filter := Format('CodMateria=%d',
    [QuCruceMateriaCodMateria.Value]);
end;

procedure THorarioForm.ActSeleccionarHorarioExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
    SeleccionarHorario;
  DBGrid.Refresh;
end;

procedure THorarioForm.FillMateriaCortadaDia;
var
  CodHorario, CodNivel, CodEspecializacion, CodParaleloId, CodDia, CodHora,
    Sesion, CodNivel1, CodEspecializacion1, CodParaleloId1, CodHora1, CodDia1,
    Sesion1: Integer;
  d: string;
begin
  with SourceDataModule do
  begin
    CodHorario := TbHorario.FindField('CodHorario').AsInteger;
    TbHorarioDetalle.DisableControls;
    d := TbHorarioDetalle.IndexedBy;
    try
      TbHorarioDetalle.IndexedBy := 'CodHorario;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        CodNivel1 := TbHorarioDetalle.FindField('CodNivel').AsInteger;
        CodEspecializacion1 := TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
        CodParaleloId1 := TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
        CodDia1 := TbHorarioDetalle.FindField('CodDia').AsInteger;
        CodHora1 := TbHorarioDetalle.FindField('CodHora').AsInteger;
        Sesion1 := TbHorarioDetalle['Sesion'].Value;
        TbHorarioDetalle.Next;
        QuMateriaCortadaDia.Close;
        QuMateriaCortadaDia.Open;
        QuMateriaCortadaDia.DisableControls;
        try
          while (TbHorarioDetalle.FindField('CodHorario').AsInteger = CodHorario) and not TbHorarioDetalle.Eof do
          begin
            CodNivel := TbHorarioDetalle.FindField('CodNivel').AsInteger;
            CodEspecializacion := TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
            CodParaleloId := TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
            CodDia := TbHorarioDetalle.FindField('CodDia').AsInteger;
            CodHora := TbHorarioDetalle.FindField('CodHora').AsInteger;
            Sesion := TbHorarioDetalle['Sesion'].Value;
            if (CodNivel = CodNivel1)
              and (CodEspecializacion = CodEspecializacion1)
              and (CodParaleloId = CodParaleloId1)
              and (Sesion = Sesion1)
              and (CodDia <> CodDia1) then
            begin
              QuMateriaCortadaDia.Append;
              QuMateriaCortadaDiaCodNivel.Value := CodNivel1;
              QuMateriaCortadaDiaCodEspecializacion.Value := CodEspecializacion1;
              QuMateriaCortadaDiaCodParaleloId.Value := CodParaleloId1;
              QuMateriaCortadaDiaCodHora.Value := CodHora1;
              QuMateriaCortadaDiaCodDia.Value := CodDia1;
              QuMateriaCortadaDiaCodMateria.Value := TbHorarioDetalle.FindField('CodMateria').AsInteger;
              QuMateriaCortadaDia.Post;
              QuMateriaCortadaDia.Append;
              QuMateriaCortadaDiaCodNivel.Value := CodNivel;
              QuMateriaCortadaDiaCodEspecializacion.Value := CodEspecializacion;
              QuMateriaCortadaDiaCodParaleloId.Value := CodParaleloId;
              QuMateriaCortadaDiaCodHora.Value := CodHora;
              QuMateriaCortadaDiaCodDia.Value := CodDia;
              QuMateriaCortadaDiaCodMateria.Value := TbHorarioDetalle.FindField('CodMateria').AsInteger;
              QuMateriaCortadaDia.Post;
            end;
            CodNivel1 := CodNivel;
            CodEspecializacion1 := CodEspecializacion;
            CodParaleloId1 := CodParaleloId;
            CodDia1 := CodDia;
            CodHora1 := CodHora;
            Sesion1 := Sesion;
            TbHorarioDetalle.Next;
          end;
        finally
          QuMateriaCortadaDia.EnableControls;
        end;
      end
    finally
      TbHorarioDetalle.IndexedBy := d;
      TbHorarioDetalle.EnableControls;
    end;
  end;
end;

procedure THorarioForm.ActMateriaCortadaDiaExecute(Sender: TObject);
begin
  inherited;
  if TSingleEditorForm.ToggleSingleEditor(Self,
					  FMateriaCortadaDiaForm,
					  ConfigStorage,
					  ActMateriaCortadaDia,
					  QuMateriaCortadaDia) then
  begin;
    // QuMateriaCortadaDia.Close;
    FillMateriaCortadaDia;
  end;
end;

procedure THorarioForm.FillMateriaCortadaHora;
var
  d, h, s: string;
  CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId, CodDia,
  CodHora, CodNivel1, CodMateria1, CodEspecializacion1, CodParaleloId1,
  CodHora1, CodDia1, CodHora2: Integer;
begin
  with SourceDataModule do
  begin
    QuMateriaCortadaHora.DisableControls;
    QuMateriaCortadaHoraDetalle.DisableControls;
    TbHora.DisableControls;
    TbDia.DisableControls;
    h := TbHora.IndexedBy;
    d := TbDia.IndexedBy;
    try
      QuMateriaCortadaHora.Close;
      QuMateriaCortadaHora.Open;
      QuMateriaCortadaHoraDetalle.Close;
      QuMateriaCortadaHoraDetalle.Open;
      TbHora.IndexedBy := 'CodHora';
      TbDia.IndexedBy := 'CodDia';
      TbHora.First;
      TbPeriodo.IndexedBy := 'CodDia;CodHora';
      while not TbHora.Eof do
      begin
        TbDia.First;
        CodHora := TbHora.FindField('CodHora').AsInteger;
        while not TbDia.Eof do
        begin
          CodDia := TbDia.FindField('CodDia').AsInteger;
          if not TbPeriodo.Locate('CodDia;CodHora', VarArrayOf([CodDia, CodHora]), []) then
          begin
            QuMateriaCortadaHora.Append;
            QuMateriaCortadaHoraCodDia.Value := CodDia;
            QuMateriaCortadaHoraCodHora.Value := CodHora;
            QuMateriaCortadaHora.Post;
          end;
          TbDia.Next;
        end;
        TbHora.Next;
      end;
      QuMateriaCortadaHora.First;
      TbHorarioDetalle.DisableControls;
      s := TbHorarioDetalle.IndexedBy;
      try
        TbHorarioDetalle.IndexedBy := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
        CodHorario := TbHorario.FindField('CodHorario').AsInteger;
        if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
        begin
          CodMateria1 := TbHorarioDetalle.FindField('CodMateria').AsInteger;
          CodNivel1 := TbHorarioDetalle.FindField('CodNivel').AsInteger;
          CodEspecializacion1 := TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
          CodParaleloId1 := TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
          CodDia1 := TbHorarioDetalle.FindField('CodDia').AsInteger;
          CodHora1 := TbHorarioDetalle.FindField('CodHora').AsInteger;
          TbHorarioDetalle.Next;
          while (TbHorarioDetalle.FindField('CodHorario').AsInteger = CodHorario) and not TbHorarioDetalle.Eof do
          begin
            CodMateria := TbHorarioDetalle.FindField('CodMateria').AsInteger;
            CodNivel := TbHorarioDetalle.FindField('CodNivel').AsInteger;
            CodEspecializacion := TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
            CodParaleloId := TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
            CodDia := TbHorarioDetalle.FindField('CodDia').AsInteger;
            CodHora2 := TbHorarioDetalle.FindField('CodHora').AsInteger;
            if (CodMateria1 = CodMateria)
               and (CodNivel1 = CodNivel)
               and (CodEspecializacion1 = CodEspecializacion)
               and (CodParaleloId1 = CodParaleloId)
               and (CodDia1 = CodDia)
               and QuMateriaCortadaHora.Locate('CodDia', CodDia, []) then
            begin
              while (QuMateriaCortadaHoraCodDia.Value = CodDia) and not QuMateriaCortadaHora.Eof do
              begin
                CodHora := QuMateriaCortadaHoraCodHora.Value;
                if (CodHora1 < CodHora) and (CodHora < CodHora2) then
                begin
                  QuMateriaCortadaHoraDetalle.Append;
                  QuMateriaCortadaHoraDetalleCodMateria.Value := CodMateria;
                  QuMateriaCortadaHoraDetalleCodNivel.Value := CodNivel;
                  QuMateriaCortadaHoraDetalleCodEspecializacion.Value := CodEspecializacion;
                  QuMateriaCortadaHoraDetalleCodParaleloId.Value := CodParaleloId;
                  QuMateriaCortadaHoraDetalleCodDia.Value := CodDia;
                  QuMateriaCortadaHoraDetalleCodHora.Value := CodHora;
                  QuMateriaCortadaHoraDetalleCodHora0.Value := CodHora1;
                  QuMateriaCortadaHoraDetalle.Post;
                  QuMateriaCortadaHoraDetalle.Append;
                  QuMateriaCortadaHoraDetalleCodMateria.Value := CodMateria;
                  QuMateriaCortadaHoraDetalleCodNivel.Value := CodNivel;
                  QuMateriaCortadaHoraDetalleCodEspecializacion.Value := CodEspecializacion;
                  QuMateriaCortadaHoraDetalleCodParaleloId.Value := CodParaleloId;
                  QuMateriaCortadaHoraDetalleCodDia.Value := CodDia;
                  QuMateriaCortadaHoraDetalleCodHora.Value := CodHora;
                  QuMateriaCortadaHoraDetalleCodHora0.Value := CodHora2;
                  QuMateriaCortadaHoraDetalle.Post;
                end;
                QuMateriaCortadaHora.Next;
              end;
            end;
            CodMateria1 := CodMateria;
            CodNivel1 := CodNivel;
            CodEspecializacion1 := CodEspecializacion;
            CodParaleloId1 := CodParaleloId;
            CodDia1 := CodDia;
            CodHora1 := CodHora2;
            TbHorarioDetalle.Next;
          end;
        end;
        QuMateriaCortadaHora.First;
        while not QuMateriaCortadaHora.Eof do
        begin
          if QuMateriaCortadaHoraDetalle.RecordCount = 0 then
            QuMateriaCortadaHora.Delete
          else
            QuMateriaCortadaHora.Next;
        end;
      finally
        TbHorarioDetalle.EnableControls;
        TbHorarioDetalle.IndexedBy := s;
      end;
    finally
      QuMateriaCortadaHora.EnableControls;
      QuMateriaCortadaHoraDetalle.EnableControls;
      TbHora.IndexedBy := h;
      TbDia.IndexedBy := d;
      TbHora.EnableControls;
      TbDia.EnableControls;
    end
  end;
end;

procedure THorarioForm.ActMateriaCortadaHoraExecute(Sender: TObject);
begin
  inherited;
  with SourceDataModule, QuMateriaCortadaHora do
  begin
    if TMasterDetailEditorForm.ToggleMasterDetailEditor(Self,
                                                        FMateriaCortadaHoraForm,
                                                        ConfigStorage,
                                                        ActMateriaCortadaHora,
                                                        QuMateriaCortadaHora,
                                                        QuMateriaCortadaHoraDetalle) then
    begin
      // QuMateriaCortadaHora.Close;
      // QuMateriaCortadaHoraDetalle.Close;
      FillMateriaCortadaHora;
    end;
  end;
end;

procedure THorarioForm.ActHorarioAulaTipoExecute(Sender: TObject);
begin
  inherited;
  if THorarioAulaTipoForm.ToggleEditor(Self,
				       FHorarioAulaTipoForm,
				       ConfigStorage,
				       ActHorarioAulaTipo) then
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

procedure THorarioForm.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
                                            DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  DBGrid: TCustomDBGrid;
begin
  DBGrid := Sender as TCustomDBGrid;
  if (SourceDataModule.HorarioSeleccionado <> -1)
     and (SourceDataModule.HorarioSeleccionado
          = SourceDataModule.TbHorario.FindField('CodHorario').AsInteger) then
    Column.Color := clAqua
  else
    Column.Color := clWhite;
  DBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
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
  PrepareQuery(QuHorarioDetalle, 'HorarioDetalle',
    'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia');
  PrepareQuery(QuCruceAula, 'CruceAula', 'CodAulaTipo;CodDia;CodHora');
  PrepareQuery(QuCruceAulaDetalle, 'CruceAulaDetalle', 'CodAulaTipo;CodDia;CodHora');
  PrepareQuery(QuCruceProfesor, 'CruceProfesorInde', 'CodProfesor;CodDia;CodHora');
  PrepareQuery(QuCruceMateria, 'CruceMateria', 'CodMateria');
  //QuCruceMateria.AddIndex('QuCruceMateriaIxNomMateria', 'NomMateria', []);
  PrepareQuery(QuCruceMateriaDetalle,'CruceMateriaDetalle',
    'CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora');
  PrepareQuery(QuHorarioDetalleMateriaProhibicion,
    'HorarioDetalleMateriaProhibicion',
    'CodMateProhibicionTipo;NomMateria;CodDia;CodHora');
  {with QuHorarioDetalleMateriaProhibicion.IndexDefs.AddIndexDef do
  begin
    Name := 'QuHorarioDetalleMateriaProhibicionIndex1';
    Fields := 'CodMateProhibicionTipo;NomMateria;CodDia;CodHora';
    Options := [ixDescending];
    DescFields := 'CodMateProhibicionTipo';
  end;}
  PrepareQuery(QuMateriaCortadaHora, 'MateriaCortadaHora', 'CodDia');
  PrepareQuery(QuMateriaCortadaHoraDetalle,'MateriaCortadaHoraDetalle',
    'CodDia;CodHora');
end;

procedure THorarioForm.FormDestroy(Sender: TObject);
begin
  inherited FormDestroy(Sender);
end;

initialization
{$IFDEF FPC}
  {$i FHorario.lrs}
{$ENDIF}

end.
