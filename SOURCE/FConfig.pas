unit FConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, CurrEdit, Buttons, ComCtrls, Spin, Grids, DBGrids,
  Db, DBCtrls;

type
  TConfiguracionForm = class(TForm)
    bbtnOk: TBitBtn;
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
    MemComentarios: TMemo;
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
    Label18: TLabel;
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
    dbcColMateProhibicionTipo: TDBComboBox;
    dbeValMateProhibicionTipo: TDBEdit;
    Label30: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    dbeNomProfProhibicionTipo: TDBEdit;
    Label40: TLabel;
    dbcColProfProhibicionTipo: TDBComboBox;
    Label41: TLabel;
    dbeValProfProhibicionTipo: TDBEdit;
    Label42: TLabel;
    dedCompartir: TDirectoryEdit;
    bbtnCancel: TBitBtn;
    speRangoPolinizacion: TSpinEdit;
    Label43: TLabel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBRandomizeClick(Sender: TObject);
    procedure edtNomColegioChange(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitRandom;
    procedure Clear;
    procedure LoadFromStrings(AStrings: TStrings);
    procedure SaveToStrings(AStrings: TStrings);
  end;

var
  ConfiguracionForm: TConfiguracionForm;

implementation

uses
  DSource, rand, FMain, RelUtils;

{$R *.DFM}

procedure TConfiguracionForm.FormCreate(Sender: TObject);
begin
  Clear;
end;

procedure TConfiguracionForm.FormDestroy(Sender: TObject);
begin
end;

procedure TConfiguracionForm.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  DBGrid: TCustomDBGrid;
begin
  DBGrid := Sender as TCustomDBGrid;
  if (Copy(Column.Field.FieldName, 1, 3) = 'Col') and not Column.Field.isNull then
    Column.Color := Column.Field.AsInteger
  else
    Column.Color := clWhite;
  DBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
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

procedure TConfiguracionForm.edtNomColegioChange(Sender: TObject);
begin
  MainForm.Caption := Application.Title + ' - ' + edtNomColegio.Text;
end;

procedure TConfiguracionForm.Clear;
begin
  edtNomColegio.Text := '';
  edtAnioLectivo.Text := '';
  edtNomAutoridad.Text := '';
  edtCarAutoridad.Text := '';
  speMaxCargaProfesor.Value := 20;
  lblHorarioSeleccionado.Caption := '(Ninguno)';
  MemComentarios.Clear;
  speSeed1.Value := 1;
  speSeed2.Value := 1;
  speSeed3.Value := 1;
  speSeed4.Value := 1;
  CBRandomize.Checked := False;
  speNumIteraciones.Value := 1;
  edtHorarioIni.Text := '';
  dedCompartir.Text := '';
  edtMostrarProfesorHorarioTexto.Text := 'AbrNivel + " " + NomParaleloId + " " + AbrEspecializacion + " " + NomMateria';
  speMostrarProfesorHorarioLongitud.Value := 20;
  edtProfesorHorarioExcluirProfProhibicion.Text := 'ProfesorProhibicion.CodProfProhibicionTipo NOT IN (0,1)';
  creCruceProfesor.Value := 200;
  creProfesorFraccionamiento.Value := 50;
  creCruceAulaTipo.Value := 200;
  creHoraHueca.Value := 100;
  creSesionCortada.Value := 150;
  creMateriaNoDispersa.Value := 5;
  speTamPoblacion.Value := 10;
  speNumMaxGeneracion.Value := 10000;
  creProbCruzamiento.Value := 0.30;
  creProbMutacion1.Value := 0.20;
  speOrdenMutacion1.Value := 3;
  creProbMutacion2.Value := 0.20;
  creProbReparacion.Value := 0.20;
  speRangoPolinizacion.Value := 1;
end;

procedure TConfiguracionForm.LoadFromStrings(AStrings: TStrings);
begin
  with AStrings do
  begin
    edtNomColegio.Text := Values['edtNomColegio_Text'];
    edtAnioLectivo.Text := Values['edtAnioLectivo_Text'];
    edtNomAutoridad.Text := Values['edtNomAutoridad_Text'];
    edtCarAutoridad.Text := Values['edtCarAutoridad_Text'];
    edtNomResponsable.Text := Values['edtNomResponsable_Text'];
    edtCarResponsable.Text := Values['edtCarResponsable_Text'];
    speMaxCargaProfesor.Value := StrToInt(Values['speMaxCargaProfesor_Value']);
    lblHorarioSeleccionado.Caption := Values['lblHorarioSeleccionado_Caption'];
    MemComentarios.Lines.Text := ScapedToString(Values['MemComentarios_Lines']);
    CBRandomize.Checked := StrToBool(Values['CBRandomize_Checked']);
    speSeed1.Value := StrToInt(Values['speSeed1_Value']);
    speSeed2.Value := StrToInt(Values['speSeed2_Value']);
    speSeed3.Value := StrToInt(Values['speSeed3_Value']);
    speSeed4.Value := StrToInt(Values['speSeed4_Value']);
    speNumIteraciones.Value := StrToInt(Values['speNumIteraciones_Value']);
    creCruceProfesor.Value := StrToFloat(Values['creCruceProfesor_Value']);
    creProfesorFraccionamiento.Value := StrToFloat(Values['creProfesorFraccionamiento_Value']);
    creCruceAulaTipo.Value := StrToFloat(Values['creCruceAulaTipo_Value']);
    creHoraHueca.Value := StrToFloat(Values['creHoraHueca_Value']);
    creSesionCortada.Value := StrToFloat(Values['creSesionCortada_Value']);
    creMateriaNoDispersa.Value := StrToFloat(Values['creMateriaNoDispersa_Value']);
    speTamPoblacion.Value := StrToInt(Values['speTamPoblacion_Value']);
    speNumMaxGeneracion.Value := StrToInt(Values['speNumMaxGeneracion_Value']);
    creProbCruzamiento.Value := StrToFloat(Values['creProbCruzamiento_Value']);
    creProbMutacion1.Value := StrToFloat(Values['creProbMutacion1_Value']);
    speOrdenMutacion1.Value := StrToInt(Values['speOrdenMutacion1_Value']);
    creProbMutacion2.Value := StrToFloat(Values['creProbMutacion2_Value']);
    creProbReparacion.Value := StrToFloat(Values['creProbReparacion_Value']);
    edtMostrarProfesorHorarioTexto.Text := Values['edtMostrarProfesorHorarioTexto_Text'];
    speMostrarProfesorHorarioLongitud.Value :=
      StrToInt(Values['speMostrarProfesorHorarioLongitud_Value']);
    edtProfesorHorarioExcluirProfProhibicion.Text :=
      Values['edtProfesorHorarioExcluirProfProhibicion_Text'];
    edtHorarioIni.Text := Values['edtHorarioIni_Text'];
    dedCompartir.Text := Values['dedCompartir_Text'];
    speRangoPolinizacion.Value := StrToInt(Values['speRangoPolinizacion_Value']);
  end;
end;

procedure TConfiguracionForm.SaveToStrings(AStrings: TStrings);
begin
  with AStrings do
  begin
    Values['edtNomColegio_Text'] := edtNomColegio.Text;
    Values['edtAnioLectivo_Text'] := edtAnioLectivo.Text;
    Values['edtNomAutoridad_Text'] := edtNomAutoridad.Text;
    Values['edtCarAutoridad_Text'] := edtCarAutoridad.Text;
    Values['edtNomResponsable_Text'] := edtNomResponsable.Text;
    Values['edtCarResponsable_Text'] := edtCarResponsable.Text;
    Values['speMaxCargaProfesor_Value'] := IntToStr(speMaxCargaProfesor.Value);
    Values['lblHorarioSeleccionado_Caption'] := lblHorarioSeleccionado.Caption;
    Values['MemComentarios_Lines'] := StringToScaped(MemComentarios.Lines.Text);
    Values['CBRandomize_Checked'] := BoolToStr(CBRandomize.Checked);
    Values['speSeed1_Value'] := IntToStr(speSeed1.Value);
    Values['speSeed2_Value'] := IntToStr(speSeed2.Value);
    Values['speSeed3_Value'] := IntToStr(speSeed3.Value);
    Values['speSeed4_Value'] := IntToStr(speSeed4.Value);
    Values['speNumIteraciones_Value'] := IntToStr(speNumIteraciones.Value);
    Values['creCruceProfesor_Value'] := FloatToStr(creCruceProfesor.Value);
    Values['creProfesorFraccionamiento_Value'] := FloatToStr(creProfesorFraccionamiento.Value);
    Values['creCruceAulaTipo_Value'] := FloatToStr(creCruceAulaTipo.Value);
    Values['creHoraHueca_Value'] := FloatToStr(creHoraHueca.Value);
    Values['creSesionCortada_Value'] := FloatToStr(creSesionCortada.Value);
    Values['creMateriaNoDispersa_Value'] := FloatToStr(creMateriaNoDispersa.Value);
    Values['speTamPoblacion_Value'] := IntToStr(speTamPoblacion.Value);
    Values['speNumMaxGeneracion_Value'] := IntToStr(speNumMaxGeneracion.Value);
    Values['creProbCruzamiento_Value'] := FloatToStr(creProbCruzamiento.Value);
    Values['creProbMutacion1_Value'] := FloatToStr(creProbMutacion1.Value);
    Values['speOrdenMutacion1_Value'] := IntToStr(speOrdenMutacion1.Value);
    Values['creProbMutacion2_Value'] := FloatToStr(creProbMutacion2.Value);
    Values['creProbReparacion_Value'] := FloatToStr(creProbReparacion.Value);
    Values['edtMostrarProfesorHorarioTexto_Text'] := edtMostrarProfesorHorarioTexto.Text;
    Values['speMostrarProfesorHorarioLongitud_Value'] :=
      IntToStr(speMostrarProfesorHorarioLongitud.Value);
    Values['edtProfesorHorarioExcluirProfProhibicion_Text'] :=
      edtProfesorHorarioExcluirProfProhibicion.Text;
    Values['edtHorarioIni_Text'] := edtHorarioIni.Text;
    Values['dedCompartir_Text'] := dedCompartir.Text;
    Values['speRangoPolinizacion_Value'] := IntToStr(speRangoPolinizacion.Value);
  end;
end;

end.

