{ -*- mode: Delphi -*- }
program ttg;
uses
  {$IFDEF UNIX}
  CThreads,
  CMem,
  {$ENDIF}
  Forms,
  Dialogs, Interfaces,
  SysUtils,
  FMain {MainForm},
  DMaster in 'DMaster.pas' {MasterDataModule: TDataModule},
  FSplash {SplashForm},
  DSource in 'DSource.pas' {SourceDataModule: TDataModule},
  UConfigStorage, UAbout, UTTGi18n, zcomponent, UProgress;

var
  FConfigStorage: TConfigStorage;
  FConfigFileName, ExecutableExt, FConfigPath, Language: string;
  
const
  AppBaseName: string = 'ttg';

{$R *.res}

begin
  {$IFDEF UNIX}
  FConfigPath := GetEnvironmentVariable('HOME');
  {$ELSE}
  {$IFDEF WINDOWS}
  FConfigPath := GetEnvironmentVariable('HOMEDRIVE')
    + GetEnvironmentVariable('HOMEPATH');
  ExecutableExt = '.exe';
  {$ELSE}
  FConfigPath := GetCurrentDir;
  {$ENDIF}
  {$ENDIF}
  FConfigFileName := FConfigPath + DirectorySeparator + AppBaseName + '.conf';
  AppFullPath := GetCurrentDir + DirectorySeparator + AppBaseName + ExecutableExt;
  FConfigStorage := TConfigStorage.Create(Application);
  if FileExists(FConfigFileName) then
  begin
    FConfigStorage.ConfigStrings.LoadFromFile(FConfigFileName);
    Language := FConfigStorage.Values['Language'];
  end;
  if Language = '' then
    Language := GetDefaultLanguage;
  EnableTranslator('ttg', Language);
  if Assigned(ResourceTranslator) then
    ResourceTranslator.TranslateResourceStrings;
  DecimalSeparator := ',';
  //RequireDerivedFormResource := True;
  Application.Initialize;
  Application.Title := SAppName;
  {Application.HelpFile := '../hlp/ttg.hlp';}
  Application.CreateForm(TSourceDataModule, SourceDataModule);
  Application.CreateForm(TMasterDataModule, MasterDataModule);
  Application.CreateForm(TMainForm, MainForm);
  MainForm.ConfigStorage := FConfigStorage;
  MainForm.ConfigFileName := FConfigFileName;
  if FileExists(FConfigFileName) then
    MainForm.LoadStoredConfig;
  Application.Run;
end.
