program ttg;
{$IFNDEF FPC}
{$IMAGEBASE $00400000}
{$ENDIF}
uses
  Forms,
  Dialogs,
{$IFDEF FPC}
  CThreads,
  LResources,
  Interfaces,
{$ENDIF}
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
  FMsgView in 'FMsgView.pas' {MessageViewForm},
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
  Application.CreateForm(TMessageViewForm, MessageViewForm);
  Application.CreateForm(TProgressForm, ProgressForm);
  Application.Run;
end.
