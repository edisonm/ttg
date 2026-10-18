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
  UConfigStorage, UTTGi18n, UProgress, zdbc, UAbout, UConsole;

var
  FConfigStorage: TConfigStorage;
  FConfigFileName, ExecutableExt, FConfigPath, Language: string;
  Args: TCommandLine;
  
const
  AppBaseName: string = 'ttg';

{$R *.res}

begin
  { Command line interface: --solve runs headlessly, before any GUI is
    initialized; use the ttgsolve build when no display is available. }
  ParseCommandLine(Args);
  if Args.ShowHelp then
  begin
    PrintUsage;
    Halt(0);
  end;
  if Args.Solving then
  begin
    if Args.InputFile = '' then
    begin
      WriteLn(StdErr, 'ttg --solve: missing input .ttd file');
      PrintUsage;
      Halt(2);
    end;
    try
      Halt(SolveFile(Args.InputFile, Args.OutputFile, Args.Seed,
        Args.MaxIteration, Args.NoDownHill));
    except
      on E: Exception do
      begin
        WriteLn(StdErr, 'ttg: ', E.Message);
        Halt(1);
      end;
    end;
  end;
  {$IFDEF UNIX}
  FConfigPath := GetEnvironmentVariable('HOME');
  ExecutableExt := '';
  {$ELSE}
  {$IFDEF WINDOWS}
  FConfigPath := GetEnvironmentVariable('HOMEDRIVE')
    + GetEnvironmentVariable('HOMEPATH');
  ExecutableExt := '.exe';
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
  DefaultFormatSettings.DecimalSeparator := ',';
  //RequireDerivedFormResource := True;
  Application.Initialize;
  Application.Title:='';
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
