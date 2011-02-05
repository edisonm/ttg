unit FMain;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  SysConst, ExtCtrls, DB, Menus, ComCtrls, ImgList, Buttons,
  ActnList, ToolWin, StdActns, StdCtrls,
  FSingEdt, kbmMemTable, FCrsMME0, FEditor, UConfig{, Protect};
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
    Label1: TLabel;
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
    TbParalelo: TkbmMemTable;
    TbProfesor: TkbmMemTable;
    QuParaleloHora: TkbmMemTable;
    QuParaleloHoraCodNivel: TIntegerField;
    QuParaleloHoraCodEspecializacion: TIntegerField;
    QuParaleloHoraCodParaleloId: TIntegerField;
    QuParaleloHoraCodHora: TIntegerField;
    QuParaleloHoraNomHora: TStringField;
    QuProfesorHora: TkbmMemTable;
    QuProfesorHoraCodProfesor: TIntegerField;
    QuProfesorHoraCodHora: TIntegerField;
    QuProfesorHoraNomHora: TStringField;
    QuProfesorHorarioDetalle: TkbmMemTable;
    QuParaleloHorarioDetalle: TkbmMemTable;
    TbMateria: TkbmMemTable;
    QuMateriaMateriaProhibicion: TkbmMemTable;
    QuMateriaMateriaProhibicionCodMateria: TIntegerField;
    QuMateriaMateriaProhibicionNomMateria: TStringField;
    QuMateriaMateriaProhibicionHora: TkbmMemTable;
    QuMateriaMateriaProhibicionHoraCodMateria: TIntegerField;
    QuMateriaMateriaProhibicionHoraCodHora: TIntegerField;
    QuMateriaMateriaProhibicionHoraNomHora: TStringField;
    QuProfesorProfesorProhibicion: TkbmMemTable;
    QuProfesorProfesorProhibicionApeProfesor: TStringField;
    QuProfesorProfesorProhibicionNomProfesor: TStringField;
    QuProfesorProfesorProhibicionCodProfesor: TIntegerField;
    QuProfesorProfesorProhibicionHora: TkbmMemTable;
    QuProfesorProfesorProhibicionHoraCodProfesor: TIntegerField;
    QuProfesorProfesorProhibicionHoraCodHora: TIntegerField;
    QuProfesorProfesorProhibicionHoraNomHora: TStringField;
    TbProfesor1: TkbmMemTable;
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
    QuParaleloHorarioDetalleCodNivel: TIntegerField;
    QuParaleloHorarioDetalleCodEspecializacion: TIntegerField;
    QuParaleloHorarioDetalleCodParaleloId: TIntegerField;
    QuParaleloHorarioDetalleCodDia: TIntegerField;
    QuParaleloHorarioDetalleCodHora: TIntegerField;
    QuParaleloHorarioDetalleCodMateria: TIntegerField;
    QuParaleloHorarioDetalleNomMateria: TStringField;
    QuProfesorHorarioDetalleCodProfesor: TIntegerField;
    QuProfesorHorarioDetalleCodDia: TIntegerField;
    QuProfesorHorarioDetalleCodHora: TIntegerField;
    QuProfesorHorarioDetalleNombre: TStringField;
    ToolBar: TToolBar;
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
    procedure QuParaleloAfterScroll(DataSet: TDataSet);
    procedure QuProfesorAfterScroll(DataSet: TDataSet);
    procedure TbParaleloFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TbProfesorFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure TbMateriaFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure QuMateriaMateriaProhibicionAfterScroll(DataSet: TDataSet);
    procedure QuProfesorProfesorProhibicionAfterScroll(DataSet: TDataSet);
    procedure TbProfesor1FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure ActContentsExecute(Sender: TObject);
    procedure ActIndexExecute(Sender: TObject);
    procedure ActExportarCSVExecute(Sender: TObject);
    procedure ActMejorarHorarioExecute(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure ActRegistrationInfoExecute(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
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

{$R *.DFM}

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
  if TCrossManyToManyEditor0Form.ToggleEditor(Self,
                                              FPeriodoForm,
					      ConfigStorage,
					      ActPeriodo) then
  with SourceDataModule do
    FPeriodoForm.ShowEditor(TbDia, TbHora, TbPeriodo, nil, 'CodDia', 'NomDia',
                            'CodDia', '', 'CodHora', 'NomHora', 'CodHora', '');
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
    MessageDlg('Los cambios realizados hasta el momento se perderán, '#13#10
    + '¿Está seguro?', mtWarning, [mbYes, mbNo], 0) = mrYes
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
  begin
    if not InputQuery('Códigos de los Horarios: ',
      'Ingrese los códigos de los Horarios a generar', s) then
      Exit;
    ElaborarHorario(s);
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
      VEvolElitista.SaveMejorToDatabase(Cod, FMomentoInicial,
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
          mr := MessageDlg('El archivo de sincronización ya existe.  ' +
                             '¿Desea eliminar los archivos relacionados?',
                           mtWarning, [mbYes, mbNo, mbCancel], 0);
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
        VEvolElitista.PrefijarHorarios(HorarioIni);
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
      + MulDiv(Rect.Right - Rect.Left, FRelProgress, (FMax - FMin));
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
          ' El sistema correrá sin las opciones que permiten generar el horario',
          mtWarning, [mbOk], 0);
        ActElaborarHorario.Enabled := False;
        ActMejorarHorario.Enabled := False;
      end
      else if Protect1.DaysExpire > 0 then
      begin
        StatusBar.Panels[2].Text := Format('Transcurridos %d de %d días',
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
  FConfigFileName := GetCurrentDir + '\TTG.cfg';
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
    if MessageDlg('No se encontraron errores, está listo para generar horario.'#13#10 +
                    '¿Desea mostrar el resumen del chequeo del horario?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      LogisticForm.Show;
  end;
end;

procedure TMainForm.ActAboutExecute(Sender: TObject);
begin
  MessageDlg(sAppName + ' ' + sAppVersion + '.'#13#10 +
               'Compilado: ' + sBuildDateTime + #13#10 +
               'Elaborado por Edison Mera.'#13#10 +
               '1999-2011. Quito-Ecuador, Madrid-España.',
    mtInformation, [mbOK], 0);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose :=
    MessageDlg('Los cambios realizados hasta el momento se perderán.'#13#10 +
    '¿Está seguro que desea cerrar el programa?',
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
      TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      TbDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      TbDistributivo.MasterFields := TbDistributivo.IndexFieldNames;
      TbDistributivo.MasterSource := DSHorarioDetalle;
      TbDistributivo.First;
      try
        if TbHorarioDetalle.Locate('CodHorario', CodHorarioSeleccionado, []) then
        begin
          while (TbHorarioDetalleCodHorario.Value = CodHorarioSeleccionado) and not TbHorarioDetalle.Eof do
          begin
            QuProfesorHorarioDetalle.Append;
            QuProfesorHorarioDetalleCodProfesor.Value := TbDistributivoCodProfesor.Value;
            QuProfesorHorarioDetalleCodDia.Value := TbHorarioDetalleCodDia.Value;
            QuProfesorHorarioDetalleCodHora.Value := TbHorarioDetalleCodHora.Value;
            QuProfesorHorarioDetalleNombre.Value :=
              TbDistributivoAbrNivel.Value + ' ' +
              TbDistributivoAbrEspecializacion.Value + ' ' +
              TbDistributivoNomParaleloId.Value + ' ' +
              TbDistributivoNomMateria.Value;
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
  TbProfesor.Filtered := false;
  CrossBatchMove(SourceDataModule.TbDia, QuProfesorHora, QuProfesorHorarioDetalle,
    TbProfesor, 'CodDia', 'NomDia', 'CodDia', 'CodProfesor;CodHora',
    'NomHora', 'CodProfesor;CodHora', 'Nombre');
  TbProfesor.Filtered := true;
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
    s := TbHorarioDetalle.IndexFieldNames;
    p := TbHorarioDetalle.GetBookmark;
    try
      TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
      TbHorarioDetalle.First;
      if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
      begin
        while (TbHorarioDetalleCodHorario.Value = CodHorario) and not TbHorarioDetalle.Eof do
        begin
          QuParaleloHorarioDetalle.Append;
          QuParaleloHorarioDetalleCodNivel.Value := TbHorarioDetalleCodNivel.Value;
          QuParaleloHorarioDetalleCodEspecializacion.Value := TbHorarioDetalleCodNivel.Value;
          QuParaleloHorarioDetalleCodParaleloId.Value := TbHorarioDetalleCodParaleloId.Value;
          QuParaleloHorarioDetalleCodHora.Value := TbHorarioDetalleCodHora.Value;
          QuParaleloHorarioDetalleCodDia.Value := TbHorarioDetalleCodDia.Value;
          QuParaleloHorarioDetalle.Post;
          TbHorarioDetalle.Next;
        end;
        QuParaleloHorarioDetalle.First;
      end;
    finally
      TbHorarioDetalle.IndexFieldNames := s;
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
  TbParalelo.Filtered := false;
  CrossBatchMove(SourceDataModule.TbDia, QuParaleloHora, QuParaleloHorarioDetalle,
                 TbParalelo, 'CodDia', 'NomDia', 'CodDia',
                 'CodNivel;CodEspecializacion;CodParaleloId;CodHora', 'NomHora',
                 'CodNivel;CodEspecializacion;CodParaleloId;CodHora', 'NomMateria');
  TbParalelo.Filtered := true;
end;

procedure TMainForm.QuParaleloAfterScroll(DataSet: TDataSet);
begin
  TbParalelo.Filtered := false;
  TbParalelo.Filtered := true;
end;

procedure TMainForm.QuProfesorAfterScroll(DataSet: TDataSet);
begin
  TbProfesor.Filtered := false;
  TbProfesor.Filtered := true;
end;

procedure TMainForm.TbParaleloFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  with SourceDataModule do
    Accept := (DataSet.FindField('CodNivel').AsInteger = TbParaleloCodNivel.Value)
    and (DataSet.FindField('CodParaleloId').AsInteger = TbParaleloCodParaleloId.Value);
end;

procedure TMainForm.TbProfesorFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  with SourceDataModule do
    Accept := DataSet.FindField('CodProfesor').AsInteger =
    TbProfesorCodProfesor.AsInteger;
end;

procedure TMainForm.ToolButton5Click(Sender: TObject);
begin
//  if not ToolButton5.Down then
//    ToolButton5.Down := True;
end;

procedure TMainForm.TbMateriaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := DataSet.FindField('CodMateria').AsInteger =
    QuMateriaMateriaProhibicionCodMateria.Value;
end;

procedure TMainForm.QuMateriaMateriaProhibicionAfterScroll(DataSet: TDataSet);
begin
  TbMateria.Filtered := false;
  TbMateria.Filtered := true;
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
    s := TbProfesor.IndexFieldNames;
    p := TbProfesor.GetBookmark;
    TbProfesor.IndexFieldNames := 'NomMateria';
    try
      while not TbProfesor.Eof do
      begin
        if TbProfesorProhibicion.Locate('CodProfesor', TbProfesorCodProfesor.Value, []) then
        begin
          QuProfesorProfesorProhibicion.Append;
          QuProfesorProfesorProhibicionCodProfesor.Value := TbProfesorCodProfesor.Value;
          QuProfesorProfesorProhibicion.Post;
        end;
        TbProfesor.Next;
      end;
    finally
      TbProfesor.IndexFieldNames := s;
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
    s := TbProfesor.IndexFieldNames;
    d := TbHora.IndexFieldNames;
    p := TbProfesor.GetBookmark;
    q := TbHora.GetBookmark;
    TbProfesor.IndexFieldNames := 'NomMateria';
    TbHora.IndexFieldNames := 'CodHora';
    try
      while not TbProfesor.Eof do
      begin
        if TbProfesorProhibicion.Locate('CodProfesor', TbProfesorCodProfesor.Value, []) then
        begin
          TbHora.First;
          while not TbHora.Eof do
          begin
            QuProfesorProfesorProhibicionHora.Append;
            QuProfesorProfesorProhibicionHoraCodProfesor.Value := TbProfesorCodProfesor.Value;
            QuProfesorProfesorProhibicionHoraCodHora.Value := TbHoraCodHora.Value;
            QuProfesorProfesorProhibicionHora.Post;
            TbHora.Next;
          end;
        end;
        TbProfesor.Next;
      end;
    finally
      TbProfesor.IndexFieldNames := s;
      TbProfesor.GotoBookmark(p);
      TbProfesor.FreeBookmark(p);
      TbHora.IndexFieldNames := d;
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

procedure TMainForm.TbProfesor1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := DataSet.FindField('CodProfesor').AsInteger =
    QuProfesorProfesorProhibicionCodProfesor.Value;
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
  Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TMainForm.ActIndexExecute(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER, 0);
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
    TbProfesor1.Filtered := false;
    AStrings.Add('PROHIBICIONES DE PROFESORES;;;;;;');
    with SourceDataModule, MasterDataModule do
    begin
      TbProfesorProhibicion.MasterSource := nil;
      CrossBatchMove(TbDia, QuProfesorProfesorProhibicionHora,
                     TbProfesorProhibicion, TbProfesor1, 'CodDia', 'NomDia', 'CodDia',
                     'CodProfesor;CodHora', 'NomHora', 'CodProfesor;CodHora',
                     'NomProfProhibicionTipo');
      TbProfesor1.Filtered := true;
      ExportarCSV(QuProfesorProfesorProhibicion, TbProfesor1, AStrings);
      TbProfesorProhibicion.MasterSource := DSProfesor;
    end;
    AStrings.Add('DISTRIBUTIVO POR PROFESORES;;;;;;');
    FillMateriaMateriaProhibicion;
    FillMateriaMateriaProhibicionHora;
    TbMateria.Close;
    TbMateria.Filtered := false;
    SourceDataModule.TbMateriaProhibicion.MasterSource := nil;
    try
      CrossBatchMove(SourceDataModule.TbDia, QuMateriaMateriaProhibicionHora,
                     SourceDataModule.TbMateriaProhibicion, TbMateria,
                     'CodDia', 'NomDia', 'CodDia', 'CodMateria;CodHora', 'NomHora',
                     'CodMateria;CodHora', 'NomMateProhibicionTipo');
      TbMateria.Filtered := true;
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
      TbDistributivo.IndexFieldNames :=
        'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      TbDistributivo.MasterFields := 'CodMateria';
      TbDistributivo.MasterSource := DSMateria;
      ExportarCSV(TbMateria, TbDistributivo, AStrings);
      TbDistributivo.MasterSource := nil;
      TbDistributivo.IndexFieldNames := 'CodProfesor';
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
  if not InputQuery('Código del horario a mejorar: ',
    'Código del horario a mejorar', s) then
    Exit;
  if s = '' then
    Exit;
  if not InputQuery('Código del horario mejorado: ',
    'Código del horario mejorado', d) then
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
    and (MessageDlg('¿Está seguro de que desea finalizar esta operación?',
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
    s := TbParalelo.IndexFieldNames;
    p := TbParalelo.GetBookmark;
    TbHora.CheckBrowseMode;
    TbHora.DisableControls;
    d := TbHora.IndexFieldNames;
    q := TbHora.GetBookmark;
    try
      TbParalelo.IndexFieldNames := 'CodNivel;CodEspecializacion;CodParaleloId';
      TbParalelo.First;
      TbHora.IndexFieldNames := 'CodHora';
      while not TbParalelo.Eof do
      begin
        TbHora.First;
        while not TbHora.Eof do
        begin
          QuParaleloHora.Append;
          QuParaleloHoraCodNivel.Value := TbParaleloCodNivel.Value;
          QuParaleloHoraCodEspecializacion.Value := TbParaleloCodEspecializacion.Value;
          QuParaleloHoraCodParaleloId.Value := TbParaleloCodParaleloId.Value;
          QuParaleloHoraCodHora.Value := TbHoraCodHora.Value;
          QuParaleloHora.Post;
          TbHora.Next;
        end;
        TbParalelo.Next;
      end;
    finally
      TbParalelo.IndexFieldNames := s;
      TbParalelo.GotoBookmark(p);
      TbParalelo.FreeBookmark(p);
      TbParalelo.EnableControls;
      TbHora.IndexFieldNames := d;
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
    s := TbProfesor.IndexFieldNames;
    TbProfesor.IndexFieldNames := 'NomMateria';
    p := TbProfesor.GetBookmark;
    TbHora.CheckBrowseMode;
    TbHora.DisableControls;
    d := TbHora.IndexFieldNames;
    TbHora.IndexFieldNames := 'CodHora';
    q := TbHora.GetBookmark;
    try
      TbProfesor.First;
      while not TbProfesor.Eof do
      begin
        TbHora.First;
        while not TbHora.Eof do
        begin
          QuProfesorHora.Append;
          QuProfesorHoraCodProfesor.Value := TbProfesorCodProfesor.Value;
          QuProfesorHoraCodHora.Value := TbHoraCodHora.Value;
          QuProfesorHora.Post;
          TbHora.Next;
        end;
        TbProfesor.Next;
      end;
    finally
      TbProfesor.IndexFieldNames := s;
      TbProfesor.GotoBookmark(p);
      TbProfesor.FreeBookmark(p);
      TbProfesor.EnableControls;
      TbHora.IndexFieldNames := d;
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
    s := TbMateria.IndexFieldNames;
    TbMateria.IndexFieldNames := 'NomMateria';
    p := TbMateria.GetBookmark;
    try
      while not TbMateria.Eof do
      begin
        if TbMateriaProhibicion.Locate('CodMateria', TbMateriaCodMateria.Value, []) then
        begin
          QuMateriaMateriaProhibicion.Append;
          QuMateriaMateriaProhibicionCodMateria.Value := TbMateriaCodMateria.Value;
          QuMateriaMateriaProhibicion.Post;
        end;
        TbMateria.Next;
      end;
    finally
      TbMateria.IndexFieldNames := s;
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
    s := TbMateria.IndexFieldNames;
    TbMateria.IndexFieldNames := 'NomMateria';
    p := TbMateria.GetBookmark;
    d := TbHora.IndexFieldNames;
    TbHora.IndexFieldNames := 'CodHora';
    q := TbHora.GetBookmark;
    try
      TbMateria.First;
      while not TbMateria.Eof do
      begin
        if TbMateriaProhibicion.Locate('CodMateria', TbMateriaCodMateria.Value, []) then
        begin
          TbHora.First;
          while not TbHora.Eof do
          begin
            QuMateriaMateriaProhibicionHora.Append;
            QuMateriaMateriaProhibicionHoraCodMateria.Value := TbMateriaCodMateria.Value;
            QuMateriaMateriaProhibicionHoraCodHora.Value := TbHoraCodHora.Value;
            QuMateriaMateriaProhibicionHora.Post;
            TbHora.Next;
          end;
        end;
        TbMateria.Next;
      end;
    finally
      TbMateria.IndexFieldNames := s;
      TbMateria.GotoBookmark(p);
      TbMateria.FreeBookmark(p);
      TbHora.IndexFieldNames := d;
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

end.
