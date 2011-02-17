unit FMain;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  SysConst, ExtCtrls, DB, Menus, ComCtrls, ImgList, Buttons,
  ActnList, ToolWin, StdActns, StdCtrls, FSplash,
  FSingEdt, SqlitePassDbo, FCrsMME0, FEditor, UConfig;
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
    OpenDialog: TOpenDialog;
    MIPeriodo: TMenuItem;
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
    SIPeriodo: TToolButton;
    SIParalelo: TToolButton;
    SIMateria: TToolButton;
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
    ActNew: TAction;
    ActOpen: TAction;
    ActSave: TAction;
    ActPasswd: TAction;
    ActExit: TAction;
    ActDia: TAction;
    ActHora: TAction;
    ActEspecializacion: TAction;
    ActNivel: TAction;
    ActParaleloId: TAction;
    ActProfesor: TAction;
    ActAulaTipo: TAction;
    ActPeriodo: TAction;
    ActParalelo: TAction;
    ActMateria: TAction;
    ActChequearFactibilidad: TAction;
    ActElaborarHorario: TAction;
    ActConfigurar: TAction;
    ActHorario: TAction;
    ActAbout: TAction;
    ActContents: TAction;
    ActIndex: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    MIChangePasswd: TMenuItem;
    ActChangePasswd: TAction;
    N2: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    MIPresentarProfesorHorario: TMenuItem;
    MIPresentarParaleloHorario: TMenuItem;
    ActPresentarParaleloHorario: TAction;
    ActPresentarProfesorHorario: TAction;
    ActPresentarMateriaProhibicion: TAction;
    ActPresentarDistributivoMateria: TAction;
    ActPresentarProfesorProhibicion: TAction;
    MIPresentarProfesorProhibicion: TMenuItem;
    MIPresentarMateriaProhibicion: TMenuItem;
    MIPresentarDistributivoMateria: TMenuItem;
    TbParalelo: TSqlitePassDataset;
    TbProfesor: TSqlitePassDataset;
    QuParaleloHora: TSqlitePassDataset;
    QuParaleloHoraCodNivel: TLargeintField;
    QuParaleloHoraCodEspecializacion: TLargeintField;
    QuParaleloHoraCodParaleloId: TLargeintField;
    QuParaleloHoraCodHora: TLargeintField;
    QuParaleloHoraNomHora: TStringField;
    QuProfesorHora: TSqlitePassDataset;
    QuProfesorHoraCodProfesor: TLargeintField;
    QuProfesorHoraCodHora: TLargeintField;
    QuProfesorHoraNomHora: TStringField;
    QuProfesorHorarioDetalle: TSqlitePassDataset;
    QuParaleloHorarioDetalle: TSqlitePassDataset;
    TbMateria: TSqlitePassDataset;
    QuMateriaMateriaProhibicion: TSqlitePassDataset;
    QuMateriaMateriaProhibicionCodMateria: TLargeintField;
    QuMateriaMateriaProhibicionNomMateria: TStringField;
    QuMateriaMateriaProhibicionHora: TSqlitePassDataset;
    QuMateriaMateriaProhibicionHoraCodMateria: TLargeintField;
    QuMateriaMateriaProhibicionHoraCodHora: TLargeintField;
    QuMateriaMateriaProhibicionHoraNomHora: TStringField;
    QuProfesorProfesorProhibicion: TSqlitePassDataset;
    QuProfesorProfesorProhibicionApeProfesor: TStringField;
    QuProfesorProfesorProhibicionNomProfesor: TStringField;
    QuProfesorProfesorProhibicionCodProfesor: TLargeintField;
    QuProfesorProfesorProhibicionHora: TSqlitePassDataset;
    QuProfesorProfesorProhibicionHoraCodProfesor: TLargeintField;
    QuProfesorProfesorProhibicionHoraCodHora: TLargeintField;
    QuProfesorProfesorProhibicionHoraNomHora: TStringField;
    TbProfesor1: TSqlitePassDataset;
    ActPresentarDistributivoProfesor: TAction;
    MIPresentarDistributivoProfesor: TMenuItem;
    ActExportarCSV: TAction;
    ExportarelhorarioaExcel1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    ActMejorarHorario: TAction;
    MIMejorarHorario: TMenuItem;
    SaveDialogCSV: TSaveDialog;
    ActRegistrationInfo: TAction;
    MIRegistrationInfo: TMenuItem;
    QuParaleloHorarioDetalleCodNivel: TLargeintField;
    QuParaleloHorarioDetalleCodEspecializacion: TLargeintField;
    QuParaleloHorarioDetalleCodParaleloId: TLargeintField;
    QuParaleloHorarioDetalleCodDia: TLargeintField;
    QuParaleloHorarioDetalleCodHora: TLargeintField;
    QuParaleloHorarioDetalleCodMateria: TLargeintField;
    QuParaleloHorarioDetalleNomMateria: TStringField;
    QuProfesorHorarioDetalleCodProfesor: TLargeintField;
    QuProfesorHorarioDetalleCodDia: TLargeintField;
    QuProfesorHorarioDetalleCodHora: TLargeintField;
    QuProfesorHorarioDetalleNombre: TStringField;
    ToolBar: TToolBar;
    DSProfesorProfesorProhibicion: TDataSource;
    DSMateriaMateriaProhibicion: TDataSource;
    procedure ActExitExecute(Sender: TObject);
    procedure ActProfesorExecute(Sender: TObject);
    procedure ActMateriaExecute(Sender: TObject);
    procedure ActEspecializacionExecute(Sender: TObject);
    procedure ActNivelExecute(Sender: TObject);
    procedure ActAulaTipoExecute(Sender: TObject);
    procedure ActParaleloIdExecute(Sender: TObject);
    procedure ActParaleloExecute(Sender: TObject);
    procedure ActDiaExecute(Sender: TObject);
    procedure ActHoraExecute(Sender: TObject);
    procedure ActNewExecute(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure ActOpenExecute(Sender: TObject);
    procedure ActHorarioExecute(Sender: TObject);
    procedure ActElaborarHorarioExecute(Sender: TObject);
    procedure ActPeriodoExecute(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure FormCreate(Sender: TObject);
    procedure MRUManagerClick(Sender: TObject; const RecentName,
      Caption: string; UserData: Integer);
    procedure ActConfigurarExecute(Sender: TObject);
    procedure ActChequearFactibilidadExecute(Sender: TObject);
    procedure ActAboutExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure QuProfesorProfesorProhibicionAfterScroll(DataSet: TDataSet);
    procedure ActContentsExecute(Sender: TObject);
    procedure ActIndexExecute(Sender: TObject);
    procedure ActExportarCSVExecute(Sender: TObject);
    procedure ActMejorarHorarioExecute(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure ActRegistrationInfoExecute(Sender: TObject);
{
    procedure ActSaveCSVExecute(Sender: TObject);
    procedure ActOpenCSVExecute(Sender: TObject);
}
  private
    { Private declarations }
    FConfigFileName: string;
    FConfigStorage: TConfigStorage;
    FDiaForm,
    FNivelForm,
    FAulaTipoForm,
    FParaleloIdForm,
    FHoraForm,
    FEspecializacionForm: TSingleEditorForm;
    FPeriodoForm: TCrossManyToManyEditor0Form;
{$IFNDEF FREEWARE}
    FInit: TDateTime;
    FCloseClick:Boolean;
    FCancelClick: Boolean;
    FEjecutando: Boolean;
    FPasada: Integer;
{$ENDIF}
    FProgress: Integer;
    FRelProgress: Integer;
    FMin: Integer;
    FMax: Integer;
    FStep: Integer;
    FAjustar: Boolean;
    FLogStrings: TStrings;
    FCodHorario: Integer;
    procedure SetProgress(Value: Integer);
    procedure SetMin(Value: Integer);
    procedure SetMax(Value: Integer);
    procedure SetStep(Value: Integer);
    procedure SaveConfig(Strings: TStrings);
    procedure LoadConfig(Strings: TStrings);
    procedure UpdRelProgress;

    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
    function ConfirmOperation: boolean;
    function GetCodHorarioSeleccionado: Integer;
    procedure ObtParaleloHorario;
    procedure ObtProfesorHorario;
{$IFNDEF FREEWARE}
    procedure ElaborarHorario(s: string);
    procedure MejorarHorario;
    procedure ProgressDescensoDoble(I, Max: Integer; Value: Double; var Stop: Boolean);
{$ENDIF}
    procedure ExportarCSV(AMasterDataSet, ADetailDataSet: TDataSet; AStrings: TStrings);
    procedure ExportToFile(AFileName: TFileName);
    procedure ExportToStrings(AStrings: TStrings);
    procedure PedirRegistrarSoftware;
    procedure ProtegerSoftware;

    procedure FillParaleloHora;
    procedure FillProfesorHora;
    procedure FillMateriaMateriaProhibicion;
    procedure FillMateriaMateriaProhibicionHora;
    procedure FillProfesorProfesorProhibicion;
    procedure FillProfesorProfesorProhibicionHora;
    procedure FillParaleloHorarioDetalle;
    procedure FillProfesorHorarioDetalle;

    //procedure MarcarProgreso(Count, Cant: Integer);

  public
    { Public declarations }
    procedure AjustarPesos;
{$IFNDEF FREEWARE}
    procedure OnIterar(Sender: TObject);
    procedure OnRegistrarMejor(Sender: TObject);
    procedure ProgressFormCloseClick(Sender: TObject);
    procedure ProgressFormCancelClick(Sender: TObject);
    property Ejecutando: Boolean read FEjecutando;
{$ENDIF}
    property Progress: Integer read FProgress write SetProgress;
    property Min: Integer read FMin write SetMin;
    property Max: Integer read FMax write SetMax;
    property Step: Integer read FStep write SetStep;
    property CodHorario: Integer read FCodHorario write FCodHorario;
    property CodHorarioSeleccionado: Integer read GetCodHorarioSeleccionado;
    property ConfigStorage: TConfigStorage read FConfigStorage;
  end;

var
  MainForm: TMainForm;

implementation

uses
{$IFNDEF FREEWARE}
  KerEvolE, KerModel, FProgres,
{$ENDIF}
  FCrsMMEd, FCrsMME1, DMaster, FMateria, FProfesr, FHorario, FMasDeEd, About,
  FConfig, FLogstic, TTGUtls, FParalel, Rand, Printers, DSource, DSrcBase;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TMainForm.ActExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ActProfesorExecute(Sender: TObject);
begin
  TProfesorForm.ToggleSingleEditor(Self,
				   ProfesorForm,
				   ConfigStorage,
				   actProfesor,
				   SourceDataModule.TbProfesor);
end;

procedure TMainForm.ActPeriodoExecute(Sender: TObject);
begin
  if TCrossManyToManyEditor0Form.ToggleEditor(Self, FPeriodoForm,
    ConfigStorage, ActPeriodo) then
  with SourceDataModule do
  begin
    {$IFDEF FPC}
    FPeriodoForm.DrawGrid.OnPrepareCanvas := FPeriodoForm.DrawGridPrepareCanvas;
    {$ENDIF}
    FPeriodoForm.ShowEditor(TbDia, TbHora, TbPeriodo, nil, 'CodDia', 'NomDia',
      'CodDia', '', 'CodHora', 'NomHora', 'CodHora', '');
  end;
end;

procedure TMainForm.ActMateriaExecute(Sender: TObject);
begin
   TMateriaForm.ToggleSingleEditor(Self,
				   MateriaForm,
				   ConfigStorage,
				   ActMateria,
				   SourceDataModule.TbMateria);
end;

procedure TMainForm.ActEspecializacionExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FEspecializacionForm,
					ConfigStorage,
					ActEspecializacion,
					SourceDataModule.TbEspecializacion);
end;

procedure TMainForm.ActNivelExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FNivelForm,
					ConfigStorage,
					ActNivel,
					SourceDataModule.TbNivel);
end;

procedure TMainForm.ActAulaTipoExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FAulaTipoForm,
					ConfigStorage,
					ActAulaTipo,
					SourceDataModule.TbAulaTipo);
end;

procedure TMainForm.ActParaleloIdExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FParaleloIdForm,
					ConfigStorage,
					ActParaleloId,
					SourceDataModule.TbParaleloId);
end;

procedure TMainForm.ActDiaExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FDiaForm,
					ConfigStorage,
					ActDia,
					SourceDataModule.TbDia);
end;

procedure TMainForm.ActHoraExecute(Sender: TObject);
begin
   TSingleEditorForm.ToggleSingleEditor(Self,
					FHoraForm,
					ConfigStorage,
					ActHora,
					SourceDataModule.TbHora);
end;

procedure TMainForm.ActHorarioExecute(Sender: TObject);
begin
   THorarioForm.ToggleSingleEditor(Self,
				   HorarioForm,
				   ConfigStorage,
				   ActHorario,
				   SourceDataModule.TbHorario);
end;

procedure TMainForm.ActParaleloExecute(Sender: TObject);
begin
   TParaleloForm.ToggleSingleEditor(Self,
				    ParaleloForm,
				    ConfigStorage,
				    ActParalelo,
				    SourceDataModule.TbCurso);
end;

function TMainForm.ConfirmOperation: boolean;
begin
  Result :=
    MessageDlg('Los cambios realizados hasta el momento se perderan, '#13#10
    + 'Esta seguro?', mtWarning, [mbYes, mbNo], 0) = mrYes
end;

procedure TMainForm.ActNewExecute(Sender: TObject);
begin
  StatusBar.Panels[1].Style := psOwnerDraw;
  Progress := 0;
  try
    if ConfirmOperation then
    begin
      Max := 20;
      SourceDataModule.NewDataBase;
      Progress := 0;
    end;
  finally
    StatusBar.Panels[1].Style := psText;
    StatusBar.Panels[2].Text := 'Listo';
  end;
end;

procedure TMainForm.ActSaveExecute(Sender: TObject);
begin
  StatusBar.Panels[1].Style := psOwnerDraw;
  Progress := 0;
  Max := 100;
  SaveDialog.DefaultExt := 'ttd'; // Time Tabling Data
  SaveDialog.Filter := 'Horario para colegio (*.ttd)|*.ttd';
  try
    SaveDialog.HelpContext := ActSave.HelpContext;
    if SaveDialog.Execute then
    begin
      SaveToFile(SaveDialog.FileName);
      OpenDialog.FileName := SaveDialog.FileName;
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
    SourceDataModule.SaveToTextFile(AFileName);
  finally
    Cursor := crDefault;
  end;
end;

procedure TMainForm.LoadFromFile(const AFileName: string);
begin
  Cursor := crHourGlass;
  try
    SourceDataModule.EmptyTables;
    SourceDataModule.LoadFromTextFile(AFileName);
  finally
    Cursor := crDefault;
  end;
end;

procedure TMainForm.ActOpenExecute(Sender: TObject);
begin
  StatusBar.Panels[1].Style := psOwnerDraw;
  Progress := 0;
  try
    if ConfirmOperation then
    begin
      OpenDialog.HelpContext := ActOpen.HelpContext;
      if OpenDialog.Execute then
      begin
        LoadFromFile(OpenDialog.FileName);
        SaveDialog.FileName := OpenDialog.FileName;
        MainForm.Caption := Application.Title + ' - ' + SourceDataModule.NomColegio;
      end;
    end;
  finally
    StatusBar.Panels[1].Style := psText;
    StatusBar.Panels[2].Text := 'Listo';
  end;
end;

procedure TMainForm.AjustarPesos;
begin
  FAjustar := True;
end;


procedure TMainForm.ActElaborarHorarioExecute(Sender: TObject);
{$IFNDEF FREEWARE}
var
  s: string;
{$ENDIF}
begin
{$IFNDEF FREEWARE}
  with MasterDataModule do
  try
    if not InputQuery('Codigos de los Horarios: ',
      'Ingrese los codigos de los Horarios a generar', s) then
      Exit;
    ElaborarHorario(s);
  finally
    ActElaborarHorario.Checked := False;
  end;
{$ENDIF}
end;

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
      HelpContext := ActElaborarHorario.HelpContext;
      NumMaxGeneracion := vEvolElitista.NumMaxGeneracion;
      FInit := Now;
      Caption :=
        Format('Elaboracion en progreso [%d]', [CodHorario]);
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
    if SourceDataModule.TbHorario.Locate('CodHorario', CodHorario, []) then
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
      {if True then
      begin
        with VEvolElitista.MejorObjetoModeloHorario do
        begin
          DescensoRapido2(MarcarProgreso);
        end;
      end;}
      FMomentoFinal := Now;
      VEvolElitista.SaveBestToDatabase(Cod, FMomentoInicial,
        FMomentoFinal);
    end;
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
        raise Exception.Create('El dato ingresado no es valido');
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
  with SourceDataModule, MasterDataModule do
  begin
    InitRandom;
    ActElaborarHorario.Enabled := False;
    FEjecutando := True;
    try
      VModeloHorario :=
        TModeloHorario.CrearDesdeDataModule(
          CruceProfesor,
          ProfesorFraccionamiento,
          CruceAulaTipo,
          HoraHueca,
          SesionCortada,
          MateriaNoDispersa);
      try
        VEvolElitista := TEvolElitista.CrearDesdeModelo(VModeloHorario,
                                                        TamPoblacion);
        VEvolElitista.NumMaxGeneracion := NumMaxGeneracion;
        VEvolElitista.ProbCruzamiento := ProbCruzamiento;
        VEvolElitista.ProbMutacion1 := ProbMutacion1;
        VEvolElitista.OrdenMutacion1 := OrdenMutacion1;
        VEvolElitista.ProbMutacion2 := ProbMutacion2;
        VEvolElitista.ProbReparacion := ProbReparacion;
        VEvolElitista.SyncDirectory := Compartir;
        VEvolElitista.RangoPolinizacion := RangoPolinizacion;
        if (Compartir <> '')
           and FileExists(VEvolElitista.SyncFileName) then
        begin
          mr := MessageDlg('El archivo de sincronizacion ya existe.  ' +
                             'Desea eliminar los archivos relacionados?',
                           mtWarning, [mbYes, mbNo, mbCancel], 0);
          if mr = mrYes then
          begin
            DeleteFile(VEvolElitista.FileName);
            DeleteFile(VEvolElitista.SyncFileName);
          end
          else if mr = mrCancel then
          begin
            raise Exception.Create('Operacion cancelada por el usuario');
          end
        end;
        VEvolElitista.PrefijarHorarios(HorarioIni);
        FCancelClick := False;
        FAjustar := False;
        VEvolElitista.OnIterar := Self.OnIterar;
        VEvolElitista.OnRegistrarMejor := Self.OnRegistrarMejor;
        try
          sProb := '';
          ProcessCodList(s);
          if sProb <> '' then
            MessageDlg(Format('Los siguientes horarios ya existian: %s',
                              [sProb]), mtError, [mbOK], 0);
        finally
          VEvolElitista.Free;
        end;
      finally
        VModeloHorario.Free;
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
      ActElaborarHorario.Enabled := True;
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
    if NumGeneracion mod SourceDataModule.NumIteraciones = 0 then
    begin
      Application.ProcessMessages;
      StatusBar.Panels[2].Text := Format('%d de %d', [NumGeneracion,
        ProgressForm.PBNumMaxGeneracion.Max]);
      ProgressForm.SetValues(Now - FInit,
                             NumGeneracion,
                             MejorCruceProfesor,
                             MejorProfesorFraccionamiento,
                             MejorCruceAulaTipo,
                             MejorHoraHuecaDesubicada,
                             MejorSesionCortada,
                             MejorMateriaProhibicion,
                             MejorProfesorProhibicion,
                             MejorMateriaNoDispersa,
                             NumImportacion,
                             NumExportacion,
                             NumColision,
                             MejorCruceProfesorValor,
                             MejorProfesorFraccionamientoValor,
                             MejorCruceAulaTipoValor,
                             MejorHoraHuecaDesubicadaValor,
                             MejorSesionCortadaValor,
                             MejorMateriaProhibicionValor,
                             MejorDisponiblidadValor,
                             MejorMateriaNoDispersaValor,
                             MejorValor);
      if FAjustar then
      begin
        InvalidarValores;
	//Actualizar;
        with SourceDataModule do
	  ModeloHorario.Configurar(CruceProfesor,
	               		   ProfesorFraccionamiento,
				   CruceAulaTipo,
				   HoraHueca,
				   SesionCortada,
				   MateriaNoDispersa);
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
  Self.Progress := i;
  StatusBar.Panels[0].Text := Format('Pasada %d - %d de %d %f - van: %d-%s - restan: %d-%s',
                                     [FPasada, i, max, value, Trunc(t),
                                      FormatDateTime('hh:mm:ss', t), Trunc(x),
                                      FormatDateTime('hh:mm:ss', x)]);
  Application.ProcessMessages;
  Stop := FCloseClick;
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

procedure TMainForm.SetProgress(Value: Integer);
begin
  if FProgress <> Value then
  begin
    FProgress := Value;
    UpdRelProgress;
  end;
end;

procedure TMainForm.SetStep(Value: Integer);
begin
  if FStep <> Value then
  begin
    FStep := Value;
    UpdRelProgress;
  end;
end;

procedure TMainForm.UpdRelProgress;
var
  VRelProgress: Integer;
begin
  VRelProgress := ((FProgress - FMin) div FStep) * FStep;
  if FRelProgress <> VRelProgress then
  begin
    FRelProgress := VRelProgress;
    StatusBar.Repaint;
  end;
end;

procedure TMainForm.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  VRect: TRect;
begin
  if FRelProgress <> 0 then
  begin
    VRect := Rect;
    VRect.Right := VRect.Left
      + (Rect.Right - Rect.Left) * FRelProgress div (FMax - FMin);
    StatusBar.Canvas.Brush.Color := clNavy;
    StatusBar.Canvas.FillRect(VRect);
  end
  else
    StatusBar.Canvas.FillRect(Rect);
end;

procedure TMainForm.PedirRegistrarSoftware;
{var
  InitDate: TDateTime;}
begin
{  with FSProteccion do
    if Protect1.Execute(VarToStr(StoredValue['Password'])) then
    begin
      InitDate := Now;
      StoredValue['Password'] := Protect1.Password;
      if VarToStr(StoredValue['InitDate']) = '' then
        StoredValue['InitDate'] := Double(InitDate);
    end;}
end;

procedure TMainForm.ProtegerSoftware;
{var
  LastDate, InitDate: TDateTime;}
begin
{  with FSProteccion do
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
          ' El sistema se ejecutara sin las opciones que permiten generar el horario',
          mtWarning, [mbOk], 0);
        ActElaborarHorario.Enabled := False;
        ActMejorarHorario.Enabled := False;
      end
      else if Protect1.DaysExpire > 0 then
      begin
        StatusBar.Panels[2].Text := Format('Transcurridos %d de %d dias',
          [Trunc(LastDate - InitDate), Protect1.DaysExpire]);
      end
      else
      begin
        ActElaborarHorario.Enabled := True;
        ActMejorarHorario.Enabled := True;
      end;
    end;
  end;}
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FConfigFileName := GetCurrentDir + '/TTG.cfg';
  FConfigStorage := TConfigStorage.Create(Self);
  try
    if FileExists(FConfigFileName) then
    begin
      FConfigStorage.ConfigStrings.LoadFromFile(FConfigFileName);
      LoadConfig(FConfigStorage.ConfigStrings);
    end;
    FMin := 0;
    FMax := 100;
    FProgress := 0;
    FRelProgress := 0;
    FStep := 1;
    FAjustar := False;
    FLogStrings := TStringList.Create;
    {$IFDEF FREEWARE}
    ActElaborarHorario.Enabled := False;
    ActMejorarHorario.Enabled := False;
    Caption := Caption + ' ***Freeware***';
    {$ENDIF}
    {$IFNDEF FREEWARE}
    FEjecutando := False;
    {$ENDIF}
{    Protect1.DaysExpire := 60;}
{    with FSProteccion do
    begin
      //StoredValue['Password'] := '';
      //StoredValue['InitDate'] := '';
      //StoredValue['LastDate'] := '';
      RestoreFormPlacement;
      Protect1.UserID := Protect1.HardDiskID;
      if StoredValue['Password'] <> Protect1.Password then
        PedirRegistrarSoftware;
      ProtegerSoftware;
    end;}
  except
    ActElaborarHorario.Enabled := False;
    ActMejorarHorario.Enabled := False;
    raise;
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

procedure TMainForm.ActConfigurarExecute(Sender: TObject);
begin
  try
    if ShowConfiguracionForm(ActConfigurar.HelpContext) = mrOK then
    begin
      MainForm.Caption := Application.Title + ' - ' + SourceDataModule.NomColegio;
      {$IFNDEF FREEWARE}
      if FEjecutando then
        Self.AjustarPesos;
      {$ENDIF}
    end
    else
    begin
      SourceDataModule.TbMateriaProhibicionTipo.Refresh;
      SourceDataModule.TbProfesorProhibicionTipo.Refresh;
    end;
  finally
    ActConfigurar.Checked := False;
  end;
end;

procedure TMainForm.ActChequearFactibilidadExecute(Sender: TObject);
begin
  LogisticForm.HelpContext := ActChequearFactibilidad.HelpContext;
  if MasterDataModule.PerformAllChecks(LogisticForm.MemLogistic.Lines,
                                       LogisticForm.MemResumen.Lines,
                                       SourceDataModule.MaxCargaProfesor)
  then
  begin
    LogisticForm.Show;
  end
  else
  begin
    if MessageDlg('No se encontraron errores, esta listo para generar horario.'#13#10 +
                    'Desea mostrar el resumen del chequeo del horario?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      LogisticForm.Show;
  end;
end;

procedure TMainForm.ActAboutExecute(Sender: TObject);
begin
  SplashForm := TSplashForm.Create(Application);
  SplashForm.Caption := sAppName + ' ' + sAppVersion;
  SplashForm.lblProductName.Caption := SplashForm.Caption;
  SplashForm.lblProductVersion.Caption := sAppVersion;
  SplashForm.ShowModal;
  ActAbout.Checked := False;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose :=
    MessageDlg('Los cambios realizados hasta el momento se perderan.'#13#10 +
    'Esta seguro que desea cerrar el programa?',
    mtWarning, [mbYes, mbNo], 0) = mrYes;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  SaveConfig(FConfigStorage.ConfigStrings);
  FConfigStorage.ConfigStrings.SaveToFile(FConfigFileName);
  FLogStrings.Free;
end;

procedure TMainForm.FillProfesorHorarioDetalle;
begin
  with SourceDataModule do
  begin
    with QuProfesorHorarioDetalle do
    begin
      Close;
      Open;
      TbHorarioDetalle.IndexedBy := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      TbDistributivo.IndexedBy := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      TbDistributivo.MasterFields := TbDistributivo.IndexedBy;
      TbDistributivo.MasterSource := DSHorarioDetalle;
      TbDistributivo.First;
      try
        if TbHorarioDetalle.Locate('CodHorario', CodHorarioSeleccionado, []) then
        begin
          while (TbHorarioDetalle.FindField('CodHorario').AsInteger = CodHorarioSeleccionado) and not TbHorarioDetalle.Eof do
          begin
            QuProfesorHorarioDetalle.Append;
            QuProfesorHorarioDetalleCodProfesor.Value := TbDistributivo.FindField('CodProfesor').AsInteger;
            QuProfesorHorarioDetalleCodDia.Value := TbHorarioDetalle.FindField('CodDia').AsInteger;
            QuProfesorHorarioDetalleCodHora.Value := TbHorarioDetalle.FindField('CodHora').AsInteger;
            QuProfesorHorarioDetalleNombre.AsString :=
              TbDistributivo.FindField('AbrNivel').AsString + ' ' +
              TbDistributivo.FindField('AbrEspecializacion').AsString + ' ' +
              TbDistributivo.FindField('NomParaleloId').AsString + ' ' +
              TbDistributivo.FindField('NomMateria').AsString;
            QuProfesorHorarioDetalle.Post;
            TbHorarioDetalle.Next;
          end;
        end;
      finally
        TbDistributivo.MasterFields := '';
        TbDistributivo.MasterSource := nil;
      end;
    end;
  end;
end;

procedure TMainForm.ObtProfesorHorario;
begin
  FillProfesorHora;
  FillProfesorHorarioDetalle;
  TbProfesor.Close;
  TbProfesor.MasterSource.Enabled := false;
  CrossBatchMove(SourceDataModule.TbDia, QuProfesorHora, QuProfesorHorarioDetalle,
    TbProfesor, 'CodDia', 'NomDia', 'CodDia', 'CodProfesor;CodHora',
    'NomHora', 'CodProfesor;CodHora', 'Nombre');
  TbProfesor.MasterSource.Enabled := true;
end;

procedure TMainForm.FillParaleloHorarioDetalle;
var
  s: string;
  p: TBookmark;
begin
  QuParaleloHorarioDetalle.Close;
  QuParaleloHorarioDetalle.Open;
  with SourceDataModule do
  begin
    s := TbHorarioDetalle.IndexedBy;
    p := TbHorarioDetalle.GetBookmark;
    try
      TbHorarioDetalle.IndexedBy := 'CodHorario;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      TbHorarioDetalle.First;
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        while (TbHorarioDetalle.FindField('CodHorario').AsInteger = CodHorario) and not TbHorarioDetalle.Eof do
        begin
          QuParaleloHorarioDetalle.Append;
          QuParaleloHorarioDetalleCodNivel.Value := TbHorarioDetalle.FindField('CodNivel').AsInteger;
          QuParaleloHorarioDetalleCodEspecializacion.Value := TbHorarioDetalle.FindField('CodNivel').AsInteger;
          QuParaleloHorarioDetalleCodParaleloId.Value := TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
          QuParaleloHorarioDetalleCodHora.Value := TbHorarioDetalle.FindField('CodHora').AsInteger;
          QuParaleloHorarioDetalleCodDia.Value := TbHorarioDetalle.FindField('CodDia').AsInteger;
          QuParaleloHorarioDetalle.Post;
          TbHorarioDetalle.Next;
        end;
        QuParaleloHorarioDetalle.First;
      end;
    finally
      TbHorarioDetalle.IndexedBy := s;
      TbHorarioDetalle.GotoBookmark(p);
      TbHorarioDetalle.FreeBookmark(p);
    end;
  end
end;

procedure TMainForm.ObtParaleloHorario;
begin
  FillParaleloHora;
  FillParaleloHorarioDetalle;
  TbParalelo.Close;
  TbParalelo.MasterSource.Enabled := false;
  CrossBatchMove(SourceDataModule.TbDia, QuParaleloHora, QuParaleloHorarioDetalle,
                 TbParalelo, 'CodDia', 'NomDia', 'CodDia',
                 'CodNivel;CodEspecializacion;CodParaleloId;CodHora', 'NomHora',
                 'CodNivel;CodEspecializacion;CodParaleloId;CodHora', 'NomMateria');
  TbParalelo.MasterSource.Enabled := true;
end;

procedure TMainForm.FillProfesorProfesorProhibicion;
var
  s: string;
  p: TBookmark;
begin
  with SourceDataModule do
  begin
    QuProfesorProfesorProhibicion.Close;
    QuProfesorProfesorProhibicion.Open;
    TbProfesor.First;
    s := TbProfesor.IndexedBy;
    p := TbProfesor.GetBookmark;
    TbProfesor.IndexedBy := 'NomMateria';
    try
      while not TbProfesor.Eof do
      begin
        if TbProfesorProhibicion.Locate('CodProfesor', TbProfesor.FindField('CodProfesor').AsInteger, []) then
        begin
          QuProfesorProfesorProhibicion.Append;
          QuProfesorProfesorProhibicionCodProfesor.Value := TbProfesor.FindField('CodProfesor').AsInteger;
          QuProfesorProfesorProhibicion.Post;
        end;
        TbProfesor.Next;
      end;
    finally
      TbProfesor.IndexedBy := s;
      TbProfesor.GotoBookmark(p);
      TbProfesor.FreeBookmark(p);
    end;
  end;
end;

procedure TMainForm.FillProfesorProfesorProhibicionHora;
var
  s, d: string;
  p, q: TBookmark;
begin
  with SourceDataModule do
  begin
    QuProfesorProfesorProhibicionHora.Close;
    QuProfesorProfesorProhibicionHora.Open;
    TbProfesor.First;
    s := TbProfesor.IndexedBy;
    d := TbHora.IndexedBy;
    p := TbProfesor.GetBookmark;
    q := TbHora.GetBookmark;
    TbProfesor.IndexedBy := 'NomMateria';
    TbHora.IndexedBy := 'CodHora';
    try
      while not TbProfesor.Eof do
      begin
        if TbProfesorProhibicion.Locate('CodProfesor', TbProfesor.FindField('CodProfesor').AsInteger, []) then
        begin
          TbHora.First;
          while not TbHora.Eof do
          begin
            QuProfesorProfesorProhibicionHora.Append;
            QuProfesorProfesorProhibicionHoraCodProfesor.Value := TbProfesor.FindField('CodProfesor').AsInteger;
            QuProfesorProfesorProhibicionHoraCodHora.Value := TbHora.FindField('CodHora').AsInteger;
            QuProfesorProfesorProhibicionHora.Post;
            TbHora.Next;
          end;
        end;
        TbProfesor.Next;
      end;
    finally
      TbProfesor.IndexedBy := s;
      TbProfesor.GotoBookmark(p);
      TbProfesor.FreeBookmark(p);
      TbHora.IndexedBy := d;
      TbHora.GotoBookmark(q);
      TbHora.FreeBookmark(q);
    end;
  end;
end;

procedure TMainForm.QuProfesorProfesorProhibicionAfterScroll(
  DataSet: TDataSet);
begin
  TbProfesor1.Filtered := false;
  TbProfesor1.Filtered := true;
end;

function TMainForm.GetCodHorarioSeleccionado: Integer;
begin
  try
    Result := SourceDataModule.HorarioSeleccionado;
  except
    raise Exception.Create('Debe seleccionar un horario');
  end;
end;

procedure TMainForm.ActContentsExecute(Sender: TObject);
begin
{$IFNDEF FPC}
  Application.HelpCommand(HELP_FINDER, 0);
{$ENDIF}
end;

procedure TMainForm.ActIndexExecute(Sender: TObject);
begin
{$IFNDEF FPC}
  Application.HelpCommand(HELP_FINDER, 0);
{$ENDIF}
end;

procedure TMainForm.ExportarCSV(AMasterDataSet, ADetailDataSet: TDataSet;
  AStrings: TStrings);
var
  s: string;
  j: Integer;
begin
  AStrings.Add(';;;;;;');
  AMasterDataSet.First;
  Max := AMasterDataSet.RecordCount;
  while not AMasterDataSet.Eof do
  begin
    s := '';
    Progress := AMasterDataSet.RecNo;
    for j := 0 to AMasterDataSet.FieldCount - 1 do
    begin
      if AMasterDataSet.Fields[j].Visible then
        s := s + AMasterDataSet.Fields[j].AsString + ' ';
    end;
    AStrings.Add(s + ';;;;;;');
    ADetailDataSet.First;
    s := '';
    for j := 0 to ADetailDataSet.FieldCount - 1 do
    begin
      if ADetailDataSet.Fields[j].Visible then
      begin
        s := s + ADetailDataSet.Fields[j].DisplayLabel + ';';
      end;
    end;
    AStrings.Add(s);
    while not ADetailDataSet.Eof do
    begin
      s := '';
      for j := 0 to ADetailDataSet.FieldCount - 1 do
      begin
        if ADetailDataSet.Fields[j].Visible then
          s := s + ADetailDataSet.Fields[j].AsString + ';';
      end;
      AStrings.Add(s);
      ADetailDataSet.Next;
    end;
    AStrings.Add(';;;;;;');
    AMasterDataSet.Next;
  end;
end;

procedure TMainForm.ActExportarCSVExecute(Sender: TObject);
begin
  StatusBar.Panels[1].Style := psOwnerDraw;
  Progress := 0;
  try
    SaveDialogCSV.HelpContext := ActSave.HelpContext;
    if SaveDialogCSV.Execute then
      ExportToFile(SaveDialogCSV.FileName);
  finally
    Progress := 0;
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
    AStrings.Add('HORARIO POR PARALELOS;;;;;;');
    ExportarCSV(SourceDataModule.TbParalelo, TbParalelo, AStrings);
    AStrings.Add('HORARIO POR PROFESORES;;;;;;');
    ObtProfesorHorario;
    ExportarCSV(SourceDataModule.TbProfesor, TbProfesor, AStrings);

    FillProfesorProfesorProhibicion;
    FillProfesorProfesorProhibicionHora;
    TbProfesor1.Close;
    TbProfesor1.MasterSource.Enabled := false;
    AStrings.Add('PROHIBICIONES DE PROFESORES;;;;;;');
    with SourceDataModule, MasterDataModule do
    begin
      TbProfesorProhibicion.MasterSource := nil;
      CrossBatchMove(TbDia, QuProfesorProfesorProhibicionHora,
                     TbProfesorProhibicion, TbProfesor1, 'CodDia', 'NomDia', 'CodDia',
                     'CodProfesor;CodHora', 'NomHora', 'CodProfesor;CodHora',
                     'NomProfProhibicionTipo');
      TbProfesor1.MasterSource.Enabled := true;
      ExportarCSV(QuProfesorProfesorProhibicion, TbProfesor1, AStrings);
      TbProfesorProhibicion.MasterSource := DSProfesor;
    end;
    AStrings.Add('DISTRIBUTIVO POR PROFESORES;;;;;;');
    FillMateriaMateriaProhibicion;
    FillMateriaMateriaProhibicionHora;
    TbMateria.Close;
    TbMateria.MasterSource.Enabled := false;
    SourceDataModule.TbMateriaProhibicion.MasterSource := nil;
    try
      CrossBatchMove(SourceDataModule.TbDia, QuMateriaMateriaProhibicionHora,
                     SourceDataModule.TbMateriaProhibicion, TbMateria,
                     'CodDia', 'NomDia', 'CodDia', 'CodMateria;CodHora', 'NomHora',
                     'CodMateria;CodHora', 'NomMateProhibicionTipo');
      TbMateria.MasterSource.Enabled := true;
      ExportarCSV(QuMateriaMateriaProhibicion, TbMateria, AStrings);
    finally
      SourceDataModule.TbMateriaProhibicion.MasterSource := SourceDataModule.DSMateria;
    end;
    AStrings.Add('DISTRIBUTIVO POR PROFESORES;;;;;;');
    ExportarCSV(SourceDataModule.TbProfesor, SourceDataModule.TbDistributivo, AStrings);
    AStrings.Add('DISTRIBUTIVO POR MATERIAS;;;;;;');
    with SourceDataModule, MasterDataModule do
    begin
      TbDistributivo.MasterSource := nil;
      TbDistributivo.IndexedBy :=
        'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      TbDistributivo.MasterFields := 'CodMateria';
      TbDistributivo.MasterSource := DSMateria;
      ExportarCSV(TbMateria, TbDistributivo, AStrings);
      TbDistributivo.MasterSource := nil;
      TbDistributivo.IndexedBy := 'CodProfesor';
      TbDistributivo.MasterFields := 'CodProfesor';
      TbDistributivo.MasterSource := DSProfesor;
    end;
  finally
    AStrings.EndUpdate;
  end;
end;

procedure TMainForm.ActMejorarHorarioExecute(Sender: TObject);
begin
{$IFNDEF FREEWARE}
  MejorarHorario;
{$ENDIF}
end;

{$IFNDEF FREEWARE}
procedure TMainForm.MejorarHorario;
var
  VModeloHorario: TModeloHorario;
  VObjetoModeloHorario: TObjetoModeloHorario;
  CodHorarioFuente, CodHorarioDestino: Integer;
  Informe: TStrings;
  MomentoInicial, MomentoFinal: TDateTime;
  s, d: string;
  va, vd: Double;
begin
  if not InputQuery('Codigo del horario a mejorar: ',
    'Codigo del horario a mejorar', s) then
    Exit;
  if s = '' then
    Exit;
  if not InputQuery('Codigo del horario mejorado: ',
    'Codigo del horario mejorado', d) then
    Exit;
  CodHorarioFuente := StrToInt(s);
  CodHorarioDestino := StrToInt(d);
  FCloseClick := False;
  with SourceDataModule do
  begin
    InitRandom;
    MomentoInicial := Now;
    FEjecutando := True;
    VModeloHorario :=
      TModeloHorario.CrearDesdeDataModule(
        CruceProfesor,
        ProfesorFraccionamiento,
        CruceAulaTipo,
        HoraHueca,
        SesionCortada,
        MateriaNoDispersa);
    StatusBar.Panels[1].Style := psOwnerDraw;
    Self.Progress := 0;
    FPasada := 0;
    try
      VModeloHorario.OnProgress := Self.ProgressDescensoDoble;
      Self.Step := 1;
      VObjetoModeloHorario := TObjetoModeloHorario.CrearDesdeModelo(VModeloHorario);
      try
        if s = '' then
          VObjetoModeloHorario.HacerAleatorio
        else
          VObjetoModeloHorario.LoadFromDataModule(CodHorarioFuente);
        va := VObjetoModeloHorario.Valor;
        VObjetoModeloHorario.DescensoRapidoForzado;
        VObjetoModeloHorario.DescensoRapidoDobleForzado;
        vd := VObjetoModeloHorario.Valor;
        MomentoFinal := Now;
        Informe := TStringList.Create;
        try
          Informe.Add(Format('Peso del horario antes:  %f', [va]));
          Informe.Add(Format('Peso del horaro despues: %f', [vd]));
          VObjetoModeloHorario.SaveToDataModule(CodHorarioDestino, MomentoInicial,
            MomentoFinal, Informe);
          if SourceDataModule.TbHorario.Active then
            SourceDataModule.TbHorario.Refresh;
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
{$ENDIF}

procedure TMainForm.FormDblClick(Sender: TObject);
begin
{$IFNDEF FREEWARE}
  if FEjecutando
    and (MessageDlg('Esta seguro de que desea finalizar esta operacion?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    FCloseClick := True;
{$ENDIF}
end;

procedure TMainForm.ActRegistrationInfoExecute(Sender: TObject);
begin
  PedirRegistrarSoftware;
  ProtegerSoftware;
end;

procedure TMainForm.FillParaleloHora;
var
  s, d: string;
  p, q: TBookmark;
begin
  with SourceDataModule do
  begin
    QuParaleloHora.Close;
    QuParaleloHora.Open;
    TbParalelo.CheckBrowseMode;
    TbParalelo.DisableControls;
    s := TbParalelo.IndexedBy;
    p := TbParalelo.GetBookmark;
    TbHora.CheckBrowseMode;
    TbHora.DisableControls;
    d := TbHora.IndexedBy;
    q := TbHora.GetBookmark;
    try
      TbParalelo.IndexedBy := 'CodNivel;CodEspecializacion;CodParaleloId';
      TbParalelo.First;
      TbHora.IndexedBy := 'CodHora';
      while not TbParalelo.Eof do
      begin
        TbHora.First;
        while not TbHora.Eof do
        begin
          QuParaleloHora.Append;
          QuParaleloHoraCodNivel.Value := TbParalelo.FindField('CodNivel').AsInteger;
          QuParaleloHoraCodEspecializacion.Value := TbParalelo.FindField('CodEspecializacion').AsInteger;
          QuParaleloHoraCodParaleloId.Value := TbParalelo.FindField('CodParaleloId').AsInteger;
          QuParaleloHoraCodHora.Value := TbHora.FindField('CodHora').AsInteger;
          QuParaleloHora.Post;
          TbHora.Next;
        end;
        TbParalelo.Next;
      end;
    finally
      TbParalelo.IndexedBy := s;
      TbParalelo.GotoBookmark(p);
      TbParalelo.FreeBookmark(p);
      TbParalelo.EnableControls;
      TbHora.IndexedBy := d;
      TbHora.GotoBookmark(q);
      TbHora.FreeBookmark(q);
      TbHora.EnableControls;
    end;
  end;
end;

procedure TMainForm.FillProfesorHora;
var
  s, d: string;
  p, q: TBookmark;
begin
  with SourceDataModule do
  begin
    QuProfesorHora.Close;
    QuProfesorHora.Open;
    TbProfesor.CheckBrowseMode;
    TbProfesor.DisableControls;
    s := TbProfesor.IndexedBy;
    TbProfesor.IndexedBy := 'NomMateria';
    p := TbProfesor.GetBookmark;
    TbHora.CheckBrowseMode;
    TbHora.DisableControls;
    d := TbHora.IndexedBy;
    TbHora.IndexedBy := 'CodHora';
    q := TbHora.GetBookmark;
    try
      TbProfesor.First;
      while not TbProfesor.Eof do
      begin
        TbHora.First;
        while not TbHora.Eof do
        begin
          QuProfesorHora.Append;
          QuProfesorHoraCodProfesor.Value := TbProfesor.FindField('CodProfesor').AsInteger;
          QuProfesorHoraCodHora.Value := TbHora.FindField('CodHora').AsInteger;
          QuProfesorHora.Post;
          TbHora.Next;
        end;
        TbProfesor.Next;
      end;
    finally
      TbProfesor.IndexedBy := s;
      TbProfesor.GotoBookmark(p);
      TbProfesor.FreeBookmark(p);
      TbProfesor.EnableControls;
      TbHora.IndexedBy := d;
      TbHora.GotoBookmark(q);
      TbHora.FreeBookmark(q);
      TbHora.EnableControls;
    end;
  end;
end;

procedure TMainForm.FillMateriaMateriaProhibicion;
var
  s: string;
  p: TBookmark;
begin
  QuMateriaMateriaProhibicion.Close;
  QuMateriaMateriaProhibicion.Open;
  with SourceDataModule do
  begin
    TbMateria.First;
    s := TbMateria.IndexedBy;
    TbMateria.IndexedBy := 'NomMateria';
    p := TbMateria.GetBookmark;
    try
      while not TbMateria.Eof do
      begin
        if TbMateriaProhibicion.Locate('CodMateria', TbMateria.FindField('CodMateria').AsInteger, []) then
        begin
          QuMateriaMateriaProhibicion.Append;
          QuMateriaMateriaProhibicionCodMateria.Value := TbMateria.FindField('CodMateria').AsInteger;
          QuMateriaMateriaProhibicion.Post;
        end;
        TbMateria.Next;
      end;
    finally
      TbMateria.IndexedBy := s;
      TbMateria.GotoBookmark(p);
      TbMateria.FreeBookmark(p);
    end;
  end;
end;

procedure TMainForm.FillMateriaMateriaProhibicionHora;
var
  s, d: string;
  p, q: TBookmark;
begin
  QuMateriaMateriaProhibicionHora.Close;
  QuMateriaMateriaProhibicionHora.Open;
  with SourceDataModule do
  begin
    s := TbMateria.IndexedBy;
    TbMateria.IndexedBy := 'NomMateria';
    p := TbMateria.GetBookmark;
    d := TbHora.IndexedBy;
    TbHora.IndexedBy := 'CodHora';
    q := TbHora.GetBookmark;
    try
      TbMateria.First;
      while not TbMateria.Eof do
      begin
        if TbMateriaProhibicion.Locate('CodMateria', TbMateria.FindField('CodMateria').AsInteger, []) then
        begin
          TbHora.First;
          while not TbHora.Eof do
          begin
            QuMateriaMateriaProhibicionHora.Append;
            QuMateriaMateriaProhibicionHoraCodMateria.Value := TbMateria.FindField('CodMateria').AsInteger;
            QuMateriaMateriaProhibicionHoraCodHora.Value := TbHora.FindField('CodHora').AsInteger;
            QuMateriaMateriaProhibicionHora.Post;
            TbHora.Next;
          end;
        end;
        TbMateria.Next;
      end;
    finally
      TbMateria.IndexedBy := s;
      TbMateria.GotoBookmark(p);
      TbMateria.FreeBookmark(p);
      TbHora.IndexedBy := d;
      TbHora.GotoBookmark(q);
      TbHora.FreeBookmark(q);
    end;
  end;
end;

(*
procedure TMainForm.ActOpenCSVExecute(Sender: TObject);
var
  DirName: string;
begin
  StatusBar.Panels[1].Style := psOwnerDraw;
  Progress := 0;
  try
    if ConfirmOperation then
    begin
      if InputQuery('Directorio', 'Directorio del cual leer los archivos CSV:',
        DirName) then
      begin
        LoadFromTextDir(DirName);
      end;
    end;
  finally
    StatusBar.Panels[1].Style := psText;
    StatusBar.Panels[2].Text := 'Listo';
  end;
end;
*)

procedure TMainForm.LoadConfig(Strings: TStrings);
begin
  Position := poDesigned;
  with Strings do
  begin
    Top := StrToInt(Values['MainForm_Top']);
    Left := StrToInt(Values['MainForm_Left']);
    Width := StrToInt(Values['MainForm_Width']);
    Height := StrToInt(Values['MainForm_Height']);
    WindowState := TWindowState(StrToInt(Values['MainForm_WindowState']));
    SaveDialog.FileName := Values['SaveDialog_FileName'];
    SaveDialogCSV.FileName := Values['SaveDialogCSV_FileName'];
    OpenDialog.FileName := Values['OpenDialog_FileName'];
{
    LogisticForm.MemResumen.Height :=
      StrToInt(Values['LogisticForm_MemResumen_Height']);
}
  end;
end;

procedure TMainForm.SaveConfig(Strings: TStrings);
begin
  with Strings do
  begin
    Values['MainForm_Top'] := IntToStr(Top);
    Values['MainForm_Left'] := IntToStr(Left);
    Values['MainForm_Width'] := IntToStr(Width);
    Values['MainForm_Height'] := IntToStr(Height);
    Values['MainForm_WindowState'] := IntToStr(Ord(WindowState));
    Values['SaveDialog_FileName'] := SaveDialog.FileName;
    Values['SaveDialogCSV_FileName'] := SaveDialogCSV.FileName;
    Values['OpenDialog_FileName'] := OpenDialog.FileName;
{
    Values['LogisticForm_MemResumen_Height'] :=
      IntToStr(LogisticForm.MemResumen.Height);
}
  end;
end;

initialization

{$IFDEF FPC}
  {$i FMain.lrs}
{$ENDIF}

end.
