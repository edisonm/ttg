program ttg;
{$IFNDEF FPC}
{$IMAGEBASE $00400000}
{$ENDIF}
uses
{$IFDEF UNIX}
  CThreads,
  CMem,
{$ENDIF}
{$IFDEF FPC}
  LResources,
  Interfaces,
{$ENDIF}
  Forms,
  Dialogs, multithreadprocslaz,
  SysUtils,
  FMain {MainForm},
  DMaster in 'DMaster.pp' {MasterDataModule: TDataModule},
  UTTModel,
  UEvolElitist in 'uevolelitist.pp',
  FProgress {ProgressForm},
  USortAlgs,
  FCrossManyToManyEditor {CrossManyToManyEditorForm},
  FCrossManyToManyEditor0 {CrossManyToManyEditor0Form},
  FCrossManyToManyEditor1 {CrossManyToManyEditor1Form},
  FCrossManytoManyEditorR {CrossManyToManyEditorRForm},
  FEditor {EditorForm},
  FMateria {MateriaForm},
  FProfesor {ProfesorForm},
  UTTGDBUtils in 'uttgdbutils.pp',
  UConfigStorage,
  FConfiguracion {ConfiguracionForm},
  FHorarioParalelo {HorarioParaleloForm},
  FMasterDetailEditor {MasterDetailEditorForm},
  FHorarioAulaTipo {HorarioAulaTipoForm},
  FSplash {SplashForm},
  FParalelo {ParaleloForm},
  FSingleEditor {SingleEditorForm},
  FHorario {HorarioForm},
  FHorarioProfesor {HorarioProfesorForm},
  DSourceBase {SourceBaseDataModule: TDataModule},
  URelUtils,
  UTTGConfig in 'uttgconfig.pp',
  DSource in 'DSource.pp' {SourceDataModule: TDataModule},
  FSelPeriodo {SelPeriodoForm},
  DBase in 'DBase.pp', 
UModel, UMakeTT, UDownHill, USolver, UTTGBasics, UAbout, FMessageView;

{$IFNDEF FPC}
{$R *.res}
{$ENDIF}

{$IFDEF WINDOWS}{$R ttg.rc}{$ENDIF}

begin
  {$IFDEF FPC}
  {$I ttg.lrs}
  {$ENDIF}
  DecimalSeparator := ',';
  Application.Initialize;
  Application.Title := sAppName + ' ' + sAppVersion;
  Application.HelpFile := '../hlp/ttg.hlp';
  Application.CreateForm(TSourceDataModule, SourceDataModule);
  Application.CreateForm(TMasterDataModule, MasterDataModule);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
