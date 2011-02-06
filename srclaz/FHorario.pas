unit FHorario;

{$I TTG.inc}

interface

uses
  LResources, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Grids, DBGrids, StdCtrls, Buttons, FEditor,
  DBCtrls, ExtCtrls, Sqlite3DS, ImgList, ComCtrls, ToolWin, FMasDeEd,
  ActnList, FHorProf, FHorAulT, FHorPara;

type
  THorarioForm = class(TSingleEditorForm)
    BtnMateriaProhibicionNoRespetada: TToolButton;
    BtnProfesorProhibicionNoRespetada: TToolButton;
    BtnHorarioParalelo: TToolButton;
    BtnHorarioProfesor: TToolButton;
    BtnCruceProfesor: TToolButton;
    BtnCruceMateria: TToolButton;
    BtnCruceAula: TToolButton;
    QuHorarioDetalle: TSqlite3Dataset;
    QuHorarioDetalleCodHorario: TLongIntField;
    QuHorarioDetalleCodMateria: TLongIntField;
    QuHorarioDetalleCodNivel: TLongIntField;
    QuHorarioDetalleCodEspecializacion: TLongIntField;
    QuHorarioDetalleCodParaleloId: TLongIntField;
    QuHorarioDetalleCodDia: TLongIntField;
    QuHorarioDetalleCodHora: TLongIntField;
    QuHorarioDetalleSesion: TLongIntField;
    QuCruceAula: TSqlite3Dataset;
    QuCruceAulaCodDia: TLongIntField;
    QuCruceAulaCodHora: TLongIntField;
    QuCruceAulaCodAulaTipo: TLongIntField;
    QuCruceAulaAbrAulaTipo: TStringField;
    QuCruceAulaNomDia: TStringField;
    QuCruceAulaNomHora: TStringField;
    QuCruceAulaUsadas: TLongIntField;
    QuCruceAulaCruces: TLongIntField;
    QuCruceAulaDetalle: TSqlite3Dataset;
    QuCruceAulaDetalleCodNivel: TLongIntField;
    QuCruceAulaDetalleCodEspecializacion: TLongIntField;
    QuCruceAulaDetalleCodParaleloId: TLongIntField;
    QuCruceAulaDetalleNomMateria: TStringField;
    QuCruceAulaDetalleAbrNivel: TStringField;
    QuCruceAulaDetalleAbrEspecializacion: TStringField;
    QuCruceAulaDetalleNomParaleloId: TStringField;
    DSCruceAula: TDataSource;
    QuCruceProfesorDetalle: TSqlite3Dataset;
    QuCruceProfesorDetalleCodProfesor: TLongIntField;
    QuCruceProfesorDetalleCodDia: TLongIntField;
    QuCruceProfesorDetalleCodHora: TLongIntField;
    QuCruceProfesorDetalleCodNivel: TLongIntField;
    QuCruceProfesorDetalleCodEspecializacion: TLongIntField;
    QuCruceProfesorDetalleCodParaleloId: TLongIntField;
    QuCruceProfesorDetalleCodMateria: TLongIntField;
    QuCruceProfesorDetalleAbrNivel: TStringField;
    QuCruceProfesorDetalleAbrEspecializacion: TStringField;
    QuCruceProfesorDetalleNomParaleloId: TStringField;
    QuCruceProfesorDetalleNomMateria: TStringField;
    QuCruceProfesor: TSqlite3Dataset;
    QuCruceProfesorCodProfesor: TLongIntField;
    QuCruceProfesorCodDia: TLongIntField;
    QuCruceProfesorCodHora: TLongIntField;
    QuCruceProfesorApeProfesor: TStringField;
    QuCruceProfesorNomProfesor: TStringField;
    QuCruceProfesorNomDia: TStringField;
    QuCruceProfesorNomHora: TStringField;
    QuCruceProfesorCruces: TLongIntField;
    QuCruceMateria: TSqlite3Dataset;
    QuCruceMateriaCodMateria: TLongIntField;
    QuCruceMateriaNomMateria: TStringField;
    QuCruceMateriaDetalle: TSqlite3Dataset;
    QuHorarioDetalleMateriaProhibicion: TSqlite3Dataset;
    QuHorarioDetalleMateriaProhibicionNomMateria: TStringField;
    QuHorarioDetalleMateriaProhibicionCodDia: TLongIntField;
    QuHorarioDetalleMateriaProhibicionCodHora: TLongIntField;
    QuHorarioDetalleMateriaProhibicionCodMateProhibicionTipo: TLongIntField;
    QuHorarioDetalleMateriaProhibicionCodNivel: TLongIntField;
    QuHorarioDetalleMateriaProhibicionCodEspecializacion: TLongIntField;
    QuHorarioDetalleMateriaProhibicionCodParaleloId: TLongIntField;
    QuHorarioDetalleMateriaProhibicionNomDia: TStringField;
    QuHorarioDetalleMateriaProhibicionNomHora: TStringField;
    QuHorarioDetalleMateriaProhibicionNomMateProhibicionTipo: TStringField;
    QuHorarioDetalleMateriaProhibicionAbrNivel: TStringField;
    QuHorarioDetalleMateriaProhibicionAbrEspecializacion: TStringField;
    QuHorarioDetalleMateriaProhibicionNomParaleloId: TStringField;
    QuHorarioDetalleProfesorProhibicion: TSqlite3Dataset;
    QuHorarioDetalleProfesorProhibicionApeNomProfesor: TStringField;
    QuHorarioDetalleProfesorProhibicionCodDia: TLongIntField;
    QuHorarioDetalleProfesorProhibicionCodHora: TLongIntField;
    QuHorarioDetalleProfesorProhibicionCodProfProhibicionTipo: TLongIntField;
    QuHorarioDetalleProfesorProhibicionCodNivel: TLongIntField;
    QuHorarioDetalleProfesorProhibicionCodEspecializacion: TLongIntField;
    QuHorarioDetalleProfesorProhibicionCodParaleloId: TLongIntField;
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
    QuMateriaCortadaDia: TSqlite3Dataset;
    QuMateriaCortadaDiaCodNivel: TLongIntField;
    QuMateriaCortadaDiaCodEspecializacion: TLongIntField;
    QuMateriaCortadaDiaCodParaleloId: TLongIntField;
    QuMateriaCortadaDiaCodDia: TLongIntField;
    QuMateriaCortadaDiaCodHora: TLongIntField;
    QuMateriaCortadaDiaCodMateria: TLongIntField;
    QuMateriaCortadaDiaAbrNivel: TStringField;
    QuMateriaCortadaDiaAbrEspecializacion: TStringField;
    QuMateriaCortadaDiaNomParaleloId: TStringField;
    QuMateriaCortadaDiaNomMateria: TStringField;
    QuMateriaCortadaDiaNomDia: TStringField;
    QuMateriaCortadaDiaNomHora: TStringField;
    BtnMateriaCortadaHora: TToolButton;
    QuMateriaCortadaHora: TSqlite3Dataset;
    QuMateriaCortadaHoraCodDia: TLongIntField;
    QuMateriaCortadaHoraCodHora: TLongIntField;
    QuMateriaCortadaHoraDetalle: TSqlite3Dataset;
    DSMateriaCortadaHora: TDataSource;
    BtnHorarioAulaTipo: TToolButton;
    QuCruceAulaDetalleCodDia: TLongIntField;
    QuCruceAulaDetalleCodHora: TLongIntField;
    QuCruceAulaDetalleCodAulaTipo: TLongIntField;
    QuCruceAulaCantidad: TLongIntField;
    QuMateriaCortadaHoraNomDia: TStringField;
    QuMateriaCortadaHoraNomHora: TStringField;
    QuCruceMateriaDetalleCodMateria: TLongIntField;
    QuCruceMateriaDetalleCodNivel: TLongIntField;
    QuCruceMateriaDetalleCodEspecializacion: TLongIntField;
    QuCruceMateriaDetalleCodParaleloId: TLongIntField;
    QuCruceMateriaDetalleCodDia: TLongIntField;
    QuCruceMateriaDetalleCodHora: TLongIntField;
    QuCruceMateriaDetalleAbrNivel: TStringField;
    QuCruceMateriaDetalleAbrEspecializacion: TStringField;
    QuCruceMateriaDetalleNomParaleloId: TStringField;
    QuCruceMateriaDetalleNomDia: TStringField;
    QuCruceMateriaDetalleNomHora: TStringField;
    QuMateriaCortadaHoraDetalleCodNivel: TLongIntField;
    QuMateriaCortadaHoraDetalleCodEspecializacion: TLongIntField;
    QuMateriaCortadaHoraDetalleCodParaleloId: TLongIntField;
    QuMateriaCortadaHoraDetalleCodDia: TLongIntField;
    QuMateriaCortadaHoraDetalleCodHora0: TLongIntField;
    QuMateriaCortadaHoraDetalleCodMateria: TLongIntField;
    QuMateriaCortadaHoraDetalleAbrNivel: TStringField;
    QuMateriaCortadaHoraDetalleAbrEspecializacion: TStringField;
    QuMateriaCortadaHoraDetalleNomParaleloId: TStringField;
    QuMateriaCortadaHoraDetalleNomDia: TStringField;
    QuMateriaCortadaHoraDetalleNomHora: TStringField;
    QuMateriaCortadaHoraDetalleNomMateria: TStringField;
    QuMateriaCortadaHoraDetalleCodHora: TLongIntField;
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
    QuHorarioDetalleProfesorProhibicionCodProfesor: TLongIntField;
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
    CodHorario := TbHorarioCodHorario.Value;
    TbHorarioDetalle.DisableControls;
    d := TbHorarioDetalle.IndexFieldNames;
    try
      TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        QuCruceProfesor.DisableControls;
        TbDistributivo.DisableControls;
        s := TbDistributivo.IndexFieldNames;
        try
          TbDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
          TbDistributivo.First;
          QuCruceProfesor.Close;
          QuCruceProfesor.Open;
          while (TbHorarioDetalleCodHorario.Value = CodHorario) and not TbHorarioDetalle.Eof do
          begin
            CodMateria := TbHorarioDetalleCodMateria.Value;
            CodNivel := TbHorarioDetalleCodNivel.Value;
            CodEspecializacion := TbHorarioDetalleCodEspecializacion.Value;
            CodParaleloId := TbHorarioDetalleCodParaleloId.Value;
            while ((TbDistributivoCodMateria.Value <> CodMateria)
              or (TbDistributivoCodNivel.Value <> CodNivel)
              or (TbDistributivoCodEspecializacion.Value <> CodEspecializacion)
              or (TbDistributivoCodParaleloId.Value <> CodParaleloId))
              and not TbDistributivo.Eof do
              TbDistributivo.Next;
            CodProfesor := TbDistributivoCodProfesor.Value;
            CodDia := TbHorarioDetalleCodDia.Value;
            CodHora := TbHorarioDetalleCodHora.Value;
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
          TbDistributivo.IndexFieldNames := s;
          TbDistributivo.EnableControls;
          QuCruceProfesor.EnableControls;
        end;
      end;
    finally
      TbHorarioDetalle.IndexFieldNames := d;
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
    CodHorario := TbHorarioCodHorario.Value;
    TbHorarioDetalle.DisableControls;
    d := TbHorarioDetalle.IndexFieldNames;
    try
      TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        s := TbDistributivo.IndexFieldNames;
        TbDistributivo.DisableControls;
        QuCruceProfesorDetalle.DisableControls;
        try
          TbDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
          TbDistributivo.First;
          while (TbHorarioDetalleCodHorario.Value = CodHorario) and not TbHorarioDetalle.Eof do
          begin
            CodMateria := TbHorarioDetalleCodMateria.Value;
            CodNivel := TbHorarioDetalleCodNivel.Value;
            CodEspecializacion := TbHorarioDetalleCodEspecializacion.Value;
            CodParaleloId := TbHorarioDetalleCodParaleloId.Value;
            while ((TbDistributivoCodMateria.Value <> CodMateria)
		   or (TbDistributivoCodNivel.Value <> CodNivel)
		   or (TbDistributivoCodEspecializacion.Value <> CodEspecializacion)
		   or (TbDistributivoCodParaleloId.Value <> CodParaleloId))
                  and not TbDistributivo.Eof do
              TbDistributivo.Next;
            CodProfesor := TbDistributivoCodProfesor.Value;
            CodHora := TbHorarioDetalleCodHora.Value;
            CodDia := TbHorarioDetalleCodDia.Value;
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
              QuCruceProfesorDetalleCodMateria.Value := TbHorarioDetalleCodMateria.Value;
              QuCruceProfesorDetalle.Post;
            end;
            TbHorarioDetalle.Next;
	  end;
        finally
          TbDistributivo.IndexFieldNames := s;
          TbDistributivo.EnableControls;
          QuCruceProfesorDetalle.EnableControls;
        end;
      end;
    finally
      TbHorarioDetalle.IndexFieldNames := d;
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
    CodHorario := TbHorarioCodHorario.Value;
    TbHorarioDetalle.DisableControls;
    s := TbHorarioDetalle.IndexFieldNames;
    try
      TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      TbHorarioDetalle.Filtered := True;
      TbHorarioDetalle.Filter := Format('CodHorario=%d', [CodHorario]);
      LoadDataSetFromDataSet(QuHorarioDetalle, TbHorarioDetalle);
      TbHorarioDetalle.First;
      QuCruceMateria.IndexFieldNames := 'CodMateria';
      while (TbHorarioDetalleCodHorario.Value = CodHorario) and not TbHorarioDetalle.Eof do
      begin
        QuHorarioDetalle.First;
        CodMateria := TbHorarioDetalleCodMateria.Value;
        CodNivel := TbHorarioDetalleCodNivel.Value;
        CodEspecializacion := TbHorarioDetalleCodEspecializacion.Value;
        CodParaleloId := TbHorarioDetalleCodParaleloId.Value;
        CodDia := TbHorarioDetalleCodDia.Value;
        Sesion := TbHorarioDetalleSesion.Value;
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
              QuCruceMateriaCodMateria.Value := TbHorarioDetalleCodMateria.Value;
              QuCruceMateriaNomMateria.Value := TbHorarioDetalleNomMateria.Value;
              QuCruceMateria.Post;
            end;
            QuCruceMateriaDetalle.Append;
            QuCruceMateriaDetalleCodMateria.Value := CodMateria;
            QuCruceMateriaDetalleCodNivel.Value := TbHorarioDetalleCodNivel.Value;
            QuCruceMateriaDetalleCodEspecializacion.Value := TbHorarioDetalleCodEspecializacion.Value;
            QuCruceMateriaDetalleCodParaleloId.Value := TbHorarioDetalleCodParaleloId.Value;
            QuCruceMateriaDetalleCodDia.Value := TbHorarioDetalleCodDia.Value;
            QuCruceMateriaDetalleCodHora.Value := TbHorarioDetalleCodHora.Value;
            QuCruceMateriaDetalle.Post;
          end;
          QuHorarioDetalle.Next;
        end;
        TbHorarioDetalle.Next;
      end;
    finally
      TbHorarioDetalle.Filtered := False;
      TbHorarioDetalle.Filter := '';
      TbHorarioDetalle.IndexFieldNames := s;
      TbHorarioDetalle.EnableControls;
    end;
    QuCruceMateria.IndexFieldNames := 'NomMateria';
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
    CodHorario := TbHorarioCodHorario.Value;
    TbHorarioDetalle.DisableControls;
    d := TbHorarioDetalle.IndexFieldNames;
    try
      TbHorarioDetalle.IndexFieldNames := 'CodHorario';
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        TbMateriaProhibicion.DisableControls;
        s := TbMateriaProhibicion.IndexFieldNames;
        try
          TbMateriaProhibicion.IndexFieldNames := 'CodMateria;CodDia;CodHora';
          QuHorarioDetalleMateriaProhibicion.Close;
          QuHorarioDetalleMateriaProhibicion.Open;
          QuHorarioDetalleMateriaProhibicion.DisableControls;
          try
          while (TbHorarioDetalleCodHorario.Value = CodHorario)
      	    and not TbHorarioDetalle.Eof do
          begin
            if TbMateriaProhibicion.Locate('CodMateria;CodDia;CodHora',
                                           VarArrayOf([TbHorarioDetalleCodMateria.Value,
              TbHorarioDetalleCodDia.Value, TbHorarioDetalleCodHora.Value]), []) then
            begin
              QuHorarioDetalleMateriaProhibicion.Append;
              QuHorarioDetalleMateriaProhibicionNomMateria.Value :=
                TbHorarioDetalleNomMateria.Value;
              QuHorarioDetalleMateriaProhibicionCodHora.Value :=
                TbHorarioDetalleCodHora.Value;
              QuHorarioDetalleMateriaProhibicionCodDia.Value :=
                TbHorarioDetalleCodDia.Value;
              QuHorarioDetalleMateriaProhibicionCodMateProhibicionTipo.Value :=
                TbMateriaProhibicionCodMateProhibicionTipo.Value;
              QuHorarioDetalleMateriaProhibicionCodNivel.Value :=
                TbHorarioDetalleCodNivel.Value;
              QuHorarioDetalleMateriaProhibicionCodEspecializacion.Value :=
                TbHorarioDetalleCodEspecializacion.Value;
              QuHorarioDetalleMateriaProhibicionCodParaleloId.Value :=
                TbHorarioDetalleCodParaleloId.Value;
              QuHorarioDetalleMateriaProhibicion.Post;
            end;
            TbHorarioDetalle.Next;
          end;
          finally
            QuHorarioDetalleMateriaProhibicion.EnableControls;
          end;
        finally
          TbMateriaProhibicion.IndexFieldNames := s;
          TbMateriaProhibicion.EnableControls;
        end;
      end;
    finally
      s := TbMateriaProhibicion.IndexFieldNames;
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
    CodHorario := TbHorarioCodHorario.Value;
    TbHorarioDetalle.DisableControls; 
    r := TbHorarioDetalle.IndexFieldNames;
    try
      TbHorarioDetalle.IndexFieldNames :=
        'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        TbDistributivo.DisableControls;
        s := TbDistributivo.IndexFieldNames;
        TbProfesorProhibicion.DisableControls;
        d := TbProfesorProhibicion.IndexFieldNames;
        QuHorarioDetalleProfesorProhibicion.DisableControls;
        try
          QuHorarioDetalleProfesorProhibicion.Close;
          QuHorarioDetalleProfesorProhibicion.Open;
          TbProfesorProhibicion.IndexFieldNames := 'CodProfesor;CodDia;CodHora';
          TbDistributivo.IndexFieldNames :=
            'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
          TbDistributivo.First;
          while (TbHorarioDetalleCodHorario.Value = CodHorario)
                and not TbHorarioDetalle.Eof do
          begin
            CodMateria := TbHorarioDetalleCodMateria.Value;
            CodNivel := TbHorarioDetalleCodNivel.Value;
            CodEspecializacion := TbHorarioDetalleCodEspecializacion.Value;
            CodParaleloId := TbHorarioDetalleCodParaleloId.Value;
            while ((TbDistributivoCodMateria.Value <> CodMateria)
                   or (TbDistributivoCodNivel.Value <> CodNivel)
                   or (TbDistributivoCodEspecializacion.Value <> CodEspecializacion)
                   or (TbDistributivoCodParaleloId.Value <> CodParaleloId))
                  and not TbDistributivo.Eof do
              TbDistributivo.Next;
            if TbProfesorProhibicion.Locate('CodProfesor;CodDia;CodHora',
                                            VarArrayOf([TbDistributivoCodProfesor.Value,
                                                        TbHorarioDetalleCodDia.Value,
                                                        TbHorarioDetalleCodHora.Value]), []) then
            begin
              QuHorarioDetalleProfesorProhibicion.Append;
              QuHorarioDetalleProfesorProhibicionCodProfesor.Value :=
                TbDistributivoCodProfesor.Value;
              QuHorarioDetalleProfesorProhibicionCodHora.Value :=
                TbHorarioDetalleCodHora.Value;
              QuHorarioDetalleProfesorProhibicionCodDia.Value :=
                TbHorarioDetalleCodDia.Value;
              QuHorarioDetalleProfesorProhibicionCodProfProhibicionTipo.Value :=
                TbProfesorProhibicionCodProfProhibicionTipo.Value;
              QuHorarioDetalleProfesorProhibicionCodNivel.Value :=
                TbHorarioDetalleCodNivel.Value;
              QuHorarioDetalleProfesorProhibicionCodEspecializacion.Value :=
                TbHorarioDetalleCodEspecializacion.Value;
              QuHorarioDetalleProfesorProhibicionCodParaleloId.Value :=
                TbHorarioDetalleCodParaleloId.Value;
              QuHorarioDetalleProfesorProhibicion.Post;
            end;
            TbHorarioDetalle.Next;
          end;
        finally
          TbDistributivo.IndexFieldNames := s;
          TbProfesorProhibicion.IndexFieldNames := d;
          TbDistributivo.EnableControls;
          TbProfesorProhibicion.EnableControls;
          QuHorarioDetalleProfesorProhibicion.EnableControls;
        end;
      end;
    finally
      TbHorarioDetalle.IndexFieldNames := r;
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
    CodHorario := TbHorarioCodHorario.Value;
    TbHorarioDetalle.DisableControls;
    d := TbHorarioDetalle.IndexFieldNames;
    try
      TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      TbHorarioDetalle.First;
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        TbDistributivo.DisableControls;
        s := TbDistributivo.IndexFieldNames;
        TbDistributivo.IndexFieldNames :=
          'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
        TbDistributivo.First;
        QuCruceAula.DisableControls;
        try
          while (TbHorarioDetalleCodHorario.Value = CodHorario)
                and not TbHorarioDetalle.Eof do
          begin
            CodMateria := TbHorarioDetalleCodMateria.Value;
            CodNivel := TbHorarioDetalleCodNivel.Value;
            CodEspecializacion := TbHorarioDetalleCodEspecializacion.Value;
            CodParaleloId := TbHorarioDetalleCodParaleloId.Value;
            while ((TbDistributivoCodMateria.Value <> CodMateria)
                   or (TbDistributivoCodNivel.Value <> CodNivel)
                   or (TbDistributivoCodEspecializacion.Value <> CodEspecializacion)
                   or (TbDistributivoCodParaleloId.Value <> CodParaleloId))
                  and not TbDistributivo.Eof do
              TbDistributivo.Next;
            CodAulaTipo := TbDistributivoCodAulaTipo.Value;
            CodHora := TbHorarioDetalleCodHora.Value;
            CodDia := TbHorarioDetalleCodDia.Value;
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
          TbDistributivo.IndexFieldNames := s;
          TbDistributivo.EnableControls;
          QuCruceAula.EnableControls;
        end;
      end;
    finally
      TbHorarioDetalle.IndexFieldNames := d;
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
    CodHorario := TbHorarioCodHorario.Value;
    d := TbHorarioDetalle.IndexFieldNames;
    TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    QuCruceAulaDetalle.DisableControls;
    QuCruceAulaDetalle.EnableIndexes := False;
    try
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        s := TbDistributivo.IndexFieldNames;
        try
          TbDistributivo.DisableControls;
          TbDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion';
          TbDistributivo.First;
          while (TbHorarioDetalleCodHorario.Value = CodHorario) and not TbHorarioDetalle.Eof do
          begin
            CodMateria := TbHorarioDetalleCodMateria.Value;
            CodNivel := TbHorarioDetalleCodNivel.Value;
            CodEspecializacion := TbHorarioDetalleCodEspecializacion.Value;
            while ((TbDistributivoCodMateria.Value <> CodMateria)
                   or (TbDistributivoCodNivel.Value <> CodNivel)
                   or (TbDistributivoCodEspecializacion.Value <> CodEspecializacion))
                  and not TbDistributivo.Eof do
              TbDistributivo.Next;
            CodAulaTipo := TbDistributivoCodAulaTipo.Value;
            CodHora := TbHorarioDetalleCodHora.Value;
            CodDia := TbHorarioDetalleCodDia.Value;
            if QuCruceAula.Locate('CodAulaTipo;CodDia;CodHora',
                                  VarArrayOf([CodAulaTipo, CodDia, CodHora]), []) then
            begin
              QuCruceAulaDetalle.Append;
              QuCruceAulaDetalleCodAulaTipo.Value := CodAulaTipo;
              QuCruceAulaDetalleCodDia.Value := CodDia;
              QuCruceAulaDetalleCodHora.Value := CodHora;
              QuCruceAulaDetalleCodNivel.Value := TbHorarioDetalleCodNivel.Value;
              QuCruceAulaDetalleCodEspecializacion.Value := TbHorarioDetalleCodEspecializacion.Value;
              QuCruceAulaDetalleCodParaleloId.Value := TbHorarioDetalleCodParaleloId.Value;
              QuCruceAulaDetalleNomMateria.Value := TbHorarioDetalleNomMateria.Value;
              QuCruceAulaDetalle.Post;
            end;
            TbHorarioDetalle.Next;
          end;
        finally
          TbDistributivo.IndexFieldNames := s;
          TbDistributivo.EnableControls;
        end;
      end;
    finally
      TbHorarioDetalle.IndexFieldNames := d;
      QuCruceAulaDetalle.EnableIndexes := True;
      QuCruceAulaDetalle.UpdateIndexes;
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
    CodHorario := TbHorarioCodHorario.Value;
    TbHorarioDetalle.DisableControls;
    d := TbHorarioDetalle.IndexFieldNames;
    try
      TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        CodNivel1 := TbHorarioDetalleCodNivel.Value;
        CodEspecializacion1 := TbHorarioDetalleCodEspecializacion.Value;
        CodParaleloId1 := TbHorarioDetalleCodParaleloId.Value;
        CodDia1 := TbHorarioDetalleCodDia.Value;
        CodHora1 := TbHorarioDetalleCodHora.Value;
        Sesion1 := TbHorarioDetalleSesion.Value;
        TbHorarioDetalle.Next;
        QuMateriaCortadaDia.Close;
        QuMateriaCortadaDia.Open;
        QuMateriaCortadaDia.DisableControls;
        try
          while (TbHorarioDetalleCodHorario.Value = CodHorario) and not TbHorarioDetalle.Eof do
          begin
            CodNivel := TbHorarioDetalleCodNivel.Value;
            CodEspecializacion := TbHorarioDetalleCodEspecializacion.Value;
            CodParaleloId := TbHorarioDetalleCodParaleloId.Value;
            CodDia := TbHorarioDetalleCodDia.Value;
            CodHora := TbHorarioDetalleCodHora.Value;
            Sesion := TbHorarioDetalleSesion.Value;
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
              QuMateriaCortadaDiaCodMateria.Value := TbHorarioDetalleCodMateria.Value;
              QuMateriaCortadaDia.Post;
              QuMateriaCortadaDia.Append;
              QuMateriaCortadaDiaCodNivel.Value := CodNivel;
              QuMateriaCortadaDiaCodEspecializacion.Value := CodEspecializacion;
              QuMateriaCortadaDiaCodParaleloId.Value := CodParaleloId;
              QuMateriaCortadaDiaCodHora.Value := CodHora;
              QuMateriaCortadaDiaCodDia.Value := CodDia;
              QuMateriaCortadaDiaCodMateria.Value := TbHorarioDetalleCodMateria.Value;
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
      TbHorarioDetalle.IndexFieldNames := d;
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
    h := TbHora.IndexFieldNames;
    d := TbDia.IndexFieldNames;
    try
      QuMateriaCortadaHora.Close;
      QuMateriaCortadaHora.Open;
      QuMateriaCortadaHoraDetalle.Close;
      QuMateriaCortadaHoraDetalle.Open;
      TbHora.IndexFieldNames := 'CodHora';
      TbDia.IndexFieldNames := 'CodDia';
      TbHora.First;
      TbPeriodo.IndexFieldNames := 'CodDia;CodHora';
      while not TbHora.Eof do
      begin
        TbDia.First;
        CodHora := TbHoraCodHora.Value;
        while not TbDia.Eof do
        begin
          CodDia := TbDiaCodDia.Value;
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
      s := TbHorarioDetalle.IndexFieldNames;
      try
        TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
        CodHorario := TbHorarioCodHorario.Value;
        if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
        begin
          CodMateria1 := TbHorarioDetalleCodMateria.Value;
          CodNivel1 := TbHorarioDetalleCodNivel.Value;
          CodEspecializacion1 := TbHorarioDetalleCodEspecializacion.Value;
          CodParaleloId1 := TbHorarioDetalleCodParaleloId.Value;
          CodDia1 := TbHorarioDetalleCodDia.Value;
          CodHora1 := TbHorarioDetalleCodHora.Value;
          TbHorarioDetalle.Next;
          while (TbHorarioDetalleCodHorario.Value = CodHorario) and not TbHorarioDetalle.Eof do
          begin
            CodMateria := TbHorarioDetalleCodMateria.Value;
            CodNivel := TbHorarioDetalleCodNivel.Value;
            CodEspecializacion := TbHorarioDetalleCodEspecializacion.Value;
            CodParaleloId := TbHorarioDetalleCodParaleloId.Value;
            CodDia := TbHorarioDetalleCodDia.Value;
            CodHora2 := TbHorarioDetalleCodHora.Value;
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
        TbHorarioDetalle.IndexFieldNames := s;
      end;
    finally
      QuMateriaCortadaHora.EnableControls;
      QuMateriaCortadaHoraDetalle.EnableControls;
      TbHora.IndexFieldNames := h;
      TbDia.IndexFieldNames := d;
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

procedure THorarioForm.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
                                            DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  DBGrid: TCustomDBGrid;
begin
  DBGrid := Sender as TCustomDBGrid;
  if (SourceDataModule.HorarioSeleccionado <> -1)
     and (SourceDataModule.HorarioSeleccionado
          = SourceDataModule.TbHorarioCodHorario.Value) then
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

procedure THorarioForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuHorarioDetalle.AddIndex('QuHorarioDetalleIndex1',
                            'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia', []);
  QuCruceAula.AddIndex('QuCruceAulaIndex1', 'CodAulaTipo;CodDia;CodHora', []);
  QuCruceAulaDetalle.AddIndex('QuCruceAulaDetalleIndex1', 'CodAulaTipo;CodDia;CodHora', []);
  QuCruceProfesor.AddIndex('QuCruceProfesorIndex1', 'CodProfesor;CodDia;CodHora', []);
  QuCruceMateria.AddIndex('QuCruceMateriaIxCodMateria', 'CodMateria', []);
  QuCruceMateria.AddIndex('QuCruceMateriaIxNomMateria', 'NomMateria', []);
  QuCruceMateriaDetalle.AddIndex('QuCruceMateriaDetalleIndex1',
                                 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora', []);
  {$IFDEF FPC}
  QuHorarioDetalleMateriaProhibicion.AddIndex('QuHorarioDetalleMateriaProhibicionIndex1',
                                              'CodMateProhibicionTipo;NomMateria;CodDia;CodHora',
                                              [ixDescending],
                                              'CodMateProhibicionTipo');
  {$ELSE}
  with QuHorarioDetalleMateriaProhibicion.IndexDefs.AddIndexDef do
  begin
    Name := 'QuHorarioDetalleMateriaProhibicionIndex1';
    Fields := 'CodMateProhibicionTipo;NomMateria;CodDia;CodHora';
    Options := [ixDescending];
     DescFields := 'CodMateProhibicionTipo';
  end;
  {$ENDIF}
  QuMateriaCortadaHora.AddIndex('QuMateriaCortadaHoraIxCodDia', 'CodDia', []);
  QuMateriaCortadaHoraDetalle.AddIndex('QuMateriaCortadaHoraDetalleIxCodDia', 'CodDia;CodHora;CodHora0', []);
end;

initialization
{$IFDEF FPC}
  {$i FHorario.lrs}
{$ENDIF}

end.
