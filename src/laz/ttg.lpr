program ttg;
{$IFNDEF FPC}
{$IMAGEBASE $00400000}
{$ENDIF}
uses
  Forms,
  Dialogs,
{$IFDEF FPC}
  Interfaces,
{$ENDIF}
  SysUtils,
  FMain in 'FMain.pp' {MainForm},
  DMaster in 'DMaster.pp' {MasterDataModule: TDataModule},
  KerModel in 'KerModel.pp',
  KerEvolE in 'KerEvolE.pp',
  FProgres in 'FProgres.pp' {ProgressForm},
  SortAlgs in 'SortAlgs.pp',
  Rand in 'Rand.pp',
  About in 'About.pp',
  FCrsMMEd in 'FCrsMMEd.pp' {CrossManyToManyEditorForm},
  FCrsMME0 in 'FCrsMME0.pp' {CrossManyToManyEditor0Form},
  FCrsMME1 in 'FCrsMME1.pp' {CrossManyToManyEditor1Form},
  FCrsMMER in 'FCrsMMER.pp' {CrossManyToManyEditorRForm},
  FEditor in 'FEditor.pp' {EditorForm},
  FMateria in 'FMateria.pp' {MateriaForm},
  FProfesr in 'FProfesr.pp' {ProfesorForm},
  TTGUtls in 'TTGUtls.pp',
  UConfig in 'UConfig.pp',
  FConfig in 'FConfig.pp' {ConfiguracionForm},
  FMsgView in 'FMsgView.pp' {LogisticForm},
  FHorPara in 'FHorPara.pp' {HorarioParaleloForm},
  FMasDeEd in 'FMasDeEd.pp' {MasterDetailEditorForm},
  FHorAulT in 'FHorAulT.pp' {HorarioAulaTipoForm},
  FSplash in 'FSplash.pp' {SplashForm},
  FParalel in 'FParalel.pp' {ParaleloForm},
  FSingEdt in 'FSingEdt.pp' {SingleEditorForm},
  FHorario in 'FHorario.pp' {HorarioForm},
  HorColCm in 'HorColCm.pp',
  FHorProf in 'FHorProf.pp' {HorarioProfesorForm},
  DSrcBase in 'DSrcBase.pp' {SourceBaseDataModule: TDataModule},
  RelUtils in 'RelUtils.pp',
  DSource in 'DSource.pp' {SourceDataModule: TDataModule},
  FSelPeIn in 'FSelPeIn.pp' {SelPeriodoForm},
  DBase in 'DBase.pp' {BaseDataModule: TDataModule};

{$IFNDEF FPC}
{$R *.res}
{$ENDIF}

{$IFDEF WINDOWS}{$R ttg.rc}{$ENDIF}

begin
  DecimalSeparator := ',';
  Application.Initialize;
  Application.Title := sAppName + ' ' + sAppVersion;
  Application.HelpFile := '../hlp/ttg.hlp';
  Application.CreateForm(TSourceDataModule, SourceDataModule);
  Application.CreateForm(TMasterDataModule, MasterDataModule);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TLogisticForm, LogisticForm);
  Application.CreateForm(TProgressForm, ProgressForm);
  Application.Run;
end.
