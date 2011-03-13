unit FProgres;

{$I ttg.inc}

interface

uses
  {$IFDEF UNIX}CThreads, CMem, {$ENDIF}{$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF},
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons,
  ExtCtrls, ComCtrls, KerModel, KerEvolE, HorColCm;

type

  { TProgressForm }

  TProgressForm = class(TForm)
    lblColision: TLabel;
    lblCruceMateria: TLabel;
    lblCruceMateriaValor: TLabel;
    lblExports: TLabel;
    lblImports: TLabel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    pnlCruceMateria: TPanel;
    pnlCruceMateriaCantidad: TPanel;
    pnlCruceMateriaValor: TPanel;
    pnlProgress: TPanel;
    bbtnClose: TBitBtn;
    pnlValorTotal: TPanel;
    pnlCruceProfesor: TPanel;
    lblValorTotal: TLabel;
    pnlCruceProfesorValor: TPanel;
    lblCruceProfesorValor: TLabel;
    pnlCruceAulaTipo: TPanel;
    pnlCruceAulaTipoValor: TPanel;
    lblCruceAulaTipoValor: TLabel;
    pnlCruceProfesorCantidad: TPanel;
    lblCruceProfesor: TLabel;
    pnlCruceAulaTipoCantidad: TPanel;
    lblCruceAulaTipo: TLabel;
    pnlHoraHuecaDesubicada: TPanel;
    pnlHoraHuecaDesubicadaCantidad: TPanel;
    lblHoraHuecaDesubicada: TLabel;
    pnlHoraHuecaDesubicadaValor: TPanel;
    lblHoraHuecaDesubicadaValor: TLabel;
    pnlSesionCortada: TPanel;
    pnlSesionCortadaCantidad: TPanel;
    lblSesionCortada: TLabel;
    pnlSesionCortadaValor: TPanel;
    lblSesionCortadaValor: TLabel;
    pnlInitDateTime: TPanel;
    lblInit: TLabel;
    pnlElapsedTime: TPanel;
    lblElapsedTime: TLabel;
    pnlEstimatedTime: TPanel;
    lblRemainingTime: TLabel;
    pnlMateriaProhibicion: TPanel;
    pnlMateriaProhibicionCantidad: TPanel;
    lblMateriaProhibicion: TLabel;
    pnlMateriaProhibicionValor: TPanel;
    lblMateriaProhibicionValor: TLabel;
    pnlProfesorProhibicion: TPanel;
    pnlProfesorProhibicionCantidad: TPanel;
    lblProfesorProhibicion: TLabel;
    Panel26: TPanel;
    lblProfesorProhibicionValor: TLabel;
    pnlMateriaNoDispersa: TPanel;
    Panel28: TPanel;
    lblMateriaNoDispersa: TLabel;
    Panel29: TPanel;
    lblMateriaNoDispersaValor: TLabel;
    bbtnCancel: TBitBtn;
    PBProgress: TProgressBar;
    Panel1: TPanel;
    Panel2: TPanel;
    lblProfesorFraccionamiento: TLabel;
    Panel3: TPanel;
    lblProfesorFraccionamientoValor: TLabel;
    pnlPosition: TPanel;
    lblPosition: TLabel;
    procedure bbtnCancelClick(Sender: TObject);
    procedure bbtnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FInit: TDateTime;
    FCloseClick:Boolean;
    FCancelClick: Boolean;
    function GetProgressMax: Integer;
    procedure SetProgressMax(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    property CloseClick: Boolean read FCloseClick write FCloseClick;
    property CancelClick: Boolean read FCancelClick write FCancelClick;
    property ProgressMax: Integer read GetProgressMax write SetProgressMax;
    procedure DoProgress(APosition: Integer; ASolver: TSolver);
  end;

  { TProgressFormDrv }

  TProgressFormDrv = class
  private
    FProgressForm: TProgressForm;
    FMax: Integer;
    FCodHorario: Integer;
    FPosition: Integer;
    FSolver: TSolver;
  public
    constructor Create(AMax, ACodHorario: Integer);
    destructor Destroy; override;
    procedure CreateForm;
    procedure DestroyForm;
    procedure DoProgress;
    procedure OnProgress(APosition: Integer; ASolver: TSolver;
      var Stop: Boolean);
    property CancelClick: Boolean read FProgressForm.FCancelClick;
  end;

implementation

uses
  MTProcs;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

{ TFProgress }

function TProgressForm.GetProgressMax: Integer;
begin
  Result := PBProgress.Max;
end;

procedure TProgressForm.DoProgress(APosition: Integer; ASolver: TSolver);
var
  t: TDateTime;
begin
  with ASolver, BestIndividual do
  begin
      {
      if FAjustar then
      begin
        InvalidarValores;
      	// Update;
        with SourceDataModule do
	        Model.Configure(CruceProfesor,
                                   ProfesorFraccionamiento,
                                   CruceAulaTipo,
                                   HoraHueca,
                                   SesionCortada,
                                   MateriaNoDispersa);
        FAjustar := False;
      end;
      }
    t := Now - FInit;
    lblElapsedTime.Caption := FormatDateTime('hh:nn:ss ', t);
    if APosition <> 0 then
      lblRemainingTime.Caption := FormatDateTime('hh:nn:ss ',
        t * (PBProgress.Max - APosition) / APosition);
    lblPosition.Caption := Format('%d/%d', [APosition, PBProgress.Max]);
    PBProgress.Position := APosition;
    lblCruceProfesor.Caption := Format('%d ', [CruceProfesor]);
    lblCruceMateria.Caption := Format('%d ', [ASolver.BestIndividual.CruceMateria]);
    lblCruceAulaTipo.Caption := Format('%d ', [CruceAulaTipo]);
    lblProfesorFraccionamiento.Caption :=
      Format('%d ', [ProfesorFraccionamiento]);
    lblHoraHuecaDesubicada.Caption := Format('%d ', [HoraHuecaDesubicada]);
    lblSesionCortada.Caption := Format('%d ', [SesionCortada]);
    lblMateriaProhibicion.Caption :=
      Format('%s ', [VarArrToStr(MateriaProhibicionTipoAMateriaCant)]);
    lblProfesorProhibicion.Caption :=
      Format('%s ', [VarArrToStr(ProfesorProhibicionTipoAProfesorCant)]);
    lblMateriaNoDispersa.Caption := Format('%d ', [MateriaNoDispersa]);
    lblCruceProfesorValor.Caption := Format('%8.2f ', [CruceProfesorValor]);
    lblCruceMateriaValor.Caption := Format('%8.2f ', [ASolver.BestIndividual.CruceMateriaValor]);
    lblProfesorFraccionamientoValor.Caption :=
      Format('%8.2f ', [ProfesorFraccionamientoValor]);
    lblCruceAulaTipoValor.Caption := Format('%8.2f ', [CruceAulaTipoValor]);
    lblHoraHuecaDesubicadaValor.Caption := Format('%8.2f ',
      [HoraHuecaDesubicadaValor]);
    lblSesionCortadaValor.Caption := Format('%8.2f ', [SesionCortadaValor]);
    lblMateriaProhibicionValor.Caption := Format('%8.2f ', [MateriaProhibicionValor]);
    lblProfesorProhibicionValor.Caption := Format('%8.2f ', [ProfesorProhibicionValor]);
    lblMateriaNoDispersaValor.Caption := Format('%8.2f ', [MateriaNoDispersaValor]);
    lblValorTotal.Caption := Format('%8.2f ', [Value]);
  end;
  if ASolver is TEvolElitist then
  with TEvolElitist(ASolver) do
  begin
    lblImports.Caption := Format('%d ', [NumImports]);
    lblExports.Caption := Format('%d ', [NumExports]);
    lblColision.Caption := Format('%d ', [NumColision]);
  end;
end;

procedure TProgressForm.SetProgressMax(const Value: Integer);
begin
  PBProgress.Max := Value;
end;

procedure TProgressForm.bbtnCancelClick(Sender: TObject);
begin
  FCancelClick := True;
  Close;
end;

procedure TProgressForm.bbtnCloseClick(Sender: TObject);
begin
  FCloseClick := True;
  Close;
end;

procedure TProgressForm.FormCreate(Sender: TObject);
begin
  // HelpContext := ActElaborarHorario.HelpContext;
  FInit := Now;
  lblInit.Caption := FormatDateTime(Format('%s %s ', [ShortDateFormat,
    LongTimeFormat]), FInit);
  FCloseClick := False;
  FCancelClick := False;
  Show;
end;

{ TProgressFormDrv }

constructor TProgressFormDrv.Create(AMax, ACodHorario: Integer);
begin
  inherited Create;
  FMax := AMax;
  FCodHorario := ACodHorario;
  TThread.Synchronize(CurrentThread, CreateForm);
end;

destructor TProgressFormDrv.Destroy;
begin
  TThread.Synchronize(CurrentThread, DestroyForm);
  inherited Destroy;
end;

procedure TProgressFormDrv.CreateForm;
begin
  FProgressForm := TProgressForm.Create(Application);
  FProgressForm.ProgressMax := FMax;
  FProgressForm.Caption := Format('Elaboracion en progreso [%d]', [FCodHorario]);
end;

procedure TProgressFormDrv.DestroyForm;
begin
  FProgressForm.Free;
end;

procedure TProgressFormDrv.DoProgress;
begin
  FProgressForm.DoProgress(FPosition, FSolver);
  {$IFDEF DEBUG}
  Application.ProcessMessages;
  {$ENDIF}
end;

procedure TProgressFormDrv.OnProgress(APosition: Integer; ASolver: TSolver;
    var Stop: Boolean);
begin
  FPosition := APosition;
  FSolver := ASolver;
  TThread.Synchronize(CurrentThread, DoProgress);
  with FProgressForm do
    if (CloseClick or CancelClick) then
      Stop := True;
end;

initialization
{$IFDEF FPC}
  {$i FProgres.lrs}
{$ENDIF}

end.
