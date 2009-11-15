unit FMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  SysConst, ExtCtrls, DB, Menus, ComCtrls, Placemnt,
  MRUList, ImgList, Buttons, MrgMngr, SpeedBar, RxMenus, ActnList, ToolWin,
  MenuBar, StdActns, StdCtrls, RxQuery, DBTables,
  TB97Ctls, DB97Btn, FSingEdt, QrPrntr, kbmMemTable, Protect;
type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    MIProfesor: TMenuItem;
    MIMateria: TMenuItem;
    MIEspecializacion: TMenuItem;
    MIParaleloId: TMenuItem;
    MINivel: TMenuItem;
    MIAulaTipo: TMenuItem;
    MIFile: TMenuItem;
    MISave: TMenuItem;
    N1: TMenuItem;
    MIExit: TMenuItem;
    MIData: TMenuItem;
    MITool: TMenuItem;
    MIView: TMenuItem;
    MIHelp: TMenuItem;
    MIAbout: TMenuItem;
    MIElaborarHorario: TMenuItem;
    MINew: TMenuItem;
    MIOpen: TMenuItem;
    StatusBar: TStatusBar;
    MIPasswd: TMenuItem;
    MIHorario: TMenuItem;
    MIDia: TMenuItem;
    MIHora: TMenuItem;
    MIParalelo: TMenuItem;
    SaveDialog: TSaveDialog;
    FormStorage: TFormStorage;
    OpenDialog: TOpenDialog;
    MIHorarioLaborable: TMenuItem;
    MIAsignatura: TMenuItem;
    SpeedBar: TToolBar;
    SINew: TToolButton;
    SISave: TToolButton;
    SIOpen: TToolButton;
    SIPasswd: TToolButton;
    SIDia: TToolButton;
    SIHora: TToolButton;
    SIEspecializacion: TToolButton;
    SINivel: TToolButton;
    SIParaleloId: TToolButton;
    SIProfesor: TToolButton;
    SIAulaTipo: TToolButton;
    SIHorarioLaborable: TToolButton;
    SIParalelo: TToolButton;
    SIMateria: TToolButton;
    SIAsignatura: TToolButton;
    MRUManager: TMRUManager;
    MIReopen: TMenuItem;
    ImageList: TImageList;
    MIContent: TMenuItem;
    MIIndex: TMenuItem;
    N3: TMenuItem;
    SIFindMejor: TToolButton;
    SIHorario: TToolButton;
    SIContent: TToolButton;
    SIIndex: TToolButton;
    MIConfig: TMenuItem;
    SIConfig: TToolButton;
    MICheckFeasibility: TMenuItem;
    ActionList: TActionList;
    actNew: TAction;
    actOpen: TAction;
    actSave: TAction;
    actPasswd: TAction;
    actExit: TAction;
    actDia: TAction;
    actHora: TAction;
    actEspecializacion: TAction;
    actNivel: TAction;
    actParaleloId: TAction;
    actProfesor: TAction;
    actAulaTipo: TAction;
    actHorarioLaborable: TAction;
    actParalelo: TAction;
    actMateria: TAction;
    actAsignatura: TAction;
    actChequearFactibilidad: TAction;
    actElaborarHorario: TAction;
    actConfigurar: TAction;
    actHorario: TAction;
    actAbout: TAction;
    actContents: TAction;
    actIndex: TAction;
    ControlBar: TControlBar;
    MenuBar: TMenuBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    WindowArrange: TWindowArrange;
    WindowCascade: TWindowCascade;
    WindowMinimizeAll: TWindowMinimizeAll;
    N4: TMenuItem;
    MinimizeAll1: TMenuItem;
    Cascade1: TMenuItem;
    WindowTileHorizontal: TWindowTileHorizontal;
    WindowTileVertical: TWindowTileVertical;
    TileHorizontally1: TMenuItem;
    TileVertically1: TMenuItem;
    Arrange1: TMenuItem;
    MIChangePasswd: TMenuItem;
    actChangePasswd: TAction;
    Label1: TLabel;
    N2: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    MIPresentarProfesorHorario: TMenuItem;
    MIPresentarParaleloHorario: TMenuItem;
    actPresentarParaleloHorario: TAction;
    actPresentarProfesorHorario: TAction;
    actPresentarMateriaProhibicion: TAction;
    actPresentarCargaAcademicaMateria: TAction;
    actPresentarProfesorProhibicion: TAction;
    MIPresentarProfesorProhibicion: TMenuItem;
    MIPresentarMateriaProhibicion: TMenuItem;
    MIPresentarCargaAcademicaMateria: TMenuItem;
    rxmParalelo: TkbmMemTable;
    QuParalelo: TQuery;
    QuParaleloCodNivel: TIntegerField;
    QuParaleloCodEspecializacion: TIntegerField;
    QuParaleloCodParaleloId: TIntegerField;
    QuParaleloAbrNivel: TStringField;
    QuParaleloAbrEspecializacion: TStringField;
    QuParaleloNomParaleloId: TStringField;
    rxmProfesor: TkbmMemTable;
    QuProfesor: TQuery;
    QuProfesorCodProfesor: TIntegerField;
    QuProfesorApeProfesor: TStringField;
    QuProfesorNomProfesro: TStringField;
    QuParaleloHora: TQuery;
    QuParaleloHoraCodNivel: TIntegerField;
    QuParaleloHoraCodEspecializacion: TIntegerField;
    QuParaleloHoraCodParaleloId: TIntegerField;
    QuParaleloHoraCodHora: TIntegerField;
    QuParaleloHoraNomHora: TStringField;
    QuProfesorHora: TQuery;
    QuProfesorHoraCodProfesor: TIntegerField;
    QuProfesorHoraCodHora: TIntegerField;
    QuProfesorHoraNomHora: TStringField;
    RxQuProfesorHorarioDetalle: TRxQuery;
    RxQuParaleloHorarioDetalle: TRxQuery;
    rxmMateria: TkbmMemTable;
    QuMateriaMateriaProhibicion: TQuery;
    QuMateriaMateriaProhibicionCodMateria: TIntegerField;
    QuMateriaMateriaProhibicionNomMateria: TStringField;
    QuMateriaMateriaProhibicionHora: TQuery;
    QuMateriaMateriaProhibicionHoraCodMateria: TIntegerField;
    QuMateriaMateriaProhibicionHoraCodHora: TIntegerField;
    QuMateriaMateriaProhibicionHoraNomHora: TStringField;
    QuProfesorProfesorProhibicion: TQuery;
    QuProfesorProfesorProhibicionApeProfesor: TStringField;
    QuProfesorProfesorProhibicionNomProfesor: TStringField;
    QuProfesorProfesorProhibicionCodProfesor: TIntegerField;
    QuProfesorProfesorProhibicionHora: TQuery;
    QuProfesorProfesorProhibicionHoraCodProfesor: TIntegerField;
    QuProfesorProfesorProhibicionHoraCodHora: TIntegerField;
    QuProfesorProfesorProhibicionHoraNomHora: TStringField;
    rxmProfesor1: TkbmMemTable;
    actPresentarCargaAcademicaProfesor: TAction;
    MIPresentarCargaAcademicaProfesor: TMenuItem;
    actExportarCSV: TAction;
    ExportarelhorarioaExcel1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    actMejorarHorario: TAction;
    MIMejorarHorario: TMenuItem;
    actCompactarTablas: TAction;
    Compactartablas1: TMenuItem;
    Protect1: TProtect;
    SaveDialogCSV: TSaveDialog;
    actRegistrationInfo: TAction;
    MIRegistrationInfo: TMenuItem;
    FSProteccion: TFormStorage;
    procedure actExitExecute(Sender: TObject);
    procedure actProfesorExecute(Sender: TObject);
    procedure actMateriaExecute(Sender: TObject);
    procedure actEspecializacionExecute(Sender: TObject);
    procedure actNivelExecute(Sender: TObject);
    procedure actAulaTipoExecute(Sender: TObject);
    procedure actParaleloIdExecute(Sender: TObject);
    procedure actPasswdExecute(Sender: TObject);
    procedure actParaleloExecute(Sender: TObject);
    procedure actDiaExecute(Sender: TObject);
    procedure actHoraExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actHorarioExecute(Sender: TObject);
    procedure actElaborarHorarioExecute(Sender: TObject);
    procedure actHorarioLaborableExecute(Sender: TObject);
    procedure actAsignaturaExecute(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure FormCreate(Sender: TObject);
    procedure MRUManagerClick(Sender: TObject; const RecentName,
      Caption: string; UserData: Integer);
    procedure actConfigurarExecute(Sender: TObject);
    procedure actChequearFactibilidadExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actChangePasswdExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPresentarProfesorHorarioExecute(Sender: TObject);
    procedure actPresentarParaleloHorarioExecute(Sender: TObject);
    procedure QuParaleloAfterScroll(DataSet: TDataSet);
    procedure QuProfesorAfterScroll(DataSet: TDataSet);
    procedure rxmParaleloFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure rxmProfesorFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure actPresentarMateriaProhibicionExecute(Sender: TObject);
    procedure rxmMateriaFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuMateriaMateriaProhibicionAfterScroll(DataSet: TDataSet);
    procedure actPresentarCargaAcademicaMateriaExecute(Sender: TObject);
    procedure actPresentarProfesorProhibicionExecute(Sender: TObject);
    procedure QuProfesorProfesorProhibicionAfterScroll(DataSet: TDataSet);
    procedure rxmProfesor1FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure actPresentarCargaAcademicaProfesorExecute(Sender: TObject);
    procedure actContentsExecute(Sender: TObject);
    procedure actIndexExecute(Sender: TObject);
    procedure actExportarCSVExecute(Sender: TObject);
    procedure actMejorarHorarioExecute(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure actCompactarTablasExecute(Sender: TObject);
    procedure actRegistrationInfoExecute(Sender: TObject);
  private
    { Private declarations }
{$IFNDEF FREEWARE}
    FInit: TDateTime;
    FCloseClick, FCancelClick: Boolean;
{$ENDIF}
    FPasada: Integer;
    FPosition: Integer;
    FRelPosition: Integer;
    FNumIteraciones: Integer;
    FMin: Integer;
    FMax: Integer;
    FStep: Integer;
    FEjecutando: Boolean;
    FAjustar: Boolean;
    FLogStrings: TStrings;
    FCodHorario: Integer;
    procedure SetPosition(Value: Integer);
    procedure SetMin(Value: Integer);
    procedure SetMax(Value: Integer);
    procedure SetStep(Value: Integer);
    procedure UpdRelPosition;

    procedure EdProfesorDestroy(Sender: TObject);
    procedure EdEspecializacionDestroy(Sender: TObject);
    procedure EdNivelDestroy(Sender: TObject);
    procedure EdParaleloIdDestroy(Sender: TObject);
    procedure EdAulaTipoDestroy(Sender: TObject);
    procedure EdDiaDestroy(Sender: TObject);
    procedure EdHoraDestroy(Sender: TObject);

    procedure EdHorarioLaborableDestroy(Sender: TObject);
    procedure EdParaleloDestroy(Sender: TObject);
    procedure EdMateriaDestroy(Sender: TObject);
    procedure EdAsignaturaDestroy(Sender: TObject);

    procedure EdHorarioDestroy(Sender: TObject);

    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
    {procedure DBGridGetCellParamsColor(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);}
    function ConfirmOperation: boolean;
    function GetCodHorarioSeleccionado: Integer;
    procedure ObtParaleloHorario;
    procedure ObtProfesorHorario;
{$IFNDEF FREEWARE}
    procedure InitRandom;
    procedure ElaborarHorario(s: string);
{$ENDIF}
    procedure InternalShowFormulary(ASingleEditorForm: TSingleEditorForm;
      ADataSet: TDataSet; AAction: TAction; DestroyEvent: TNotifyEvent);
    procedure ExportarCSV(AMasterDataSet, ADetailDataSet: TDataSet; AStrings: TStrings);
    procedure PrepareReportProfesorHorario(Sender: TObject);
    procedure PrepareReportParaleloHorario(Sender: TObject);
    procedure PrepareReportProhibicion(Sender: TObject);
    procedure PrepareReportCargaAcademicaMateria(Sender: TObject);
    procedure PrepareReportCargaAcademicaProfesor(Sender: TObject);
    procedure Progress(Sender: TObject);
    procedure ProgressDescensoDoble(I, Max: Integer; Value: Double; var Stop: Boolean);
    procedure OnCompactar(Sender: TObject);
    procedure ExportToFile(AFileName: TFileName);
    procedure ExportToStrings(AStrings: TStrings);
    procedure PedirRegistrarSoftware;
    procedure ProtegerSoftware;
    //procedure MarcarProgreso(Count, Cant: Integer);

  public
    { Public declarations }
    procedure OnProgress(DataSet: TDataSet);
{$IFNDEF FREEWARE}
    procedure OnIterar(Sender: TObject);
    procedure OnRegistrarMejor(Sender: TObject);
    procedure ProgressFormCloseClick(Sender: TObject);
    procedure ProgressFormCancelClick(Sender: TObject);
{$ENDIF}
    procedure AjustarPesos;
    procedure PrepareReport(Sender: TObject);
    property Position: Integer read FPosition write SetPosition;
    property Min: Integer read FMin write SetMin;
    property Max: Integer read FMax write SetMax;
    property Step: Integer read FStep write SetStep;
    property Ejecutando: Boolean read FEjecutando;
    property CodHorario: Integer read FCodHorario write FCodHorario;
    property NumIteraciones: Integer read FNumIteraciones write FNumIteraciones;
    property CodHorarioSeleccionado: Integer read GetCodHorarioSeleccionado;
  end;

var
  MainForm: TMainForm;

implementation

uses
{$IFNDEF FREEWARE}
  KerEvolE, KerModel, FProgres,
{$ENDIF}
  FCrsMMEd, FCrsMME0, FCrsMME1, DMain, DMaster, FMateria,
  FProfesr, FHorario, FConfig, FLogstic, SGHCUtls, About, Consts,
  FParalel, Rand, ArDBUtls, QMaDeRep, Printers, QSingRep, QuickRpt, Qrctrls,
  DBPacker;

{$R *.DFM}

procedure TMainForm.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.EdProfesorDestroy(Sender: TObject);
begin
  actProfesor.Enabled := True;
end;

procedure TMainForm.EdAsignaturaDestroy(Sender: TObject);
begin
  MasterDataModule.TbAsignatura.Filtered := False;
  actAsignatura.Enabled := true;
end;

procedure TMainForm.EdParaleloDestroy(Sender: TObject);
begin
  actParalelo.Enabled := true;
end;

procedure TMainForm.EdDiaDestroy(Sender: TObject);
begin
  actDia.Enabled := true;
end;

procedure TMainForm.EdEspecializacionDestroy(Sender: TObject);
begin
  actEspecializacion.Enabled := true;
end;

procedure TMainForm.EdHoraDestroy(Sender: TObject);
begin
  actHora.Enabled := true;
end;

procedure TMainForm.EdMateriaDestroy(Sender: TObject);
begin
  actMateria.Enabled := True;
end;

procedure TMainForm.EdNivelDestroy(Sender: TObject);
begin
  actNivel.Enabled := True;
end;

procedure TMainForm.EdParaleloIdDestroy(Sender: TObject);
begin
  actParaleloId.Enabled := True;
end;

procedure TMainForm.EdHorarioLaborableDestroy(Sender: TObject);
begin
  actHorarioLaborable.Enabled := True;
end;

procedure TMainForm.EdAulaTipoDestroy(Sender: TObject);
begin
  actAulaTipo.Enabled := True;
end;

procedure TMainForm.EdHorarioDestroy(Sender: TObject);
begin
  actHorario.Enabled := True;
end;

procedure TMainForm.actProfesorExecute(Sender: TObject);
begin
  InternalShowFormulary(TProfesorForm.Create(Application),
    MasterDataModule.TbProfesor, actProfesor, EdProfesorDestroy);
end;

procedure TMainForm.actHorarioLaborableExecute(Sender: TObject);
var
  HorarioLaborableForm: TCrossManyToManyEditor0Form;
begin
  HorarioLaborableForm :=
    TCrossManyToManyEditor0Form.Create(Application);
  with MasterDataModule, HorarioLaborableForm do
  begin
    HelpContext := actHorarioLaborable.HelpContext;
    LoadCaption(HorarioLaborableForm, TbHorarioLaborable);
    OnDestroy := EdHorarioLaborableDestroy;
    with FormStorage do
    begin
      IniSection := IniSection + '\CrMME0' + TbHorarioLaborable.TableName;
      Active := True;
      RestoreFormPlacement;
    end;
    ShowEditor(TbDia, TbHora, TbHorarioLaborable, nil, 'CodDia', 'NomDia',
      'CodDia', '', 'CodHora', 'NomHora', 'CodHora', '');
  end;
  actHorarioLaborable.Enabled := False;
end;

procedure TMainForm.InternalShowFormulary(ASingleEditorForm: TSingleEditorForm;
  ADataSet: TDataSet; AAction: TAction; DestroyEvent: TNotifyEvent);
begin
  ASingleEditorForm.HelpContext := AAction.HelpContext;
  MySingleShowEditor(ASingleEditorForm, ADataSet,
    ConfiguracionForm.edtNomColegio.Text, DestroyEvent);
  AAction.Enabled := false;
end;

procedure TMainForm.actMateriaExecute(Sender: TObject);
begin
  InternalShowFormulary(TMateriaForm.Create(Application),
    MasterDataModule.TbMateria, actMateria, EdMateriaDestroy);
end;

procedure TMainForm.actEspecializacionExecute(Sender: TObject);
begin
  InternalShowFormulary(TSingleEditorForm.Create(Application),
    MasterDataModule.TbEspecializacion, actEspecializacion,
    EdEspecializacionDestroy);
end;

procedure TMainForm.actNivelExecute(Sender: TObject);
begin
  InternalShowFormulary(TSingleEditorForm.Create(Application),
    MasterDataModule.TbNivel, actNivel, EdNivelDestroy);
end;

procedure TMainForm.actAulaTipoExecute(Sender: TObject);
begin
  InternalShowFormulary(TSingleEditorForm.Create(Application),
    MasterDataModule.TbAulaTipo, actAulaTipo, EdAulaTipoDestroy);
end;

procedure TMainForm.actParaleloIdExecute(Sender: TObject);
begin
  InternalShowFormulary(TSingleEditorForm.Create(Application),
    MasterDataModule.TbParaleloId, actParaleloId, EdParaleloIdDestroy);
end;

procedure TMainForm.actDiaExecute(Sender: TObject);
begin
  InternalShowFormulary(TSingleEditorForm.Create(Application),
    MasterDataModule.TbDia, ActDia, EdDiaDestroy);
end;

procedure TMainForm.actHoraExecute(Sender: TObject);
begin
  InternalShowFormulary(TSingleEditorForm.Create(Application),
    MasterDataModule.TbHora, actHora, EdHoraDestroy);
end;

procedure TMainForm.actHorarioExecute(Sender: TObject);
begin
  InternalShowFormulary(THorarioForm.Create(Application),
    MasterDataModule.TbHorario, actHorario, EdHorarioDestroy);
end;

procedure TMainForm.actPasswdExecute(Sender: TObject);
begin
  MainDataModule.DbMain.Session.GetPassword;
end;

procedure TMainForm.actParaleloExecute(Sender: TObject);
var
  ParaleloForm: TParaleloForm;
begin
  ParaleloForm := TParaleloForm.Create(Application);
  with MasterDataModule, ParaleloForm do
  begin
    TbCurso.Open;
    TbParalelo.Open;
    TbParaleloId.Open;
    InternalShowFormulary(ParaleloForm, TbCurso, actParalelo,
      EdParaleloDestroy);
    Caption := GetDescription(TbParalelo);
  end;
end;

procedure TMainForm.actAsignaturaExecute(Sender: TObject);
begin
  InternalShowFormulary(TSingleEditorForm.Create(Application),
    MasterDataModule.TbAsignatura, actAsignatura, EdAsignaturaDestroy);
end;

function TMainForm.ConfirmOperation: boolean;
begin
  Result :=
    MessageDlg('Los cambios realizados hasta el momento se perderán, '#13#10
    + '¿Está seguro?', mtWarning, [mbYes, mbNo], 0) = mrYes
end;

procedure TMainForm.actNewExecute(Sender: TObject);
begin
  StatusBar.Panels[1].Style := psOwnerDraw;
  Position := 0;
  try
    if ConfirmOperation then
    begin
      Max := 20;
      MainDataModule.NewDataBase(OnProgress);
      ConfiguracionForm.Clear;
      Position := 0;
    end;
  finally
    StatusBar.Panels[1].Style := psText;
    StatusBar.Panels[2].Text := 'Listo';
  end;
end;

procedure TMainForm.actSaveExecute(Sender: TObject);
begin
  StatusBar.Panels[1].Style := psOwnerDraw;
  Position := 0;
  Max := 100;
  try
    SaveDialog.HelpContext := actSave.HelpContext;
    if SaveDialog.Execute then
    begin
      SaveToFile(SaveDialog.FileName);
      OpenDialog.FileName := SaveDialog.FileName;
      MRUManager.Add(SaveDialog.FileName, 0);
    end;
  finally
    StatusBar.Panels[1].Style := psText;
    StatusBar.Panels[2].Text := 'Listo';
  end;
end;

procedure TMainForm.SaveToFile(const AFileName: string);
begin
  Cursor := crHourGlass;
  try
    ConfiguracionForm.FormStorage.SaveFormPlacement;
    MainDataModule.SaveToFile(AFileName);
  finally
    Cursor := crDefault;
  end;
end;

procedure TMainForm.LoadFromFile(const AFileName: string);
begin
  Cursor := crHourGlass;
  try
    MainDataModule.LoadFromFile(AFileName);
    ConfiguracionForm.FormStorage.RestoreFormPlacement;
  finally
    Cursor := crDefault;
  end;
end;

procedure TMainForm.actOpenExecute(Sender: TObject);
begin
  StatusBar.Panels[1].Style := psOwnerDraw;
  Position := 0;
  try
    OpenDialog.HelpContext := actOpen.HelpContext;
    if OpenDialog.Execute then
    begin
      LoadFromFile(OpenDialog.FileName);
      MRUManager.Add(OpenDialog.FileName, 0);
      SaveDialog.FileName := OpenDialog.FileName;
    end;
  finally
    StatusBar.Panels[1].Style := psText;
    StatusBar.Panels[2].Text := 'Listo';
  end;
end;

{$IFNDEF FREEWARE}

procedure TMainForm.InitRandom;
begin
  ConfiguracionForm.InitRandom;
end;
{$ENDIF}

procedure TMainForm.AjustarPesos;
begin
  FAjustar := True;
end;


procedure TMainForm.actElaborarHorarioExecute(Sender: TObject);
{$IFNDEF FREEWARE}
var
  s: string;
{$ENDIF}
begin
{$IFNDEF FREEWARE}
  with MasterDataModule do
  begin
    if not InputQuery('Códigos de los Horarios: ',
      'Ingrese los códigos de los Horarios a generar', s) then
      Exit;
    ElaborarHorario(s);
  end;
{$ENDIF}
end;

procedure TMainForm.OnProgress(DataSet: TDataSet);
begin
  Position := Position + 1;
  StatusBar.Panels[2].Text := 'Eliminando ' + (DataSet as TTable).TableName;
end;

{
procedure TMainForm.MarcarProgreso(Count, Cant: Integer);
begin
  Position := Count;
  Min := 0;
  Max := Cant - 1;
  StatusBar.Panels[2].Text := Format('%d de %d', [Count, Cant]);
  Application.ProcessMessages;
end;
}
{$IFNDEF FREEWARE}

procedure TMainForm.ElaborarHorario(s: string);
var
  VModeloHorario: TModeloHorario;
  VEvolElitista: TEvolElitista;
  FMomentoInicial, FMomentoFinal: TDateTime;
  sProb: string;
  procedure ShowProgressForm;
  begin
    with ProgressForm do
    begin
      Show;
      HelpContext := actElaborarHorario.HelpContext;
      NumMaxGeneracion := vEvolElitista.NumMaxGeneracion;
      FInit := Now;
      Caption :=
        Format('Elaboración en progreso [%d]', [CodHorario]);
      lblInit.Caption := FormatDateTime(Format('%s %s ', [ShortDateFormat,
        LongTimeFormat]), FInit);
      FCloseClick := False;
      bbtnClose.OnClick := ProgressFormCloseClick;
      bbtnClose.Kind := bkCustom;
      bbtnCancel.OnClick := ProgressFormCancelClick;
      bbtnCancel.Kind := bkCustom;
    end;
  end;
  procedure ProcesarCodHorario(Cod: Integer);
  begin
    CodHorario := Cod;
    if MasterDataModule.TbHorario.Locate('CodHorario', CodHorario, []) then
      sProb := sProb + ' ' + IntToStr(CodHorario)
    else
    begin
      FMomentoInicial := Now;
      ShowProgressForm;
      FLogStrings.Clear;
      FLogStrings.BeginUpdate;
      try
        vEvolElitista.Ejecutar;
      finally
        FLogStrings.EndUpdate;
      end;
      //FLogStrings.SaveToFile(Format('LogHor_%d.txt', [CodHorario]));
      if FCancelClick then
        Exit;
      VEvolElitista.DescensoRapidoForzado;
      // Condicionar lo siguiente
      {if True then
      begin
        with VEvolElitista.MejorObjetoModeloHorario do
        begin
          DescensoRapido2(MarcarProgreso);
        end;
      end;}
      // fin de lo que debe ser condicionado
      FMomentoFinal := Now;
      VEvolElitista.SaveMejorToDatabase(Cod, FMomentoInicial,
        FMomentoFinal);
      if MasterDataModule.TbHorario.Active then
        MasterDataModule.TbHorario.Refresh;
    end; // if
  end;
  procedure ProcessCodList(const CodList: string);
  var
    d: string;
    iPos, iPosd, FCodIni, FCodFin, iCod: Integer;
  begin
    iPos := 1;
    while iPos <= Length(CodList) do
    begin
      d := ExtractString(CodList, iPos, ',');
      iPosd := 1;
      FCodIni := StrToInt(ExtractString(d, iPosd, '-'));
      if iPosd > Length(d) then
        FCodFin := FCodIni
      else
        FCodFin := StrToInt(ExtractString(d, iPosd, '-'));
      if iPosd <= Length(d) then
        raise Exception.Create('El dato ingresado no es válido');
      for iCod := FCodIni to FCodFin do
      begin
        ProcesarCodHorario(iCod);
        if FCancelClick then
          Exit;
      end;
    end;
  end;
var
  mr: TModalResult;
begin
  with MasterDataModule do
  begin
    TbHorario.Open;
    InitRandom;
    actElaborarHorario.Enabled := False;
    FEjecutando := True;
    try
      with ConfiguracionForm do
      begin
        FNumIteraciones := speNumIteraciones.Value;
        VModeloHorario :=
          TModeloHorario.CrearDesdeDatabase(MainDataModule.dbMain,
          creCruceProfesor.Value,
          creProfesorFraccionamiento.Value,
          creCruceAulaTipo.Value,
          creHoraHueca.Value,
          creSesionCortada.Value,
          creMateriaNoDispersa.Value);
        try
          VEvolElitista := TEvolElitista.CrearDesdeModelo(VModeloHorario,
            speTamPoblacion.Value);
          VEvolElitista.NumMaxGeneracion := speNumMaxGeneracion.Value;
          VEvolElitista.ProbCruzamiento := creProbCruzamiento.Value;
          VEvolElitista.ProbMutacion1 := creProbMutacion1.Value;
          VEvolElitista.OrdenMutacion1 := speOrdenMutacion1.Value;
          VEvolElitista.ProbMutacion2 := creProbMutacion2.Value;
          VEvolElitista.ProbReparacion := creProbReparacion.Value;
          VEvolElitista.SyncDirectory := dedCompartir.Text;
          VEvolElitista.RangoPolinizacion := speRangoPolinizacion.Value;
          if (dedCompartir.Text <> '')
            and FileExists(VEvolElitista.SyncFileName) then
          begin
            mr := MessageDlg('El archivo de sincronización ya existe.  ' +
              '¿Desea eliminar los archivos relacionados?', mtWarning, [mbYes,
              mbNo, mbCancel], 0);
            if mr = mrYes then
            begin
              DeleteFile(VEvolElitista.FileName);
              DeleteFile(VEvolElitista.SyncFileName);
            end
            else if mr = mrCancel then
            begin
              raise Exception.Create('Operación cancelada por el usuario');
            end
          end;
          VEvolElitista.PrefijarHorarios(ConfiguracionForm.edtHorarioIni.Text);
          FCancelClick := False;
          FAjustar := False;
          VEvolElitista.OnIterar := Self.OnIterar;
          VEvolElitista.OnRegistrarMejor := Self.OnRegistrarMejor;
          try
            sProb := '';
            ProcessCodList(s);
            if sProb <> '' then
              MessageDlg(Format('Los siguientes horarios ya existían: %s',
                [sProb]), mtError, [mbOK], 0);
          finally
            VEvolElitista.Free;
          end;
        finally
          VModeloHorario.Free;
        end;
      end;
    finally
      FEjecutando := False;
      ProgressForm.bbtnClose.OnClick := nil;
      ProgressForm.bbtnCancel.OnClick := nil;
      FCloseClick := False;
      FCancelClick := False;
      ProgressForm.bbtnClose.Kind := bkClose;
      ProgressForm.bbtnClose.Caption := 'Finalizar';
      ProgressForm.bbtnCancel.Kind := bkCancel;
      ProgressForm.Close;
      actElaborarHorario.Enabled := True;
      if TbHorarioDetalle.Active then
        TbHorarioDetalle.Refresh;
    end;
  end;
  StatusBar.Panels[2].Text := '';
end;

procedure TMainForm.OnIterar(Sender: TObject);
begin
  with Sender as TEvolElitista do
  begin
    if NumGeneracion mod NumIteraciones = 0 then
    begin
      Application.ProcessMessages;
      StatusBar.Panels[2].Text := Format('%d de %d', [NumGeneracion,
        ProgressForm.PBNumMaxGeneracion.Max]);
      ProgressForm.SetValues(Now - FInit, NumGeneracion, MejorCruceProfesor,
        MejorProfesorFraccionamiento,
        MejorCruceAulaTipo, MejorHoraHuecaDesubicada, MejorSesionCortada,
        MejorMateriaProhibicion, MejorProfesorProhibicion,
        MejorMateriaNoDispersa, NumImportacion, NumExportacion, NumColision,
        MejorCruceProfesorValor,
        MejorProfesorFraccionamientoValor, MejorCruceAulaTipoValor,
        MejorHoraHuecaDesubicadaValor, MejorSesionCortadaValor,
        MejorMateriaProhibicionValor, MejorDisponiblidadValor,
        MejorMateriaNoDispersaValor, MejorValor);
      if FAjustar then
        with ConfiguracionForm do
        begin
          InvalidarValores;
          //Actualizar;
          ModeloHorario.Configurar(
            creCruceProfesor.Value,
            creProfesorFraccionamiento.Value,
            creCruceAulaTipo.Value,
            creHoraHueca.Value,
            creSesionCortada.Value,
            creMateriaNoDispersa.Value);
          FAjustar := False;
        end;
      if (FCloseClick or FCancelClick) then
        Terminar;
    end;
  end;
end;

procedure TMainForm.OnRegistrarMejor(Sender: TObject);
var
  t: TDateTime;
begin
  with Sender as TEvolElitista do
  begin
    t := Now - FInit;
    FLogStrings.Add(Format('%g; %d; %g; %g', [t, NumGeneracion, MejorValor,
      PromedioValor]));
  end;
end;

procedure TMainForm.ProgressFormCloseClick(Sender: TObject);
begin
  FCloseClick := True;
  ProgressForm.Close;
end;

procedure TMainForm.ProgressFormCancelClick(Sender: TObject);
begin
  FCancelClick := True;
  ProgressForm.Close;
end;

{$ENDIF}

procedure TMainForm.SetMax(Value: Integer);
begin
  if FMax <> Value then
  begin
    FMax := Value;
    StatusBar.Invalidate;
  end;
end;

procedure TMainForm.SetMin(Value: Integer);
begin
  if FMin <> Value then
  begin
    FMin := Value;
    StatusBar.Invalidate;
  end;
end;

procedure TMainForm.SetPosition(Value: Integer);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    UpdRelPosition;
  end;
end;

procedure TMainForm.SetStep(Value: Integer);
begin
  if FStep <> Value then
  begin
    FStep := Value;
    UpdRelPosition;
  end;
end;

procedure TMainForm.UpdRelPosition;
var
  VRelPosition: Integer;
begin
  VRelPosition := ((FPosition - FMin) div FStep) * FStep;
  if FRelPosition <> VRelPosition then
  begin
    FRelPosition := VRelPosition;
    StatusBar.Repaint;
  end;
end;

procedure TMainForm.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  VRect: TRect;
begin
  if FRelPosition <> 0 then
  begin
    VRect := Rect;
    VRect.Right := VRect.Left + MulDiv(Rect.Right - Rect.Left, FRelPosition,
      (FMax - FMin));
    StatusBar.Canvas.Brush.Color := clNavy;
    StatusBar.Canvas.FillRect(VRect);
  end
  else
    StatusBar.Canvas.FillRect(Rect);
end;

procedure TMainForm.PedirRegistrarSoftware;
var
  InitDate: TDateTime;
begin
  with FSProteccion do
    if Protect1.Execute(VarToStr(StoredValue['Password'])) then
    begin
      InitDate := Now;
      StoredValue['Password'] := Protect1.Password;
      if VarToStr(StoredValue['InitDate']) = '' then
        StoredValue['InitDate'] := Double(InitDate);
    end;
end;

procedure TMainForm.ProtegerSoftware;
var
  LastDate, InitDate: TDateTime;
begin
  with FSProteccion do
  begin
    if VarToStr(StoredValue['LastDate']) = '' then
      StoredValue['LastDate'] := Double(Now);
    if VarToStr(StoredValue['Password']) = Protect1.Password then
    begin
      InitDate := StoredValue['InitDate'];
      LastDate := StoredValue['LastDate'];
      if LastDate < Now then
      begin
        LastDate := Now;
        StoredValue['LastDate'] := Double(LastDate);
      end;
      if (Protect1.DaysExpire > 0) and ((Protect1.DaysExpire + InitDate < LastDate)
        or (LastDate > Now)) then
      begin
        MessageDlg('El tiempo de prueba a concluido'#13#10 +
          ' El sistema correrá sin las opciones que permiten generar el horario',
          mtWarning, [mbOk], 0);
        actElaborarHorario.Enabled := False;
        actMejorarHorario.Enabled := False;
      end
      else if Protect1.DaysExpire > 0 then
      begin
        StatusBar.Panels[2].Text := Format('Transcurridos %d de %d días',
          [Trunc(LastDate - InitDate), Protect1.DaysExpire]);
      end
      else
      begin
        actElaborarHorario.Enabled := True;
        actMejorarHorario.Enabled := True;
      end;
    end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  try
    FMin := 0;
    FMax := 100;
    FPosition := 0;
    FRelPosition := 0;
    FStep := 1;
    FEjecutando := False;
    FAjustar := False;
    FLogStrings := TStringList.Create;
{$IFDEF FREEWARE}
    actElaborarHorario.Enabled := False;
{$ENDIF}
    Protect1.DaysExpire := 60;
    FormStorage.RestoreFormPlacement;
    with FSProteccion do
    begin
      //StoredValue['Password'] := '';
      //StoredValue['InitDate'] := '';
      //StoredValue['LastDate'] := '';
      RestoreFormPlacement;
      Protect1.UserID := Protect1.HardDiskID;
      if StoredValue['Password'] <> Protect1.Password then
        PedirRegistrarSoftware;
      ProtegerSoftware;
    end;
  except
    actElaborarHorario.Enabled := False;
    actMejorarHorario.Enabled := False;
    raise;
  end;
  MainDataModule.dbpkMain.OnProgress := Progress;
end;

procedure TMainForm.Progress(Sender: TObject);
const
  SMsgs: array[TPackerStatus] of string = (
    'Desocupado', 'Comprimiendo', 'Expandiendo', 'Leyendo', 'Escribiendo');
begin
  with Sender as TDBPacker do
  begin
    StatusBar.Panels[2].Text := SMsgs[Status];
    Self.Max := Max;
    Self.Position := Position;
  end;
end;

procedure TMainForm.MRUManagerClick(Sender: TObject; const RecentName,
  Caption: string; UserData: Integer);
begin
  if ConfirmOperation then
  begin
    LoadFromFile(RecentName);
    SaveDialog.FileName := RecentName;
    OpenDialog.FileName := RecentName;
  end;
end;

procedure TMainForm.actConfigurarExecute(Sender: TObject);
begin
  MasterDataModule.TbMateriaProhibicionTipo.Open;
  MasterDataModule.TbProfesorProhibicionTipo.Open;
  ConfiguracionForm.HelpContext := actConfigurar.HelpContext;
  MainDataModule.dbMain.StartTransaction;
  if ConfiguracionForm.ShowModal = mrOk then
  begin
    ConfiguracionForm.FormStorage.SaveFormPlacement;
    MainDataModule.dbMain.Commit;
    with MasterDataModule.TbMateriaProhibicionTipo do
    begin
      CheckBrowseMode;
      FlushBuffers;
    end;
    with MasterDataModule.TbProfesorProhibicionTipo do
    begin
      CheckBrowseMode;
      FlushBuffers;
    end;
    if Self.Ejecutando then
      Self.AjustarPesos;
  end
  else
  begin
    ConfiguracionForm.FormStorage.RestoreFormPlacement;
    MainDataModule.dbMain.Rollback;
    MasterDataModule.TbMateriaProhibicionTipo.Refresh;
    MasterDataModule.TbProfesorProhibicionTipo.Refresh;
  end;
  FNumIteraciones := ConfiguracionForm.speNumIteraciones.Value;
end;

procedure TMainForm.actChequearFactibilidadExecute(Sender: TObject);
begin
  LogisticForm.HelpContext := actChequearFactibilidad.HelpContext;
  if MasterDataModule.PerformAllChecks(LogisticForm.memLogistic.Lines,
    LogisticForm.memResumen.Lines, ConfiguracionForm.speMaxCargaProfesor.Value)
    then
  begin
    LogisticForm.Show;
  end
  else
  begin
    if MessageDlg('No se encontraron errores, está listo para generar horario.'#13#10 +
      '¿Desea mostrar el resumen del chequeo del horario?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      LogisticForm.Show;
  end;
end;

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
  VerAboutBox;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageDlg('¿Está seguro que desea cerrar el programa?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

procedure TMainForm.actChangePasswdExecute(Sender: TObject);
begin
  MainDataModule.secMain.ChangePassword;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FLogStrings.Free;
  FormStorage.SaveFormPlacement;
  FSProteccion.SaveFormPlacement;
end;

procedure TMainForm.ObtProfesorHorario;
begin
  QuProfesor.Close;
  QuProfesor.Open;
  QuProfesorHora.Close;
  QuProfesorHora.Open;
  rxmProfesor.Close;
  rxmProfesor.Filtered := false;
  with MasterDataModule do
  begin
    TbDia.Open;
    with RxQuProfesorHorarioDetalle do
    begin
      Close;
      MacroByName('CodHorario').AsInteger := CodHorarioSeleccionado;
      MacroByName('Excluir').AsString
        := ConfiguracionForm.edtProfesorHorarioExcluirProfProhibicion.Text;
      MacroByName('Longitud').AsInteger
        := ConfiguracionForm.speMostrarProfesorHorarioLongitud.Value;
      MacroByName('Mostrar').AsString
        := ConfiguracionForm.edtMostrarProfesorHorarioTexto.Text;
      Open;
      CrossBatchMove(TbDia, QuProfesorHora, RxQuProfesorHorarioDetalle,
        rxmProfesor, 'CodDia', 'NomDia', 'CodDia', 'CodProfesor;CodHora',
        'NomHora', 'CodProfesor;CodHora', 'Nombre');
      rxmProfesor.Filtered := true;
    end;
  end;
end;

procedure TMainForm.PrepareReportProfesorHorario(Sender: TObject);
begin
  PrepareReport(Sender);
  with Sender as TSingleReportQrp do
  begin
    TitleBand1.BandType := rbPageHeader;
  end;
end;

procedure TMainForm.actPresentarProfesorHorarioExecute(Sender: TObject);
begin
  ObtProfesorHorario;
  with MasterDataModule do
  begin
    PreviewMasterDetailReport(QuProfesor, rxmProfesor,
      'ApeProfesor;NomProfesor', '', '', ConfiguracionForm.edtNomColegio.Text,
      'Horario de profesores', poLandscape, PrepareReportProfesorHorario);
  end;
end;

procedure TMainForm.ObtParaleloHorario;
begin
  QuParalelo.Close;
  QuParalelo.Open;
  QuParaleloHora.Close;
  QuParaleloHora.Open;
  rxmParalelo.Close;
  rxmParalelo.Filtered := false;
  with MasterDataModule do
  begin
    TbDia.Open;
    with RxQuParaleloHorarioDetalle do
    begin
      Close;
      ParamByName('CodHorario').AsInteger := CodHorarioSeleccionado;
      Prepare;
      Open;
      if FindField('NomMateria').DisplayWidth > 20 then
        FindField('NomMateria').DisplayWidth := 20;
      CrossBatchMove(TbDia, QuParaleloHora, RxQuParaleloHorarioDetalle,
        rxmParalelo, 'CodDia', 'NomDia', 'CodDia',
        'CodNivel;CodEspecializacion;CodParaleloId;CodHora', 'NomHora',
        'CodNivel;CodEspecializacion;CodParaleloId;CodHora', 'NomMateria');
      rxmParalelo.Filtered := true;
    end;
  end;
end;

procedure TMainForm.actPresentarParaleloHorarioExecute(Sender: TObject);
begin
  ObtParaleloHorario;
  with MasterDataModule do
  begin
    PreviewMasterDetailReport(QuParalelo, rxmParalelo, '', '', '',
      ConfiguracionForm.edtNomColegio.Text, 'Horario de paralelos',
      poLandscape, PrepareReportParaleloHorario);
  end;
end;

procedure TMainForm.PrepareReportParaleloHorario(Sender: TObject);
begin
  PrepareReport(Sender);
  with Sender as TSingleReportQrp do
  begin
    QRBand1.Free;
    QRSysData1.Free;
    PageFooterBand1.BandType := rbSummary;
    DetailBand1.ForceNewColumn := False;
  end;
end;

procedure TMainForm.QuParaleloAfterScroll(DataSet: TDataSet);
begin
  rxmParalelo.Filtered := false;
  rxmParalelo.Filtered := true;
end;

procedure TMainForm.QuProfesorAfterScroll(DataSet: TDataSet);
begin
  rxmProfesor.Filtered := false;
  rxmProfesor.Filtered := true;
end;

procedure TMainForm.rxmParaleloFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (DataSet.FindField('CodNivel').AsInteger =
    QuParaleloCodNivel.Value) and (DataSet.FindField('CodParaleloId').AsInteger
    = QuParaleloCodParaleloId.Value);
end;

procedure TMainForm.rxmProfesorFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := DataSet.FindField('CodProfesor').AsInteger =
    QuProfesorCodProfesor.AsInteger;
end;

procedure TMainForm.actPresentarMateriaProhibicionExecute(Sender: TObject);
begin
  QuMateriaMateriaProhibicion.Close;
  QuMateriaMateriaProhibicion.Open;
  QuMateriaMateriaProhibicionHora.Close;
  QuMateriaMateriaProhibicionHora.Open;
  rxmMateria.Close;
  rxmMateria.Filtered := false;
  with MasterDataModule do
  begin
    TbDia.Open;
    TbMateria.Open;
    TbMateriaProhibicion.Open;
    TbMateriaProhibicion.MasterSource := nil;
    try
      CrossBatchMove(TbDia, QuMateriaMateriaProhibicionHora,
        TbMateriaProhibicion, rxmMateria,
        'CodDia', 'NomDia', 'CodDia', 'CodMateria;CodHora', 'NomHora',
        'CodMateria;CodHora', 'NomMateProhibicionTipo');
      rxmMateria.Filtered := true;
      PreviewMasterDetailReport(QuMateriaMateriaProhibicion, rxmMateria, '', '',
        '', ConfiguracionForm.edtNomColegio.Text,
        GetDescription(TbMateriaProhibicion), poPortrait,
        PrepareReportProhibicion);
    finally
      TbMateriaProhibicion.MasterSource := DSMateria;
    end;
  end;
end;

procedure TMainForm.PrepareReportProhibicion(Sender: TObject);
begin
  PrepareReport(Sender);
  with Sender as TSingleReportQrp do
  begin
    DetailBand1.ForceNewColumn := False;
    PageFooterBand1.BandType := rbSummary;
  end;
end;

procedure TMainForm.rxmMateriaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := DataSet.FindField('CodMateria').AsInteger =
    QuMateriaMateriaProhibicionCodMateria.Value;
end;

procedure TMainForm.QuMateriaMateriaProhibicionAfterScroll(
  DataSet: TDataSet);
begin
  rxmMateria.Filtered := false;
  rxmMateria.Filtered := true;
end;

procedure TMainForm.actPresentarCargaAcademicaMateriaExecute(
  Sender: TObject);
begin
  with MasterDataModule do
  begin
    TbMateria.Open;
    TbCargaAcademica.MasterSource := nil;
    TbCargaAcademica.IndexFieldNames :=
      'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
    TbCargaAcademica.MasterFields := 'CodMateria';
    TbCargaAcademica.MasterSource := DSMateria;
    TbCargaAcademica.Open;
    PreviewMasterDetailReport(TbMateria, TbCargaAcademica, 'NomMateria',
      'AbrNivel;AbrEspecializacion;NomParaleloId;ApeNomProfesor;Duracion',
      'Duracion', ConfiguracionForm.edtNomColegio.Text,
      'Carga académica por materias', poPortrait,
      PrepareReportCargaAcademicaMateria);
    TbCargaAcademica.MasterSource := nil;
    TbCargaAcademica.IndexFieldNames := 'CodProfesor';
    TbCargaAcademica.MasterFields := 'CodProfesor';
    TbCargaAcademica.MasterSource := DSProfesor;
  end;
end;

procedure TMainForm.PrepareReportCargaAcademicaMateria(Sender: TObject);
begin
  PrepareReport(Sender);
  with Sender as TSingleReportQrp do
  begin
    DetailBand1.ForceNewColumn := False;
    PageFooterBand1.BandType := rbSummary;
  end;
end;

procedure TMainForm.actPresentarProfesorProhibicionExecute(
  Sender: TObject);
begin
  QuProfesorProfesorProhibicion.Close;
  QuProfesorProfesorProhibicion.Open;
  QuProfesorProfesorProhibicionHora.Close;
  QuProfesorProfesorProhibicionHora.Open;
  rxmProfesor1.Close;
  rxmProfesor1.Filtered := false;
  with MasterDataModule do
  begin
    TbDia.Open;
    TbProfesorProhibicion.MasterSource := nil;
    CrossBatchMove(TbDia, QuProfesorProfesorProhibicionHora,
      TbProfesorProhibicion, rxmProfesor1, 'CodDia', 'NomDia', 'CodDia',
      'CodProfesor;CodHora', 'NomHora', 'CodProfesor;CodHora',
      'NomProfProhibicionTipo');
    rxmProfesor1.Filtered := true;
    PreviewMasterDetailReport(QuProfesorProfesorProhibicion, rxmProfesor1, '',
      '', '', ConfiguracionForm.edtNomColegio.Text,
      GetDescription(TbProfesorProhibicion), poPortrait,
      PrepareReportProhibicion);
    TbProfesorProhibicion.MasterSource := DSProfesor;
  end;
end;

procedure TMainForm.QuProfesorProfesorProhibicionAfterScroll(
  DataSet: TDataSet);
begin
  rxmProfesor1.Filtered := false;
  rxmProfesor1.Filtered := true;
end;

procedure TMainForm.rxmProfesor1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := DataSet.FindField('CodProfesor').AsInteger =
    QuProfesorProfesorProhibicionCodProfesor.Value;
end;

procedure TMainForm.actPresentarCargaAcademicaProfesorExecute(
  Sender: TObject);
begin
  with MasterDataModule do
  begin
    TbProfesor.Open;
    TbCargaAcademica.Open;
    PreviewMasterDetailReport(TbProfesor, TbCargaAcademica,
      'ApeProfesor;NomProfesor',
      'NomMateria;AbrNivel;AbrEspecializacion;NomParaleloId;Duracion',
      'Duracion', ConfiguracionForm.edtNomColegio.Text,
      'Carga académica por profesores', poPortrait,
      PrepareReportCargaAcademicaProfesor);
  end;
end;

procedure TMainForm.PrepareReportCargaAcademicaProfesor(Sender: TObject);
begin
  PrepareReport(Sender);
  with Sender as TSingleReportQrp do
  begin
    TitleBand1.BandType := rbPageHeader;
    PageFooterBand1.Visible := False;
    //QRBand1.Free;
    //QRSysData1.Free;
  end;
end;

function TMainForm.GetCodHorarioSeleccionado: Integer;
begin
  try
    Result := StrToInt(ConfiguracionForm.lblHorarioSeleccionado.Caption);
  except
    raise Exception.Create('Debe seleccionar un horario');
  end;
end;

procedure TMainForm.actContentsExecute(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TMainForm.actIndexExecute(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TMainForm.ExportarCSV(AMasterDataSet, ADetailDataSet: TDataSet;
  AStrings: TStrings);
var
  s: string;
  j: Integer;
begin
  AStrings.Add(',,,,,,');
  AMasterDataSet.First;
  Max := AMasterDataSet.RecordCount;
  while not AMasterDataSet.Eof do
  begin
    s := '';
    Position := AMasterDataSet.RecNo;
    for j := 0 to AMasterDataSet.FieldCount - 1 do
    begin
      if AMasterDataSet.Fields[j].Visible then
        s := s + AMasterDataSet.Fields[j].AsString + ' ';
    end;
    AStrings.Add(s + ',,,,,,');
    ADetailDataSet.First;
    s := '';
    for j := 0 to ADetailDataSet.FieldCount - 1 do
    begin
      if ADetailDataSet.Fields[j].Visible then
      begin
        s := s + ADetailDataSet.Fields[j].DisplayLabel + ',';
      end;
    end;
    AStrings.Add(s);
    while not ADetailDataSet.Eof do
    begin
      s := '';
      for j := 0 to ADetailDataSet.FieldCount - 1 do
      begin
        if ADetailDataSet.Fields[j].Visible then
          s := s + ADetailDataSet.Fields[j].AsString + ',';
      end;
      AStrings.Add(s);
      ADetailDataSet.Next;
    end;
    AStrings.Add(',,,,,,');
    AMasterDataSet.Next;
  end;
end;

procedure TMainForm.actExportarCSVExecute(Sender: TObject);
begin
  StatusBar.Panels[1].Style := psOwnerDraw;
  Position := 0;
  try
    SaveDialogCSV.HelpContext := actSave.HelpContext;
    if SaveDialogCSV.Execute then
      ExportToFile(SaveDialogCSV.FileName);
  finally
    Position := 0;
    StatusBar.Panels[1].Style := psText;
    StatusBar.Panels[2].Text := 'Listo';
  end;
end;


procedure TMainForm.ExportToFile(AFileName: TFileName);
var
  Strings: TStrings;
begin
  Strings := TStringList.Create;
  try
    ExportToStrings(Strings);
    Strings.SaveToFile(AFileName);
  finally
    Strings.Free;
  end;
end;

procedure TMainForm.ExportToStrings(AStrings: TStrings);
begin
  AStrings.BeginUpdate;
  try
    ObtParaleloHorario;
    AStrings.Add('HORARIO POR PARALELOS,,,,,,');
    ExportarCSV(QuParalelo, rxmParalelo, AStrings);
    AStrings.Add('HORARIO POR PROFESORES,,,,,,');
    ObtProfesorHorario;
    ExportarCSV(QuProfesor, rxmProfesor, AStrings);
  finally
    AStrings.EndUpdate;
  end;
end;

{
procedure TMainForm.ToolbarButton971Click(Sender: TObject);
begin
  ConfiguracionForm.FormStorage.IniFileName := '..\DAT\PRUEBAS\CONFIG1.INI';
  ConfiguracionForm.FormStorage.RestoreFormPlacement;
  ElaborarHorario('1-5');
  ConfiguracionForm.FormStorage.IniFileName := '..\DAT\PRUEBAS\CONFIG2.INI';
  ConfiguracionForm.FormStorage.RestoreFormPlacement;
  ElaborarHorario('6-10');
  ConfiguracionForm.FormStorage.IniFileName := '..\DAT\PRUEBAS\CONFIG3.INI';
  ConfiguracionForm.FormStorage.RestoreFormPlacement;
  ElaborarHorario('11-15');
  ConfiguracionForm.FormStorage.IniFileName := '..\DAT\PRUEBAS\CONFIG4.INI';
  ConfiguracionForm.FormStorage.RestoreFormPlacement;
  ElaborarHorario('16-20');
  ConfiguracionForm.FormStorage.IniFileName := '..\DAT\PRUEBAS\CONFIG5.INI';
  ConfiguracionForm.FormStorage.RestoreFormPlacement;
  ElaborarHorario('21-25');
  ConfiguracionForm.FormStorage.IniFileName := '..\DAT\PRUEBAS\CONFIG6.INI';
  ConfiguracionForm.FormStorage.RestoreFormPlacement;
  ElaborarHorario('26-30');
  ConfiguracionForm.FormStorage.IniFileName := '..\DAT\PRUEBAS\CONFIG7.INI';
  ConfiguracionForm.FormStorage.RestoreFormPlacement;
  ElaborarHorario('31-35');
  ConfiguracionForm.FormStorage.IniFileName := '..\DAT\PRUEBAS\CONFIG8.INI';
  ConfiguracionForm.FormStorage.RestoreFormPlacement;
  ElaborarHorario('36-40');
  ConfiguracionForm.FormStorage.IniFileName := '..\DAT\PRUEBAS\CONFIG9.INI';
  ConfiguracionForm.FormStorage.RestoreFormPlacement;
  ElaborarHorario('41-45');
  ConfiguracionForm.FormStorage.IniFileName := '..\DAT\PRUEBAS\CONFIG10.INI';
  ConfiguracionForm.FormStorage.RestoreFormPlacement;
  ElaborarHorario('46-50');
  ConfiguracionForm.FormStorage.IniFileName := '..\DAT\CONFIG.INI';
  ConfiguracionForm.FormStorage.RestoreFormPlacement;
end;
}

procedure TMainForm.PrepareReport(Sender: TObject);
begin
  with Sender as TSingleReportQrp, ConfiguracionForm do
  begin
    qrlFirm1.Caption := 'Autoridad';
    qrlName1.Caption := edtNomAutoridad.Text;
    qrlPosition1.Caption := edtCarAutoridad.Text;
    qrlFirm2.Caption := 'Responsable';
    qrlName2.Caption := edtNomResponsable.Text;
    qrlPosition2.Caption := edtCarResponsable.Text;
    qrlAnioLectivo.Caption := 'Año Lectivo: ' +
      ConfiguracionForm.edtAnioLectivo.Text;
  end;
end;

var
  MomentoInicialProgress: TDateTime;

procedure TMainForm.ProgressDescensoDoble(I, Max: Integer; value: Double; var Stop: Boolean);
var
  t, x: TDateTime;
begin
  if I = 0 then
  begin
    Self.Max := Max;
    x := 0;
    Inc(FPasada);
    MomentoInicialProgress := Now;
    t := 0;
  end
  else
  begin
    t := Now - MomentoInicialProgress;
    x := t * (Max - I) / I;
  end;
  Self.Position := i;
  StatusBar.Panels[0].Text := Format('Pasada %d - %d de %d %f - van: %d-%s - restan: %d-%s',
    [FPasada, i, max, value, Trunc(t), FormatDateTime('hh:mm:ss', t), Trunc(x),
    FormatDateTime('hh:mm:ss', x)]);
  Application.ProcessMessages;
  Stop := FCloseClick;
end;

procedure TMainForm.actMejorarHorarioExecute(Sender: TObject);
var
  VModeloHorario: TModeloHorario;
  VObjetoModeloHorario: TObjetoModeloHorario;
  CodHorarioFuente, CodHorarioDestino: Integer;
  Informe: TStrings;
  MomentoInicial, MomentoFinal: TDateTime;
  s, d: string;
  va, vd: Double;
begin
  if not InputQuery('Código del horario a mejorar: ',
    'Código del horario a mejorar', s) then
    Exit;
  if s <> '' then
    CodHorarioFuente := StrToInt(s);
  if not InputQuery('Código del horario mejorado: ',
    'Código del horario mejorado', d) then
    Exit;
  CodHorarioDestino := StrToInt(d);
  FCloseClick := False;
  with ConfiguracionForm do
  begin
    InitRandom;
    MomentoInicial := Now;
    FNumIteraciones := speNumIteraciones.Value;
    FEjecutando := True;
    VModeloHorario :=
      TModeloHorario.CrearDesdeDatabase(MainDataModule.dbMain,
      creCruceProfesor.Value,
      creProfesorFraccionamiento.Value,
      creCruceAulaTipo.Value,
      creHoraHueca.Value,
      creSesionCortada.Value,
      creMateriaNoDispersa.Value);
    StatusBar.Panels[1].Style := psOwnerDraw;
    Self.Position := 0;
    FPasada := 0;
    try
      VModeloHorario.OnProgress := Self.ProgressDescensoDoble;
      Self.Step := 1;
      VObjetoModeloHorario := TObjetoModeloHorario.CrearDesdeModelo(VModeloHorario);
      try
        if s = '' then
          VObjetoModeloHorario.HacerAleatorio
        else
          VObjetoModeloHorario.LoadFromDatabase(CodHorarioFuente);
        va := VObjetoModeloHorario.Valor;
        VObjetoModeloHorario.DescensoRapidoForzado;
        VObjetoModeloHorario.DescensoRapidoDobleForzado;
        vd := VObjetoModeloHorario.Valor;
        MomentoFinal := Now;
        Informe := TStringList.Create;
        try
          Informe.Add(Format('Peso del horario antes:  %f', [va]));
          Informe.Add(Format('Peso del horaro despues: %f', [vd]));
          VObjetoModeloHorario.SaveToDatabase(CodHorarioDestino, MomentoInicial,
            MomentoFinal, Informe);
          if MasterDataModule.TbHorario.Active then
            MasterDataModule.TbHorario.Refresh;
        finally
          Informe.Free;
        end;
      finally
        VObjetoModeloHorario.Free;
      end;
    finally
      VModeloHorario.Free;
      FEjecutando := False;
      StatusBar.Panels[1].Style := psText;
      StatusBar.Panels[2].Text := 'Listo';
    end;
  end;
end;

procedure TMainForm.FormDblClick(Sender: TObject);
begin
  if FEjecutando
    and (MessageDlg('¿Está seguro de que desea finalizar esta operación?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    FCloseClick := True;
end;

procedure TMainForm.actCompactarTablasExecute(Sender: TObject);
begin
  Max := 20;
  StatusBar.Panels[1].Style := psOwnerDraw;
  Self.Position := 0;
  try
    MainDataModule.CompactarTablas(OnCompactar);
  finally
    StatusBar.Panels[1].Style := psText;
    StatusBar.Panels[2].Text := 'Listo';
  end;
end;

procedure TMainForm.OnCompactar(Sender: TObject);
begin
  StatusBar.Panels[2].Text := 'Compactando ' + (Sender as TTable).TableName;
  Self.Position := Self.Position + 1;
end;

procedure TMainForm.actRegistrationInfoExecute(Sender: TObject);
begin
  PedirRegistrarSoftware;
  ProtegerSoftware;
end;

end.

