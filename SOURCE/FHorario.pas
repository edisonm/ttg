unit FHorario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, StdCtrls, DBIndex, Buttons,
  DBCtrls, ExtCtrls, kbmMemTable, ImgList, ComCtrls, ToolWin;
(*
  FormStorage:
   Panel2.Width
*)

type
  THorarioForm = class(TSingleEditorForm)
    btn97MateriaProhibicionNoRespetada: TToolButton;
    btn97ProfesorProhibicionNoRespetada: TToolButton;
    btn97HorarioParalelo: TToolButton;
    btn97Profesor: TToolButton;
    btn97CruceProfesor: TToolButton;
    btn97CruceMateria: TToolButton;
    btn97CruceAula: TToolButton;
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
    dsCruceAula: TDataSource;
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
    RxQuHorarioDetalleMateriaProhibicion: TkbmMemTable;
    RxQuHorarioDetalleMateriaProhibicionNomMateria: TStringField;
    RxQuHorarioDetalleMateriaProhibicionCodDia: TIntegerField;
    RxQuHorarioDetalleMateriaProhibicionCodHora: TIntegerField;
    RxQuHorarioDetalleMateriaProhibicionCodMateProhibicionTipo: TIntegerField;
    RxQuHorarioDetalleMateriaProhibicionCodNivel: TIntegerField;
    RxQuHorarioDetalleMateriaProhibicionCodEspecializacion: TIntegerField;
    RxQuHorarioDetalleMateriaProhibicionCodParaleloId: TIntegerField;
    RxQuHorarioDetalleMateriaProhibicionNomDia: TStringField;
    RxQuHorarioDetalleMateriaProhibicionNomHora: TStringField;
    RxQuHorarioDetalleMateriaProhibicionNomMateProhibicionTipo: TStringField;
    RxQuHorarioDetalleMateriaProhibicionAbrNivel: TStringField;
    RxQuHorarioDetalleMateriaProhibicionAbrEspecializacion: TStringField;
    RxQuHorarioDetalleMateriaProhibicionNomParaleloId: TStringField;
    RxQuHorarioDetalleProfesorProhibicion: TkbmMemTable;
    RxQuHorarioDetalleProfesorProhibicionApeNomProfesor: TStringField;
    RxQuHorarioDetalleProfesorProhibicionNomProfesor: TStringField;
    RxQuHorarioDetalleProfesorProhibicionCodDia: TIntegerField;
    RxQuHorarioDetalleProfesorProhibicionCodHora: TIntegerField;
    RxQuHorarioDetalleProfesorProhibicionCodProfProhibicionTipo: TIntegerField;
    RxQuHorarioDetalleProfesorProhibicionCodNivel: TIntegerField;
    RxQuHorarioDetalleProfesorProhibicionCodEspecializacion: TIntegerField;
    RxQuHorarioDetalleProfesorProhibicionCodParaleloId: TIntegerField;
    RxQuHorarioDetalleProfesorProhibicionNomProfProhibicionTipo: TStringField;
    RxQuHorarioDetalleProfesorProhibicionNomNivel: TStringField;
    RxQuHorarioDetalleProfesorProhibicionNomEspecializacion: TStringField;
    RxQuHorarioDetalleProfesorProhibicionNomParaleloId: TStringField;
    RxQuHorarioDetalleProfesorProhibicionNomDia: TStringField;
    RxQuHorarioDetalleProfesorProhibicionNomHora: TStringField;
    Panel2: TPanel;
    dbmInforme: TDBMemo;
    btn97SeleccionarHorario: TToolButton;
    btn97MateriaCortadaDia: TToolButton;
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
    btn97MateriaCortadaHora: TToolButton;
    QuMateriaCortadaHora: TkbmMemTable;
    QuMateriaCortadaHoraCodDia: TIntegerField;
    QuMateriaCortadaHoraCodHora: TIntegerField;
    QuMateriaCortadaHoraDetalle: TkbmMemTable;
    dsMateriaCortadaHora: TDataSource;
    btn97HorarioAulaTipo: TToolButton;
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
    procedure btn97HorarioParaleloClick(Sender: TObject);
    procedure btn97CruceProfesorClick(Sender: TObject);
    procedure btn97CruceMateriaClick(Sender: TObject);
    procedure btn97HorarioProfesorClick(Sender: TObject);
    procedure btn97MateriaProhibicionNoRespetadaClick(Sender: TObject);
    procedure btn97ProfesorProhibicionNoRespetadaClick(Sender: TObject);
    procedure btn97CruceAulaClick(Sender: TObject);
    procedure QuCruceProfesorAfterScroll(DataSet: TDataSet);
    procedure QuCruceMateriaAfterScroll(DataSet: TDataSet);
    procedure btn97SeleccionarHorarioClick(Sender: TObject);
    procedure DBGridGetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);
    procedure btn97MateriaCortadaDiaClick(Sender: TObject);
    procedure btn97MateriaCortadaHoraClick(Sender: TObject);
    procedure btn97HorarioAulaTipoClick(Sender: TObject);
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

implementation
uses
  FCrsMMER, FHorPara, FHorAulT, DMaster, SGHCUtls, FMasDEEd, FCrsMME1, FHorProf,
  FConfig, Printers, DSource;
{$R *.DFM}

procedure THorarioForm.btn97HorarioParaleloClick(Sender: TObject);
var
  HorarioParaleloForm: THorarioParaleloForm;
begin
  inherited;
  HorarioParaleloForm := THorarioParaleloForm.Create(Self);
  with SourceDataModule, HorarioParaleloForm do
  begin
    Caption := Format('%s %d', [Description[kbmHorario],
      kbmHorarioCodHorario.Value]);
    LoadHints(HorarioParaleloForm, kbmDia, kbmHora, kbmMateria);
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
    CodHorario := kbmHorarioCodHorario.Value;
    kbmHorarioDetalle.DisableControls;
    try
      d := kbmHorarioDetalle.IndexFieldNames;
      kbmHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      try
        if kbmHorarioDetalle.Locate('CodHorario', CodHorario, []) then
        begin
          s := kbmDistributivo.IndexFieldNames;
          kbmDistributivo.DisableControls;
          kbmDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
          kbmDistributivo.First;
          QuCruceProfesor.DisableControls;
          try
            while (kbmHorarioDetalleCodHorario.Value = CodHorario) and not kbmHorarioDetalle.Eof do
            begin
              CodMateria := kbmHorarioDetalleCodMateria.Value;
              CodNivel := kbmHorarioDetalleCodNivel.Value;
              CodEspecializacion := kbmHorarioDetalleCodEspecializacion.Value;
              CodParaleloId := kbmHorarioDetalleCodParaleloId.Value;
              while ((kbmDistributivoCodMateria.Value <> CodMateria)
                or (kbmDistributivoCodNivel.Value <> CodNivel)
                or (kbmDistributivoCodEspecializacion.Value <> CodEspecializacion)
                or (kbmDistributivoCodParaleloId.Value <> CodParaleloId))
                and not kbmDistributivo.Eof do
                kbmDistributivo.Next;
              CodProfesor := kbmDistributivoCodProfesor.Value;
              CodDia := kbmHorarioDetalleCodDia.Value;
              CodHora := kbmHorarioDetalleCodHora.Value;
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
              kbmHorarioDetalle.Next;
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
            kbmDistributivo.IndexFieldNames := s;
            kbmDistributivo.EnableControls;
            QuCruceProfesor.EnableControls;
          end;
        end;
      finally
        kbmHorarioDetalle.IndexFieldNames := d;
      end;
    finally
      kbmHorarioDetalle.EnableControls;
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
    CodHorario := kbmHorarioCodHorario.Value;
    kbmHorarioDetalle.DisableControls;
    try
      d := kbmHorarioDetalle.IndexFieldNames;
      kbmHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      try
        if kbmHorarioDetalle.Locate('CodHorario', CodHorario, []) then
        begin
          s := kbmDistributivo.IndexFieldNames;
          kbmDistributivo.DisableControls;
          kbmDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
          kbmDistributivo.First;
          QuCruceProfesorDetalle.DisableControls;
          try
            while (kbmHorarioDetalleCodHorario.Value = CodHorario) and not kbmHorarioDetalle.Eof do
            begin
              CodMateria := kbmHorarioDetalleCodMateria.Value;
              CodNivel := kbmHorarioDetalleCodNivel.Value;
              CodEspecializacion := kbmHorarioDetalleCodEspecializacion.Value;
              CodParaleloId := kbmHorarioDetalleCodParaleloId.Value;
              while ((kbmDistributivoCodMateria.Value <> CodMateria)
                or (kbmDistributivoCodNivel.Value <> CodNivel)
                or (kbmDistributivoCodEspecializacion.Value <> CodEspecializacion)
                or (kbmDistributivoCodParaleloId.Value <> CodParaleloId))
                and not kbmDistributivo.Eof do
                kbmDistributivo.Next;
              CodProfesor := kbmDistributivoCodProfesor.Value;
              CodHora := kbmHorarioDetalleCodHora.Value;
              CodDia := kbmHorarioDetalleCodDia.Value;
              if QuCruceProfesor.FindKey([CodProfesor, CodDia, CodHora]) then
              begin
                QuCruceProfesorDetalle.Append;
                QuCruceProfesorDetalleCodProfesor.Value := CodProfesor;
                QuCruceProfesorDetalleCodDia.Value := CodDia;
                QuCruceProfesorDetalleCodHora.Value := CodHora;
                QuCruceProfesorDetalleCodNivel.Value := CodNivel;
                QuCruceProfesorDetalleCodEspecializacion.Value := CodEspecializacion;
                QuCruceProfesorDetalleCodParaleloId.Value := CodParaleloId;
                QuCruceProfesorDetalleCodMateria.Value := kbmHorarioDetalleCodMateria.Value;
                QuCruceProfesorDetalle.Post;
              end;
              kbmHorarioDetalle.Next;
            end;
          finally
            kbmDistributivo.IndexFieldNames := s;
            kbmDistributivo.EnableControls;
            QuCruceProfesorDetalle.EnableControls;
          end;
        end;
      finally
        kbmHorarioDetalle.IndexFieldNames := d;
      end;
    finally
      kbmHorarioDetalle.EnableControls;
    end;
  end;
end;

procedure THorarioForm.btn97CruceProfesorClick(Sender: TObject);
var
  MasterDetailEditorForm: TMasterDetailEditorForm;
begin
  inherited;
  with SourceDataModule, MasterDataModule, QuCruceProfesor do
  begin
    FillCruceProfesor;
    FillCruceProfesorDetalle;
    First;
    btn97CruceProfesor.Enabled := false;
    MasterDetailEditorForm := TMasterDetailEditorForm.Create(Self);
    MasterDetailEditorForm.Caption := 'Cruce de Profesores';
    MyMasterDetailShowEditor(MasterDetailEditorForm, QuCruceProfesor,
      QuCruceProfesorDetalle, ConfiguracionForm.edtNomColegio.Text,
      EdQuCruceProfesorDestroy);
  end;
end;

procedure THorarioForm.EdQuCruceProfesorDestroy(Sender: TObject);
begin
  if Assigned(btn97CruceProfesor) then btn97CruceProfesor.Enabled := true;
  QuCruceProfesor.Close;
  QuCruceProfesorDetalle.Close;
end;

procedure THorarioForm.EdQuCruceAulaTipoDestroy(Sender: TObject);
begin
  if Assigned(btn97CruceAula) then btn97CruceAula.Enabled := true;
  QuCruceAula.Close;
  QuCruceAulaDetalle.Close;
end;

procedure THorarioForm.EdQuCruceMateriaDestroy(Sender: TObject);
begin
  if Assigned(btn97CruceMateria) then btn97CruceMateria.Enabled := true;
  QuCruceMateria.Close;
  QuCruceMateriaDetalle.Close;
end;

procedure THorarioForm.EdQuMateriaCortadaDiaDestroy(Sender: TObject);
begin
  if Assigned(btn97MateriaCortadaDia) then btn97MateriaCortadaDia.Enabled := true;
  QuMateriaCortadaDia.Close;
end;

procedure THorarioForm.EdQuMateriaCortadaHoraDestroy(Sender: TObject);
begin
  if Assigned(btn97MateriaCortadaHora) then btn97MateriaCortadaHora.Enabled := true;
  QuMateriaCortadaHora.Close;
  QuMateriaCortadaHoraDetalle.Close;
end;

procedure THorarioForm.EdQuHorarioDetalleMateriaProhibicionDestroy(Sender:
  TObject);
begin
  if Assigned(btn97MateriaProhibicionNoRespetada) then
    btn97MateriaProhibicionNoRespetada.Enabled := true;
  RxQuHorarioDetalleMateriaProhibicion.Close;
end;

procedure THorarioForm.EdQuHorarioDetalleProfesorProhibicionDestroy(Sender:
  TObject);
begin
  if Assigned(btn97ProfesorProhibicionNoRespetada) then
    btn97ProfesorProhibicionNoRespetada.Enabled := true;
  RxQuHorarioDetalleProfesorProhibicion.Close;
end;

procedure THorarioForm.btn97HorarioProfesorClick(Sender: TObject);
var
  HorarioProfesorForm: THorarioProfesorForm;
begin
  inherited;
  HorarioProfesorForm := THorarioProfesorForm.Create(Self);
  with SourceDataModule, MasterDataModule, HorarioProfesorForm do
  begin
    Caption := Format('%s %d', [Description[kbmHorario],
      kbmHorarioCodHorario.Value]);
    (*
    with FormStorage do
    begin
      IniSection := IniSection + '\MMEd1HorarioProfesor';
      Active := True;
      RestoreFormPlacement;
    end;
    *)
    LoadHints(HorarioProfesorForm, kbmDia, kbmHora, kbmProfesor);
  end;
end;

procedure THorarioForm.FillCruceMateria;
var
  CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId, CodDia,
    Sesion: Integer;
  kbmMemTable: TkbmMemTable;
  kbmMemTableCodHorario,
    kbmMemTableCodMateria,
    kbmMemTableCodNivel,
    kbmMemTableCodEspecializacion,
    kbmMemTableCodParaleloId,
    kbmMemTableCodDia,
    kbmMemTableSesion: TIntegerField;
begin
  with SourceDataModule do
  begin
    QuCruceMateria.Close;
    QuCruceMateria.Open;
    QuCruceMateriaDetalle.Close;
    QuCruceMateriaDetalle.Open;
    CodHorario := kbmHorarioCodHorario.Value;
    kbmMemTable := TkbmMemTable.Create(nil);
    try
      kbmHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      kbmHorarioDetalle.Filtered := True;
      kbmHorarioDetalle.Filter := Format('CodHorario=%d', [CodHorario]);
      try
        kbmMemTable.LoadFromDataSet(kbmHorarioDetalle, [mtcpoStructure]);
        kbmHorarioDetalle.First;
        with kbmMemTable.IndexDefs.AddIndexDef do
        begin
          Name := 'ixTmp1';
          Fields := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia';
        end;
        kbmMemTableCodHorario := kbmMemTable.FindField('CodHorario') as TIntegerField;
        kbmMemTableCodMateria := kbmMemTable.FindField('CodMateria') as TIntegerField;
        kbmMemTableCodNivel := kbmMemTable.FindField('CodNivel') as TIntegerField;
        kbmMemTableCodEspecializacion := kbmMemTable.FindField('CodEspecializacion') as TIntegerField;
        kbmMemTableCodParaleloId := kbmMemTable.FindField('CodParaleloId') as TIntegerField;
        kbmMemTableCodDia := kbmMemTable.FindField('CodDia') as TIntegerField;
        kbmMemTableSesion := kbmMemTable.FindField('Sesion') as TIntegerField;
        QuCruceMateria.IndexFieldNames := 'CodMateria';
        while (kbmHorarioDetalleCodHorario.Value = CodHorario) and not kbmHorarioDetalle.Eof do
        begin
          kbmMemTable.First;
          CodMateria := kbmHorarioDetalleCodMateria.Value;
          CodNivel := kbmHorarioDetalleCodNivel.Value;
          CodEspecializacion := kbmHorarioDetalleCodEspecializacion.Value;
          CodParaleloId := kbmHorarioDetalleCodParaleloId.Value;
          CodDia := kbmHorarioDetalleCodDia.Value;
          Sesion := kbmHorarioDetalleSesion.Value;
          kbmMemTable.FindKey([CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId, CodDia]);
          while (kbmMemTableCodHorario.Value = CodHorario)
            and (kbmMemTableCodMateria.Value = CodMateria)
            and (kbmMemTableCodNivel.Value = CodNivel)
            and (kbmMemTableCodEspecializacion.Value = CodEspecializacion)
            and (kbmMemTableCodParaleloId.Value = CodParaleloId)
            and (kbmMemTableCodDia.Value = CodDia)
            and not kbmMemTable.Eof do
          begin
            if kbmMemTableSesion.Value <> Sesion then
            begin
              if not QuCruceMateria.FindKey([CodMateria]) then
              begin
                QuCruceMateria.Append;
                QuCruceMateriaCodMateria.Value := kbmHorarioDetalleCodMateria.Value;
                QuCruceMateriaNomMateria.Value := kbmHorarioDetalleNomMateria.Value;
                QuCruceMateria.Post;
              end;
              QuCruceMateriaDetalle.Append;
              QuCruceMateriaDetalleCodMateria.Value := CodMateria;
              QuCruceMateriaDetalleCodNivel.Value := kbmHorarioDetalleCodNivel.Value;
              QuCruceMateriaDetalleCodEspecializacion.Value := kbmHorarioDetalleCodEspecializacion.Value;
              QuCruceMateriaDetalleCodParaleloId.Value := kbmHorarioDetalleCodParaleloId.Value;
              QuCruceMateriaDetalleCodDia.Value := kbmHorarioDetalleCodDia.Value;
              QuCruceMateriaDetalleCodHora.Value := kbmHorarioDetalleCodHora.Value;
              QuCruceMateriaDetalle.Post;
            end;
            kbmMemTable.Next;
          end;
          kbmHorarioDetalle.Next;
        end;
      finally
        kbmHorarioDetalle.Filtered := False;
        kbmHorarioDetalle.Filter := '';
      end;
      QuCruceMateria.IndexFieldNames := 'NomMateria';
    finally
      kbmMemTable.Free;
    end;
  end;
end;

procedure THorarioForm.btn97CruceMateriaClick(Sender: TObject);
var
  MasterDetailEditorForm: TMasterDetailEditorForm;
begin
  inherited;
  with SourceDataModule, MasterDataModule, QuCruceMateria do
  begin
    FillCruceMateria;
    btn97CruceMateria.Enabled := false;
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
    CodHorario := kbmHorarioCodHorario.Value;
    RxQuHorarioDetalleMateriaProhibicion.Close;
    RxQuHorarioDetalleMateriaProhibicion.Open;
    kbmMateriaProhibicion.IndexFieldNames := 'CodMateria;CodDia;CodHora';
    kbmHorarioDetalle.IndexFieldNames := 'CodHorario';
    if kbmHorarioDetalle.Locate('CodHorario', CodHorario, []) then
    begin
      while (KbmHorarioDetalleCodHorario.Value = CodHorario) and not kbmHorarioDetalle.Eof do
      begin
        if kbmMateriaProhibicion.FindKey([kbmHorarioDetalleCodMateria.Value,
          kbmHorarioDetalleCodDia.Value, kbmHorarioDetalleCodHora.Value]) then
        begin
          RxQuHorarioDetalleMateriaProhibicion.Append;
          RxQuHorarioDetalleMateriaProhibicionNomMateria.Value := kbmHorarioDetalleNomMateria.Value;
          RxQuHorarioDetalleMateriaProhibicionCodHora.Value := kbmHorarioDetalleCodHora.Value;
          RxQuHorarioDetalleMateriaProhibicionCodDia.Value := kbmHorarioDetalleCodDia.Value;
          RxQuHorarioDetalleMateriaProhibicionCodMateProhibicionTipo.Value := kbmMateriaProhibicionCodMateProhibicionTipo.Value;
          RxQuHorarioDetalleMateriaProhibicionCodNivel.Value := kbmHorarioDetalleCodNivel.Value;
          RxQuHorarioDetalleMateriaProhibicionCodEspecializacion.Value := kbmHorarioDetalleCodEspecializacion.Value;
          RxQuHorarioDetalleMateriaProhibicionCodParaleloId.Value := kbmHorarioDetalleCodParaleloId.Value;
          RxQuHorarioDetalleMateriaProhibicion.Post;
        end;
        kbmHorarioDetalle.Next;
      end;
    end;
  end;
end;

procedure THorarioForm.btn97MateriaProhibicionNoRespetadaClick(Sender: TObject);
var
  FSingleEditor: TSingleEditorForm;
begin
  inherited;
  with SourceDataModule, RxQuHorarioDetalleMateriaProhibicion do
  begin
    FillHorarioDetalleMateriaProhibicion;
    btn97MateriaProhibicionNoRespetada.Enabled := false;
    FSingleEditor := TSingleEditorForm.Create(Self);
    FSingleEditor.Caption := Description[kbmMateriaProhibicion] +
      ' No Respetadas';
    MySingleShowEditor(FSingleEditor, RxQuHorarioDetalleMateriaProhibicion,
      ConfiguracionForm.edtNomColegio.Text, EdQuHorarioDetalleMateriaProhibicionDestroy);
  end;
end;

procedure THorarioForm.FillHorarioDetalleProfesorProhibicion;
var
  CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId: Integer;
begin
  with SourceDataModule do
  begin
    CodHorario := kbmHorarioCodHorario.Value;
    RxQuHorarioDetalleProfesorProhibicion.Close;
    RxQuHorarioDetalleProfesorProhibicion.Open;
    kbmProfesorProhibicion.IndexFieldNames := 'CodProfesor;CodDia;CodHora';
    kbmHorarioDetalle.IndexFieldNames :=
      'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    kbmDistributivo.IndexFieldNames :=
      'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
    if kbmHorarioDetalle.Locate('CodHorario', CodHorario, []) then
    begin
      kbmDistributivo.First;
      while (KbmHorarioDetalleCodHorario.Value = CodHorario) and not kbmHorarioDetalle.Eof do
      begin
        CodMateria := kbmHorarioDetalleCodMateria.Value;
        CodNivel := kbmHorarioDetalleCodNivel.Value;
        CodEspecializacion := kbmHorarioDetalleCodEspecializacion.Value;
        CodParaleloId := kbmHorarioDetalleCodParaleloId.Value;
        while ((kbmDistributivoCodMateria.Value <> CodMateria)
          or (kbmDistributivoCodNivel.Value <> CodNivel)
          or (kbmDistributivoCodEspecializacion.Value <> CodEspecializacion)
          or (kbmDistributivoCodParaleloId.Value <> CodParaleloId))
          and not kbmDistributivo.Eof do
          kbmDistributivo.Next;
        if kbmProfesorProhibicion.FindKey([kbmDistributivoCodProfesor.Value,
          kbmHorarioDetalleCodDia.Value, kbmHorarioDetalleCodHora.Value]) then
        begin
          RxQuHorarioDetalleProfesorProhibicion.Append;
          RxQuHorarioDetalleProfesorProhibicionApeNomProfesor.Value := kbmDistributivoApeNomProfesor.Value;
          RxQuHorarioDetalleProfesorProhibicionCodHora.Value := kbmHorarioDetalleCodHora.Value;
          RxQuHorarioDetalleProfesorProhibicionCodDia.Value := kbmHorarioDetalleCodDia.Value;
          RxQuHorarioDetalleProfesorProhibicionCodProfProhibicionTipo.Value := kbmProfesorProhibicionCodProfProhibicionTipo.Value;
          RxQuHorarioDetalleProfesorProhibicionCodNivel.Value := kbmHorarioDetalleCodNivel.Value;
          RxQuHorarioDetalleProfesorProhibicionCodEspecializacion.Value := kbmHorarioDetalleCodEspecializacion.Value;
          RxQuHorarioDetalleProfesorProhibicionCodParaleloId.Value := kbmHorarioDetalleCodParaleloId.Value;
          RxQuHorarioDetalleProfesorProhibicion.Post;
        end;
        kbmHorarioDetalle.Next;
      end;
    end;
  end;
end;

procedure THorarioForm.btn97ProfesorProhibicionNoRespetadaClick(Sender:
  TObject);
var
  FSingleEditor: TSingleEditorForm;
begin
  inherited;
  with SourceDataModule, RxQuHorarioDetalleProfesorProhibicion do
  begin
    FillHorarioDetalleProfesorProhibicion;
    btn97ProfesorProhibicionNoRespetada.Enabled := false;
    FSingleEditor := TSingleEditorForm.Create(Self);
    FSingleEditor.Caption := 'Prohibiciones de profesor no respetadas';
    MySingleShowEditor(FSingleEditor,
      RxQuHorarioDetalleProfesorProhibicion,
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
    CodHorario := kbmHorarioCodHorario.Value;
    kbmHorarioDetalle.DisableControls;
    try
      d := kbmHorarioDetalle.IndexFieldNames;
      kbmHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      try
        if kbmHorarioDetalle.Locate('CodHorario', CodHorario, []) then
        begin
          s := kbmDistributivo.IndexFieldNames;
          kbmDistributivo.DisableControls;
          kbmDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
          kbmDistributivo.First;
          QuCruceAula.DisableControls;
          try
            while (kbmHorarioDetalleCodHorario.Value = CodHorario) and not kbmHorarioDetalle.Eof do
            begin
              CodMateria := kbmHorarioDetalleCodMateria.Value;
              CodNivel := kbmHorarioDetalleCodNivel.Value;
              CodEspecializacion := kbmHorarioDetalleCodEspecializacion.Value;
              CodParaleloId := kbmHorarioDetalleCodParaleloId.Value;
              while ((kbmDistributivoCodMateria.Value <> CodMateria)
                or (kbmDistributivoCodNivel.Value <> CodNivel)
                or (kbmDistributivoCodEspecializacion.Value <> CodEspecializacion)
                or (kbmDistributivoCodParaleloId.Value <> CodParaleloId))
                and not kbmDistributivo.Eof do
                kbmDistributivo.Next;
              CodAulaTipo := kbmDistributivoCodAulaTipo.Value;
              CodHora := kbmHorarioDetalleCodHora.Value;
              CodDia := kbmHorarioDetalleCodDia.Value;
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
              kbmHorarioDetalle.Next;
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
            kbmDistributivo.IndexFieldNames := s;
            kbmDistributivo.EnableControls;
            QuCruceAula.EnableControls;
          end;
        end;
      finally
        kbmHorarioDetalle.IndexFieldNames := d;
      end;
    finally
      kbmHorarioDetalle.EnableControls;
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
    CodHorario := kbmHorarioCodHorario.Value;
    d := kbmHorarioDetalle.IndexFieldNames;
    kbmHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    QuCruceAulaDetalle.DisableControls;
    QuCruceAulaDetalle.EnableIndexes := False;
    try
      if kbmHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        s := kbmDistributivo.IndexFieldNames;
        try
          kbmDistributivo.DisableControls;
          kbmDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion';
          kbmDistributivo.First;
          while (kbmHorarioDetalleCodHorario.Value = CodHorario) and not kbmHorarioDetalle.Eof do
          begin
            CodMateria := kbmHorarioDetalleCodMateria.Value;
            CodNivel := kbmHorarioDetalleCodNivel.Value;
            CodEspecializacion := kbmHorarioDetalleCodEspecializacion.Value;
            while ((kbmDistributivoCodMateria.Value <> CodMateria)
              or (kbmDistributivoCodNivel.Value <> CodNivel)
              or (kbmDistributivoCodEspecializacion.Value <> CodEspecializacion))
              and not kbmDistributivo.Eof do
              kbmDistributivo.Next;
            CodAulaTipo := kbmDistributivoCodAulaTipo.Value;
            CodHora := kbmHorarioDetalleCodHora.Value;
            CodDia := kbmHorarioDetalleCodDia.Value;
            if QuCruceAula.FindKey([CodAulaTipo, CodDia, CodHora]) then
            begin
              QuCruceAulaDetalle.Append;
              QuCruceAulaDetalleCodAulaTipo.Value := CodAulaTipo;
              QuCruceAulaDetalleCodDia.Value := CodDia;
              QuCruceAulaDetalleCodHora.Value := CodHora;
              QuCruceAulaDetalleCodNivel.Value := kbmHorarioDetalleCodNivel.Value;
              QuCruceAulaDetalleCodEspecializacion.Value := kbmHorarioDetalleCodEspecializacion.Value;
              QuCruceAulaDetalleCodParaleloId.Value := kbmHorarioDetalleCodParaleloId.Value;
              QuCruceAulaDetalleNomMateria.Value := kbmHorarioDetalleNomMateria.Value;
              QuCruceAulaDetalle.Post;
            end;
            kbmHorarioDetalle.Next;
          end;
        finally
          kbmDistributivo.IndexFieldNames := s;
          kbmDistributivo.EnableControls;
        end;
      end;
    finally
      kbmHorarioDetalle.IndexFieldNames := d;
      QuCruceAulaDetalle.EnableIndexes := True;
      QuCruceAulaDetalle.UpdateIndexes;
      QuCruceAulaDetalle.EnableControls;
    end;
  end;
end;

procedure THorarioForm.btn97CruceAulaClick(Sender: TObject);
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
    btn97CruceAula.Enabled := false;
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

procedure THorarioForm.btn97SeleccionarHorarioClick(Sender: TObject);
begin
  inherited;
  ConfiguracionForm.lblHorarioSeleccionado.Caption :=
    SourceDataModule.kbmHorarioCodHorario.AsString;
  ConfiguracionForm.FormStorage.SaveFormPlacement;
  DBGrid.Refresh;
end;

procedure THorarioForm.DBGridGetCellParams(Sender: TObject; Field: TField;
  AFont: TFont; var Background: TColor; Highlight: Boolean);
begin
  inherited;
  if (ConfiguracionForm.lblHorarioSeleccionado.Caption <> '(Ninguno)')
    and (ConfiguracionForm.lblHorarioSeleccionado.Caption
    = SourceDataModule.kbmHorarioCodHorario.AsString) then
    Background := clAqua;
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
    CodHorario := kbmHorarioCodHorario.Value;
    QuMateriaCortadaDia.Close;
    QuMateriaCortadaDia.Open;
    kbmHorarioDetalle.DisableControls;
    try
      d := kbmHorarioDetalle.IndexFieldNames;
      kbmHorarioDetalle.IndexFieldNames := 'CodHorario;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      try
        if kbmHorarioDetalle.Locate('CodHorario', CodHorario, []) then
        begin
          CodNivel1 := kbmHorarioDetalleCodNivel.Value;
          CodEspecializacion1 := kbmHorarioDetalleCodEspecializacion.Value;
          CodParaleloId1 := kbmHorarioDetalleCodParaleloId.Value;
          CodDia1 := kbmHorarioDetalleCodDia.Value;
          CodHora1 := kbmHorarioDetalleCodHora.Value;
          Sesion1 := kbmHorarioDetalleSesion.Value;
          kbmHorarioDetalle.Next;
          while (kbmHorarioDetalleCodHorario.Value = CodHorario) and not kbmHorarioDetalle.Eof do
          begin
            CodNivel := kbmHorarioDetalleCodNivel.Value;
            CodEspecializacion := kbmHorarioDetalleCodEspecializacion.Value;
            CodParaleloId := kbmHorarioDetalleCodParaleloId.Value;
            CodDia := kbmHorarioDetalleCodDia.Value;
            CodHora := kbmHorarioDetalleCodHora.Value;
            Sesion := kbmHorarioDetalleSesion.Value;
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
              QuMateriaCortadaDiaCodMateria.Value := kbmHorarioDetalleCodMateria.Value;
              QuMateriaCortadaDia.Post;
              QuMateriaCortadaDia.Append;
              QuMateriaCortadaDiaCodNivel.Value := CodNivel;
              QuMateriaCortadaDiaCodEspecializacion.Value := CodEspecializacion;
              QuMateriaCortadaDiaCodParaleloId.Value := CodParaleloId;
              QuMateriaCortadaDiaCodHora.Value := CodHora;
              QuMateriaCortadaDiaCodDia.Value := CodDia;
              QuMateriaCortadaDiaCodMateria.Value := kbmHorarioDetalleCodMateria.Value;
              QuMateriaCortadaDia.Post;
            end;
            CodNivel1 := CodNivel;
            CodEspecializacion1 := CodEspecializacion;
            CodParaleloId1 := CodParaleloId;
            CodDia1 := CodDia;
            CodHora1 := CodHora;
            Sesion1 := Sesion;
            kbmHorarioDetalle.Next;
          end;
        end
      finally
        kbmHorarioDetalle.IndexFieldNames := d;
      end;
    finally
      kbmHorarioDetalle.EnableControls;
    end;
  end;
end;

procedure THorarioForm.btn97MateriaCortadaDiaClick(Sender: TObject);
var
  SingleEditorForm: TSingleEditorForm;
begin
  inherited;
  with SourceDataModule, QuMateriaCortadaDia do
  begin
    FillMateriaCortadaDia;
    btn97MateriaCortadaDia.Enabled := false;
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
    kbmHora.IndexFieldNames := 'CodHora';
    kbmDia.IndexFieldNames := 'CodDia';
    kbmHora.First;
    kbmPeriodo.IndexFieldNames := 'CodDia;CodHora';
    while not kbmHora.Eof do
    begin
      kbmDia.First;
      CodHora := kbmHoraCodHora.Value;
      while not kbmDia.Eof do
      begin
        CodDia := kbmDiaCodDia.Value;
        if not kbmPeriodo.FindKey([CodDia, CodHora]) then
        begin
          QuMateriaCortadaHora.Append;
          QuMateriaCortadaHoraCodDia.Value := CodDia;
          QuMateriaCortadaHoraCodHora.Value := CodHora;
          QuMateriaCortadaHora.Post;
        end;
        kbmDia.Next;
      end;
      kbmHora.Next;
    end;
    QuMateriaCortadaHora.First;
    s := kbmHorarioDetalle.IndexFieldNames;
    kbmHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    try
      CodHorario := kbmHorarioCodHorario.Value;
      if kbmHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        CodMateria1 := kbmHorarioDetalleCodMateria.Value;
        CodNivel1 := kbmHorarioDetalleCodNivel.Value;
        CodEspecializacion1 := kbmHorarioDetalleCodEspecializacion.Value;
        CodParaleloId1 := kbmHorarioDetalleCodParaleloId.Value;
        CodDia1 := kbmHorarioDetalleCodDia.Value;
        CodHora1 := kbmHorarioDetalleCodHora.Value;
        kbmHorarioDetalle.Next;
        while (kbmHorarioDetalleCodHorario.Value = CodHorario) and not kbmHorarioDetalle.Eof do
        begin
          CodMateria := kbmHorarioDetalleCodMateria.Value;
          CodNivel := kbmHorarioDetalleCodNivel.Value;
          CodEspecializacion := kbmHorarioDetalleCodEspecializacion.Value;
          CodParaleloId := kbmHorarioDetalleCodParaleloId.Value;
          CodDia := kbmHorarioDetalleCodDia.Value;
          CodHora2 := kbmHorarioDetalleCodHora.Value;
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
          kbmHorarioDetalle.Next;
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
      kbmHorarioDetalle.IndexFieldNames := s;
    end;
  end;
end;

procedure THorarioForm.btn97MateriaCortadaHoraClick(Sender: TObject);
var
  MasterDetailEditorForm: TMasterDetailEditorForm;
begin
  inherited;
  with SourceDataModule, QuMateriaCortadaHora do
  begin
    FillMateriaCortadaHora;
    btn97MateriaCortadaHora.Enabled := false;
    MasterDetailEditorForm := TMasterDetailEditorForm.Create(Self);
    MasterDetailEditorForm.Caption := 'Materias cortadas por la hora';
    MyMasterDetailShowEditor(MasterDetailEditorForm, QuMateriaCortadaHora,
      QuMateriaCortadaHoraDetalle, ConfiguracionForm.edtNomColegio.Text,
      EdQuMateriaCortadaHoraDestroy);
  end;
end;

procedure THorarioForm.btn97HorarioAulaTipoClick(Sender: TObject);
var
  HorarioAulaTipoForm: THorarioAulaTipoForm;
begin
  inherited;
  HorarioAulaTipoForm := THorarioAulaTipoForm.Create(Self);
  with SourceDataModule, HorarioAulaTipoForm do
  begin
    Caption := Format('%s %d', [Description[kbmHorario],
      kbmHorarioCodHorario.Value]);
    LoadHints(HorarioAulaTipoForm, kbmDia, kbmHora, kbmMateria);
  end;
end;

end.

