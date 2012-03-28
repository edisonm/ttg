{ -*- mode: Delphi -*- }
program ttg;
uses
  {$IFDEF UNIX}
  CThreads,
  CMem,
  {$ENDIF}
  Forms,
  Dialogs, Interfaces, LResources,
  SysUtils,
  FMain {MainForm},
  DMaster in 'DMaster.pas' {MasterDataModule: TDataModule},
  UConfigStorage,
  FSplash {SplashForm},
  DSource in 'DSource.pp' {SourceDataModule: TDataModule},
  UAbout,
  UTTGi18n, zcomponent;

{$IFDEF WINDOWS}{$R ttg.rc}{$ENDIF}

var
  FConfigStorage: TConfigStorage;
  FConfigFileName, Language: string;

begin
  {$I ttg.lrs}
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
    EnableTranslator('ttg', Language);
  if Assigned(ResourceTranslator) then
  begin
    ResourceTranslator.TranslateUnitResourceStrings('UAbout');
    ResourceTranslator.TranslateUnitResourceStrings('UDataSetToStrings');
    ResourceTranslator.TranslateUnitResourceStrings('UTTGi18n');
    ResourceTranslator.TranslateUnitResourceStrings('UTTGConsts');
    ResourceTranslator.TranslateUnitResourceStrings('DSourceConsts');
  end;
  DecimalSeparator := ',';
  //RequireDerivedFormResource := True;
  Application.Initialize;
  Application.Title := sAppName;
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
