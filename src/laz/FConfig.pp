unit FConfig;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}ColorBox, LResources{$ELSE}Mask, Windows{$ENDIF}, SysUtils, Grids,
  Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ComCtrls,
  Spin, DBGrids, DSource, DMaster, DB, ExtCtrls, DBCtrls, EditBtn;

type

  { TConfiguracionForm }

  TConfiguracionForm = class(TForm)
    bbtnOk: TBitBtn;
    CBApplyDoubleDownHill: TCheckBox;
    creCruceMateria: TEdit;
    creProbCruzamiento: TEdit;
    creProbMutacion1: TEdit;
    creProbMutacion2: TEdit;
    creProbReparacion: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label20: TLabel;
    Label43: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    pgcConfig: TPageControl;
    speNumMaxGeneracion: TSpinEdit;
    speOrdenMutacion1: TSpinEdit;
    speRangoPolinizacion: TSpinEdit;
    speTamPoblacion: TSpinEdit;
    tbsPesos: TTabSheet;
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
    tbsUnidadEducativa: TTabSheet;
    Label14: TLabel;
    speMaxCargaProfesor: TSpinEdit;
    MemComentarios: TMemo;
    lblComentarios: TLabel;
    Label17: TLabel;
    edtNomColegio: TEdit;
    Label15: TLabel;
    Label18: TLabel;
    tbsOpciones: TTabSheet;
    CBRandomize: TCheckBox;
    Label19: TLabel;
    speSeed: TSpinEdit;
    Label4: TLabel;
    edtNomResponsable: TEdit;
    Label25: TLabel;
    edtCarResponsable: TEdit;
    Label26: TLabel;
    edtNomAutoridad: TEdit;
    edtCarAutoridad: TEdit;
    Label27: TLabel;
    Label29: TLabel;
    speNumIteraciones: TSpinEdit;
    Label31: TLabel;
    edtAnioLectivo: TEdit;
    Label16: TLabel;
    creProfesorFraccionamiento: TEdit;
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
    dedSharedDirectory: TDirectoryEdit;
    bbtnCancel: TBitBtn;
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
    procedure bbtnOkClick(Sender: TObject);
    procedure bbtnCancelClick(Sender: TObject);
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
  DSrcBase;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

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
    speSeed.Enabled := not Checked;
  end;
end;

procedure TConfiguracionForm.LoadFromSourceDataModule;
begin
   with MasterDataModule.ConfigStorage do
   begin
      edtNomColegio.Text := NomColegio;
      edtAnioLectivo.Text := AnioLectivo;
      edtNomAutoridad.Text := NomAutoridad;
      edtCarAutoridad.Text := CarAutoridad;
      edtNomResponsable.Text := NomResponsable;
      edtCarResponsable.Text := CarResponsable;
      speMaxCargaProfesor.Value := MaxCargaProfesor;
      MemComentarios.Lines.Text := Comentarios;
      CBRandomize.Checked := Randomize;
      speSeed.Value := Seed;
      speNumIteraciones.Value := RefreshInterval;
      creCruceProfesor.Text := FloatToStr(CruceProfesor);
      creCruceMateria.Text := FloatToStr(CruceMateria);
      creCruceAulaTipo.Text := FloatToStr(CruceAulaTipo);
      creProfesorFraccionamiento.Text := FloatToStr(ProfesorFraccionamiento);
      creHoraHueca.Text := FloatToStr(HoraHueca);
      creSesionCortada.Text := FloatToStr(SesionCortada);
      creMateriaNoDispersa.Text := FloatToStr(MateriaNoDispersa);
      speTamPoblacion.Value := PopulationSize;
      speNumMaxGeneracion.Value := MaxIteration;
      creProbCruzamiento.Text := FloatToStr(CrossProb);
      creProbMutacion1.Text := FloatToStr(Mutation1Prob);
      speOrdenMutacion1.Value := Mutation1Order;
      creProbMutacion2.Text := FloatToStr(Mutation2Prob);
      creProbReparacion.Text := FloatToStr(RepairProb);
      edtHorarioIni.Text := HorarioIni;
      dedSharedDirectory.Directory := SharedDirectory;
      speRangoPolinizacion.Value := PollinationFreq;
      CBApplyDoubleDownHill.Checked := ApplyDoubleDownHill;
   end;
end;

procedure TConfiguracionForm.SaveToSourceDataModule;
begin
   with MasterDataModule.ConfigStorage do
   begin
      NomColegio := edtNomColegio.Text;
      AnioLectivo := edtAnioLectivo.Text;
      NomAutoridad := edtNomAutoridad.Text;
      CarAutoridad := edtCarAutoridad.Text;
      NomResponsable := edtNomResponsable.Text;
      CarResponsable := edtCarResponsable.Text;
      MaxCargaProfesor := speMaxCargaProfesor.Value;
      Comentarios := MemComentarios.Lines.Text;
      Randomize := CBRandomize.Checked;
      Seed := speSeed.Value;
      RefreshInterval := speNumIteraciones.Value;
      CruceProfesor := StrToFloat(creCruceProfesor.Text);
      CruceMateria := StrToFloat(creCruceMateria.Text);
      CruceAulaTipo := StrToFloat(creCruceAulaTipo.Text);
      ProfesorFraccionamiento := StrToFloat(creProfesorFraccionamiento.Text);
      HoraHueca := StrToFloat(creHoraHueca.Text);
      SesionCortada := StrToFloat(creSesionCortada.Text);
      MateriaNoDispersa := StrToFloat(creMateriaNoDispersa.Text);
      PopulationSize := speTamPoblacion.Value;
      MaxIteration := speNumMaxGeneracion.Value;
      CrossProb := StrToFloat(creProbCruzamiento.Text);
      Mutation1Prob := StrToFloat(creProbMutacion1.Text);
      Mutation1Order := speOrdenMutacion1.Value;
      Mutation2Prob := StrToFloat(creProbMutacion2.Text);
      RepairProb := StrToFloat(creProbReparacion.Text);
      HorarioIni := edtHorarioIni.Text;
      SharedDirectory := dedSharedDirectory.Text;
      PollinationFreq := speRangoPolinizacion.Value;
      ApplyDoubleDownHill := CBApplyDoubleDownHill.Checked;
   end;
end;

procedure TConfiguracionForm.DSMateriaProhibicionTipoDataChange(Sender: TObject; Field: TField);
begin
  CBColMateProhibicionTipo.Selected :=
    SourceDataModule.TbMateriaProhibicionTipo.FindField('ColMateProhibicionTipo').AsInteger;
end;

procedure TConfiguracionForm.CBColMateProhibicionTipoExit(Sender: TObject);
begin
  with SourceDataModule.TbMateriaProhibicionTipo.FindField('ColMateProhibicionTipo') do
    if (DSMateriaProhibicionTipo.State in [dsEdit, dsInsert])
        and (AsInteger <> CBColMateProhibicionTipo.Selected) then
      AsInteger := CBColMateProhibicionTipo.Selected;
end;

procedure TConfiguracionForm.bbtnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TConfiguracionForm.bbtnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
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
  with SourceDataModule.TbProfesorProhibicionTipo.FindField('ColProfProhibicionTipo') do
    if (DSProfesorProhibicionTipo.State in [dsEdit, dsInsert])
        and (AsInteger <> CBColProfProhibicionTipo.Selected) then
      AsInteger := CBColProfProhibicionTipo.Selected;
end;

procedure TConfiguracionForm.DSProfesorProhibicionTipoDataChange(
  Sender: TObject; Field: TField);
begin
  CBColProfProhibicionTipo.Selected
    := SourceDataModule.TbProfesorProhibicionTipo.FindField('ColProfProhibicionTipo').AsInteger;
end;

initialization
{$IFDEF FPC}
  {$i FConfig.lrs}
{$ENDIF}

end.

