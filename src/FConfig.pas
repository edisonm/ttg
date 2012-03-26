{ -*- mode: Delphi -*- }
unit FConfig;

{$I ttg.inc}

interface

uses
  ColorBox, LResources, SysUtils, Grids, Classes, Graphics, Controls, Forms, DB,
  Dialogs, StdCtrls, Buttons, ComCtrls, Spin, DBGrids, DSource, DMaster, DBCtrls,
  ExtCtrls, EditBtn, ZDataset;

type

  { TConfigForm }

  TConfigForm = class(TForm)
    BBOk: TBitBtn;
    CBApplyDoubleDownHill: TCheckBox;
    CBColRestrictionType: TColorBox;
    DBGrid2: TDBGrid;
    EdClashActivity: TEdit;
    EdCrossProbability: TEdit;
    EdMutationProbability: TEdit;
    EdNaRestrictionType: TDBEdit;
    EdReparationProbability: TEdit;
    edBookmarks: TEdit;
    EdValRestrictionType: TDBEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    LbCrossProbability: TLabel;
    LbMutationProbability: TLabel;
    LbReparationProbability: TLabel;
    LbIterations: TLabel;
    LbClashActivity: TLabel;
    LbDownhillLevels: TLabel;
    LbPollinationProbability: TLabel;
    LbPopulationSize: TLabel;
    LbTRColor: TLabel;
    LbTRName: TLabel;
    LbTRValue: TLabel;
    MeComments: TMemo;
    PCConfig: TPageControl;
    SEMaxIteration: TSpinEdit;
    EdPollinationProbability: TEdit;
    spePopulationSize: TSpinEdit;
    TbRestrictionType: TZTable;
    TrBValRestrictionType: TTrackBar;
    TrBCrossProbability: TTrackBar;
    TrBClashActivity: TTrackBar;
    TrBBreakTimetableResource: TTrackBar;
    TrBNonScatteredActivity: TTrackBar;
    TrBBrokenSession: TTrackBar;
    TrBMutationProbability: TTrackBar;
    TrBReparationProbability: TTrackBar;
    TrBPollinationProbability: TTrackBar;
    TSWeights: TTabSheet;
    LbBrokenActivity: TLabel;
    LbNonScatteredActivity: TLabel;
    EdBrokenSession: TEdit;
    EdNonScatteredActivity: TEdit;
    TSInstitution: TTabSheet;
    LbInstitutionName: TLabel;
    EdNaInstitution: TEdit;
    TSOptions: TTabSheet;
    CBUseCustomSeed: TCheckBox;
    speSeed: TSpinEdit;
    LbAuthority: TLabel;
    EdNameAuthority: TEdit;
    LbBreakTimetableResource: TLabel;
    EdBreakTimetableResource: TEdit;
    LbInitialTimetables: TLabel;
    EdInitialTimetables: TEdit;
    LbSharedDirectory: TLabel;
    dedSharedDirectory: TDirectoryEdit;
    BBCancel: TBitBtn;
    DBGrid1: TDBGrid;
    DSRestrictionType: TDataSource;
    procedure CBUseCustomSeedClick(Sender: TObject);
    procedure CBColRestrictionTypeChange(Sender: TObject);
    procedure CBColRestrictionTypeExit(Sender: TObject);
    procedure DSRestrictionTypeDataChange(Sender: TObject;
      Field: TField);
    procedure BBOkClick(Sender: TObject);
    procedure BBCancelClick(Sender: TObject);
    procedure EdBreakTimetableResourceChange(Sender: TObject);
    procedure EdBrokenSessionChange(Sender: TObject);
    procedure EdClashActivityChange(Sender: TObject);
    procedure EdCrossProbabilityExit(Sender: TObject);
    procedure EdMutationProbabilityExit(Sender: TObject);
    procedure EdNonScatteredActivityChange(Sender: TObject);
    procedure EdPollinationProbabilityChange(Sender: TObject);
    procedure EdReparationProbabilityChange(Sender: TObject);
    procedure EdValRestrictionTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrBBreakTimetableResourceChange(Sender: TObject);
    procedure TrBBrokenSessionChange(Sender: TObject);
    procedure TrBClashActivityChange(Sender: TObject);
    procedure TrBCrossProbabilityChange(Sender: TObject);
    procedure TrBMutationProbabilityChange(Sender: TObject);
    procedure TrBNonScatteredActivityChange(Sender: TObject);
    procedure TrBPollinationProbabilityChange(Sender: TObject);
    procedure TrBReparationProbabilityChange(Sender: TObject);
    procedure TrBValRestrictionTypeChange(Sender: TObject);
  private
    procedure LinkEditWithTrackBar(AEdit: TCustomEdit; ATrackBar: TTrackBar); overload;
    procedure LinkEditWithTrackBar(AFactor: Integer; AEdit: TCustomEdit;
      ATrackBar: TTrackBar); overload;
    procedure LinkTrackBarWithEdit(ATrackBar: TTrackBar; AEdit: TCustomEdit); overload;
    procedure LinkTrackBarWithEdit(Factor: Integer; ATrackBar: TTrackBar;
      AEdit: TCustomEdit); overload;
    { Private declarations }
  public
    { Public declarations }
    procedure LoadFromSourceDataModule;
    procedure SaveToSourceDataModule;
  end;

function ShowConfigForm(AHelpContext: THelpContext): Integer;

implementation

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

procedure TConfigForm.CBUseCustomSeedClick(Sender: TObject);
begin
  speSeed.Enabled := CBUseCustomSeed.Checked;
end;

procedure TConfigForm.LoadFromSourceDataModule;
begin
   with MasterDataModule.ConfigStorage do
   begin
      EdNaInstitution.Text := NaInstitution;
      EdNameAuthority.Text := NameAuthority;
      MeComments.Lines.Text := Comments;
      CBUseCustomSeed.Checked := UseCustomSeed;
      speSeed.Value := Seed;
      EdClashActivity.Text := FloatToStr(ClashActivity);
      EdBreakTimetableResource.Text := FloatToStr(BreakTimetableResource);
      EdBrokenSession.Text := FloatToStr(BrokenSession);
      EdNonScatteredActivity.Text := FloatToStr(NonScatteredActivity);
      spePopulationSize.Value := PopulationSize;
      SEMaxIteration.Value := MaxIteration;
      EdCrossProbability.Text := FloatToStr(CrossProbability);
      EdMutationProbability.Text := FloatToStr(MutationProbability);
      EdReparationProbability.Text := FloatToStr(ReparationProbability);
      EdInitialTimetables.Text := InitialTimetables;
      dedSharedDirectory.Directory := SharedDirectory;
      EdPollinationProbability.Text := FloatToStr(PollinationProbability);
      CBApplyDoubleDownHill.Checked := ApplyDoubleDownHill;
      edBookmarks.Text := Bookmarks;
   end;
end;

procedure TConfigForm.SaveToSourceDataModule;
begin
   with MasterDataModule.ConfigStorage do
   begin
      NaInstitution := EdNaInstitution.Text;
      NameAuthority := EdNameAuthority.Text;
      Comments := MeComments.Lines.Text;
      UseCustomSeed := CBUseCustomSeed.Checked;
      Seed := speSeed.Value;
      ClashActivity := StrToInt(EdClashActivity.Text);
      BreakTimetableResource := StrToInt(EdBreakTimetableResource.Text);
      BrokenSession := StrToInt(EdBrokenSession.Text);
      NonScatteredActivity := StrToInt(EdNonScatteredActivity.Text);
      PopulationSize := spePopulationSize.Value;
      MaxIteration := SEMaxIteration.Value;
      CrossProbability := StrToFloat(EdCrossProbability.Text);
      MutationProbability := StrToFloat(EdMutationProbability.Text);
      ReparationProbability := StrToFloat(EdReparationProbability.Text);
      InitialTimetables := EdInitialTimetables.Text;
      SharedDirectory := dedSharedDirectory.Directory;
      PollinationProbability := StrToFloat(EdPollinationProbability.Text);
      ApplyDoubleDownHill := CBApplyDoubleDownHill.Checked;
      Bookmarks := edBookmarks.Text;
   end;
end;

procedure TConfigForm.BBCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TConfigForm.EdBreakTimetableResourceChange(Sender: TObject);
begin
  LinkEditWithTrackBar(1, EdBreakTimetableResource, TrBBreakTimetableResource);
end;

procedure TConfigForm.EdBrokenSessionChange(Sender: TObject);
begin
  LinkEditWithTrackBar(1, EdBrokenSession, TrBBrokenSession);
end;

procedure TConfigForm.EdClashActivityChange(Sender: TObject);
begin
  LinkEditWithTrackBar(1, EdClashActivity, TrBClashActivity);
end;

procedure TConfigForm.LinkEditWithTrackBar(AFactor: Integer; AEdit: TCustomEdit; ATrackBar: TTrackBar);
begin
  if AEdit.Text <> '' then
    with ATrackBar do Position := trunc(StrToFloat(AEdit.Text) * AFactor);
end;

procedure TConfigForm.LinkEditWithTrackBar(AEdit: TCustomEdit; ATrackBar: TTrackBar);
begin
  LinkEditWithTrackBar(ATrackBar.Max, AEdit, ATrackBar);
end;

procedure TConfigForm.EdCrossProbabilityExit(Sender: TObject);
begin
  LinkEditWithTrackBar(EdCrossProbability, TrBCrossProbability);
end;

procedure TConfigForm.EdMutationProbabilityExit(Sender: TObject);
begin
  LinkEditWithTrackBar(EdMutationProbability, TrBMutationProbability);
end;

procedure TConfigForm.EdNonScatteredActivityChange(Sender: TObject);
begin
  LinkEditWithTrackBar(1, EdNonScatteredActivity, TrBNonScatteredActivity);
end;

procedure TConfigForm.EdPollinationProbabilityChange(Sender: TObject);
begin
  LinkEditWithTrackBar(EdPollinationProbability, TrBPollinationProbability);
end;

procedure TConfigForm.EdReparationProbabilityChange(Sender: TObject);
begin
  LinkEditWithTrackBar(EdReparationProbability, TrBReparationProbability);
end;

procedure TConfigForm.EdValRestrictionTypeChange(Sender: TObject);
begin
  LinkEditWithTrackBar(1, EdValRestrictionType, TrBValRestrictionType);
end;

procedure TConfigForm.FormCreate(Sender: TObject);
begin
  SourceDataModule.PrepareTable(TbRestrictionType);
  TbRestrictionType.Open;
end;

procedure TConfigForm.TrBBreakTimetableResourceChange(Sender: TObject);
begin
  LinkTrackBarWithEdit(1, TrBBreakTimetableResource, EdBreakTimetableResource);
end;

procedure TConfigForm.TrBBrokenSessionChange(Sender: TObject);
begin
  LinkTrackBarWithEdit(1, TrBBrokenSession, EdBrokenSession);
end;

procedure TConfigForm.TrBClashActivityChange(Sender: TObject);
begin
  LinkTrackBarWithEdit(1, TrBClashActivity, EdClashActivity);
end;

procedure TConfigForm.LinkTrackBarWithEdit(Factor: Integer; ATrackBar: TTrackBar;
  AEdit: TCustomEdit);
begin
  with ATrackBar do AEdit.Text := FloatToStr(Position / Factor);
end;

procedure TConfigForm.LinkTrackBarWithEdit(ATrackBar: TTrackBar; AEdit: TCustomEdit);
begin
  LinkTrackBarWithEdit(ATrackBar.Max, ATrackBar, AEdit);
end;

procedure TConfigForm.TrBCrossProbabilityChange(Sender: TObject);
begin
  LinkTrackBarWithEdit(TrBCrossProbability, EdCrossProbability);
end;

procedure TConfigForm.TrBMutationProbabilityChange(Sender: TObject);
begin
  LinkTrackBarWithEdit(TrBMutationProbability, EdMutationProbability);
end;

procedure TConfigForm.TrBNonScatteredActivityChange(Sender: TObject);
begin
  LinkTrackBarWithEdit(1, TrBNonScatteredActivity, EdNonScatteredActivity);
end;

procedure TConfigForm.TrBPollinationProbabilityChange(Sender: TObject);
begin
  LinkTrackBarWithEdit(TrBPollinationProbability, EdPollinationProbability);
end;

procedure TConfigForm.TrBReparationProbabilityChange(Sender: TObject);
begin
  LinkTrackBarWithEdit(TrBReparationProbability, EdReparationProbability);
end;

procedure TConfigForm.TrBValRestrictionTypeChange(Sender: TObject);
begin
  LinkTrackBarWithEdit(1, TrBValRestrictionType, EdValRestrictionType);
end;

procedure TConfigForm.BBOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TConfigForm.CBColRestrictionTypeChange(Sender: TObject);
begin
  with DSRestrictionType do
  begin
    OnDataChange := nil;
    Edit;
    OnDataChange := DSRestrictionTypeDataChange;
  end
end;

procedure TConfigForm.CBColRestrictionTypeExit(Sender: TObject);
begin
  with TbRestrictionType.FindField('ColRestrictionType') do
    if (DSRestrictionType.State in [dsEdit, dsInsert])
        and (AsInteger <> CBColRestrictionType.Selected) then
      AsInteger := CBColRestrictionType.Selected;
end;

procedure TConfigForm.DSRestrictionTypeDataChange(
  Sender: TObject; Field: TField);
begin
  CBColRestrictionType.Selected
    := TbRestrictionType.FindField('ColRestrictionType').AsInteger;
end;

initialization
  
{$i FConfig.lrs}

end.

