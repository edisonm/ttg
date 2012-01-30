{ -*- mode: Delphi -*- }
unit FConfiguracion;

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
    creClashSubject: TEdit;
    creProbCruzamiento: TEdit;
    creMutationProb: TEdit;
    creProbReparacion: TEdit;
    edBookmarks: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label43: TLabel;
    Label8: TLabel;
    pgcConfig: TPageControl;
    speNumMaxGeneracion: TSpinEdit;
    crePollinationProb: TEdit;
    speTamPoblacion: TSpinEdit;
    tbsPesos: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    creClashTeacher: TEdit;
    creClashRoomType: TEdit;
    creHourHueca: TEdit;
    creSessionCortada: TEdit;
    creSubjectNoDispersa: TEdit;
    tbsUnidadEducativa: TTabSheet;
    Label14: TLabel;
    speMaxCargaTeacher: TSpinEdit;
    MemComentarios: TMemo;
    lblComentarios: TLabel;
    Label17: TLabel;
    edtNaInstitution: TEdit;
    Label15: TLabel;
    Label18: TLabel;
    tbsOpciones: TTabSheet;
    CBRandomize: TCheckBox;
    Label19: TLabel;
    speSeed: TSpinEdit;
    Label4: TLabel;
    edtNaResponsable: TEdit;
    Label25: TLabel;
    edtCarResponsable: TEdit;
    Label26: TLabel;
    edtNaAutoridad: TEdit;
    edtCarAutoridad: TEdit;
    Label27: TLabel;
    Label29: TLabel;
    speNumIteraciones: TSpinEdit;
    Label31: TLabel;
    edtAnioLectivo: TEdit;
    Label16: TLabel;
    creTeacherFraccionamiento: TEdit;
    Label36: TLabel;
    edtTimeTableIni: TEdit;
    dbeNaSubjectRestrictionType: TDBEdit;
    dbeValSubjectRestrictionType: TDBEdit;
    Label30: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    dbeNaTeacherRestrictionType: TDBEdit;
    Label40: TLabel;
    Label41: TLabel;
    dbeValTeacherRestrictionType: TDBEdit;
    Label42: TLabel;
    dedSharedDirectory: TDirectoryEdit;
    bbtnCancel: TBitBtn;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    CBColSubjectRestrictionType: TColorBox;
    DSSubjectRestrictionType: TDataSource;
    DSTeacherRestrictionType: TDataSource;
    CBColTeacherRestrictionType: TColorBox;
    procedure CBRandomizeClick(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DSSubjectRestrictionTypeDataChange(Sender: TObject;
      Field: TField);
    procedure CBColSubjectRestrictionTypeExit(Sender: TObject);
    procedure CBColSubjectRestrictionTypeChange(Sender: TObject);
    procedure CBColTeacherRestrictionTypeChange(Sender: TObject);
    procedure CBColTeacherRestrictionTypeExit(Sender: TObject);
    procedure DSTeacherRestrictionTypeDataChange(Sender: TObject;
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
  DSourceBase;

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
      edtNaInstitution.Text := NaInstitution;
      edtAnioLectivo.Text := AnioLectivo;
      edtNaAutoridad.Text := NaAutoridad;
      edtCarAutoridad.Text := CarAutoridad;
      edtNaResponsable.Text := NaResponsable;
      edtCarResponsable.Text := CarResponsable;
      speMaxCargaTeacher.Value := MaxCargaTeacher;
      MemComentarios.Lines.Text := Comentarios;
      CBRandomize.Checked := Randomize;
      speSeed.Value := Seed;
      speNumIteraciones.Value := RefreshInterval;
      creClashTeacher.Text := FloatToStr(ClashTeacher);
      creClashSubject.Text := FloatToStr(ClashSubject);
      creClashRoomType.Text := FloatToStr(ClashRoomType);
      creTeacherFraccionamiento.Text := FloatToStr(TeacherFraccionamiento);
      creHourHueca.Text := FloatToStr(HourHuecaDesubicada);
      creSessionCortada.Text := FloatToStr(SessionCortada);
      creSubjectNoDispersa.Text := FloatToStr(SubjectNoDispersa);
      speTamPoblacion.Value := PopulationSize;
      speNumMaxGeneracion.Value := MaxIteration;
      creProbCruzamiento.Text := FloatToStr(CrossProb);
      creMutationProb.Text := FloatToStr(MutationProb);
      creProbReparacion.Text := FloatToStr(RepairProb);
      edtTimeTableIni.Text := TimeTableIni;
      dedSharedDirectory.Directory := SharedDirectory;
      crePollinationProb.Text := FloatToStr(PollinationProb);
      CBApplyDoubleDownHill.Checked := ApplyDoubleDownHill;
      edBookmarks.Text := Bookmarks;
   end;
end;

procedure TConfiguracionForm.SaveToSourceDataModule;
begin
   with MasterDataModule.ConfigStorage do
   begin
      NaInstitution := edtNaInstitution.Text;
      AnioLectivo := edtAnioLectivo.Text;
      NaAutoridad := edtNaAutoridad.Text;
      CarAutoridad := edtCarAutoridad.Text;
      NaResponsable := edtNaResponsable.Text;
      CarResponsable := edtCarResponsable.Text;
      MaxCargaTeacher := speMaxCargaTeacher.Value;
      Comentarios := MemComentarios.Lines.Text;
      Randomize := CBRandomize.Checked;
      Seed := speSeed.Value;
      RefreshInterval := speNumIteraciones.Value;
      ClashTeacher := StrToInt(creClashTeacher.Text);
      ClashSubject := StrToInt(creClashSubject.Text);
      ClashRoomType := StrToInt(creClashRoomType.Text);
      TeacherFraccionamiento := StrToInt(creTeacherFraccionamiento.Text);
      HourHuecaDesubicada := StrToInt(creHourHueca.Text);
      SessionCortada := StrToInt(creSessionCortada.Text);
      SubjectNoDispersa := StrToInt(creSubjectNoDispersa.Text);
      PopulationSize := speTamPoblacion.Value;
      MaxIteration := speNumMaxGeneracion.Value;
      CrossProb := StrToFloat(creProbCruzamiento.Text);
      MutationProb := StrToFloat(creMutationProb.Text);
      RepairProb := StrToFloat(creProbReparacion.Text);
      TimeTableIni := edtTimeTableIni.Text;
      SharedDirectory := dedSharedDirectory.Directory;
      PollinationProb := StrToFloat(crePollinationProb.Text);
      ApplyDoubleDownHill := CBApplyDoubleDownHill.Checked;
      Bookmarks := edBookmarks.Text;
   end;
end;

procedure TConfiguracionForm.DSSubjectRestrictionTypeDataChange(Sender: TObject; Field: TField);
begin
  CBColSubjectRestrictionType.Selected :=
    SourceDataModule.TbSubjectRestrictionType.FindField('ColSubjectRestrictionType').AsInteger;
end;

procedure TConfiguracionForm.CBColSubjectRestrictionTypeExit(Sender: TObject);
begin
  with SourceDataModule.TbSubjectRestrictionType.FindField('ColSubjectRestrictionType') do
    if (DSSubjectRestrictionType.State in [dsEdit, dsInsert])
        and (AsInteger <> CBColSubjectRestrictionType.Selected) then
      AsInteger := CBColSubjectRestrictionType.Selected;
end;

procedure TConfiguracionForm.bbtnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TConfiguracionForm.bbtnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TConfiguracionForm.CBColSubjectRestrictionTypeChange(Sender: TObject);
begin
  with DSSubjectRestrictionType do
  begin
    OnDataChange := nil;
    Edit;
    OnDataChange := DSSubjectRestrictionTypeDataChange;
  end
end;

procedure TConfiguracionForm.CBColTeacherRestrictionTypeChange(Sender: TObject);
begin
  with DSTeacherRestrictionType do
  begin
    OnDataChange := nil;
    Edit;
    OnDataChange := DSTeacherRestrictionTypeDataChange;
  end
end;

procedure TConfiguracionForm.CBColTeacherRestrictionTypeExit(Sender: TObject);
begin
  with SourceDataModule.TbTeacherRestrictionType.FindField('ColTeacherRestrictionType') do
    if (DSTeacherRestrictionType.State in [dsEdit, dsInsert])
        and (AsInteger <> CBColTeacherRestrictionType.Selected) then
      AsInteger := CBColTeacherRestrictionType.Selected;
end;

procedure TConfiguracionForm.DSTeacherRestrictionTypeDataChange(
  Sender: TObject; Field: TField);
begin
  CBColTeacherRestrictionType.Selected
    := SourceDataModule.TbTeacherRestrictionType.FindField('ColTeacherRestrictionType').AsInteger;
end;

initialization
{$IFDEF FPC}
  {$i fconfiguracion.lrs}
{$ENDIF}

end.

