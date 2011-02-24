program TTG;
{$IFNDEF FPC}
{$IMAGEBASE $00400000}
{$ENDIF}
uses
  Forms,
  Dialogs,
{$IFDEF FPC}
  Interfaces,
  LResources,
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

{$IFNDEF FPC}
{$R *.res}
{$ENDIF}

{$IFDEF WINDOWS}{$R ttg.rc}{$ENDIF}

begin
{$IFDEF FPC}
  {$I ttg.lrs}
{$ENDIF}
  DecimalSeparator := ',';
  DateSeparator := '/';
  ShortDateFormat := 'dd/mm/yyyy';
  LongTimeFormat := 'hh:nn:ss';
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
