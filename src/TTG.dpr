program TTG;

{$MODE Delphi}

{$IMAGEBASE $00400000}
uses
  Forms,
  Dialogs,
  SysUtils,
  FMain in 'FMain.pas' {MainForm},
  DMaster in 'DMaster.pas' {MasterDataModule: TDataModule},
  KerModel in 'KerModel.pas',
  KerEvolE in 'KerEvolE.pas',
  FProgres in 'FProgres.pas' {ProgressForm},
  SortAlgs in 'SortAlgs.pas',
  Rand in 'Rand.pas',
  About in 'About.pas',
  FCrsMMEd in 'FCrsMMEd.pas' {CrossManyToManyEditorForm},
  FCrsMME0 in 'FCrsMME0.pas' {CrossManyToManyEditor0Form},
  FCrsMME1 in 'FCrsMME1.pas' {CrossManyToManyEditor1Form},
  FCrsMMER in 'FCrsMMER.pas' {CrossManyToManyEditorRForm},
  FEditor in 'FEditor.pas' {EditorForm},
  FMateria in 'FMateria.pas' {MateriaForm},
  FProfesr in 'FProfesr.pas' {ProfesorForm},
  TTGUtls in 'TTGUtls.pas',
  UConfig in 'UConfig.pas',
  FConfig in 'FConfig.pas' {ConfiguracionForm},
  FLogstic in 'FLogstic.pas' {LogisticForm},
  FHorPara in 'FHorPara.pas' {HorarioParaleloForm},
  FMasDeEd in 'FMasDeEd.pas' {MasterDetailEditorForm},
  FHorAulT in 'FHorAulT.pas' {HorarioAulaTipoForm},
  FSplash in 'FSplash.pas' {SplashForm},
  FParalel in 'FParalel.pas' {ParaleloForm},
  FSingEdt in 'FSingEdt.pas' {SingleEditorForm},
  FHorario in 'FHorario.pas' {HorarioForm},
  HorColCm in 'HorColCm.pas',
  FHorProf in 'FHorProf.pas' {HorarioProfesorForm},
  DSrcBase in 'DSrcBase.pas' {SourceBaseDataModule: TDataModule},
  RelUtils in 'RelUtils.pas',
  DSource in 'DSource.pas' {SourceDataModule: TDataModule},
  FSelPeIn in 'FSelPeIn.pas' {SelPeriodoForm},
  DBase in 'DBase.pas' {BaseDataModule: TDataModule};

{$R *.res}

begin
  SplashForm := TSplashForm.Create(Application);
  SplashForm.Caption := sAppName + ' ' + sAppVersion;
  SplashForm.lblProductName.Caption := SplashForm.Caption;
  SplashForm.lblProductVersion.Caption := sAppVersion;
  SplashForm.Show;
  SplashForm.Update;
  SplashForm.PBLoad.Max := 4;
  Application.Initialize;
  Application.Title := sAppName + ' ' + sAppVersion;
  Application.HelpFile := '..\hlp\TTG.hlp';
  Application.CreateForm(TSourceDataModule, SourceDataModule);
  SplashForm.IncPosition;
  Application.CreateForm(TMasterDataModule, MasterDataModule);
  SplashForm.IncPosition;
  Application.CreateForm(TMainForm, MainForm);
  SplashForm.IncPosition;
  Application.CreateForm(TLogisticForm, LogisticForm);
  SplashForm.IncPosition;
  Application.CreateForm(TProgressForm, ProgressForm);
  SplashForm.Hide;
  SplashForm.Free;
  Application.Run;
end.
