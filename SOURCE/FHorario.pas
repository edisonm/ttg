unit FHorario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, StdCtrls, DBIndex, Buttons,
  DBBBtn, DBCtrls, ExtCtrls, RXCtrls, RXDBCtrl, TB97Tlbr, TB97, TB97Ctls,
  DB97Btn, DBTables, RxQuery, StrHlder, RXSplit, CDBFmlry, DBFmlry;

type
  THorarioForm = class(TSingleEditorForm)
    btn97MateriaProhibicionNoRespetada: TDBToolbarButton97;
    btn97ProfesorProhibicionNoRespetada: TDBToolbarButton97;
    btn97HorarioParalelo: TDBToolbarButton97;
    btn97Profesor: TDBToolbarButton97;
    btn97CruceProfesor: TDBToolbarButton97;
    btn97CruceMateria: TDBToolbarButton97;
    btn97CruceAula: TDBToolbarButton97;
    QuCruceAula: TQuery;
    QuCruceAulaCodHorario: TIntegerField;
    QuCruceAulaCodDia: TIntegerField;
    QuCruceAulaCodHora: TIntegerField;
    QuCruceAulaCodAulaTipo: TIntegerField;
    QuCruceAulaAbrAulaTipo: TStringField;
    QuCruceAulaNomDia: TStringField;
    QuCruceAulaNomHora: TStringField;
    QuCruceAulaUsadas: TIntegerField;
    QuCruceAulaCruces: TIntegerField;
    QuCruceAulaDetalle: TQuery;
    QuCruceAulaDetallelCodivel: TIntegerField;
    QuCruceAulaDetalleCodEspecializacion: TIntegerField;
    QuCruceAulaDetalleCodParaleloId: TIntegerField;
    QuCruceAulaDetalleNomMateria: TStringField;
    QuCruceAulaDetalleAbrNivel: TStringField;
    QuCruceAulaDetalleAbrEspecializacion: TStringField;
    QuCruceAulaDetalleNomParaleloId: TStringField;
    DSCruceAula: TDataSource;
    QuCruceProfesorDetalle: TQuery;
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
    QuCruceProfesor: TQuery;
    QuCruceProfesorCodProfesor: TIntegerField;
    QuCruceProfesorCodDia: TIntegerField;
    QuCruceProfesorCodHora: TIntegerField;
    QuCruceProfesorApeProfesor: TStringField;
    QuCruceProfesorNomProfesor: TStringField;
    QuCruceProfesorNomDia: TStringField;
    QuCruceProfesorNomHora: TStringField;
    QuCruceProfesorCruces: TIntegerField;
    QuCruceMateria: TQuery;
    QuCruceMateriaCodMateria: TIntegerField;
    QuCruceMateriaNomMateria: TStringField;
    QuCruceMateriaDetalle: TQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    RxQuHorarioDetalleMateriaProhibicion: TRxQuery;
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
    RxQuHorarioDetalleProfesorProhibicion: TRxQuery;
    RxQuHorarioDetalleProfesorProfesorProhibicionApeProfesor: TStringField;
    RxQuHorarioDetalleProfesorProfesorProhibicionNomProfesor: TStringField;
    RxQuHorarioDetalleProfesorProhibicionDia: TIntegerField;
    RxQuHorarioDetalleProfesorProhibicionHora: TIntegerField;
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
    btn97SeleccionarHorario: TDBToolbarButton97;
    btn97MateriaCortadaDia: TDBToolbarButton97;
    QuMateriaCortadaDia: TQuery;
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
    btn97MateriaCortadaHora: TDBToolbarButton97;
    QuMateriaCortadaHora: TRxQuery;
    QuMateriaCortadaHoraDetalle: TQuery;
    DSMateriaCortadaHora: TDataSource;
    btn97HorarioAulaTipo: TDBToolbarButton97;
    QuMateriaCortadaHoraDetalleCodNivel: TIntegerField;
    QuMateriaCortadaHoraDetalleCodEspecializacion: TIntegerField;
    QuMateriaCortadaHoraDetalleCodParaleloId: TIntegerField;
    QuMateriaCortadaHoraDetalleCodDia: TIntegerField;
    QuMateriaCortadaHoraDetalleCodHora: TIntegerField;
    QuMateriaCortadaHoraDetalleCodMateria: TIntegerField;
    QuMateriaCortadaHoraDetalleAbrNivel: TStringField;
    QuMateriaCortadaHoraDetalleAbrEspecializacion: TStringField;
    QuMateriaCortadaHoraDetalleNomParaleloId: TStringField;
    QuMateriaCortadaHoraDetalleNomDia: TStringField;
    QuMateriaCortadaHoraDetalleNomHora: TStringField;
    QuMateriaCortadaHoraDetalleNomMateria: TStringField;
    QuMateriaCortadaHoraCodDia: TIntegerField;
    QuMateriaCortadaHoraCodHora: TIntegerField;
    QuMateriaCortadaHoraNomDia: TStringField;
    QuMateriaCortadaHoraNomHora: TStringField;
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
  public
    { Public declarations }
  end;

implementation
uses
  FCrsMMER, FHorPara, FHorAulT, DMaster, SGHCUtls, FMasDEEd, FCrsMME1, FHorProf,
  FConfig, QMaDeRep, Printers;
{$R *.DFM}

procedure THorarioForm.btn97HorarioParaleloClick(Sender: TObject);
var
  HorarioParaleloForm: THorarioParaleloForm;
begin
  inherited;
  HorarioParaleloForm := THorarioParaleloForm.Create(Self);
  with MasterDataModule, HorarioParaleloForm do
  begin
    Caption := Format('%s %d', [TbHorario.TableName,
      TbHorarioCodHorario.Value]);
    LoadHints(HorarioParaleloForm, TbDia, TbHora, TbMateria);
  end;
end;

procedure THorarioForm.btn97CruceProfesorClick(Sender: TObject);
var
  MasterDetailEditorForm: TMasterDetailEditorForm;
begin
  inherited;
  with MasterDataModule, QuCruceProfesor do
  begin
    Close;
    ParamByName('CodHorario').Value := TbHorarioCodHorario.Value;
    Open;
    First;
    QuCruceProfesorDetalle.Close;
    QuCruceProfesorDetalle.ParamByName('CodHorario').Value :=
      TbHorarioCodHorario.Value;
    QuCruceProfesorDetalle.Open;
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
  with MasterDataModule, HorarioProfesorForm do
  begin
    Caption := Format('%s %d', [TbHorario.TableName,
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

procedure THorarioForm.btn97CruceMateriaClick(Sender: TObject);
var
  MasterDetailEditorForm: TMasterDetailEditorForm;
begin
  inherited;
  with MasterDataModule, QuCruceMateria do
  begin
    Close;
    ParamByName('CodHorario').Value := TbHorarioCodHorario.Value;
    Open;
    First;
    QuCruceMateriaDetalle.Close;
    QuCruceMateriaDetalle.ParamByName('CodHorario').Value :=
      TbHorarioCodHorario.Value;
    QuCruceMateriaDetalle.Open;
    btn97CruceMateria.Enabled := false;
    MasterDetailEditorForm := TMasterDetailEditorForm.Create(Self);
    MasterDetailEditorForm.Caption := 'Cruce de Materias';
    MyMasterDetailShowEditor(MasterDetailEditorForm, QuCruceMateria,
      QuCruceMateriaDetalle, ConfiguracionForm.edtNomColegio.Text,
      EdQuCruceMateriaDestroy);
  end;
end;

procedure THorarioForm.btn97MateriaProhibicionNoRespetadaClick(Sender: TObject);
var
  FSingleEditor: TSingleEditorForm;
begin
  inherited;
  with MasterDataModule, RxQuHorarioDetalleMateriaProhibicion do
  begin
    Close;
    MacroByName('CodHorario').Value := TbHorarioCodHorario.Value;
    Open;
    btn97MateriaProhibicionNoRespetada.Enabled := false;
    FSingleEditor := TSingleEditorForm.Create(Self);
    FSingleEditor.Caption := GetDescription(TbMateriaProhibicion) +
      ' No Respetadas';
    MySingleShowEditor(FSingleEditor, RxQuHorarioDetalleMateriaProhibicion,
      ConfiguracionForm.edtNomColegio.Text,
      EdQuHorarioDetalleMateriaProhibicionDestroy);
  end;
end;

procedure THorarioForm.btn97ProfesorProhibicionNoRespetadaClick(Sender:
  TObject);
var
  FSingleEditor: TSingleEditorForm;
begin
  inherited;
  with MasterDataModule, RxQuHorarioDetalleProfesorProhibicion do
  begin
    Close;
    MacroByName('CodHorario').Value := TbHorarioCodHorario.Value;
    Open;
    btn97ProfesorProhibicionNoRespetada.Enabled := false;
    FSingleEditor := TSingleEditorForm.Create(Self);
    FSingleEditor.Caption := 'Prohibiciones de profesor no respetadas';
    MySingleShowEditor(FSingleEditor,
      RxQuHorarioDetalleProfesorProhibicion,
      ConfiguracionForm.edtNomColegio.Text,
      EdQuHorarioDetalleProfesorProhibicionDestroy);
  end;
end;

procedure THorarioForm.btn97CruceAulaClick(Sender: TObject);
var
  MasterDetailEditorForm: TMasterDetailEditorForm;
begin
  inherited;
  with MasterDataModule, QuCruceAula do
  begin
    Close;
    ParamByName('CodHorario').Value := TbHorarioCodHorario.Value;
    Open;
    QuCruceAulaDetalle.Close;
    QuCruceAulaDetalle.Open;
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
    MasterDataModule.TbHorarioCodHorario.AsString;
  ConfiguracionForm.FormStorage.SaveFormPlacement;
  DBGrid.Refresh;
end;

procedure THorarioForm.DBGridGetCellParams(Sender: TObject; Field: TField;
  AFont: TFont; var Background: TColor; Highlight: Boolean);
begin
  inherited;
  if (ConfiguracionForm.lblHorarioSeleccionado.Caption <> '(Ninguno)')
    and (ConfiguracionForm.lblHorarioSeleccionado.Caption
    = MasterDataModule.TbHorarioCodHorario.AsString) then
    Background := clAqua;
end;

procedure THorarioForm.btn97MateriaCortadaDiaClick(Sender: TObject);
var
  SingleEditorForm: TSingleEditorForm;
begin
  inherited;
  with MasterDataModule, QuMateriaCortadaDia do
  begin
    Close;
    ParamByName('CodHorario').Value := TbHorarioCodHorario.Value;
    Open;
    btn97MateriaCortadaDia.Enabled := false;
    SingleEditorForm := TSingleEditorForm.Create(Self);
    SingleEditorForm.Caption := 'Materias cortadas por el día';
    MySingleShowEditor(SingleEditorForm, QuMateriaCortadaDia,
      ConfiguracionForm.edtNomColegio.Text, EdQuMateriaCortadaDiaDestroy);
  end;
end;

procedure THorarioForm.btn97MateriaCortadaHoraClick(Sender: TObject);
var
  MasterDetailEditorForm: TMasterDetailEditorForm;
begin
  inherited;
  with MasterDataModule, QuMateriaCortadaHora do
  begin
    Close;
    MacroByName('CodHorario').Value := TbHorarioCodHorario.Value;
    Open;
    First;
    QuMateriaCortadaHoraDetalle.Close;
    QuMateriaCortadaHoraDetalle.ParamByName('CodHorario').Value :=
      TbHorarioCodHorario.Value;
    QuMateriaCortadaHoraDetalle.Open;
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
  with MasterDataModule, HorarioAulaTipoForm do
  begin
    Caption := Format('%s %d', [TbHorario.TableName,
      TbHorarioCodHorario.Value]);
    LoadHints(HorarioAulaTipoForm, TbDia, TbHora, TbMateria);
  end;
end;

end.

