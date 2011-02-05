unit FConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, Spin, Grids, DBGrids, DSource, DB,
  ExtCtrls, DBCtrls;

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
    creCruceProfesor: TEdit;
    creCruceAulaTipo: TEdit;
    creHoraHueca: TEdit;
    creSesionCortada: TEdit;
    creMateriaNoDispersa: TEdit;
    Label8: TLabel;
    creProbCruzamiento: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    creProbMutacion1: TEdit;
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
    creProbMutacion2: TEdit;
    creProbReparacion: TEdit;
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
    creProfesorFraccionamiento: TEdit;
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
    dbeValMateProhibicionTipo: TDBEdit;
    Label30: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    dbeNomProfProhibicionTipo: TDBEdit;
    Label40: TLabel;
    Label41: TLabel;
    dbeValProfProhibicionTipo: TDBEdit;
    Label42: TLabel;
    dedCompartir: TEdit;
    bbtnCancel: TBitBtn;
    speRangoPolinizacion: TSpinEdit;
    Label43: TLabel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    CBColMateProhibicionTipo: TColorBox;
    DSMateriaProhibicionTipo: TDataSource;
    DSProfesorProhibicionTipo: TDataSource;
    CBColProfProhibicionTipo: TColorBox;
    procedure CBRandomizeClick(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DSMateriaProhibicionTipoDataChange(Sender: TObject;
      Field: TField);
    procedure CBColMateProhibicionTipoExit(Sender: TObject);
    procedure CBColMateProhibicionTipoChange(Sender: TObject);
    procedure CBColProfProhibicionTipoChange(Sender: TObject);
    procedure CBColProfProhibicionTipoExit(Sender: TObject);
    procedure DSProfesorProhibicionTipoDataChange(Sender: TObject;
      Field: TField);
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
  FMain, RelUtils, DSrcBase;

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
      creCruceProfesor.Text := FloatToStr(CruceProfesor);
      creProfesorFraccionamiento.Text := FloatToStr(ProfesorFraccionamiento);
      creCruceAulaTipo.Text := FloatToStr(CruceAulaTipo);
      creHoraHueca.Text := FloatToStr(HoraHueca);
      creSesionCortada.Text := FloatToStr(SesionCortada);
      creMateriaNoDispersa.Text := FloatToStr(MateriaNoDispersa);
      speTamPoblacion.Value := TamPoblacion;
      speNumMaxGeneracion.Value := NumMaxGeneracion;
      creProbCruzamiento.Text := FloatToStr(ProbCruzamiento);
      creProbMutacion1.Text := FloatToStr(ProbMutacion1);
      speOrdenMutacion1.Value := OrdenMutacion1;
      creProbMutacion2.Text := FloatToStr(ProbMutacion2);
      creProbReparacion.Text := FloatToStr(ProbReparacion);
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
      CruceProfesor := StrToFloat(creCruceProfesor.Text);
      ProfesorFraccionamiento := StrToFloat(creProfesorFraccionamiento.Text);
      CruceAulaTipo := StrToFloat(creCruceAulaTipo.Text);
      HoraHueca := StrToFloat(creHoraHueca.Text);
      SesionCortada := StrToFloat(creSesionCortada.Text);
      MateriaNoDispersa := StrToFloat(creMateriaNoDispersa.Text);
      TamPoblacion := speTamPoblacion.Value;
      NumMaxGeneracion := speNumMaxGeneracion.Value;
      ProbCruzamiento := StrToFloat(creProbCruzamiento.Text);
      ProbMutacion1 := StrToFloat(creProbMutacion1.Text);
      OrdenMutacion1 := speOrdenMutacion1.Value;
      ProbMutacion2 := StrToFloat(creProbMutacion2.Text);
      ProbReparacion := StrToFloat(creProbReparacion.Text);
      MostrarProfesorHorarioTexto := edtMostrarProfesorHorarioTexto.Text;
      MostrarProfesorHorarioLongitud := speMostrarProfesorHorarioLongitud.Value;
      ProfesorHorarioExcluirProfProhibicion
        := edtProfesorHorarioExcluirProfProhibicion.Text;
      HorarioIni := edtHorarioIni.Text;
      Compartir := dedCompartir.Text;
      RangoPolinizacion := speRangoPolinizacion.Value;
   end;
end;

procedure TConfiguracionForm.DSMateriaProhibicionTipoDataChange(
  Sender: TObject; Field: TField);
begin
  CBColMateProhibicionTipo.Selected :=
    SourceDataModule.TbMateriaProhibicionTipoColMateProhibicionTipo.Value;
end;

procedure TConfiguracionForm.CBColMateProhibicionTipoExit(Sender: TObject);
begin
  with SourceDataModule.TbMateriaProhibicionTipoColMateProhibicionTipo do
    if (DSMateriaProhibicionTipo.State in [dsEdit, dsInsert])
        and (Value <> CBColMateProhibicionTipo.Selected) then
      Value := CBColMateProhibicionTipo.Selected;
end;

procedure TConfiguracionForm.CBColMateProhibicionTipoChange(Sender: TObject);
begin
  with DSMateriaProhibicionTipo do
  begin
    OnDataChange := nil;
    Edit;
    OnDataChange := DSMateriaProhibicionTipoDataChange;
  end
end;

procedure TConfiguracionForm.CBColProfProhibicionTipoChange(Sender: TObject);
begin
  with DSProfesorProhibicionTipo do
  begin
    OnDataChange := nil;
    Edit;
    OnDataChange := DSProfesorProhibicionTipoDataChange;
  end
end;

procedure TConfiguracionForm.CBColProfProhibicionTipoExit(Sender: TObject);
begin
  with SourceDataModule.TbProfesorProhibicionTipoColProfProhibicionTipo do
    if (DSProfesorProhibicionTipo.State in [dsEdit, dsInsert])
        and (Value <> CBColProfProhibicionTipo.Selected) then
      Value := CBColProfProhibicionTipo.Selected;
end;

procedure TConfiguracionForm.DSProfesorProhibicionTipoDataChange(
  Sender: TObject; Field: TField);
begin
  CBColProfProhibicionTipo.Selected
    := SourceDataModule.TbProfesorProhibicionTipoColProfProhibicionTipo.Value;
end;

end.

