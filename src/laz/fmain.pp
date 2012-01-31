{ -*- mode: Delphi -*- }
unit FMain;

{$I ttg.inc}

{
TODO:
  - HORARIO POR PARALELOS
  - HORARIO POR PROFESORES
  - PROHIBICIONES DE PROFESORES
  - DISTRIBUTIVO POR PROFESORES
  - DISTRIBUTIVO POR MATERIAS
}
interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, MTProcs, SysUtils, Classes, Graphics,
  Forms, Dialogs, ExtCtrls, Menus, ComCtrls, Buttons, ActnList, FSplash, FSingleEditor,
  ZConnection, Controls, FCrossManyToManyEditor0, FEditor, UConfigStorage
{$IFNDEF FREEWARE}, UTTModel, UMakeTT{$ENDIF};

type

  { TMainForm }

  TMainForm = class(TForm)
    ActLangEnglish: TAction;
    ActLangSpanish: TAction;
    MainMenu: TMainMenu;
    MILanguages: TMenuItem;
    MILangSpanish: TMenuItem;
    MILangEnglish: TMenuItem;
    MITeacher: TMenuItem;
    MISubject: TMenuItem;
    MISpecialization: TMenuItem;
    MIGroupId: TMenuItem;
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
    MIElaborarTimeTable: TMenuItem;
    MINew: TMenuItem;
    MIOpen: TMenuItem;
    StatusBar: TStatusBar;
    MIPasswd: TMenuItem;
    MITimeTable: TMenuItem;
    MIDay: TMenuItem;
    MIHour: TMenuItem;
    MIClass: TMenuItem;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    MITimeSlot: TMenuItem;
    SpeedBar: TToolBar;
    SINew: TToolButton;
    SISave: TToolButton;
    SIOpen: TToolButton;
    SIPasswd: TToolButton;
    SIDay: TToolButton;
    SIHour: TToolButton;
    SISpecialization: TToolButton;
    SILevel: TToolButton;
    SIGroupId: TToolButton;
    SITeacher: TToolButton;
    SIRoomType: TToolButton;
    SITimeSlot: TToolButton;
    SIClass: TToolButton;
    SISubject: TToolButton;
    MIReopen: TMenuItem;
    ImageList: TImageList;
    MIContent: TMenuItem;
    MIIndex: TMenuItem;
    N3: TMenuItem;
    SIFindMejor: TToolButton;
    SITimeTable: TToolButton;
    SIContent: TToolButton;
    SIIndex: TToolButton;
    MIConfig: TMenuItem;
    SIConfig: TToolButton;
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
    ActGroupId: TAction;
    ActTeacher: TAction;
    ActRoomType: TAction;
    ActTimeSlot: TAction;
    ActClass: TAction;
    ActSubject: TAction;
    ActChequearFactibilidad: TAction;
    ActElaborarTimeTable: TAction;
    ActConfigurar: TAction;
    ActTimeTable: TAction;
    ActAbout: TAction;
    ActContents: TAction;
    ActIndex: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    MIChangePasswd: TMenuItem;
    ActChangePasswd: TAction;
    N2: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    ActMejorarTimeTable: TAction;
    MIMejorarTimeTable: TMenuItem;
    SaveDialogCSV: TSaveDialog;
    ActRegistrationInfo: TAction;
    MIRegistrationInfo: TMenuItem;
    ToolBar: TToolBar;
    procedure ActExitExecute(Sender: TObject);
    procedure ActLangEnglishExecute(Sender: TObject);
    procedure ActLangSpanishExecute(Sender: TObject);
    procedure ActTeacherExecute(Sender: TObject);
    procedure ActSubjectExecute(Sender: TObject);
    procedure ActSpecializationExecute(Sender: TObject);
    procedure ActLevelExecute(Sender: TObject);
    procedure ActRoomTypeExecute(Sender: TObject);
    procedure ActGroupIdExecute(Sender: TObject);
    procedure ActClassExecute(Sender: TObject);
    procedure ActDayExecute(Sender: TObject);
    procedure ActHourExecute(Sender: TObject);
    procedure ActNewExecute(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure ActOpenExecute(Sender: TObject);
    procedure ActTimeTableExecute(Sender: TObject);
    procedure ActElaborarTimeTableExecute(Sender: TObject);
    procedure ActTimeSlotExecute(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure FormCreate(Sender: TObject);
    procedure ActConfigurarExecute(Sender: TObject);
    procedure ActChequearFactibilidadExecute(Sender: TObject);
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
    FGroupIdForm,
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
    procedure ElaborarTimeTables(const SIdTimeTables: string);
{$ENDIF}
    procedure PedirRegistrarSoftware;
    procedure ProtegerSoftware;

  public
    { Public declarations }
    property UpdateIndex: Integer read FUpdateIndex write FUpdateIndex;
    property Progress: Integer read FProgress write SetProgress;
    property Min: Integer read FMin write SetMin;
    property Max: Integer read FMax write SetMax;
    property Step: Integer read FStep write SetStep;
    property ConfigStorage: TConfigStorage read FConfigStorage;
  end;

var
  MainForm: TMainForm;

implementation

uses
  FCrossManyToManyEditor, FCrossManyToManyEditor1, DMaster, FSubject, FTeacher,
  FTimeTable, FMasterDetailEditor, FConfiguracion, FClass, Printers, DSource,
  DSourceBase, UTTGBasics, FMessageView, uttgi18n;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TMainForm.ActExitExecute(Sender: TObject);
begin
  Close;
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

procedure TMainForm.ActGroupIdExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FGroupIdForm,
					ConfigStorage,
					ActGroupId,
					SourceDataModule.TbGroupId);
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

procedure TMainForm.ActTimeTableExecute(Sender: TObject);
begin
  TTimeTableForm.ToggleSingleEditor(Self,
                                    TimeTableForm,
				    ConfigStorage,
				    ActTimeTable,
				    SourceDataModule.TbTimeTable);
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
  Result :=
    MessageDlg('Los cambios realizados hasta el momento se perderan, '#13#10
    + 'Esta seguro?', mtWarning, [mbYes, mbNo], 0) = mrYes
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
    StatusBar.Panels[2].Text := 'Listo';
  end;
end;

procedure TMainForm.ActSaveExecute(Sender: TObject);
begin
  StatusBar.Panels[1].Style := psOwnerDraw;
  Progress := 0;
  Max := 100;
  SaveDialog.DefaultExt := 'ttd'; // Time Tabling Data
  SaveDialog.Filter := 'TimeTable para colegio (*.ttd)|*.ttd';
  try
    SaveDialog.HelpContext := ActSave.HelpContext;
    if SaveDialog.Execute then
    begin
      SaveToFile(SaveDialog.FileName);
      OpenDialog.FileName := SaveDialog.FileName;
    end;
  finally
    StatusBar.Panels[1].Style := psText;
    StatusBar.Panels[2].Text := 'Listo';
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
        MainForm.Caption := Application.Title + ' - ' +
          MasterDataModule.ConfigStorage.NaInstitution;
      end;
    end;
  finally
    StatusBar.Panels[1].Style := psText;
    StatusBar.Panels[2].Text := 'Listo';
  end;
end;

procedure TMainForm.ActElaborarTimeTableExecute(Sender: TObject);
{$IFNDEF FREEWARE}
var
  SIdTimeTables: string;
{$ENDIF}
begin
{$IFNDEF FREEWARE}
  try
    SIdTimeTables := IntToStr(MasterDataModule.NewIdTimeTable);
    if not InputQuery('Generar Horarioss', 'Codigos de los Horarios a generar',
        SIdTimeTables) then
      Exit;
    ElaborarTimeTables(SIdTimeTables);
  finally
    ActElaborarTimeTable.Checked := False;
  end;
{$ENDIF}
end;

{$IFNDEF FREEWARE}
procedure TMainForm.ElaborarTimeTables(const SIdTimeTables: string);
var
  ValidIdes, WrongIdes: TDynamicIntegerArray;
  procedure ProcessIdList(const IdList: string);
  var
    d: string;
    Position, Position2, IdTimeTable1, IdTimeTable2, IdTimeTable, Valids, Wrongs: Integer;
  begin
    Position := 1;
    Valids := 0;
    Wrongs := 0;
    while Position <= Length(IdList) do
    begin
      d := ExtractString(IdList, Position, ',');
      Position2 := 1;
      IdTimeTable1 := StrToInt(ExtractString(d, Position2, '-'));
      if Position2 > Length(d) then
        IdTimeTable2 := IdTimeTable1
      else
        IdTimeTable2 := StrToInt(ExtractString(d, Position2, '-'));
      if Position2 <= Length(d) then
        raise Exception.Create('El dato ingresado no es valido');
      SetLength(ValidIdes, Valids + IdTimeTable2 - IdTimeTable1 + 1);
      SetLength(WrongIdes, Wrongs + IdTimeTable2 - IdTimeTable1 + 1);
      for IdTimeTable := IdTimeTable1 to IdTimeTable2 do
      begin
        if SourceDataModule.TbTimeTable.Locate('IdTimeTable', IdTimeTable, []) then
        begin
          WrongIdes[Wrongs] := IdTimeTable;
          Inc(Wrongs);
        end
        else
        begin
          ValidIdes[Valids] := IdTimeTable;
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
    ActElaborarTimeTable.Enabled := False;
    try
      ProcessIdList(SIdTimeTables);
      {$IFDEF THREADED}
      TMakeTimeTableThread.Create(ValidIdes, False);
      {$ELSE}
      with TMakeTimeTableThread.Create(ValidIdes, True) do
      try
        Execute;
      finally
        Free;
      end;
      {$ENDIF}
      if Length(WrongIdes) > 0 then
        MessageDlg(Format('Los siguientes horarios ya existian: %s',
          [VarArrToStr(WrongIdes)]), mtError, [mbOK], 0);
    finally
      ActElaborarTimeTable.Enabled := True;
      TbTimeTableDetail.Refresh;
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

procedure TMainForm.PedirRegistrarSoftware;
{var
  InitDate: TDateTime;}
begin
{  with FSProteccion do
    if Protect1.Execute(VarToStr(StoredValue['Password'])) then
    begin
      InitDate := Now;
      StoredValue['Password'] := Protect1.Password;
      if VarToStr(StoredValue['InitDate']) = '' then
        StoredValue['InitDate'] := Double(InitDate);
    end;}
end;

procedure TMainForm.ProtegerSoftware;
{var
  LastDate, InitDate: TDateTime;}
begin
{  with FSProteccion do
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
      if (Protect1.DaysExpire > 0) and ((Protect1.DaysExpire + InitDate < LastDate)
        or (LastDate > Now)) then
      begin
        MessageDlg('El tiempo de prueba a concluido'#13#10 +
          ' El sistema se ejecutara sin las opciones que permiten generar el horario',
          mtWarning, [mbOk], 0);
        ActElaborarTimeTable.Enabled := False;
        ActMejorarTimeTable.Enabled := False;
      end
      else if Protect1.DaysExpire > 0 then
      begin
        StatusBar.Panels[2].Text := Format('Transcurridos %d de %d dias',
          [Trunc(LastDate - InitDate), Protect1.DaysExpire]);
      end
      else
      begin
        ActElaborarTimeTable.Enabled := True;
        ActMejorarTimeTable.Enabled := True;
      end;
    end;
  end;}
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  MainForm.Caption := Application.Title;
{$IFDEF DEBUG}
  Caption := Caption + ' - Debug Build';
{$ENDIF}
  FConfigFileName := GetCurrentDir + '/ttg.cfg';
  FConfigStorage := TConfigStorage.Create(Self);
  FUpdateIndex := 0;
  try
    if FileExists(FConfigFileName) then
    begin
      FConfigStorage.ConfigStrings.LoadFromFile(FConfigFileName);
      LoadConfig(FConfigStorage.ConfigStrings);
    end;
    FMin := 0;
    FMax := 100;
    FProgress := 0;
    FRelProgress := 0;
    FStep := 1;
    FLogStrings := TStringList.Create;
    {$IFDEF FREEWARE}
    ActElaborarTimeTable.Enabled := False;
    ActMejorarTimeTable.Enabled := False;
    Caption := Caption + ' ***Freeware***';
    {$ENDIF}
{    Protect1.DaysExpire := 60;}
{    with FSProteccion do
    begin
      //StoredValue['Password'] := '';
      //StoredValue['InitDate'] := '';
      //StoredValue['LastDate'] := '';
      RestoreFormPlacement;
      Protect1.UserID := Protect1.HardDiskID;
      if StoredValue['Password'] <> Protect1.Password then
        PedirRegistrarSoftware;
      ProtegerSoftware;
    end;}
  except
    ActElaborarTimeTable.Enabled := False;
    ActMejorarTimeTable.Enabled := False;
    raise;
  end;
end;

procedure TMainForm.ActConfigurarExecute(Sender: TObject);
begin
  try
    if ShowConfiguracionForm(ActConfigurar.HelpContext) = mrOK then
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
    ActConfigurar.Checked := False;
  end;
end;

procedure TMainForm.ActChequearFactibilidadExecute(Sender: TObject);
begin
  MessageViewForm.HelpContext := ActChequearFactibilidad.HelpContext;
  if MasterDataModule.PerformAllChecks(MessageViewForm.MemLog.Lines,
                                       MessageViewForm.MemSummary.Lines,
                                       MasterDataModule.ConfigStorage.MaxCargaTeacher) then
  begin
    MessageViewForm.Show;
  end
  else
  begin
    if MessageDlg('No se encontraron errores, esta listo para generar horario.'#13#10 +
                    'Desea mostrar el resumen del chequeo del horario?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
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
    MessageDlg('Los cambios realizados hasta el momento se perderan.'#13#10 +
    'Esta seguro que desea cerrar el programa?',
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
  PedirRegistrarSoftware;
  ProtegerSoftware;
end;

procedure TMainForm.LoadConfig(Strings: TStrings);
begin
  Position := poDesigned;
  with Strings do
  begin
    Top := StrToInt(Values['MainForm_Top']);
    Left := StrToInt(Values['MainForm_Left']);
    Width := StrToInt(Values['MainForm_Width']);
    Height := StrToInt(Values['MainForm_Height']);
    WindowState := TWindowState(StrToInt(Values['MainForm_WindowState']));
    SaveDialog.FileName := Values['SaveDialog_FileName'];
    SaveDialogCSV.FileName := Values['SaveDialogCSV_FileName'];
    OpenDialog.FileName := Values['OpenDialog_FileName'];
{
    MessageViewForm.MemSummary.Height :=
      StrToInt(Values['MessageViewForm_MemResumen_Height']);
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
    Values['MainForm_Height'] := IntToStr(Height);
    Values['MainForm_WindowState'] := IntToStr(Ord(WindowState));
    Values['SaveDialog_FileName'] := SaveDialog.FileName;
    Values['SaveDialogCSV_FileName'] := SaveDialogCSV.FileName;
    Values['OpenDialog_FileName'] := OpenDialog.FileName;
{
    Values['MessageViewForm_MemResumen_Height'] :=
      IntToStr(MessageViewForm.MemSummary.Height);
}
  end;
end;

initialization

{$IFDEF FPC}
  {$i fmain.lrs}
{$ENDIF}

end.
