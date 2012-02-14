{ -*- mode: Delphi -*- }
unit FMain;

{$I ttg.inc}

{
TODO:
  - Timetables by Classes
  - Timetables by Teachers
  - Teacher Restrictions
  - Teacher Distribution
  - Subject Distribution
}
interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, MTProcs, SysUtils, Classes, Graphics,
  Forms, Dialogs, ExtCtrls, Menus, ComCtrls, Buttons, ActnList, FSplash, FSingleEditor,
  Controls, FCrossManyToManyEditor0, FEditor, UConfigStorage
{$IFNDEF FREEWARE}, UTTModel, UMakeTT{$ENDIF};

type

  { TMainForm }

  TMainForm = class(TForm)
    ActDBExplorer: TAction;
    ActLangDefault: TAction;
    ActLangEnglish: TAction;
    ActLangSpanish: TAction;
    MainMenu: TMainMenu;
    MIDBExplorer: TMenuItem;
    MILangDefault: TMenuItem;
    MILanguages: TMenuItem;
    MILangSpanish: TMenuItem;
    MILangEnglish: TMenuItem;
    MITeacher: TMenuItem;
    MISubject: TMenuItem;
    MISpecialization: TMenuItem;
    MIParallel: TMenuItem;
    MILevel: TMenuItem;
    MIRoomType: TMenuItem;
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
    MIClass: TMenuItem;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    MITimeSlot: TMenuItem;
    TBNew: TToolButton;
    TBSave: TToolButton;
    TBOpen: TToolButton;
    TBPassword: TToolButton;
    TBDay: TToolButton;
    TBHour: TToolButton;
    TBSpecialization: TToolButton;
    TBLevel: TToolButton;
    TBParallel: TToolButton;
    TBTeacher: TToolButton;
    TBRoomType: TToolButton;
    TBTimeSlot: TToolButton;
    TBClass: TToolButton;
    TBSubject: TToolButton;
    MIReopen: TMenuItem;
    ImageList: TImageList;
    MIContent: TMenuItem;
    MIIndex: TMenuItem;
    N3: TMenuItem;
    TBFindBetter: TToolButton;
    TBTimetable: TToolButton;
    TBContent: TToolButton;
    TBIndex: TToolButton;
    MIConfig: TMenuItem;
    TBConfig: TToolButton;
    MICheckFeasibility: TMenuItem;
    ActionList: TActionList;
    ActNew: TAction;
    ActOpen: TAction;
    ActSave: TAction;
    ActPasswd: TAction;
    ActExit: TAction;
    ActDay: TAction;
    ActHour: TAction;
    ActSpecialization: TAction;
    ActLevel: TAction;
    ActParallel: TAction;
    ActTeacher: TAction;
    ActRoomType: TAction;
    ActTimeSlot: TAction;
    ActClass: TAction;
    ActSubject: TAction;
    ActCheckFeasibility: TAction;
    ActMakeTimetable: TAction;
    ActConfigure: TAction;
    ActTimetable: TAction;
    ActAbout: TAction;
    ActContents: TAction;
    ActIndex: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    MIChangePassword: TMenuItem;
    ActChangePasswd: TAction;
    N2: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    SaveDialogCSV: TSaveDialog;
    ActRegistrationInfo: TAction;
    MIRegistrationInfo: TMenuItem;
    ToolBar: TToolBar;
    procedure ActDBExplorerExecute(Sender: TObject);
    procedure ActExitExecute(Sender: TObject);
    procedure ActLangDefaultExecute(Sender: TObject);
    procedure ActLangEnglishExecute(Sender: TObject);
    procedure ActLangSpanishExecute(Sender: TObject);
    procedure ActTeacherExecute(Sender: TObject);
    procedure ActSubjectExecute(Sender: TObject);
    procedure ActSpecializationExecute(Sender: TObject);
    procedure ActLevelExecute(Sender: TObject);
    procedure ActRoomTypeExecute(Sender: TObject);
    procedure ActParallelExecute(Sender: TObject);
    procedure ActClassExecute(Sender: TObject);
    procedure ActDayExecute(Sender: TObject);
    procedure ActHourExecute(Sender: TObject);
    procedure ActNewExecute(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure ActOpenExecute(Sender: TObject);
    procedure ActTimetableExecute(Sender: TObject);
    procedure ActMakeTimetableExecute(Sender: TObject);
    procedure ActTimeSlotExecute(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure FormCreate(Sender: TObject);
    procedure ActConfigureExecute(Sender: TObject);
    procedure ActCheckFeasibilityExecute(Sender: TObject);
    procedure ActAboutExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ActContentsExecute(Sender: TObject);
    procedure ActIndexExecute(Sender: TObject);
    procedure ActRegistrationInfoExecute(Sender: TObject);
  private
    { Private declarations }
    FConfigFileName: string;
    FConfigStorage: TConfigStorage;
    FDayForm,
    FLevelForm,
    FRoomTypeForm,
    FParallelForm,
    FHourForm,
    FSpecializationForm: TSingleEditorForm;
    FTimeSlotForm: TCrossManyToManyEditor0Form;
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
{$IFNDEF FREEWARE}
    procedure ElaborarTimetables(const SIdTimetables: string);
{$ENDIF}
    procedure RegisterSoftware;
    procedure ProtectSoftware;

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
  FCrossManyToManyEditor, FCrossManyToManyEditor1, DMaster, FSubject, FTeacher,
  FTimetable, FMasterDetailEditor, FConfig, FClass, Printers, DSource,
  DSourceBase, UTTGBasics, FMessageView, UTTGi18n, UTTGConsts, FDBExplorer;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TMainForm.ActExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ActDBExplorerExecute(Sender: TObject);
begin
  with TDBExplorerForm.Create(Self) do
    try
      Show;
    finally
      // free;
    end;
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

procedure TMainForm.ActTeacherExecute(Sender: TObject);
begin
  TTeacherForm.ToggleSingleEditor(Self,
				  TeacherForm,
				  ConfigStorage,
				  actTeacher,
				  SourceDataModule.TbTeacher);
end;

procedure TMainForm.ActTimeSlotExecute(Sender: TObject);
begin
  if TCrossManyToManyEditor0Form.ToggleEditor(Self, FTimeSlotForm,
    ConfigStorage, ActTimeSlot) then
  with SourceDataModule do
  begin
    {$IFDEF FPC}
    FTimeSlotForm.DrawGrid.OnPrepareCanvas := FTimeSlotForm.DrawGridPrepareCanvas;
    {$ENDIF}
    FTimeSlotForm.ShowEditor(TbDay, TbHour, TbTimeSlot, nil, 'IdDay', 'NaDay',
      'IdDay', '', 'IdHour', 'NaHour', 'IdHour', '');
  end;
end;

procedure TMainForm.ActSubjectExecute(Sender: TObject);
begin
   TSubjectForm.ToggleSingleEditor(Self,
				   SubjectForm,
				   ConfigStorage,
				   ActSubject,
				   SourceDataModule.TbSubject);
end;

procedure TMainForm.ActSpecializationExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FSpecializationForm,
					ConfigStorage,
					ActSpecialization,
					SourceDataModule.TbSpecialization);
end;

procedure TMainForm.ActLevelExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FLevelForm,
					ConfigStorage,
					ActLevel,
					SourceDataModule.TbLevel);
end;

procedure TMainForm.ActRoomTypeExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FRoomTypeForm,
					ConfigStorage,
					ActRoomType,
					SourceDataModule.TbRoomType);
end;

procedure TMainForm.ActParallelExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FParallelForm,
					ConfigStorage,
					ActParallel,
					SourceDataModule.TbParallel);
end;

procedure TMainForm.ActDayExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FDayForm,
					ConfigStorage,
					ActDay,
					SourceDataModule.TbDay);
end;

procedure TMainForm.ActHourExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FHourForm,
					ConfigStorage,
					ActHour,
					SourceDataModule.TbHour);
end;

procedure TMainForm.ActTimetableExecute(Sender: TObject);
begin
  TTimetableForm.ToggleSingleEditor(Self,
                                    TimetableForm,
				    ConfigStorage,
				    ActTimetable,
				    SourceDataModule.TbTimetable);
end;

procedure TMainForm.ActClassExecute(Sender: TObject);
begin
   TClassForm.ToggleSingleEditor(Self,
				 ClassForm,
				 ConfigStorage,
				 ActClass,
				 SourceDataModule.TbCourse);
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
{$IFNDEF FREEWARE}
var
  SIdTimetables: string;
{$ENDIF}
begin
{$IFNDEF FREEWARE}
  try
    SIdTimetables := IntToStr(MasterDataModule.NewIdTimetable);
    if not InputQuery(SGenerateTimetables, STimetableCodesToGenerate, SIdTimetables) then
      Exit;
    ElaborarTimetables(SIdTimetables);
  finally
    ActMakeTimetable.Checked := False;
  end;
{$ENDIF}
end;

{$IFNDEF FREEWARE}
procedure TMainForm.ElaborarTimetables(const SIdTimetables: string);
var
  ValidIdes, WrongIdes: TDynamicIntegerArray;
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
      SetLength(ValidIdes, Valids + IdTimetable2 - IdTimetable1 + 1);
      SetLength(WrongIdes, Wrongs + IdTimetable2 - IdTimetable1 + 1);
      for IdTimetable := IdTimetable1 to IdTimetable2 do
      begin
        if SourceDataModule.TbTimetable.Locate('IdTimetable', IdTimetable, []) then
        begin
          WrongIdes[Wrongs] := IdTimetable;
          Inc(Wrongs);
        end
        else
        begin
          ValidIdes[Valids] := IdTimetable;
          Inc(Valids);
        end;
      end;
    end;
    SetLength(ValidIdes, Valids);
    SetLength(WrongIdes, Wrongs);
  end;
begin
  with SourceDataModule do
  begin
    ActMakeTimetable.Enabled := False;
    try
      ProcessIdList(SIdTimetables);
      {$IFDEF THREADED}
      TMakeTimetableThread.Create(ValidIdes, False);
      {$ELSE}
      with TMakeTimetableThread.Create(ValidIdes, True) do
      try
        Execute;
      finally
        Free;
      end;
      {$ENDIF}
      if Length(WrongIdes) > 0 then
        MessageDlg(Format(STheNextTimetablesAlreadyExists, [VarArrToStr(WrongIdes)]),
          mtError, [mbOK], 0);
    finally
      ActMakeTimetable.Enabled := True;
      TbTimetableDetail.Refresh;
    end;
  end;
end;
{$ENDIF}

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

procedure TMainForm.RegisterSoftware;
{var
  InitDate: TDateTime;}
begin
{  with FSProtection do
    if Protect1.Execute(VarToStr(StoredValue['Password'])) then
    begin
      InitDate := Now;
      StoredValue['Password'] := Protect1.Password;
      if VarToStr(StoredValue['InitDate']) = '' then
        StoredValue['InitDate'] := Double(InitDate);
    end;}
end;

procedure TMainForm.ProtectSoftware;
{var
  LastDate, InitDate: TDateTime;}
begin
{  with FSProtection do
  begin
    if VarToStr(StoredValue['LastDate']) = '' then
      StoredValue['LastDate'] := Double(Now);
    if VarToStr(StoredValue['Password']) = Protect1.Password then
    begin
      InitDate := StoredValue['InitDate'];
      LastDate := StoredValue['LastDate'];
      if LastDate < Now then
      begin
        LastDate := Now;
        StoredValue['LastDate'] := Double(LastDate);
      end;
      if (Protect1.ExpirationDays > 0) and ((Protect1.ExpirationDays + InitDate < LastDate)
        or (LastDate > Now)) then
      begin
        MessageDlg('El tiempo de prueba a concluido'#13#10 +
          ' El sistema se ejecutara sin las opciones que permiten generar el horario',
          mtWarning, [mbOk], 0);
        ActMakeTimetable.Enabled := False;
        ActImproveTimeTable.Enabled := False;
      end
      else if Protect1.ExpirationDays > 0 then
      begin
        StatusBar.Panels[2].Text := Format('Transcurridos %d de %d dias',
          [Trunc(LastDate - InitDate), Protect1.ExpirationDays]);
      end
      else
      begin
        ActMakeTimetable.Enabled := True;
        ActImproveTimeTable.Enabled := True;
      end;
    end;
  end;}
end;

procedure TMainForm.LoadStoredConfig;
begin
  LoadConfig(FConfigStorage.ConfigStrings);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FUpdateIndex := 0;
  Height := 10 + Toolbar.Height + StatusBar.Height;
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
    {$IFDEF FREEWARE}
    ActMakeTimetable.Enabled := False;
    Caption := Caption + ' >>> Freeware <<<';
    {$ENDIF}
{    Protect1.ExpirationDays := 60;}
{    with FSProtection do
    begin
      //StoredValue['Password'] := '';
      //StoredValue['InitDate'] := '';
      //StoredValue['LastDate'] := '';
      RestoreFormPlacement;
      Protect1.UserID := Protect1.HardDiskID;
      if StoredValue['Password'] <> Protect1.Password then
        RegisterSoftware;
      ProtectSoftware;
    end;}
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
      {$IFNDEF FREEWARE}
      Inc(FUpdateIndex);
      {$ENDIF}
    end
    else
    begin
      SourceDataModule.TbSubjectRestrictionType.Refresh;
      SourceDataModule.TbTeacherRestrictionType.Refresh;
    end;
  finally
    ActConfigure.Checked := False;
  end;
end;

procedure TMainForm.ActCheckFeasibilityExecute(Sender: TObject);
begin
  MessageViewForm.HelpContext := ActCheckFeasibility.HelpContext;
  if MasterDataModule.PerformAllChecks(MessageViewForm.MemLog.Lines,
                                       MessageViewForm.MemSummary.Lines,
                                       MasterDataModule.ConfigStorage.MaxTeacherWorkLoad) then
  begin
    MessageViewForm.Show;
  end
  else
  begin
    if MessageDlg(SNoErrorReadyForCheckSummary, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      MessageViewForm.Show;
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

procedure TMainForm.ActContentsExecute(Sender: TObject);
begin
{$IFNDEF FPC}
  Application.HelpCommand(HELP_FINDER, 0);
{$ENDIF}
end;

procedure TMainForm.ActIndexExecute(Sender: TObject);
begin
{$IFNDEF FPC}
  Application.HelpCommand(HELP_FINDER, 0);
{$ENDIF}
end;

procedure TMainForm.ActRegistrationInfoExecute(Sender: TObject);
begin
  RegisterSoftware;
  ProtectSoftware;
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
{
    Values['MessageViewForm_MemSummary_Height'] :=
      IntToStr(MessageViewForm.MemSummary.Height);
}
  end;
end;

initialization

{$IFDEF FPC}
  {$i fmain.lrs}
{$ENDIF}

end.
