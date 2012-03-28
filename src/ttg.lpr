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
  UConfigStorage,
  FSplash {SplashForm},
  DSource in 'DSource.pp' {SourceDataModule: TDataModule},
  UAbout,
  UTTGi18n, zcomponent;

var
  FConfigStorage: TConfigStorage;
  FConfigFileName, Language: string;

{$R *.res}

begin
  FConfigFileName := GetCurrentDir + '/ttg.cfg';
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
  Application.Title := sAppName;
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
