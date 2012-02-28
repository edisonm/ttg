{ -*- mode: Delphi -*- }
unit FConfig;

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
    CBApplyDoubleDownHill: TCheckBox;
    EdClashActivity: TEdit;
    EdCrossProbability: TEdit;
    EdMutationProbability: TEdit;
    EdReparationProbability: TEdit;
    edBookmarks: TEdit;
    LbCrossProbability: TLabel;
    LbMutationProbability: TLabel;
    LbReparationProbability: TLabel;
    LbIterations: TLabel;
    LbClashActivity: TLabel;
    LbDownhillLevels: TLabel;
    LbPollinationProbability: TLabel;
    LbPopulationSize: TLabel;
    LbMaxResourceWorkLoad: TLabel;
    PCConfig: TPageControl;
    SEMaxIteration: TSpinEdit;
    EdPollinationProbability: TEdit;
    spePopulationSize: TSpinEdit;
    TSWeights: TTabSheet;
    LbClashResource: TLabel;
    LbOutOfPositionEmptyHour: TLabel;
    LbBrokenActivity: TLabel;
    LbNonScatteredActivity: TLabel;
    EdEmptyHour: TEdit;
    EdBrokenSession: TEdit;
    EdNonScatteredActivity: TEdit;
    TSInstitution: TTabSheet;
    SEMaxResourceWorkLoad: TSpinEdit;
    MeComments: TMemo;
    LbComments: TLabel;
    LbInstitutionName: TLabel;
    EdNaInstitution: TEdit;
    LbResourceRestrictions: TLabel;
    TSOptions: TTabSheet;
    CBRandomize: TCheckBox;
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
    LbUpdateEach: TLabel;
    speNumIterations: TSpinEdit;
    LbSchoolYear: TLabel;
    EdSchoolYear: TEdit;
    LbBreakTimetableResource: TLabel;
    EdBreakTimetableResource: TEdit;
    LbInitialTimetables: TLabel;
    EdInitialTimetables: TEdit;
    LbSRName: TLabel;
    LbSRColor: TLabel;
    LbSRValue: TLabel;
    LbTRName: TLabel;
    EdNaResourceRestrictionType: TDBEdit;
    LbTRColor: TLabel;
    LbTRValue: TLabel;
    EdValResourceRestrictionType: TDBEdit;
    LbSharedDirectory: TLabel;
    dedSharedDirectory: TDirectoryEdit;
    BBCancel: TBitBtn;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DSResourceRestrictionType: TDataSource;
    CBColResourceRestrictionType: TColorBox;
    procedure CBRandomizeClick(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure CBColResourceRestrictionTypeChange(Sender: TObject);
    procedure CBColResourceRestrictionTypeExit(Sender: TObject);
    procedure DSResourceRestrictionTypeDataChange(Sender: TObject;
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

procedure TConfigForm.CBRandomizeClick(Sender: TObject);
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
      SEMaxResourceWorkLoad.Value := MaxResourceWorkLoad;
      MeComments.Lines.Text := Comments;
      CBRandomize.Checked := Randomize;
      speSeed.Value := Seed;
      speNumIterations.Value := RefreshInterval;
      EdClashActivity.Text := FloatToStr(ClashActivity);
      EdBreakTimetableResource.Text := FloatToStr(BreakTimetableResource);
      EdEmptyHour.Text := FloatToStr(OutOfPositionEmptyHour);
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
      SchoolYear := EdSchoolYear.Text;
      NameAuthority := EdNameAuthority.Text;
      PositionAuthority := EdPositionAuthority.Text;
      NameResponsible := EdNameResponsible.Text;
      PositionResponsible := EdPositionResponsible.Text;
      MaxResourceWorkLoad := SEMaxResourceWorkLoad.Value;
      Comments := MeComments.Lines.Text;
      Randomize := CBRandomize.Checked;
      Seed := speSeed.Value;
      RefreshInterval := speNumIterations.Value;
      ClashActivity := StrToInt(EdClashActivity.Text);
      BreakTimetableResource := StrToInt(EdBreakTimetableResource.Text);
      OutOfPositionEmptyHour := StrToInt(EdEmptyHour.Text);
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

procedure TConfigForm.BBOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TConfigForm.CBColResourceRestrictionTypeChange(Sender: TObject);
begin
  with DSResourceRestrictionType do
  begin
    OnDataChange := nil;
    Edit;
    OnDataChange := DSResourceRestrictionTypeDataChange;
  end
end;

procedure TConfigForm.CBColResourceRestrictionTypeExit(Sender: TObject);
begin
  with SourceDataModule.TbResourceRestrictionType.FindField('ColResourceRestrictionType') do
    if (DSResourceRestrictionType.State in [dsEdit, dsInsert])
        and (AsInteger <> CBColResourceRestrictionType.Selected) then
      AsInteger := CBColResourceRestrictionType.Selected;
end;

procedure TConfigForm.DSResourceRestrictionTypeDataChange(
  Sender: TObject; Field: TField);
begin
  CBColResourceRestrictionType.Selected
    := SourceDataModule.TbResourceRestrictionType.FindField('ColResourceRestrictionType').AsInteger;
end;

initialization
{$IFDEF FPC}
  {$i FConfig.lrs}
{$ENDIF}

end.

