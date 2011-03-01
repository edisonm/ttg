unit FMain;

{$I ttg.inc}
{
TODO:
  - HORARIO POR PARALELOS
  - HORARIO POR PROFESORES
  - PROHIBICIONES DE PROFESORES
  - DISTRIBUTIVO POR PROFESORES
  - DISTRIBUTIVO POR MATERIAS
}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Forms, Dialogs, ExtCtrls, Menus, ComCtrls, Buttons, ActnList,
  FSplash, FSingEdt, ZConnection, Controls, FCrsMME0, FEditor, UConfig
{$IFNDEF FREEWARE}, KerEvolE, KerModel, FProgres{$ENDIF};

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
    ActMejorarHorario: TAction;
    MIMejorarHorario: TMenuItem;
    SaveDialogCSV: TSaveDialog;
    ActRegistrationInfo: TAction;
    MIRegistrationInfo: TMenuItem;
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
    procedure ActConfigurarExecute(Sender: TObject);
    procedure ActChequearFactibilidadExecute(Sender: TObject);
    procedure ActAboutExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ActContentsExecute(Sender: TObject);
    procedure ActIndexExecute(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure ActRegistrationInfoExecute(Sender: TObject);
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
{$IFNDEF FREEWARE}
    procedure ElaborarHorario(s: string);
{$ENDIF}
    procedure PedirRegistrarSoftware;
    procedure ProtegerSoftware;

    //procedure MarcarProgreso(Count, Cant: Integer);

  public
    { Public declarations }
    procedure AjustarPesos;
{$IFNDEF FREEWARE}
    procedure OnRegistrarMejor(Sender: TObject);
    property Ejecutando: Boolean read FEjecutando write FEjecutando;
    property Pasada: Integer read FPasada write FPasada;
{$ENDIF}
    property Progress: Integer read FProgress write SetProgress;
    property Min: Integer read FMin write SetMin;
    property Max: Integer read FMax write SetMax;
    property Step: Integer read FStep write SetStep;
    property CodHorario: Integer read FCodHorario write FCodHorario;
    property ConfigStorage: TConfigStorage read FConfigStorage;
  end;

var
  MainForm: TMainForm;

implementation

uses
  FCrsMMEd, FCrsMME1, DMaster, FMateria, FProfesr, FHorario, FMasDeEd, About,
  FConfig, FMsgView, FParalel, Rand, Printers, DSource, DSrcBase, HorColCm;

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
      MasterDataModule.NewDataBase;
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
    MasterDataModule.SaveToTextFile(AFileName);
  finally
    Cursor := crDefault;
  end;
end;

procedure TMainForm.LoadFromFile(const AFileName: string);
begin
  Cursor := crHourGlass;
  try
    SourceDataModule.EmptyTables;
    MasterDataModule.LoadFromTextFile(AFileName);
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
        MainForm.Caption := Application.Title + ' - ' +
          MasterDataModule.ConfigStorage.NomColegio;
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
    s := IntToStr(NewCodHorario);
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

const
  FBoolToStr: array [Boolean] of string = ('No', 'Sí');

procedure TMainForm.ElaborarHorario(s: string);
var
  VModeloHorario: TModeloHorario;
  VEvolElitista: TEvolElitista;
  FMomentoInicial, FMomentoFinal: TDateTime;
  sProb: string;
  Report: TStrings;
  procedure ProcesarCodHorario(ACodHorario: Integer);
  begin
    CodHorario := ACodHorario;
    if SourceDataModule.TbHorario.Locate('CodHorario', CodHorario, []) then
      sProb := sProb + ' ' + IntToStr(CodHorario)
    else
    begin
      FMomentoInicial := Now;
      ProgressForm.Caption := Format('Elaboracion en progreso [%d]', [CodHorario]);
      FLogStrings.Clear;
      ProgressForm.ProgressMax := vEvolElitista.NumMaxGeneracion;
      FLogStrings.BeginUpdate;
      ProgressForm.ShowProgressForm;
      try
        vEvolElitista.Execute(MasterDataModule.ConfigStorage.NumIteraciones);
      finally
        ProgressForm.CloseProgressForm;
        FLogStrings.EndUpdate;
      end;
      //FLogStrings.SaveToFile(Format('LogHor_%d.txt', [CodHorario]));
      if ProgressForm.CancelClick then
        Exit;
      if MasterDataModule.ConfigStorage.ApplyDoubleDownHill then
      begin
        ProgressForm.Caption := Format('Mejorando Horario [%d]', [CodHorario]);
        ProgressForm.ProgressMax := vModeloHorario.SesionCantidadDoble;
        ProgressForm.ShowProgressForm;
        try
          VEvolElitista.BestTimeTable.DescensoRapidoDobleForzado(
            MasterDataModule.ConfigStorage.NumIteraciones);
        finally
          ProgressForm.CloseProgressForm;
        end;
      end
      else
        VEvolElitista.DescensoRapidoForzado;
      FMomentoFinal := Now;
      Report := TStringList.Create;
      try
        Report.Add('Algoritmo Evolutivo Elitista');
        Report.Add('============================');
        Report.Add(Format('Descenso rapido doble: %s',
          [FBoolToStr[MasterDataModule.ConfigStorage.ApplyDoubleDownHill]]));
        VEvolElitista.ReportParameters(Report);
        VEvolElitista.BestTimeTable.ReportValues(Report);
        VEvolElitista.SaveBestToDatabase(ACodHorario, FMomentoInicial, FMomentoFinal, Report);
      finally
        Report.Free;
      end;
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
        if ProgressForm.CancelClick then
          Exit;
      end;
    end;
  end;
var
  mr: TModalResult;
begin
  with SourceDataModule, MasterDataModule.ConfigStorage do
  begin
    InitRandom;
    ActElaborarHorario.Enabled := False;
    FEjecutando := True;
    VModeloHorario := TModeloHorario.CrearDesdeDataModule(CruceProfesor,
      ProfesorFraccionamiento, CruceAulaTipo, HoraHueca, SesionCortada, MateriaNoDispersa);
    VEvolElitista := TEvolElitista.CrearDesdeModelo(VModeloHorario, TamPoblacion);
    try
      VModeloHorario.OnProgress := ProgressForm.OnProgress;
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
      ProgressForm.CancelClick := False;
      FAjustar := False;
      VEvolElitista.OnRegistrarMejor := Self.OnRegistrarMejor;
      sProb := '';
      ProcessCodList(s);
      if sProb <> '' then
        MessageDlg(Format('Los siguientes horarios ya existian: %s', [sProb]),
          mtError, [mbOK], 0);
    finally
      VEvolElitista.Free;
      VModeloHorario.Free;
      FEjecutando := False;
      ActElaborarHorario.Enabled := True;
      TbHorarioDetalle.Refresh;
    end;
  end;
end;

{
procedure TMainForm.ProgressDescensoDoble(I, Max: Integer; Horario: TObjetoModeloHorario; var Stop: Boolean);
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
}

procedure TMainForm.OnRegistrarMejor(Sender: TObject);
begin
  with Sender as TEvolElitista do
  begin
    FLogStrings.Add(Format('%g; %g; %g', [Now, MejorValor, PromedioValor]));
  end;
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
  MainForm.Caption := Application.Title;
{$IFDEF DEBUG}
  Caption := Caption + ' - Debug Build';
{$ENDIF}
  FConfigFileName := GetCurrentDir + '/ttg.cfg';
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

procedure TMainForm.ActConfigurarExecute(Sender: TObject);
begin
  try
    if ShowConfiguracionForm(ActConfigurar.HelpContext) = mrOK then
    begin
      MainForm.Caption := Application.Title + ' - ' +
        MasterDataModule.ConfigStorage.NomColegio;
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
  MessageViewForm.HelpContext := ActChequearFactibilidad.HelpContext;
  if MasterDataModule.PerformAllChecks(MessageViewForm.MemLog.Lines,
                                       MessageViewForm.MemSummary.Lines,
                                       MasterDataModule.ConfigStorage.MaxCargaProfesor) then
  begin
    MessageViewForm.Show;
  end
  else
  begin
    if MessageDlg('No se encontraron errores, esta listo para generar horario.'#13#10 +
                    'Desea mostrar el resumen del chequeo del horario?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      MessageViewForm.Show;
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

procedure TMainForm.FormDblClick(Sender: TObject);
begin
{$IFNDEF FREEWARE}
  if FEjecutando
    and (MessageDlg('Esta seguro de que desea finalizar esta operacion?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    ProgressForm.CloseClick := True;
{$ENDIF}
end;

procedure TMainForm.ActRegistrationInfoExecute(Sender: TObject);
begin
  PedirRegistrarSoftware;
  ProtegerSoftware;
end;

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
    MessageViewForm.MemSummary.Height :=
      StrToInt(Values['MessageViewForm_MemResumen_Height']);
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
    Values['MessageViewForm_MemResumen_Height'] :=
      IntToStr(MessageViewForm.MemSummary.Height);
}
  end;
end;

initialization

{$IFDEF FPC}
  {$i FMain.lrs}
{$ENDIF}

end.
