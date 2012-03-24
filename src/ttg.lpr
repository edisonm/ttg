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
  Dialogs, Interfaces,
  SysUtils,
  FMain {MainForm},
  DMaster in 'DMaster.pas' {MasterDataModule: TDataModule},
  UConfigStorage,
  FSplash {SplashForm},
  DSource in 'DSource.pp' {SourceDataModule: TDataModule},
  UAbout,
  UTTGi18n, zcomponent;

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
    ResourceTranslator.TranslateUnitResourceStrings('dsourcebaseconsts');
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
