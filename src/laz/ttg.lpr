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
  Dialogs, MultiThreadProcsLaz,
  SysUtils,
  FMain in 'FMain.pp' {MainForm},
  DMaster in 'DMaster.pp' {MasterDataModule: TDataModule},
  UTimeTableModel in 'utimetablemodel.pp',
  UEvolElitist in 'uevolelitist.pp',
  FProgres in 'FProgres.pp' {ProgressForm},
  SortAlgs in 'SortAlgs.pp',
  About in 'About.pp',
  FCrsMMEd in 'FCrsMMEd.pp' {CrossManyToManyEditorForm},
  FCrsMME0 in 'FCrsMME0.pp' {CrossManyToManyEditor0Form},
  FCrsMME1 in 'FCrsMME1.pp' {CrossManyToManyEditor1Form},
  FCrsMMER in 'FCrsMMER.pp' {CrossManyToManyEditorRForm},
  FEditor in 'FEditor.pp' {EditorForm},
  FMateria in 'FMateria.pp' {MateriaForm},
  FProfesr in 'FProfesr.pp' {ProfesorForm},
  UTTGDBUtils in 'uttgdbutils.pp',
  UConfig in 'UConfig.pp',
  FConfig in 'FConfig.pp' {ConfiguracionForm},
  FMsgView in 'FMsgView.pp' {MessageViewForm},
  FHorPara in 'FHorPara.pp' {HorarioParaleloForm},
  FMasDeEd in 'FMasDeEd.pp' {MasterDetailEditorForm},
  FHorAulT in 'FHorAulT.pp' {HorarioAulaTipoForm},
  FSplash in 'FSplash.pp' {SplashForm},
  FParalel in 'FParalel.pp' {ParaleloForm},
  FSingEdt in 'FSingEdt.pp' {SingleEditorForm},
  FHorario in 'FHorario.pp' {HorarioForm},
  UTTGCommon in 'uttgcommon.pp',
  FHorProf in 'FHorProf.pp' {HorarioProfesorForm},
  DSrcBase in 'DSrcBase.pp' {SourceBaseDataModule: TDataModule},
  RelUtils in 'RelUtils.pp',
  UTTGConfig in 'uttgconfig.pp',
  DSource in 'DSource.pp' {SourceDataModule: TDataModule},
  FSelPeIn in 'FSelPeIn.pp' {SelPeriodoForm},
  DBase in 'DBase.pp', 
UModel, UMakeTT, UDoubleDownHill, USolver, UTTGBasics;

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
  Application.Run;
end.
