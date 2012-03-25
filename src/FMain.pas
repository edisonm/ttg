{ -*- mode: Delphi -*- }
unit FMain;

{$I ttg.inc}

{
TODO:
  - Timetables by Clusters
  - Timetables by Resources
  - Resource Restrictions
  - Resource Activity
  - Theme Activity
}
interface

uses
  LResources, MTProcs, ZDataset, SysUtils, Classes, Graphics, Forms,
  Dialogs, ExtCtrls, Menus, ComCtrls, Buttons, ActnList, FSplash, FSingleEditor,
  Controls, FCrossManyToManyEditor0, FEditor, UConfigStorage, UMakeTT;

type

  { TMainForm }

  TMainForm = class(TForm)
    ActDBExplorer: TAction;
    ActRestrictionType: TAction;
    ActLangDefault: TAction;
    ActLangEnglish: TAction;
    ActLangSpanish: TAction;
    MainMenu: TMainMenu;
    MIDBExplorer: TMenuItem;
    MILangDefault: TMenuItem;
    MILanguages: TMenuItem;
    MILangSpanish: TMenuItem;
    MILangEnglish: TMenuItem;
    MIResource: TMenuItem;
    MITheme: TMenuItem;
    MIResourceType: TMenuItem;
    MIFile: TMenuItem;
    MISave: TMenuItem;
    N1: TMenuItem;
    MIExit: TMenuItem;
    MIData: TMenuItem;
    MITool: TMenuItem;
    MIView: TMenuItem;
    MIHelp: TMenuItem;
    MIAbout: TMenuItem;
    MIMakeTimetable: TMenuItem;
    MINew: TMenuItem;
    MIOpen: TMenuItem;
    StatusBar: TStatusBar;
    MIPasswd: TMenuItem;
    MITimetable: TMenuItem;
    MIDay: TMenuItem;
    MIHour: TMenuItem;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    MIPeriod: TMenuItem;
    TBNew: TToolButton;
    TBtRestrictionType: TToolButton;
    TBSave: TToolButton;
    TBOpen: TToolButton;
    TBtDay: TToolButton;
    TBtHour: TToolButton;
    TBResourceType: TToolButton;
    TBResource: TToolButton;
    TBPeriod: TToolButton;
    TBTheme: TToolButton;
    MIReopen: TMenuItem;
    ImageList: TImageList;
    TBFindBetter: TToolButton;
    TBTimetable: TToolButton;
    MIConfig: TMenuItem;
    TBConfig: TToolButton;
    ActionList: TActionList;
    ActNew: TAction;
    ActOpen: TAction;
    ActSave: TAction;
    ActExit: TAction;
    ActDay: TAction;
    ActHour: TAction;
    ActResource: TAction;
    ActResourceType: TAction;
    ActPeriod: TAction;
    ActTheme: TAction;
    ActMakeTimetable: TAction;
    ActConfigure: TAction;
    ActTimetable: TAction;
    ActAbout: TAction;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    MIChangePassword: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    SaveDialogCSV: TSaveDialog;
    ActRegistrationInfo: TAction;
    ToolBar: TToolBar;
    procedure ActDBExplorerExecute(Sender: TObject);
    procedure ActExitExecute(Sender: TObject);
    procedure ActLangDefaultExecute(Sender: TObject);
    procedure ActLangEnglishExecute(Sender: TObject);
    procedure ActLangSpanishExecute(Sender: TObject);
    procedure ActResourceExecute(Sender: TObject);
    procedure ActRestrictionTypeExecute(Sender: TObject);
    procedure ActThemeExecute(Sender: TObject);
    procedure ActResourceTypeExecute(Sender: TObject);
    procedure ActDayExecute(Sender: TObject);
    procedure ActHourExecute(Sender: TObject);
    procedure ActNewExecute(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure ActOpenExecute(Sender: TObject);
    procedure ActTimetableExecute(Sender: TObject);
    procedure ActMakeTimetableExecute(Sender: TObject);
    procedure ActPeriodExecute(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure FormCreate(Sender: TObject);
    procedure ActConfigureExecute(Sender: TObject);
    procedure ActAboutExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FConfigFileName: string;
    FConfigStorage: TConfigStorage;
    FDayForm,
    FResourceTypeForm,
    FRestrictionTypeForm,
    FHourForm,
    FDBExplorerForm,
    FPeriodForm: TCrossManyToManyEditor0Form;
    FProgress: Integer;
    FRelProgress: Integer;
    FMin: Integer;
    FMax: Integer;
    FStep: Integer;
    FUpdateIndex: Integer;
    FLogStrings: TStrings;
    procedure SetProgress(Value: Integer);
    procedure SetMin(Value: Integer);
    procedure SetMax(Value: Integer);
    procedure SetStep(Value: Integer);
    procedure SaveConfig(Strings: TStrings);
    procedure LoadConfig(Strings: TStrings);
    procedure UpdRelProgress;

    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
    function ConfirmOperation: boolean;
    procedure MakeTimetables(const SIdTimetables: string);

  public
    { Public declarations }
    procedure LoadStoredConfig;
    property UpdateIndex: Integer read FUpdateIndex write FUpdateIndex;
    property Progress: Integer read FProgress write SetProgress;
    property Min: Integer read FMin write SetMin;
    property Max: Integer read FMax write SetMax;
    property Step: Integer read FStep write SetStep;
    property ConfigStorage: TConfigStorage read FConfigStorage write FConfigStorage;
    property ConfigFileName: string read FConfigFileName write FConfigFileName;
end;

var
  MainForm: TMainForm;

implementation

uses
  FCrossManyToManyEditor, FCrossManyToManyEditor1, DMaster, FTheme, FResource,
  FTimetable, FMasterDetailEditor, FConfig, Printers, DSource,
  UTTGBasics, FMessageView, UTTGi18n, UTTGConsts, FDBExplorer;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TMainForm.ActExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ActDBExplorerExecute(Sender: TObject);
begin
   TDBExplorerForm.ToggleSingleEditor(Self,
                                      FDBExplorerForm,
                                      ConfigStorage,
                                      ActDBExplorer,
                                      nil);
end;

procedure TMainForm.ActLangDefaultExecute(Sender: TObject);
begin
  DisposeTranslator;
  EnableTranslator('ttg');
end;

procedure TMainForm.ActLangEnglishExecute(Sender: TObject);
begin
  DisposeTranslator;
end;

procedure TMainForm.ActLangSpanishExecute(Sender: TObject);
begin
  DisposeTranslator;
  EnableTranslator(GetLResourceForLanguage('ttg', 'es'));
end;

procedure TMainForm.ActResourceExecute(Sender: TObject);
begin
  TResourceForm.ToggleEditor(Self, ResourceForm, ConfigStorage, actResource);
end;

procedure TMainForm.ActRestrictionTypeExecute(Sender: TObject);
begin
  TSingleEditorForm.ToggleSingleEditor(Self, FRestrictionTypeForm, ConfigStorage,
    ActRestrictionType, 'RestrictionType');
end;

procedure TMainForm.ActPeriodExecute(Sender: TObject);
var
  TbDay, TbHour, TbPeriod: TZTable;
begin
  if TCrossManyToManyEditor0Form.ToggleEditor(Self, FPeriodForm,
    ConfigStorage, ActPeriod) then
  with SourceDataModule do
  begin
    {$IFDEF FPC}
    FPeriodForm.DrawGrid.OnPrepareCanvas := FPeriodForm.DrawGridPrepareCanvas;
    {$ENDIF}
    TbDay := SourceDataModule.NewTable('Day', FPeriodForm);
    TbHour := SourceDataModule.NewTable('Hour', FPeriodForm);
    TbPeriod := SourceDataModule.NewTable('Period', FPeriodForm);
    TbDay.Open;
    TbHour.Open;
    TbPeriod.Open;
    FPeriodForm.ShowEditor(TbDay, TbHour, TbPeriod, nil, 'IdDay', 'NaDay',
      'IdDay', '', 'IdHour', 'NaHour', 'IdHour', '');
  end;
end;

procedure TMainForm.ActThemeExecute(Sender: TObject);
begin
   TThemeForm.ToggleEditor(Self, ThemeForm, ConfigStorage, ActTheme);
end;

procedure TMainForm.ActResourceTypeExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FResourceTypeForm,
					ConfigStorage,
					ActResourceType,
					'ResourceType');
end;

procedure TMainForm.ActDayExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FDayForm,
					ConfigStorage,
					ActDay,
					'Day');
end;

procedure TMainForm.ActHourExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FHourForm,
					ConfigStorage,
					ActHour,
					'Hour');
end;

procedure TMainForm.ActTimetableExecute(Sender: TObject);
begin
  TTimetableForm.ToggleEditor(Self, TimetableForm, ConfigStorage, ActTimetable);
end;

function TMainForm.ConfirmOperation: boolean;
begin
  Result := MessageDlg(SChangesWillBeLostWarning, mtWarning, [mbYes, mbNo], 0) = mrYes
end;

procedure TMainForm.ActNewExecute(Sender: TObject);
begin
  StatusBar.Panels[1].Style := psOwnerDraw;
  Progress := 0;
  try
    if ConfirmOperation then
    begin
      Max := 20;
      MasterDataModule.NewDataBase;
      Progress := 0;
    end;
  finally
    StatusBar.Panels[1].Style := psText;
    StatusBar.Panels[2].Text := SReady;
  end;
end;

procedure TMainForm.ActSaveExecute(Sender: TObject);
begin
  StatusBar.Panels[1].Style := psOwnerDraw;
  Progress := 0;
  Max := 100;
  try
    SaveDialog.HelpContext := ActSave.HelpContext;
    if SaveDialog.Execute then
    begin
      SaveToFile(SaveDialog.FileName);
      OpenDialog.FileName := SaveDialog.FileName;
    end;
  finally
    StatusBar.Panels[1].Style := psText;
    StatusBar.Panels[2].Text := SReady;
  end;
end;

procedure TMainForm.SaveToFile(const AFileName: string);
begin
  Cursor := crHourGlass;
  try
    MasterDataModule.SaveToTextFile(AFileName);
  finally
    Cursor := crDefault;
  end;
end;

procedure TMainForm.LoadFromFile(const AFileName: string);
begin
  Cursor := crHourGlass;
  try
    SourceDataModule.EmptyTables;
    MasterDataModule.LoadFromTextFile(AFileName);
    MainForm.Caption := Application.Title + ' - ' +
      MasterDataModule.ConfigStorage.NaInstitution;
  finally
    Cursor := crDefault;
  end;
end;

procedure TMainForm.ActOpenExecute(Sender: TObject);
begin
  StatusBar.Panels[1].Style := psOwnerDraw;
  Progress := 0;
  try
    if ConfirmOperation then
    begin
      OpenDialog.HelpContext := ActOpen.HelpContext;
      if OpenDialog.Execute then
      begin
        LoadFromFile(OpenDialog.FileName);
        SaveDialog.FileName := OpenDialog.FileName;
      end;
    end;
  finally
    StatusBar.Panels[1].Style := psText;
    StatusBar.Panels[2].Text := SReady;
  end;
end;

procedure TMainForm.ActMakeTimetableExecute(Sender: TObject);
var
  SIdTimetables: string;
begin
  try
    SIdTimetables := IntToStr(MasterDataModule.NewIdTimetable);
    if not InputQuery(SGenerateTimetables, STimetableCodesToGenerate, SIdTimetables) then
      Exit;
    MakeTimetables(SIdTimetables);
  finally
    ActMakeTimetable.Checked := False;
  end;
end;

procedure TMainForm.MakeTimetables(const SIdTimetables: string);
var
  ValidIds, WrongIds: TDynamicIntegerArray;
  procedure ProcessIdList(const IdList: string);
  var
    d: string;
    Position, Position2, IdTimetable1, IdTimetable2, IdTimetable, Valids, Wrongs: Integer;
  begin
    Position := 1;
    Valids := 0;
    Wrongs := 0;
    while Position <= Length(IdList) do
    begin
      d := ExtractString(IdList, Position, ',');
      Position2 := 1;
      IdTimetable1 := StrToInt(ExtractString(d, Position2, '-'));
      if Position2 > Length(d) then
        IdTimetable2 := IdTimetable1
      else
        IdTimetable2 := StrToInt(ExtractString(d, Position2, '-'));
      if Position2 <= Length(d) then
        raise Exception.Create(SInvalidData);
      SetLength(ValidIds, Valids + IdTimetable2 - IdTimetable1 + 1);
      SetLength(WrongIds, Wrongs + IdTimetable2 - IdTimetable1 + 1);
      with SourceDataModule.QuTimetable do
      begin
        Close;
        for IdTimetable := IdTimetable1 to IdTimetable2 do
        begin
          ParamByName('IdTimetable').AsInteger := IdTimetable;
          Open;
          if not IsEmpty then
          begin
            WrongIds[Wrongs] := IdTimetable;
            Inc(Wrongs);
          end
          else
          begin
            ValidIds[Valids] := IdTimetable;
            Inc(Valids);
          end;
          Close;
        end;
      end;
    end;
    SetLength(ValidIds, Valids);
    SetLength(WrongIds, Wrongs);
  end;
begin
  with SourceDataModule do
  begin
    ActMakeTimetable.Enabled := False;
    try
      ProcessIdList(SIdTimetables);
      {$IFDEF THREADED}
      TMakeTimetableThread.Create(ValidIds, False);
      {$ELSE}
      with TMakeTimetableThread.Create(ValidIds, True) do
      try
        Execute;
      finally
        Free;
      end;
      {$ENDIF}
      if Length(WrongIds) > 0 then
        MessageDlg(Format(STheNextTimetablesAlreadyExists, [VarArrToStr(WrongIds)]),
          mtError, [mbOK], 0);
    finally
      ActMakeTimetable.Enabled := True;
    end;
  end;
end;

procedure TMainForm.SetMax(Value: Integer);
begin
  if FMax <> Value then
  begin
    FMax := Value;
    StatusBar.Invalidate;
  end;
end;

procedure TMainForm.SetMin(Value: Integer);
begin
  if FMin <> Value then
  begin
    FMin := Value;
    StatusBar.Invalidate;
  end;
end;

procedure TMainForm.SetProgress(Value: Integer);
begin
  if FProgress <> Value then
  begin
    FProgress := Value;
    UpdRelProgress;
  end;
end;

procedure TMainForm.SetStep(Value: Integer);
begin
  if FStep <> Value then
  begin
    FStep := Value;
    UpdRelProgress;
  end;
end;

procedure TMainForm.UpdRelProgress;
var
  VRelProgress: Integer;
begin
  VRelProgress := ((FProgress - FMin) div FStep) * FStep;
  if FRelProgress <> VRelProgress then
  begin
    FRelProgress := VRelProgress;
    StatusBar.Repaint;
  end;
end;

procedure TMainForm.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  VRect: TRect;
begin
  if FRelProgress <> 0 then
  begin
    VRect := Rect;
    VRect.Right := VRect.Left
      + (Rect.Right - Rect.Left) * FRelProgress div (FMax - FMin);
    StatusBar.Canvas.Brush.Color := clNavy;
    StatusBar.Canvas.FillRect(VRect);
  end
  else
    StatusBar.Canvas.FillRect(Rect);
end;

procedure TMainForm.LoadStoredConfig;
begin
  LoadConfig(FConfigStorage.ConfigStrings);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FUpdateIndex := 0;
  Height := 10 + Toolbar.Top + Toolbar.Height + StatusBar.Height;
  SaveDialog.DefaultExt := '.ttd';
  SaveDialog.Filter := SSaveDialogFilter;
  SaveDialogCSV.DefaultExt := '.csv';
  SaveDialogCSV.Filter := SSaveDialogCSVFilter;
  if Paramcount = 1 then
  begin
    LoadFromFile(ParamStr(1));
  end
  else
  begin
    MainForm.Caption := Application.Title;
{$IFDEF DEBUG}
    Caption := Caption + ' - Debug Build';
{$ENDIF}
  end;
  try
    FMin := 0;
    FMax := 100;
    FProgress := 0;
    FRelProgress := 0;
    FStep := 1;
    FLogStrings := TStringList.Create;
  except
    ActMakeTimetable.Enabled := False;
    raise;
  end;
end;

procedure TMainForm.ActConfigureExecute(Sender: TObject);
begin
  try
    if ShowConfigForm(ActConfigure.HelpContext) = mrOK then
    begin
      MainForm.Caption := Application.Title + ' - ' +
        MasterDataModule.ConfigStorage.NaInstitution;
      Inc(FUpdateIndex);
    end;
  finally
    ActConfigure.Checked := False;
  end;
end;

procedure TMainForm.ActAboutExecute(Sender: TObject);
begin
  with TSplashForm.Create(Application) do
  try 
    ShowModal;
  finally
    Free;
  end;
  ActAbout.Checked := False;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose :=
    MessageDlg(SPendingChangesWillBeLostYouReallyWantToQuit,
      mtWarning, [mbYes, mbNo], 0) = mrYes;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  SaveConfig(FConfigStorage.ConfigStrings);
  FConfigStorage.ConfigStrings.SaveToFile(FConfigFileName);
  FLogStrings.Free;
end;

procedure TMainForm.LoadConfig(Strings: TStrings);
begin
  Position := poDesigned;
  with Strings do
  begin
    Top := StrToInt(Values['MainForm_Top']);
    Left := StrToInt(Values['MainForm_Left']);
    Width := StrToInt(Values['MainForm_Width']);
    {Height := StrToInt(Values['MainForm_Height']);}
    WindowState := TWindowState(StrToInt(Values['MainForm_WindowState']));
    SaveDialog.FileName := Values['SaveDialog_FileName'];
    SaveDialogCSV.FileName := Values['SaveDialogCSV_FileName'];
    OpenDialog.FileName := Values['OpenDialog_FileName'];
    if Values['Language'] = 'en' then
      ActLangEnglish.Checked := True
    else if Values['Language'] = 'es' then
      ActLangSpanish.Checked := True
    else
      ActLangDefault.Checked := True;
{
    MessageViewForm.MemSummary.Height :=
      StrToInt(Values['MessageViewForm_MemSummary_Height']);
}
  end;
end;

procedure TMainForm.SaveConfig(Strings: TStrings);
begin
  with Strings do
  begin
    Values['MainForm_Top'] := IntToStr(Top);
    Values['MainForm_Left'] := IntToStr(Left);
    Values['MainForm_Width'] := IntToStr(Width);
    {Values['MainForm_Height'] := IntToStr(Height);}
    Values['MainForm_WindowState'] := IntToStr(Ord(WindowState));
    Values['SaveDialog_FileName'] := SaveDialog.FileName;
    Values['SaveDialogCSV_FileName'] := SaveDialogCSV.FileName;
    Values['OpenDialog_FileName'] := OpenDialog.FileName;
    if ActLangEnglish.Checked = True then
      Values['Language'] := 'en'
    else if ActLangSpanish.Checked = True then
      Values['Language'] := 'es'
    else
      Values['Language'] := '';
  end;
end;

initialization

{$IFDEF FPC}
  {$i FMain.lrs}
{$ENDIF}

end.
