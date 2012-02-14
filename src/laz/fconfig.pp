{ -*- mode: Delphi -*- }
unit fconfig;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}ColorBox, LResources{$ELSE}Mask, Windows{$ENDIF}, SysUtils, Grids,
  Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ComCtrls,
  Spin, DBGrids, DSource, DMaster, DB, ExtCtrls, DBCtrls, EditBtn;

type

  { TConfigForm }

  TConfigForm = class(TForm)
    BBOk: TBitBtn;
    cbxApplyDoubleDownHill: TCheckBox;
    creClashSubject: TEdit;
    creCrossProbability: TEdit;
    creMutationProbability: TEdit;
    creReparationProbability: TEdit;
    edBookmarks: TEdit;
    LbCrossProbability: TLabel;
    LbMutationProbability: TLabel;
    LbReparationProbability: TLabel;
    Label13: TLabel;
    Label20: TLabel;
    LbDownhillLevels: TLabel;
    LbPollinationProbability: TLabel;
    LbPopulationSize: TLabel;
    LbMaxTeacherWorkLoad: TLabel;
    PCConfig: TPageControl;
    SEMaxIteration: TSpinEdit;
    crePollinationProbability: TEdit;
    spePopulationSize: TSpinEdit;
    tbsWeigths: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    LbEmptyHours: TLabel;
    LbBrokenSubjects: TLabel;
    LbJoinedSubjects: TLabel;
    creClashTeacher: TEdit;
    creClashRoomType: TEdit;
    creEmptyHour: TEdit;
    creBrokenSession: TEdit;
    creNonScatteredSubject: TEdit;
    TSInstitution: TTabSheet;
    Label14: TLabel;
    SEMaxTeacherWorkLoad: TSpinEdit;
    MeComments: TMemo;
    LbComments: TLabel;
    LbInstitutionName: TLabel;
    EdNaInstitution: TEdit;
    Label15: TLabel;
    Label18: TLabel;
    TSOptions: TTabSheet;
    cbxRandomize: TCheckBox;
    LbSeed: TLabel;
    speSeed: TSpinEdit;
    LbResponsible: TLabel;
    EdNameResponsible: TEdit;
    LbResponsiblePosition: TLabel;
    EdPositionResponsible: TEdit;
    LbAuthority: TLabel;
    EdNameAuthority: TEdit;
    EdPositionAuthority: TEdit;
    LbAuthorityPosition: TLabel;
    Label29: TLabel;
    speNumIterations: TSpinEdit;
    LbSchoolYear: TLabel;
    EdSchoolYear: TEdit;
    LbBreakTimetableTeacher: TLabel;
    creBreakTimetableTeacher: TEdit;
    LbInitialTimetables: TLabel;
    EdInitialTimetables: TEdit;
    dbeNaSubjectRestrictionType: TDBEdit;
    dbeValSubjectRestrictionType: TDBEdit;
    LbSRName: TLabel;
    LbSRColor: TLabel;
    LbSRValue: TLabel;
    LbTRName: TLabel;
    dbeNaTeacherRestrictionType: TDBEdit;
    LbTRColor: TLabel;
    LbTRValue: TLabel;
    dbeValTeacherRestrictionType: TDBEdit;
    LbSharedDirectory: TLabel;
    dedSharedDirectory: TDirectoryEdit;
    BBCancel: TBitBtn;
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
    procedure BBOkClick(Sender: TObject);
    procedure BBCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadFromSourceDataModule;
    procedure SaveToSourceDataModule;
  end;

function ShowConfigForm(AHelpContext: THelpContext): Integer;

implementation

uses
  DSourceBase;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

function ShowConfigForm(AHelpContext: THelpContext): Integer;
var
   ConfigForm: TConfigForm;
begin
   ConfigForm := TConfigForm.Create(nil);
   with ConfigForm do
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

procedure TConfigForm.DBGridDrawColumnCell(Sender: TObject;
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

procedure TConfigForm.cbxRandomizeClick(Sender: TObject);
begin
  with (Sender as TCheckbox) do
  begin
    speSeed.Enabled := not Checked;
  end;
end;

procedure TConfigForm.LoadFromSourceDataModule;
begin
   with MasterDataModule.ConfigStorage do
   begin
      EdNaInstitution.Text := NaInstitution;
      EdSchoolYear.Text := SchoolYear;
      EdNameAuthority.Text := NameAuthority;
      EdPositionAuthority.Text := PositionAuthority;
      EdNameResponsible.Text := NameResponsible;
      EdPositionResponsible.Text := PositionResponsible;
      SEMaxTeacherWorkLoad.Value := MaxTeacherWorkLoad;
      MeComments.Lines.Text := Comments;
      cbxRandomize.Checked := Randomize;
      speSeed.Value := Seed;
      speNumIterations.Value := RefreshInterval;
      creClashTeacher.Text := FloatToStr(ClashTeacher);
      creClashSubject.Text := FloatToStr(ClashSubject);
      creClashRoomType.Text := FloatToStr(ClashRoomType);
      creBreakTimetableTeacher.Text := FloatToStr(BreakTimetableTeacher);
      creEmptyHour.Text := FloatToStr(OutOfPositionEmptyHour);
      creBrokenSession.Text := FloatToStr(BrokenSession);
      creNonScatteredSubject.Text := FloatToStr(NonScatteredSubject);
      spePopulationSize.Value := PopulationSize;
      SEMaxIteration.Value := MaxIteration;
      creCrossProbability.Text := FloatToStr(CrossProbability);
      creMutationProbability.Text := FloatToStr(MutationProbability);
      creReparationProbability.Text := FloatToStr(ReparationProbability);
      EdInitialTimetables.Text := InitialTimetables;
      dedSharedDirectory.Directory := SharedDirectory;
      crePollinationProbability.Text := FloatToStr(PollinationProbability);
      cbxApplyDoubleDownHill.Checked := ApplyDoubleDownHill;
      edBookmarks.Text := Bookmarks;
   end;
end;

procedure TConfigForm.SaveToSourceDataModule;
begin
   with MasterDataModule.ConfigStorage do
   begin
      NaInstitution := EdNaInstitution.Text;
      SchoolYear := EdSchoolYear.Text;
      NameAuthority := EdNameAuthority.Text;
      PositionAuthority := EdPositionAuthority.Text;
      NameResponsible := EdNameResponsible.Text;
      PositionResponsible := EdPositionResponsible.Text;
      MaxTeacherWorkLoad := SEMaxTeacherWorkLoad.Value;
      Comments := MeComments.Lines.Text;
      Randomize := cbxRandomize.Checked;
      Seed := speSeed.Value;
      RefreshInterval := speNumIterations.Value;
      ClashTeacher := StrToInt(creClashTeacher.Text);
      ClashSubject := StrToInt(creClashSubject.Text);
      ClashRoomType := StrToInt(creClashRoomType.Text);
      BreakTimetableTeacher := StrToInt(creBreakTimetableTeacher.Text);
      OutOfPositionEmptyHour := StrToInt(creEmptyHour.Text);
      BrokenSession := StrToInt(creBrokenSession.Text);
      NonScatteredSubject := StrToInt(creNonScatteredSubject.Text);
      PopulationSize := spePopulationSize.Value;
      MaxIteration := SEMaxIteration.Value;
      CrossProbability := StrToFloat(creCrossProbability.Text);
      MutationProbability := StrToFloat(creMutationProbability.Text);
      ReparationProbability := StrToFloat(creReparationProbability.Text);
      InitialTimetables := EdInitialTimetables.Text;
      SharedDirectory := dedSharedDirectory.Directory;
      PollinationProbability := StrToFloat(crePollinationProbability.Text);
      ApplyDoubleDownHill := cbxApplyDoubleDownHill.Checked;
      Bookmarks := edBookmarks.Text;
   end;
end;

procedure TConfigForm.DSSubjectRestrictionTypeDataChange(Sender: TObject; Field: TField);
begin
  CBColSubjectRestrictionType.Selected :=
    SourceDataModule.TbSubjectRestrictionType.FindField('ColSubjectRestrictionType').AsInteger;
end;

procedure TConfigForm.CBColSubjectRestrictionTypeExit(Sender: TObject);
begin
  with SourceDataModule.TbSubjectRestrictionType.FindField('ColSubjectRestrictionType') do
    if (DSSubjectRestrictionType.State in [dsEdit, dsInsert])
        and (AsInteger <> CBColSubjectRestrictionType.Selected) then
      AsInteger := CBColSubjectRestrictionType.Selected;
end;

procedure TConfigForm.BBCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TConfigForm.BBOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TConfigForm.CBColSubjectRestrictionTypeChange(Sender: TObject);
begin
  with DSSubjectRestrictionType do
  begin
    OnDataChange := nil;
    Edit;
    OnDataChange := DSSubjectRestrictionTypeDataChange;
  end
end;

procedure TConfigForm.CBColTeacherRestrictionTypeChange(Sender: TObject);
begin
  with DSTeacherRestrictionType do
  begin
    OnDataChange := nil;
    Edit;
    OnDataChange := DSTeacherRestrictionTypeDataChange;
  end
end;

procedure TConfigForm.CBColTeacherRestrictionTypeExit(Sender: TObject);
begin
  with SourceDataModule.TbTeacherRestrictionType.FindField('ColTeacherRestrictionType') do
    if (DSTeacherRestrictionType.State in [dsEdit, dsInsert])
        and (AsInteger <> CBColTeacherRestrictionType.Selected) then
      AsInteger := CBColTeacherRestrictionType.Selected;
end;

procedure TConfigForm.DSTeacherRestrictionTypeDataChange(
  Sender: TObject; Field: TField);
begin
  CBColTeacherRestrictionType.Selected
    := SourceDataModule.TbTeacherRestrictionType.FindField('ColTeacherRestrictionType').AsInteger;
end;

initialization
{$IFDEF FPC}
  {$i fconfig.lrs}
{$ENDIF}

end.

