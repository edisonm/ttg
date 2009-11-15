program HorColeg;
{$IMAGEBASE $00400000}
uses
  Forms,
  Dialogs,
  SysUtils,
  FMain in 'FMain.pas' {MainForm},
  DMain in 'DMain.pas' {MainDataModule: TDataModule},
  DMaster in 'DMaster.PAS' {MasterDataModule: TDataModule},
  KerModel in 'KerModel.pas',
  KerEvolE in 'KerEvolE.pas',
  FProgres in 'FProgres.pas' {ProgressForm},
  SortAlgs in 'SortAlgs.pas',
  rand in 'Rand.pas',
  FCrsMMEd in 'FCrsMMEd.pas' {CrossManyToManyEditorForm},
  FCrsMME0 in 'FCrsMME0.pas' {CrossManyToManyEditor0Form},
  FCrsMME1 in 'FCrsMME1.pas' {CrossManyToManyEditor1Form},
  FCrsMMER in 'FCrsMMER.pas' {CrossManyToManyEditorRForm},
  FEditor in 'FEditor.pas' {EditorForm},
  FMateria in 'FMateria.pas' {MateriaForm},
  FProfesr in 'FProfesr.pas' {ProfesorForm},
  SGHCUtls in 'SGHCUtls.pas',
  FConfig in 'FConfig.pas' {ConfiguracionForm},
  FLogstic in 'FLogstic.pas' {LogisticForm},
  FHorPara in 'FHorPara.pas' {HorarioParaleloForm},
  FMasDeEd in 'FMasDeEd.pas' {MasterDetailEditorForm},
  FHorProf in 'FHorProf.pas' {HorarioProfesorForm},
  FSplash in 'FSplash.pas' {SplashForm},
  QSingRep in 'QSingRep.pas' {SingleReportQrp},
  QMaDeRep in 'QMaDeRep.pas' {MasterDetailReportQrp},
  FParalel in 'FParalel.pas' {ParaleloForm},
  FSingEdt in 'fsingedt.pas' {SingleEditorForm},
  FHorario in 'FHorario.pas' {HorarioForm},
  About in 'About.pas',
  HorColCm in 'HorColCm.pas';

{$R *.RES}

begin
  SplashForm := TSplashForm.Create(Application);
  SplashForm.Show;
  SplashForm.Update;
  SplashForm.PBLoad.Max := 5;
  Application.Initialize;
{$IFDEF FREEWARE}
  Application.Title := 'Horarios Para Colegio 1.2. Edición estándar.';
{$ELSE}
  Application.Title := 'Horarios Para Colegio 1.2';
{$ENDIF}
  Application.HelpFile := '..\HLP\HORCOLEG.HLP';
  Application.CreateForm(TMasterDataModule, MasterDataModule);
  MasterDataModule.OnProgress := SplashForm.OnProgress;
  SplashForm.IncPosition;
  Application.CreateForm(TMainDataModule, MainDataModule);
  SplashForm.IncPosition;
  Application.CreateForm(TMainForm, MainForm);
  SplashForm.IncPosition;
  Application.CreateForm(TConfiguracionForm, ConfiguracionForm);
  SplashForm.IncPosition;
  Application.CreateForm(TLogisticForm, LogisticForm);
  SplashForm.IncPosition;
{$IFNDEF FREEWARE}
  Application.CreateForm(TProgressForm, ProgressForm);
{$ENDIF}
  MasterDataModule.OnProgress := nil;
  SplashForm.Hide;
  SplashForm.Free;
  MainDataModule.DbMain.Session.GetPassword;
  Application.Run;
end.

