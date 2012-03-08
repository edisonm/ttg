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
    PCConfig: TPageControl;
    SEMaxIteration: TSpinEdit;
    EdPollinationProbability: TEdit;
    spePopulationSize: TSpinEdit;
    TSWeights: TTabSheet;
    LbBrokenActivity: TLabel;
    LbNonScatteredActivity: TLabel;
    EdBrokenSession: TEdit;
    EdNonScatteredActivity: TEdit;
    TSInstitution: TTabSheet;
    MeComments: TMemo;
    LbComments: TLabel;
    LbInstitutionName: TLabel;
    EdNaInstitution: TEdit;
    LbRestrictions: TLabel;
    TSOptions: TTabSheet;
    CBUseCustomSeed: TCheckBox;
    speSeed: TSpinEdit;
    LbAuthority: TLabel;
    EdNameAuthority: TEdit;
    LbUpdateEach: TLabel;
    speNumIterations: TSpinEdit;
    LbBreakTimetableResource: TLabel;
    EdBreakTimetableResource: TEdit;
    LbInitialTimetables: TLabel;
    EdInitialTimetables: TEdit;
    LbTRName: TLabel;
    EdNaRestrictionType: TDBEdit;
    LbTRColor: TLabel;
    LbTRValue: TLabel;
    EdValRestrictionType: TDBEdit;
    LbSharedDirectory: TLabel;
    dedSharedDirectory: TDirectoryEdit;
    BBCancel: TBitBtn;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DSRestrictionType: TDataSource;
    CBColRestrictionType: TColorBox;
    procedure CBUseCustomSeedClick(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure CBColRestrictionTypeChange(Sender: TObject);
    procedure CBColRestrictionTypeExit(Sender: TObject);
    procedure DSRestrictionTypeDataChange(Sender: TObject;
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

procedure TConfigForm.CBUseCustomSeedClick(Sender: TObject);
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
      EdNameAuthority.Text := NameAuthority;
      MeComments.Lines.Text := Comments;
      CBUseCustomSeed.Checked := UseCustomSeed;
      speSeed.Value := Seed;
      speNumIterations.Value := RefreshInterval;
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
      RefreshInterval := speNumIterations.Value;
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
  with SourceDataModule.TbRestrictionType.FindField('ColRestrictionType') do
    if (DSRestrictionType.State in [dsEdit, dsInsert])
        and (AsInteger <> CBColRestrictionType.Selected) then
      AsInteger := CBColRestrictionType.Selected;
end;

procedure TConfigForm.DSRestrictionTypeDataChange(
  Sender: TObject; Field: TField);
begin
  CBColRestrictionType.Selected
    := SourceDataModule.TbRestrictionType.FindField('ColRestrictionType').AsInteger;
end;

initialization
{$IFDEF FPC}
  {$i FConfig.lrs}
{$ENDIF}

end.

