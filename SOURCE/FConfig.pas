unit FConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, CurrEdit, Placemnt, Buttons, ComCtrls, Spin,
  RxLookup, Grids, DBGrids, RXDBCtrl, Db, RXCombos, DBColCBx, DBCtrls;

type
  TConfiguracionForm = class(TForm)
    bbtnOk: TBitBtn;
    FormStorage: TFormStorage;
    pgcConfig: TPageControl;
    tbsPesos: TTabSheet;
    tbsAlgoritmoEvolutivo: TTabSheet;
    speTamPoblacion: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    creCruceProfesor: TCurrencyEdit;
    creCruceAulaTipo: TCurrencyEdit;
    creHoraHueca: TCurrencyEdit;
    creSesionCortada: TCurrencyEdit;
    creMateriaNoDispersa: TCurrencyEdit;
    Label8: TLabel;
    creProbCruzamiento: TCurrencyEdit;
    Label10: TLabel;
    Label11: TLabel;
    creProbMutacion1: TCurrencyEdit;
    Label13: TLabel;
    speNumMaxGeneracion: TSpinEdit;
    tbsUnidadEducativa: TTabSheet;
    Label14: TLabel;
    speMaxCargaProfesor: TSpinEdit;
    memComentarios: TMemo;
    lblComentarios: TLabel;
    Label17: TLabel;
    edtNomColegio: TEdit;
    speOrdenMutacion1: TSpinEdit;
    Label7: TLabel;
    Label9: TLabel;
    creProbMutacion2: TCurrencyEdit;
    creProbReparacion: TCurrencyEdit;
    Label12: TLabel;
    Label15: TLabel;
    RxDBGrid1: TRxDBGrid;
    Label18: TLabel;
    RxDBGrid2: TRxDBGrid;
    tbsOpciones: TTabSheet;
    CBRandomize: TCheckBox;
    Label19: TLabel;
    speSeed1: TSpinEdit;
    speSeed2: TSpinEdit;
    Label20: TLabel;
    Label21: TLabel;
    speSeed3: TSpinEdit;
    speSeed4: TSpinEdit;
    Label22: TLabel;
    Label23: TLabel;
    Label4: TLabel;
    edtNomResponsable: TEdit;
    Label25: TLabel;
    edtCarResponsable: TEdit;
    Label26: TLabel;
    edtNomAutoridad: TEdit;
    edtCarAutoridad: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    speNumIteraciones: TSpinEdit;
    Label31: TLabel;
    edtAnioLectivo: TEdit;
    lblHorarioSeleccionado: TLabel;
    Label33: TLabel;
    Label16: TLabel;
    creProfesorFraccionamiento: TCurrencyEdit;
    Label24: TLabel;
    edtMostrarProfesorHorarioTexto: TEdit;
    Label32: TLabel;
    Label34: TLabel;
    speMostrarProfesorHorarioLongitud: TSpinEdit;
    Label35: TLabel;
    edtProfesorHorarioExcluirProfProhibicion: TEdit;
    Label36: TLabel;
    edtHorarioIni: TEdit;
    dbeNomMateProhibicionTipo: TDBEdit;
    dbcColMateProhibicionTipo: TDBColorComboBox;
    dbeValMateProhibicionTipo: TDBEdit;
    Label30: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    dbeNomProfProhibicionTipo: TDBEdit;
    Label40: TLabel;
    dbcColProfProhibicionTipo: TDBColorComboBox;
    Label41: TLabel;
    dbeValProfProhibicionTipo: TDBEdit;
    Label42: TLabel;
    dedCompartir: TDirectoryEdit;
    bbtnCancel: TBitBtn;
    speRangoPolinizacion: TSpinEdit;
    Label43: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RxDBGridGetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);
    procedure CBRandomizeClick(Sender: TObject);
    procedure bbtnOkClick(Sender: TObject);
    procedure bbtnCancelClick(Sender: TObject);
    procedure edtNomColegioChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitRandom;
  end;

var
  ConfiguracionForm: TConfiguracionForm;

implementation

uses
  DMain, DMaster, rand, FMain;

{$R *.DFM}

procedure TConfiguracionForm.FormCreate(Sender: TObject);
begin
  with FormStorage do
  begin
    IniFileName := MainDataModule.dbMain.Directory + 'CONFIG.INI';
    RestoreFormPlacement;
  end;
end;

procedure TConfiguracionForm.FormDestroy(Sender: TObject);
begin
  FormStorage.SaveFormPlacement;
end;

procedure TConfiguracionForm.RxDBGridGetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; Highlight: Boolean);
begin
  if Assigned(Field) and (Copy(Field.FieldName, 1, 3) = 'Col') and not Field.isNull then
  begin
    Background := Field.AsInteger;
    AFont.Color := Field.AsInteger;
  end;
end;

procedure TConfiguracionForm.CBRandomizeClick(Sender: TObject);
begin
  with (Sender as TCheckbox) do
  begin
    speSeed1.Enabled := not Checked;
    speSeed2.Enabled := not Checked;
    speSeed3.Enabled := not Checked;
    speSeed4.Enabled := not Checked;
  end;
end;

procedure TConfiguracionForm.InitRandom;
begin
  if CBRandomize.Checked then
    srandom
  else
    setseeds(speSeed1.Value, speSeed2.Value, speSeed3.Value, speSeed4.Value);
end;

procedure TConfiguracionForm.bbtnOkClick(Sender: TObject);
begin
  MainDataModule.dbMain.Commit;
  FormStorage.SaveFormPlacement;
  with MasterDataModule.TbMateriaProhibicionTipo do
  begin
    CheckBrowseMode;
    FlushBuffers;
  end;
  with MasterDataModule.TbProfesorProhibicionTipo do
  begin
    CheckBrowseMode;
    FlushBuffers;
  end;
  if MainForm.Ejecutando then
    MainForm.AjustarPesos;
end;

procedure TConfiguracionForm.bbtnCancelClick(Sender: TObject);
begin
  FormStorage.RestoreFormPlacement;
  MainDataModule.dbMain.Rollback;
  MasterDataModule.TbMateriaProhibicionTipo.Refresh;
  MasterDataModule.TbProfesorProhibicionTipo.Refresh;
end;

procedure TConfiguracionForm.edtNomColegioChange(Sender: TObject);
begin
  MainForm.Caption := Application.Title + ' - ' + edtNomColegio.Text;
end;

end.

 