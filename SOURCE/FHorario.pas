unit FHorario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, StdCtrls, DBIndex, Buttons,
  DBCtrls, ExtCtrls, RXCtrls, RXDBCtrl, kbmMemTable, ImgList, ComCtrls, ToolWin;

type
  THorarioForm = class(TSingleEditorForm)
    BtnMateriaProhibicionNoRespetada: TToolButton;
    BtnProfesorProhibicionNoRespetada: TToolButton;
    BtnHorarioParalelo: TToolButton;
    BtnProfesor: TToolButton;
    BtnCruceProfesor: TToolButton;
    BtnCruceMateria: TToolButton;
    BtnCruceAula: TToolButton;
    QuCruceAula: TkbmMemTable;
    QuCruceAulaCodDia: TIntegerField;
    QuCruceAulaCodHora: TIntegerField;
    QuCruceAulaCodAulaTipo: TIntegerField;
    QuCruceAulaAbrAulaTipo: TStringField;
    QuCruceAulaNomDia: TStringField;
    QuCruceAulaNomHora: TStringField;
    QuCruceAulaUsadas: TIntegerField;
    QuCruceAulaCruces: TIntegerField;
    QuCruceAulaDetalle: TkbmMemTable;
    QuCruceAulaDetalleCodNivel: TIntegerField;
    QuCruceAulaDetalleCodEspecializacion: TIntegerField;
    QuCruceAulaDetalleCodParaleloId: TIntegerField;
    QuCruceAulaDetalleNomMateria: TStringField;
    QuCruceAulaDetalleAbrNivel: TStringField;
    QuCruceAulaDetalleAbrEspecializacion: TStringField;
    QuCruceAulaDetalleNomParaleloId: TStringField;
    DSCruceAula: TDataSource;
    QuCruceProfesorDetalle: TkbmMemTable;
    QuCruceProfesorDetalleCodProfesor: TIntegerField;
    QuCruceProfesorDetalleCodDia: TIntegerField;
    QuCruceProfesorDetalleCodHora: TIntegerField;
    QuCruceProfesorDetalleCodNivel: TIntegerField;
    QuCruceProfesorDetalleCodEspecializacion: TIntegerField;
    QuCruceProfesorDetalleCodParaleloId: TIntegerField;
    QuCruceProfesorDetalleCodMateria: TIntegerField;
    QuCruceProfesorDetalleAbrNivel: TStringField;
    QuCruceProfesorDetalleAbrEspecializacion: TStringField;
    QuCruceProfesorDetalleNomParaleloId: TStringField;
    QuCruceProfesorDetalleNomMateria: TStringField;
    QuCruceProfesor: TkbmMemTable;
    QuCruceProfesorCodProfesor: TIntegerField;
    QuCruceProfesorCodDia: TIntegerField;
    QuCruceProfesorCodHora: TIntegerField;
    QuCruceProfesorApeProfesor: TStringField;
    QuCruceProfesorNomProfesor: TStringField;
    QuCruceProfesorNomDia: TStringField;
    QuCruceProfesorNomHora: TStringField;
    QuCruceProfesorCruces: TIntegerField;
    QuCruceMateria: TkbmMemTable;
    QuCruceMateriaCodMateria: TIntegerField;
    QuCruceMateriaNomMateria: TStringField;
    QuCruceMateriaDetalle: TkbmMemTable;
    QuHorarioDetalleMateriaProhibicion: TkbmMemTable;
    QuHorarioDetalleMateriaProhibicionNomMateria: TStringField;
    QuHorarioDetalleMateriaProhibicionCodDia: TIntegerField;
    QuHorarioDetalleMateriaProhibicionCodHora: TIntegerField;
    QuHorarioDetalleMateriaProhibicionCodMateProhibicionTipo: TIntegerField;
    QuHorarioDetalleMateriaProhibicionCodNivel: TIntegerField;
    QuHorarioDetalleMateriaProhibicionCodEspecializacion: TIntegerField;
    QuHorarioDetalleMateriaProhibicionCodParaleloId: TIntegerField;
    QuHorarioDetalleMateriaProhibicionNomDia: TStringField;
    QuHorarioDetalleMateriaProhibicionNomHora: TStringField;
    QuHorarioDetalleMateriaProhibicionNomMateProhibicionTipo: TStringField;
    QuHorarioDetalleMateriaProhibicionAbrNivel: TStringField;
    QuHorarioDetalleMateriaProhibicionAbrEspecializacion: TStringField;
    QuHorarioDetalleMateriaProhibicionNomParaleloId: TStringField;
    QuHorarioDetalleProfesorProhibicion: TkbmMemTable;
    QuHorarioDetalleProfesorProhibicionApeNomProfesor: TStringField;
    QuHorarioDetalleProfesorProhibicionNomProfesor: TStringField;
    QuHorarioDetalleProfesorProhibicionCodDia: TIntegerField;
    QuHorarioDetalleProfesorProhibicionCodHora: TIntegerField;
    QuHorarioDetalleProfesorProhibicionCodProfProhibicionTipo: TIntegerField;
    QuHorarioDetalleProfesorProhibicionCodNivel: TIntegerField;
    QuHorarioDetalleProfesorProhibicionCodEspecializacion: TIntegerField;
    QuHorarioDetalleProfesorProhibicionCodParaleloId: TIntegerField;
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
    QuMateriaCortadaDia: TkbmMemTable;
    QuMateriaCortadaDiaCodNivel: TIntegerField;
    QuMateriaCortadaDiaCodEspecializacion: TIntegerField;
    QuMateriaCortadaDiaCodParaleloId: TIntegerField;
    QuMateriaCortadaDiaCodDia: TIntegerField;
    QuMateriaCortadaDiaCodHora: TIntegerField;
    QuMateriaCortadaDiaCodMateria: TIntegerField;
    QuMateriaCortadaDiaAbrNivel: TStringField;
    QuMateriaCortadaDiaAbrEspecializacion: TStringField;
    QuMateriaCortadaDiaNomParaleloId: TStringField;
    QuMateriaCortadaDiaNomMateria: TStringField;
    QuMateriaCortadaDiaNomDia: TStringField;
    QuMateriaCortadaDiaNomHora: TStringField;
    BtnMateriaCortadaHora: TToolButton;
    QuMateriaCortadaHora: TkbmMemTable;
    QuMateriaCortadaHoraCodDia: TIntegerField;
    QuMateriaCortadaHoraCodHora: TIntegerField;
    QuMateriaCortadaHoraDetalle: TkbmMemTable;
    DSMateriaCortadaHora: TDataSource;
    BtnHorarioAulaTipo: TToolButton;
    QuCruceAulaDetalleCodDia: TIntegerField;
    QuCruceAulaDetalleCodHora: TIntegerField;
    QuCruceAulaDetalleCodAulaTipo: TIntegerField;
    QuCruceAulaCantidad: TIntegerField;
    QuMateriaCortadaHoraNomDia: TStringField;
    QuMateriaCortadaHoraNomHora: TStringField;
    QuCruceMateriaDetalleCodMateria: TIntegerField;
    QuCruceMateriaDetalleCodNivel: TIntegerField;
    QuCruceMateriaDetalleCodEspecializacion: TIntegerField;
    QuCruceMateriaDetalleCodParaleloId: TIntegerField;
    QuCruceMateriaDetalleCodDia: TIntegerField;
    QuCruceMateriaDetalleCodHora: TIntegerField;
    QuCruceMateriaDetalleAbrNivel: TStringField;
    QuCruceMateriaDetalleAbrEspecializacion: TStringField;
    QuCruceMateriaDetalleNomParaleloId: TStringField;
    QuCruceMateriaDetalleNomDia: TStringField;
    QuCruceMateriaDetalleNomHora: TStringField;
    QuMateriaCortadaHoraDetalleCodNivel: TIntegerField;
    QuMateriaCortadaHoraDetalleCodEspecializacion: TIntegerField;
    QuMateriaCortadaHoraDetalleCodParaleloId: TIntegerField;
    QuMateriaCortadaHoraDetalleCodDia: TIntegerField;
    QuMateriaCortadaHoraDetalleCodHora0: TIntegerField;
    QuMateriaCortadaHoraDetalleCodMateria: TIntegerField;
    QuMateriaCortadaHoraDetalleAbrNivel: TStringField;
    QuMateriaCortadaHoraDetalleAbrEspecializacion: TStringField;
    QuMateriaCortadaHoraDetalleNomParaleloId: TStringField;
    QuMateriaCortadaHoraDetalleNomDia: TStringField;
    QuMateriaCortadaHoraDetalleNomHora: TStringField;
    QuMateriaCortadaHoraDetalleNomMateria: TStringField;
    QuMateriaCortadaHoraDetalleCodHora: TIntegerField;
    Splitter1: TSplitter;
    procedure BtnHorarioParaleloClick(Sender: TObject);
    procedure BtnCruceProfesorClick(Sender: TObject);
    procedure BtnCruceMateriaClick(Sender: TObject);
    procedure BtnHorarioProfesorClick(Sender: TObject);
    procedure BtnMateriaProhibicionNoRespetadaClick(Sender: TObject);
    procedure BtnProfesorProhibicionNoRespetadaClick(Sender: TObject);
    procedure BtnCruceAulaClick(Sender: TObject);
    procedure QuCruceProfesorAfterScroll(DataSet: TDataSet);
    procedure QuCruceMateriaAfterScroll(DataSet: TDataSet);
    procedure BtnSeleccionarHorarioClick(Sender: TObject);
    procedure BtnMateriaCortadaDiaClick(Sender: TObject);
    procedure BtnMateriaCortadaHoraClick(Sender: TObject);
    procedure BtnHorarioAulaTipoClick(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure EdQuCruceProfesorDestroy(Sender: TObject);
    procedure EdQuCruceMateriaDestroy(Sender: TObject);
    procedure EdQuHorarioDetalleProfesorProhibicionDestroy(Sender: TObject);
    procedure EdQuHorarioDetalleMateriaProhibicionDestroy(Sender: TObject);
    procedure EdQuCruceAulaTipoDestroy(Sender: TObject);
    procedure EdQuMateriaCortadaDiaDestroy(Sender: TObject);
    procedure EdQuMateriaCortadaHoraDestroy(Sender: TObject);
    procedure FillHorarioDetalleMateriaProhibicion;
    procedure FillCruceAula;
    procedure FillCruceAulaDetalle;
    procedure FillHorarioDetalleProfesorProhibicion;
    procedure FillCruceProfesor;
    procedure FillCruceProfesorDetalle;
    procedure FillMateriaCortadaDia;
    procedure FillCruceMateria;
    procedure FillMateriaCortadaHora;
  public
    { Public declarations }
  end;

var
  HorarioForm: THorarioForm;

implementation
uses
  FCrsMMER, FHorPara, FHorAulT, DMaster, SGHCUtls, FMasDEEd, FCrsMME1, FHorProf,
  FConfig, Printers, DSource;
{$R *.DFM}

procedure THorarioForm.BtnHorarioParaleloClick(Sender: TObject);
var
  HorarioParaleloForm: THorarioParaleloForm;
begin
  inherited;
  HorarioParaleloForm := THorarioParaleloForm.Create(Self);
  with SourceDataModule, HorarioParaleloForm do
  begin
    Caption := Format('%s %d', [Description[TbHorario],
      TbHorarioCodHorario.Value]);
    LoadHints(HorarioParaleloForm, TbDia, TbHora, TbMateria);
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
    QuCruceProfesor.Close;
    QuCruceProfesor.Open;
    CodHorario := TbHorarioCodHorario.Value;
    TbHorarioDetalle.DisableControls;
    try
      d := TbHorarioDetalle.IndexFieldNames;
      TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      try
        if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
        begin
          s := TbDistributivo.IndexFieldNames;
          TbDistributivo.DisableControls;
          TbDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
          TbDistributivo.First;
          QuCruceProfesor.DisableControls;
          try
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
              if QuCruceProfesor.FindKey([CodProfesor, CodDia, CodHora]) then
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
      end;
    finally
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
    try
      d := TbHorarioDetalle.IndexFieldNames;
      TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      try
        if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
        begin
          s := TbDistributivo.IndexFieldNames;
          TbDistributivo.DisableControls;
          TbDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
          TbDistributivo.First;
          QuCruceProfesorDetalle.DisableControls;
          try
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
              if QuCruceProfesor.FindKey([CodProfesor, CodDia, CodHora]) then
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
      end;
    finally
      TbHorarioDetalle.EnableControls;
    end;
  end;
end;

procedure THorarioForm.BtnCruceProfesorClick(Sender: TObject);
var
  MasterDetailEditorForm: TMasterDetailEditorForm;
begin
  inherited;
  with SourceDataModule, MasterDataModule, QuCruceProfesor do
  begin
    FillCruceProfesor;
    FillCruceProfesorDetalle;
    First;
    BtnCruceProfesor.Enabled := false;
    MasterDetailEditorForm := TMasterDetailEditorForm.Create(Self);
    MasterDetailEditorForm.Caption := 'Cruce de Profesores';
    MyMasterDetailShowEditor(MasterDetailEditorForm, QuCruceProfesor,
      QuCruceProfesorDetalle, ConfiguracionForm.edtNomColegio.Text,
      EdQuCruceProfesorDestroy);
  end;
end;

procedure THorarioForm.EdQuCruceProfesorDestroy(Sender: TObject);
begin
  if Assigned(BtnCruceProfesor) then BtnCruceProfesor.Enabled := true;
  QuCruceProfesor.Close;
  QuCruceProfesorDetalle.Close;
end;

procedure THorarioForm.EdQuCruceAulaTipoDestroy(Sender: TObject);
begin
  if Assigned(BtnCruceAula) then BtnCruceAula.Enabled := true;
  QuCruceAula.Close;
  QuCruceAulaDetalle.Close;
end;

procedure THorarioForm.EdQuCruceMateriaDestroy(Sender: TObject);
begin
  if Assigned(BtnCruceMateria) then BtnCruceMateria.Enabled := true;
  QuCruceMateria.Close;
  QuCruceMateriaDetalle.Close;
end;

procedure THorarioForm.EdQuMateriaCortadaDiaDestroy(Sender: TObject);
begin
  if Assigned(BtnMateriaCortadaDia) then BtnMateriaCortadaDia.Enabled := true;
  QuMateriaCortadaDia.Close;
end;

procedure THorarioForm.EdQuMateriaCortadaHoraDestroy(Sender: TObject);
begin
  if Assigned(BtnMateriaCortadaHora) then BtnMateriaCortadaHora.Enabled := true;
  QuMateriaCortadaHora.Close;
  QuMateriaCortadaHoraDetalle.Close;
end;

procedure THorarioForm.EdQuHorarioDetalleMateriaProhibicionDestroy(Sender:
  TObject);
begin
  if Assigned(BtnMateriaProhibicionNoRespetada) then
    BtnMateriaProhibicionNoRespetada.Enabled := true;
  QuHorarioDetalleMateriaProhibicion.Close;
end;

procedure THorarioForm.EdQuHorarioDetalleProfesorProhibicionDestroy(Sender:
  TObject);
begin
  if Assigned(BtnProfesorProhibicionNoRespetada) then
    BtnProfesorProhibicionNoRespetada.Enabled := true;
  QuHorarioDetalleProfesorProhibicion.Close;
end;

procedure THorarioForm.BtnHorarioProfesorClick(Sender: TObject);
var
  HorarioProfesorForm: THorarioProfesorForm;
begin
  inherited;
  HorarioProfesorForm := THorarioProfesorForm.Create(Self);
  with SourceDataModule, MasterDataModule, HorarioProfesorForm do
  begin
    Caption := Format('%s %d', [Description[TbHorario],
      TbHorarioCodHorario.Value]);
    with FormStorage do
    begin
      IniSection := IniSection + '\MMEd1HorarioProfesor';
      Active := True;
      RestoreFormPlacement;
    end;
    LoadHints(HorarioProfesorForm, TbDia, TbHora, TbProfesor);
  end;
end;

procedure THorarioForm.FillCruceMateria;
var
  CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId, CodDia,
    Sesion: Integer;
  TbMemTable: TkbmMemTable;
  TbMemTableCodHorario,
    TbMemTableCodMateria,
    TbMemTableCodNivel,
    TbMemTableCodEspecializacion,
    TbMemTableCodParaleloId,
    TbMemTableCodDia,
    TbMemTableSesion: TIntegerField;
begin
  with SourceDataModule do
  begin
    QuCruceMateria.Close;
    QuCruceMateria.Open;
    QuCruceMateriaDetalle.Close;
    QuCruceMateriaDetalle.Open;
    CodHorario := TbHorarioCodHorario.Value;
    TbMemTable := TkbmMemTable.Create(nil);
    try
      TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      TbHorarioDetalle.Filtered := True;
      TbHorarioDetalle.Filter := Format('CodHorario=%d', [CodHorario]);
      try
        TbMemTable.LoadFromDataSet(TbHorarioDetalle, [mtcpoStructure]);
        TbHorarioDetalle.First;
        with TbMemTable.IndexDefs.AddIndexDef do
        begin
          Name := 'ixTmp1';
          Fields := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia';
        end;
        TbMemTableCodHorario := TbMemTable.FindField('CodHorario') as TIntegerField;
        TbMemTableCodMateria := TbMemTable.FindField('CodMateria') as TIntegerField;
        TbMemTableCodNivel := TbMemTable.FindField('CodNivel') as TIntegerField;
        TbMemTableCodEspecializacion := TbMemTable.FindField('CodEspecializacion') as TIntegerField;
        TbMemTableCodParaleloId := TbMemTable.FindField('CodParaleloId') as TIntegerField;
        TbMemTableCodDia := TbMemTable.FindField('CodDia') as TIntegerField;
        TbMemTableSesion := TbMemTable.FindField('Sesion') as TIntegerField;
        QuCruceMateria.IndexFieldNames := 'CodMateria';
        while (TbHorarioDetalleCodHorario.Value = CodHorario) and not TbHorarioDetalle.Eof do
        begin
          TbMemTable.First;
          CodMateria := TbHorarioDetalleCodMateria.Value;
          CodNivel := TbHorarioDetalleCodNivel.Value;
          CodEspecializacion := TbHorarioDetalleCodEspecializacion.Value;
          CodParaleloId := TbHorarioDetalleCodParaleloId.Value;
          CodDia := TbHorarioDetalleCodDia.Value;
          Sesion := TbHorarioDetalleSesion.Value;
          TbMemTable.FindKey([CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId, CodDia]);
          while (TbMemTableCodHorario.Value = CodHorario)
            and (TbMemTableCodMateria.Value = CodMateria)
            and (TbMemTableCodNivel.Value = CodNivel)
            and (TbMemTableCodEspecializacion.Value = CodEspecializacion)
            and (TbMemTableCodParaleloId.Value = CodParaleloId)
            and (TbMemTableCodDia.Value = CodDia)
            and not TbMemTable.Eof do
          begin
            if TbMemTableSesion.Value <> Sesion then
            begin
              if not QuCruceMateria.FindKey([CodMateria]) then
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
            TbMemTable.Next;
          end;
          TbHorarioDetalle.Next;
        end;
      finally
        TbHorarioDetalle.Filtered := False;
        TbHorarioDetalle.Filter := '';
      end;
      QuCruceMateria.IndexFieldNames := 'NomMateria';
    finally
      TbMemTable.Free;
    end;
  end;
end;

procedure THorarioForm.BtnCruceMateriaClick(Sender: TObject);
var
  MasterDetailEditorForm: TMasterDetailEditorForm;
begin
  inherited;
  with SourceDataModule, MasterDataModule, QuCruceMateria do
  begin
    FillCruceMateria;
    BtnCruceMateria.Enabled := false;
    MasterDetailEditorForm := TMasterDetailEditorForm.Create(Self);
    MasterDetailEditorForm.Caption := 'Cruce de Materias';
    MyMasterDetailShowEditor(MasterDetailEditorForm, QuCruceMateria,
      QuCruceMateriaDetalle, ConfiguracionForm.edtNomColegio.Text,
      EdQuCruceMateriaDestroy);
  end;
end;

procedure THorarioForm.FillHorarioDetalleMateriaProhibicion;
var
  CodHorario: Integer;
begin
  with SourceDataModule do
  begin
    CodHorario := TbHorarioCodHorario.Value;
    QuHorarioDetalleMateriaProhibicion.Close;
    QuHorarioDetalleMateriaProhibicion.Open;
    TbMateriaProhibicion.IndexFieldNames := 'CodMateria;CodDia;CodHora';
    TbHorarioDetalle.IndexFieldNames := 'CodHorario';
    if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
    begin
      while (TbHorarioDetalleCodHorario.Value = CodHorario) and not TbHorarioDetalle.Eof do
      begin
        if TbMateriaProhibicion.FindKey([TbHorarioDetalleCodMateria.Value,
          TbHorarioDetalleCodDia.Value, TbHorarioDetalleCodHora.Value]) then
        begin
          QuHorarioDetalleMateriaProhibicion.Append;
          QuHorarioDetalleMateriaProhibicionNomMateria.Value := TbHorarioDetalleNomMateria.Value;
          QuHorarioDetalleMateriaProhibicionCodHora.Value := TbHorarioDetalleCodHora.Value;
          QuHorarioDetalleMateriaProhibicionCodDia.Value := TbHorarioDetalleCodDia.Value;
          QuHorarioDetalleMateriaProhibicionCodMateProhibicionTipo.Value := TbMateriaProhibicionCodMateProhibicionTipo.Value;
          QuHorarioDetalleMateriaProhibicionCodNivel.Value := TbHorarioDetalleCodNivel.Value;
          QuHorarioDetalleMateriaProhibicionCodEspecializacion.Value := TbHorarioDetalleCodEspecializacion.Value;
          QuHorarioDetalleMateriaProhibicionCodParaleloId.Value := TbHorarioDetalleCodParaleloId.Value;
          QuHorarioDetalleMateriaProhibicion.Post;
        end;
        TbHorarioDetalle.Next;
      end;
    end;
  end;
end;

procedure THorarioForm.BtnMateriaProhibicionNoRespetadaClick(Sender: TObject);
var
  FSingleEditor: TSingleEditorForm;
begin
  inherited;
  with SourceDataModule, QuHorarioDetalleMateriaProhibicion do
  begin
    FillHorarioDetalleMateriaProhibicion;
    BtnMateriaProhibicionNoRespetada.Enabled := false;
    FSingleEditor := TSingleEditorForm.Create(Self);
    FSingleEditor.Caption := Description[TbMateriaProhibicion] +
      ' No Respetadas';
    MySingleShowEditor(FSingleEditor, QuHorarioDetalleMateriaProhibicion,
      ConfiguracionForm.edtNomColegio.Text, EdQuHorarioDetalleMateriaProhibicionDestroy);
  end;
end;

procedure THorarioForm.FillHorarioDetalleProfesorProhibicion;
var
  CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId: Integer;
begin
  with SourceDataModule do
  begin
    CodHorario := TbHorarioCodHorario.Value;
    QuHorarioDetalleProfesorProhibicion.Close;
    QuHorarioDetalleProfesorProhibicion.Open;
    TbProfesorProhibicion.IndexFieldNames := 'CodProfesor;CodDia;CodHora';
    TbHorarioDetalle.IndexFieldNames :=
      'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    TbDistributivo.IndexFieldNames :=
      'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
    if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
    begin
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
        if TbProfesorProhibicion.FindKey([TbDistributivoCodProfesor.Value,
          TbHorarioDetalleCodDia.Value, TbHorarioDetalleCodHora.Value]) then
        begin
          QuHorarioDetalleProfesorProhibicion.Append;
          QuHorarioDetalleProfesorProhibicionApeNomProfesor.Value := TbDistributivoApeNomProfesor.Value;
          QuHorarioDetalleProfesorProhibicionCodHora.Value := TbHorarioDetalleCodHora.Value;
          QuHorarioDetalleProfesorProhibicionCodDia.Value := TbHorarioDetalleCodDia.Value;
          QuHorarioDetalleProfesorProhibicionCodProfProhibicionTipo.Value := TbProfesorProhibicionCodProfProhibicionTipo.Value;
          QuHorarioDetalleProfesorProhibicionCodNivel.Value := TbHorarioDetalleCodNivel.Value;
          QuHorarioDetalleProfesorProhibicionCodEspecializacion.Value := TbHorarioDetalleCodEspecializacion.Value;
          QuHorarioDetalleProfesorProhibicionCodParaleloId.Value := TbHorarioDetalleCodParaleloId.Value;
          QuHorarioDetalleProfesorProhibicion.Post;
        end;
        TbHorarioDetalle.Next;
      end;
    end;
  end;
end;

procedure THorarioForm.BtnProfesorProhibicionNoRespetadaClick(Sender:
  TObject);
var
  FSingleEditor: TSingleEditorForm;
begin
  inherited;
  with SourceDataModule, QuHorarioDetalleProfesorProhibicion do
  begin
    FillHorarioDetalleProfesorProhibicion;
    BtnProfesorProhibicionNoRespetada.Enabled := false;
    FSingleEditor := TSingleEditorForm.Create(Self);
    FSingleEditor.Caption := 'Prohibiciones de profesor no respetadas';
    MySingleShowEditor(FSingleEditor,
      QuHorarioDetalleProfesorProhibicion,
      ConfiguracionForm.edtNomColegio.Text,
      EdQuHorarioDetalleProfesorProhibicionDestroy);
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
    try
      d := TbHorarioDetalle.IndexFieldNames;
      TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      try
        if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
        begin
          s := TbDistributivo.IndexFieldNames;
          TbDistributivo.DisableControls;
          TbDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
          TbDistributivo.First;
          QuCruceAula.DisableControls;
          try
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
              CodAulaTipo := TbDistributivoCodAulaTipo.Value;
              CodHora := TbHorarioDetalleCodHora.Value;
              CodDia := TbHorarioDetalleCodDia.Value;
              if QuCruceAula.FindKey([CodAulaTipo, CodDia, CodHora]) then
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
      end;
    finally
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
            if QuCruceAula.FindKey([CodAulaTipo, CodDia, CodHora]) then
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

procedure THorarioForm.BtnCruceAulaClick(Sender: TObject);
var
  MasterDetailEditorForm: TMasterDetailEditorForm;
begin
  inherited;
  with SourceDataModule, QuCruceAula do
  begin
    FillCruceAula;
    FillCruceAulaDetalle;
    Last;
    First;
    BtnCruceAula.Enabled := false;
    MasterDetailEditorForm := TMasterDetailEditorForm.Create(Self);
    MasterDetailEditorForm.Caption := 'Cruce de aulas del mismo tipo';
    MyMasterDetailShowEditor(MasterDetailEditorForm, QuCruceAula,
      QuCruceAulaDetalle, ConfiguracionForm.edtNomColegio.Text,
      EdQuCruceAulaTipoDestroy);
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

procedure THorarioForm.BtnSeleccionarHorarioClick(Sender: TObject);
begin
  inherited;
  ConfiguracionForm.lblHorarioSeleccionado.Caption :=
    SourceDataModule.TbHorarioCodHorario.AsString;
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
    QuMateriaCortadaDia.Close;
    QuMateriaCortadaDia.Open;
    TbHorarioDetalle.DisableControls;
    try
      d := TbHorarioDetalle.IndexFieldNames;
      TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      try
        if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
        begin
          CodNivel1 := TbHorarioDetalleCodNivel.Value;
          CodEspecializacion1 := TbHorarioDetalleCodEspecializacion.Value;
          CodParaleloId1 := TbHorarioDetalleCodParaleloId.Value;
          CodDia1 := TbHorarioDetalleCodDia.Value;
          CodHora1 := TbHorarioDetalleCodHora.Value;
          Sesion1 := TbHorarioDetalleSesion.Value;
          TbHorarioDetalle.Next;
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
        end
      finally
        TbHorarioDetalle.IndexFieldNames := d;
      end;
    finally
      TbHorarioDetalle.EnableControls;
    end;
  end;
end;

procedure THorarioForm.BtnMateriaCortadaDiaClick(Sender: TObject);
var
  SingleEditorForm: TSingleEditorForm;
begin
  inherited;
  with SourceDataModule, QuMateriaCortadaDia do
  begin
    FillMateriaCortadaDia;
    BtnMateriaCortadaDia.Enabled := false;
    SingleEditorForm := TSingleEditorForm.Create(Self);
    SingleEditorForm.Caption := 'Materias cortadas por el día';
    MySingleShowEditor(SingleEditorForm, QuMateriaCortadaDia,
      ConfiguracionForm.edtNomColegio.Text, EdQuMateriaCortadaDiaDestroy);
  end;
end;

procedure THorarioForm.FillMateriaCortadaHora;
var
  s: string;
  CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId, CodDia,
    CodHora, CodNivel1, CodMateria1, CodEspecializacion1, CodParaleloId1,
    CodHora1, CodDia1, CodHora2: Integer;
begin
  with SourceDataModule do
  begin
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
        if not TbPeriodo.FindKey([CodDia, CodHora]) then
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
    s := TbHorarioDetalle.IndexFieldNames;
    TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    try
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
              if (CodHora1 < CodHora)
                and (CodHora < CodHora2) then
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
      TbHorarioDetalle.IndexFieldNames := s;
    end;
  end;
end;

procedure THorarioForm.BtnMateriaCortadaHoraClick(Sender: TObject);
var
  MasterDetailEditorForm: TMasterDetailEditorForm;
begin
  inherited;
  with SourceDataModule, QuMateriaCortadaHora do
  begin
    FillMateriaCortadaHora;
    BtnMateriaCortadaHora.Enabled := false;
    MasterDetailEditorForm := TMasterDetailEditorForm.Create(Self);
    MasterDetailEditorForm.Caption := 'Materias cortadas por la hora';
    MyMasterDetailShowEditor(MasterDetailEditorForm, QuMateriaCortadaHora,
      QuMateriaCortadaHoraDetalle, ConfiguracionForm.edtNomColegio.Text,
      EdQuMateriaCortadaHoraDestroy);
  end;
end;

procedure THorarioForm.BtnHorarioAulaTipoClick(Sender: TObject);
var
  HorarioAulaTipoForm: THorarioAulaTipoForm;
begin
  inherited;
  HorarioAulaTipoForm := THorarioAulaTipoForm.Create(Self);
  with SourceDataModule, HorarioAulaTipoForm do
  begin
    Caption := Format('%s %d', [Description[TbHorario],
      TbHorarioCodHorario.Value]);
    LoadHints(HorarioAulaTipoForm, TbDia, TbHora, TbMateria);
  end;
end;

procedure THorarioForm.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  DBGrid: TCustomDBGrid;
begin
  DBGrid := Sender as TCustomDBGrid;
  if (ConfiguracionForm.lblHorarioSeleccionado.Caption <> '(Ninguno)')
    and (ConfiguracionForm.lblHorarioSeleccionado.Caption
      = SourceDataModule.TbHorarioCodHorario.AsString) then
    Column.Color := clAqua
  else
    Column.Color := clWhite;
  DBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.

