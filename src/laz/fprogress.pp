{ -*- mode: Delphi -*- }
unit FProgress;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
    Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls,
    UTimeTableModel, USolver;

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
    FUpdateIndex: Integer;
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
    procedure DoProgress(APosition, AMax: Integer; ASolver: TSolver);
  end;

  { TProgressFormDrv }

  TProgressFormDrv = class
  private
    FProgressForm: TProgressForm;
    FMax: Integer;
    FPosition: Integer;
    FSolver: TSolver;
    FCaption: string;
    procedure SetCaption(const AValue: string);
    procedure UpdateCaption;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CreateForm;
    procedure DestroyForm;
    procedure DoProgress;
    procedure OnProgress(APosition, AMax: Integer; ASolver: TSolver;
      var Stop: Boolean);
    property CancelClick: Boolean read FProgressForm.FCancelClick;
    property Caption: string read FCaption write SetCaption;
  end;

implementation

uses
  FMain, DMaster, DSource, MTProcs, UTTGBasics;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

{ TFProgress }

function TProgressForm.GetProgressMax: Integer;
begin
  Result := PBProgress.Max;
end;

procedure TProgressForm.DoProgress(APosition, AMax: Integer; ASolver: TSolver);
var
  t: TDateTime;
begin
  if MainForm.UpdateIndex <> FUpdateIndex then
  begin
    with MasterDataModule.ConfigStorage do
      TTimeTableModel(ASolver.Model).Configure(CruceProfesor, CruceMateria,
        CruceAulaTipo, ProfesorFraccionamiento, HoraHuecaDesubicada,
        SesionCortada, MateriaNoDispersa);
    //ASolver.Update;
    ASolver.UpdateValue;
    FUpdateIndex := MainForm.UpdateIndex;
  end;
  with ASolver, TTimeTable(BestIndividual) do
  begin
    t := Now - FInit;
    lblElapsedTime.Caption := FormatDateTime('hh:nn:ss ', t);
    PBProgress.Max := AMax;
    if APosition <> 0 then
      lblRemainingTime.Caption := FormatDateTime('hh:nn:ss ',
        t * (AMax - APosition) / APosition);
    lblPosition.Caption := Format('%d/%d', [APosition, AMax]);
    PBProgress.Position := APosition;
    lblCruceProfesor.Caption := Format('%d ', [CruceProfesor]);
    lblCruceMateria.Caption := Format('%d ', [CruceMateria]);
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
    lblCruceProfesorValor.Caption := Format('%d ', [CruceProfesorValor]);
    lblCruceMateriaValor.Caption := Format('%d ', [CruceMateriaValor]);
    lblProfesorFraccionamientoValor.Caption :=
      Format('%d ', [ProfesorFraccionamientoValor]);
    lblCruceAulaTipoValor.Caption := Format('%d ', [CruceAulaTipoValor]);
    lblHoraHuecaDesubicadaValor.Caption := Format('%d ',
      [HoraHuecaDesubicadaValor]);
    lblSesionCortadaValor.Caption := Format('%d ', [SesionCortadaValor]);
    lblMateriaProhibicionValor.Caption := Format('%d ', [MateriaProhibicionValor]);
    lblProfesorProhibicionValor.Caption := Format('%d ', [ProfesorProhibicionValor]);
    lblMateriaNoDispersaValor.Caption := Format('%d ', [MateriaNoDispersaValor]);
    lblValorTotal.Caption := Format('%d ', [Value]);
  end;
  with ASolver do
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

procedure TProgressFormDrv.SetCaption(const AValue: string);
begin
  FCaption := AValue;
  TThread.Synchronize(CurrentThread, UpdateCaption);
end;

procedure TProgressFormDrv.UpdateCaption;
begin
  FProgressForm.Caption := FCaption;
end;

constructor TProgressFormDrv.Create;
begin
  inherited Create;
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
  FProgressForm.FUpdateIndex := MainForm.UpdateIndex;
end;

procedure TProgressFormDrv.DestroyForm;
begin
  FProgressForm.Free;
end;

procedure TProgressFormDrv.DoProgress;
begin
  FProgressForm.DoProgress(FPosition, FMax, FSolver);
  {$IFNDEF THREADED}
  Application.ProcessMessages;
  {$ENDIF}
end;

procedure TProgressFormDrv.OnProgress(APosition, AMax: Integer; ASolver: TSolver;
    var Stop: Boolean);
begin
  FPosition := APosition;
  FMax := AMax;
  FSolver := ASolver;
  TThread.Synchronize(CurrentThread, DoProgress);
  with FProgressForm do
    if (CloseClick or CancelClick) then
      Stop := True;
end;

initialization
{$IFDEF FPC}
  {$i fprogress.lrs}
{$ENDIF}

end.
