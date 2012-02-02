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
    bbtOk: TBitBtn;
    cbxApplyDoubleDownHill: TCheckBox;
    creClashSubject: TEdit;
    creCrossProb: TEdit;
    creMutationProb: TEdit;
    creProbRepair: TEdit;
    edBookmarks: TEdit;
    lblCrossProb: TLabel;
    lblMutationProb: TLabel;
    lblRepairProb: TLabel;
    Label13: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    lblPollinationProb: TLabel;
    Label8: TLabel;
    lblMaxTeacherWorkLoad: TLabel;
    pgcConfig: TPageControl;
    speNumMaxGeneracion: TSpinEdit;
    crePollinationProb: TEdit;
    speTamPoblacion: TSpinEdit;
    tbsWeigths: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    lblEmptyHours: TLabel;
    lblBrokenSubjects: TLabel;
    lblJoinSubjects: TLabel;
    creClashTeacher: TEdit;
    creClashRoomType: TEdit;
    creHourHueca: TEdit;
    creBrokenSession: TEdit;
    creNonScatteredSubject: TEdit;
    tbsInstitution: TTabSheet;
    Label14: TLabel;
    speMaxTeacherWorkLoad: TSpinEdit;
    memComments: TMemo;
    lblComments: TLabel;
    lblInstitutionName: TLabel;
    edtNaInstitution: TEdit;
    Label15: TLabel;
    Label18: TLabel;
    tbsOptions: TTabSheet;
    cbxRandomize: TCheckBox;
    lblSeed: TLabel;
    speSeed: TSpinEdit;
    lblResponsible: TLabel;
    edtNaResponsible: TEdit;
    lblResponsiblePosition: TLabel;
    edtPosResponsible: TEdit;
    lblAuthority: TLabel;
    edtNaAuthority: TEdit;
    edtPosAuthority: TEdit;
    lblAuthorityPosition: TLabel;
    Label29: TLabel;
    speNumIterations: TSpinEdit;
    lblSchoolYear: TLabel;
    edtAnioLectivo: TEdit;
    lblBrokenTTTeachers: TLabel;
    creBrokenTTTeacher: TEdit;
    Label36: TLabel;
    edtTimeTableIni: TEdit;
    dbeNaSubjectRestrictionType: TDBEdit;
    dbeValSubjectRestrictionType: TDBEdit;
    lblSRName: TLabel;
    lblSRColor: TLabel;
    lblSRValue: TLabel;
    lblTRName: TLabel;
    dbeNaTeacherRestrictionType: TDBEdit;
    lblTRColor: TLabel;
    lblTRValue: TLabel;
    dbeValTeacherRestrictionType: TDBEdit;
    Label42: TLabel;
    dedSharedDirectory: TDirectoryEdit;
    bbtCancel: TBitBtn;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    CBColSubjectRestrictionType: TColorBox;
    DSSubjectRestrictionType: TDataSource;
    DSTeacherRestrictionType: TDataSource;
    CBColTeacherRestrictionType: TColorBox;
    procedure cbxRandomizeClick(Sender: TObject);
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
    procedure bbtOkClick(Sender: TObject);
    procedure bbtCancelClick(Sender: TObject);
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

procedure TConfiguracionForm.cbxRandomizeClick(Sender: TObject);
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
      edtNaAuthority.Text := NaAuthority;
      edtPosAuthority.Text := PosAuthority;
      edtNaResponsible.Text := NaResponsible;
      edtPosResponsible.Text := PosResponsible;
      speMaxTeacherWorkLoad.Value := MaxTeacherWorkLoad;
      memComments.Lines.Text := Comments;
      cbxRandomize.Checked := Randomize;
      speSeed.Value := Seed;
      speNumIterations.Value := RefreshInterval;
      creClashTeacher.Text := FloatToStr(ClashTeacher);
      creClashSubject.Text := FloatToStr(ClashSubject);
      creClashRoomType.Text := FloatToStr(ClashRoomType);
      creBrokenTTTeacher.Text := FloatToStr(BrokenTTTeacher);
      creHourHueca.Text := FloatToStr(OutOfPositionEmptyHour);
      creBrokenSession.Text := FloatToStr(BrokenSession);
      creNonScatteredSubject.Text := FloatToStr(NonScatteredSubject);
      speTamPoblacion.Value := PopulationSize;
      speNumMaxGeneracion.Value := MaxIteration;
      creCrossProb.Text := FloatToStr(CrossProb);
      creMutationProb.Text := FloatToStr(MutationProb);
      creProbRepair.Text := FloatToStr(RepairProb);
      edtTimeTableIni.Text := TimeTableIni;
      dedSharedDirectory.Directory := SharedDirectory;
      crePollinationProb.Text := FloatToStr(PollinationProb);
      cbxApplyDoubleDownHill.Checked := ApplyDoubleDownHill;
      edBookmarks.Text := Bookmarks;
   end;
end;

procedure TConfiguracionForm.SaveToSourceDataModule;
begin
   with MasterDataModule.ConfigStorage do
   begin
      NaInstitution := edtNaInstitution.Text;
      AnioLectivo := edtAnioLectivo.Text;
      NaAuthority := edtNaAuthority.Text;
      PosAuthority := edtPosAuthority.Text;
      NaResponsible := edtNaResponsible.Text;
      PosResponsible := edtPosResponsible.Text;
      MaxTeacherWorkLoad := speMaxTeacherWorkLoad.Value;
      Comments := memComments.Lines.Text;
      Randomize := cbxRandomize.Checked;
      Seed := speSeed.Value;
      RefreshInterval := speNumIterations.Value;
      ClashTeacher := StrToInt(creClashTeacher.Text);
      ClashSubject := StrToInt(creClashSubject.Text);
      ClashRoomType := StrToInt(creClashRoomType.Text);
      BrokenTTTeacher := StrToInt(creBrokenTTTeacher.Text);
      OutOfPositionEmptyHour := StrToInt(creHourHueca.Text);
      BrokenSession := StrToInt(creBrokenSession.Text);
      NonScatteredSubject := StrToInt(creNonScatteredSubject.Text);
      PopulationSize := speTamPoblacion.Value;
      MaxIteration := speNumMaxGeneracion.Value;
      CrossProb := StrToFloat(creCrossProb.Text);
      MutationProb := StrToFloat(creMutationProb.Text);
      RepairProb := StrToFloat(creProbRepair.Text);
      TimeTableIni := edtTimeTableIni.Text;
      SharedDirectory := dedSharedDirectory.Directory;
      PollinationProb := StrToFloat(crePollinationProb.Text);
      ApplyDoubleDownHill := cbxApplyDoubleDownHill.Checked;
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

procedure TConfiguracionForm.bbtCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TConfiguracionForm.bbtOkClick(Sender: TObject);
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

