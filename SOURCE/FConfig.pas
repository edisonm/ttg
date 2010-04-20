unit FConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, CurrEdit, Buttons, ComCtrls, Spin, Grids, DBGrids,
  Db, DSource, DBCtrls;

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
    procedure CBRandomizeClick(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadFromSourceDataModule;
    procedure SaveToSourceDataModule;
  end;

function ShowConfiguracionForm(AHelpContext: THelpContext): Integer;

implementation

uses
  FMain, RelUtils;

{$R *.DFM}

function ShowConfiguracionForm(AHelpContext: THelpContext): Integer;
var
   ConfiguracionForm: TConfiguracionForm;
begin
   ConfiguracionForm := TConfiguracionForm.Create(nil);
   with ConfiguracionForm do
      try
         HelpContext := AHelpContext;
         LoadFromSourceDataModule;
         Result := ShowModal;
         if Result = mrOk then
	    SaveToSourceDataModule;
      finally
         Free;
      end;
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

procedure TConfiguracionForm.LoadFromSourceDataModule;
begin
   with SourceDataModule do
   begin
      edtNomColegio.Text := NomColegio;
      edtAnioLectivo.Text := AnioLectivo;
      edtNomAutoridad.Text := NomAutoridad;
      edtCarAutoridad.Text := CarAutoridad;
      edtNomResponsable.Text := NomResponsable;
      edtCarResponsable.Text := CarResponsable;
      speMaxCargaProfesor.Value := MaxCargaProfesor;
      lblHorarioSeleccionado.Caption := IntToStr(HorarioSeleccionado);
      MemComentarios.Lines.Text := Comentarios;
      CBRandomize.Checked := Randomize;
      speSeed1.Value := Seed1;
      speSeed2.Value := Seed2;
      speSeed3.Value := Seed3;
      speSeed4.Value := Seed4;
      speNumIteraciones.Value := NumIteraciones;
      creCruceProfesor.Value := CruceProfesor;
      creProfesorFraccionamiento.Value := ProfesorFraccionamiento;
      creCruceAulaTipo.Value := CruceAulaTipo;
      creHoraHueca.Value := HoraHueca;
      creSesionCortada.Value := SesionCortada;
      creMateriaNoDispersa.Value := MateriaNoDispersa;
      speTamPoblacion.Value := TamPoblacion;
      speNumMaxGeneracion.Value := NumMaxGeneracion;
      creProbCruzamiento.Value := ProbCruzamiento;
      creProbMutacion1.Value := ProbMutacion1;
      speOrdenMutacion1.Value := OrdenMutacion1;
      creProbMutacion2.Value := ProbMutacion2;
      creProbReparacion.Value := ProbReparacion;
      edtMostrarProfesorHorarioTexto.Text := MostrarProfesorHorarioTexto;
      speMostrarProfesorHorarioLongitud.Value := MostrarProfesorHorarioLongitud;
      edtProfesorHorarioExcluirProfProhibicion.Text := ProfesorHorarioExcluirProfProhibicion;
      edtHorarioIni.Text := HorarioIni;
      dedCompartir.Text := Compartir;
      speRangoPolinizacion.Value := RangoPolinizacion;
   end;
end;

procedure TConfiguracionForm.SaveToSourceDataModule;
begin
   with SourceDataModule do
   begin
      NomColegio := edtNomColegio.Text;
      AnioLectivo := edtAnioLectivo.Text;
      NomAutoridad := edtNomAutoridad.Text;
      CarAutoridad := edtCarAutoridad.Text;
      NomResponsable := edtNomResponsable.Text;
      CarResponsable := edtCarResponsable.Text;
      MaxCargaProfesor := speMaxCargaProfesor.Value;
      HorarioSeleccionado := StrToInt(lblHorarioSeleccionado.Caption);
      Comentarios := MemComentarios.Lines.Text;
      Randomize := CBRandomize.Checked;
      Seed1 := speSeed1.Value;
      Seed2 := speSeed2.Value;
      Seed3 := speSeed3.Value;
      Seed4 := speSeed4.Value;
      NumIteraciones := speNumIteraciones.Value;
      CruceProfesor := creCruceProfesor.Value;
      ProfesorFraccionamiento := creProfesorFraccionamiento.Value;
      CruceAulaTipo := creCruceAulaTipo.Value;
      HoraHueca := creHoraHueca.Value;
      SesionCortada := creSesionCortada.Value;
      MateriaNoDispersa := creMateriaNoDispersa.Value;
      TamPoblacion := speTamPoblacion.Value;
      NumMaxGeneracion := speNumMaxGeneracion.Value;
      ProbCruzamiento := creProbCruzamiento.Value;
      ProbMutacion1 := creProbMutacion1.Value;
      OrdenMutacion1 := speOrdenMutacion1.Value;
      ProbMutacion2 := creProbMutacion2.Value;
      ProbReparacion := creProbReparacion.Value;
      MostrarProfesorHorarioTexto := edtMostrarProfesorHorarioTexto.Text;
      MostrarProfesorHorarioLongitud := speMostrarProfesorHorarioLongitud.Value;
      ProfesorHorarioExcluirProfProhibicion := edtProfesorHorarioExcluirProfProhibicion.Text;
      HorarioIni := edtHorarioIni.Text;
      Compartir := dedCompartir.Text;
      RangoPolinizacion := speRangoPolinizacion.Value;
   end;
end;

end.
