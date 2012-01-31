program ttg;
{$IFNDEF FPC}
{$IMAGEBASE $00400000}
{$ENDIF}
uses
{$IFDEF UNIX}
  CThreads,
  CMem,
{$ENDIF}
  Forms,
  Dialogs, Interfaces, multithreadprocslaz,
  SysUtils,
  FMain {MainForm},
  DMaster in 'dmaster.pp' {MasterDataModule: TDataModule},
  UTTModel,
  UEvolElitist in 'uevolelitist.pp',
  FProgress {ProgressForm},
  USortAlgs,
  FCrossManyToManyEditor {CrossManyToManyEditorForm},
  FCrossManyToManyEditor0 {CrossManyToManyEditor0Form},
  FCrossManyToManyEditor1 {CrossManyToManyEditor1Form},
  FCrossManytoManyEditorR {CrossManyToManyEditorRForm},
  FEditor {EditorForm},
  FSubject {SubjectForm},
  FTeacher {TeacherForm},
  UTTGDBUtils in 'uttgdbutils.pp',
  UConfigStorage,
  FConfiguracion {ConfiguracionForm},
  FTimeTableClass {TimeTableClassForm},
  FMasterDetailEditor {MasterDetailEditorForm},
  FTimeTableRoomType {TimeTableRoomType},
  FSplash {SplashForm},
  FClass {ClassForm},
  FSingleEditor {SingleEditorForm},
  FTimeTable {TimeTableForm},
  FTimeTableTeacher {TimeTableTeacherForm},
  DSourceBase {SourceBaseDataModule: TDataModule},
  URelUtils,
  UTTGConfig in 'uttgconfig.pp',
  DSource in 'dsource.pp' {SourceDataModule: TDataModule},
  FSelTimeSlot {SelTimeSlotForm},
  DBase, UModel, UMakeTT, UDownHill, USolver, UTTGBasics, UAbout, FMessageView,
  UTTGi18n, uttgconsts;

{$IFNDEF FPC}
{$R *.res}
{$ENDIF}

{$IFDEF WINDOWS}{$R ttg.rc}{$ENDIF}

var
  FConfigStorage: TConfigStorage;
  FConfigFileName, Language: string;

begin
  FConfigFileName := GetCurrentDir + '/ttg.cfg';
  FConfigStorage := TConfigStorage.Create(Application);
  if FileExists(FConfigFileName) then
  begin
    FConfigStorage.ConfigStrings.LoadFromFile(FConfigFileName);
  end;
  Language := FConfigStorage.Values['Language'];
  if Language = '' then
    EnableTranslator('ttg')
  else
    EnableTranslator(GetLResourceForLanguage('ttg', Language));
  if Assigned(ResourceTranslator) then
  begin
    ResourceTranslator.TranslateUnitResourceStrings('UAbout');
    ResourceTranslator.TranslateUnitResourceStrings('URelUtils');
    ResourceTranslator.TranslateUnitResourceStrings('UTTGii18n');
    ResourceTranslator.TranslateUnitResourceStrings('UTTGConsts');
  end;
  DecimalSeparator := ',';
  Application.Initialize;
  Application.Title := sAppName + ' ' + sAppVersion;
  Application.HelpFile := '../hlp/ttg.hlp';
  Application.CreateForm(TSourceDataModule, SourceDataModule);
  Application.CreateForm(TMasterDataModule, MasterDataModule);
  Application.CreateForm(TMainForm, MainForm);
  MainForm.ConfigStorage := FConfigStorage;
  MainForm.ConfigFileName := FConfigFileName;
  if FileExists(FConfigFileName) then
    MainForm.LoadStoredConfig;
  Application.Run;
end.
