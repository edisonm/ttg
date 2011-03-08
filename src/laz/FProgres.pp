unit FProgres;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, UIndivid,
  KerModel, KerEvolE;

type

  { TProgressForm }

  TProgressForm = class(TForm)
    lblColision: TLabel;
    lblExports: TLabel;
    lblImports: TLabel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
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
    procedure SetValues(APosition, ACruceProfesor: Integer;
      AProfesorFraccionamiento: Double; ACruceAulaTipo, AHoraHuecaDesubicada,
      ASesionCortada, AMateriaProhibicion, AProfesorProhibicion,
      AMateriaNoDispersa: Integer;
      ACruceProfesorValor, AProfesorFraccionamientoValor, ACruceAulaTipoValor,
      AHoraHuecaDesubicadaValor, ASesioncortadaValor, AMateriaProhibicionValor,
      AProfesorProhibicionValor, AMateriaNoDispersaValor, AValue: Double);
    { Public declarations }
    property CloseClick: Boolean read FCloseClick write FCloseClick;
    property CancelClick: Boolean read FCancelClick write FCancelClick;
    property ProgressMax: Integer read GetProgressMax write SetProgressMax;
    procedure OnProgress(Position, Step: Integer; Solver: TSolver;
      var Stop: Boolean);
    procedure OnPollinate(EvolElitist: TEvolElitist);
  end;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

{ TFProgress }

function TProgressForm.GetProgressMax: Integer;
begin
  Result := PBProgress.Max;
end;

procedure TProgressForm.OnProgress(Position, Step: Integer;
  Solver: TSolver; var Stop: Boolean);
begin
  with Solver, BestIndividual do
  begin
    if Position mod Step = 0 then
    begin
      SetValues(Position,
                CruceProfesor,
                ProfesorFraccionamiento,
                CruceAulaTipo,
                HoraHuecaDesubicada,
                SesionCortada,
                MateriaProhibicion,
                ProfesorProhibicion,
                MateriaNoDispersa,
                CruceProfesorValor,
                ProfesorFraccionamientoValor,
                CruceAulaTipoValor,
                HoraHuecaDesubicadaValor,
                SesionCortadaValor,
                MateriaProhibicionValor,
                ProfesorProhibicionValor,
                MateriaNoDispersaValor,
                Value);
      {
      if FAjustar then
      begin
        InvalidarValores;
      	// Update;
        with SourceDataModule do
	        TimeTableModel.Configure(CruceProfesor,
                                   ProfesorFraccionamiento,
                                   CruceAulaTipo,
                                   HoraHueca,
                                   SesionCortada,
                                   MateriaNoDispersa);
        FAjustar := False;
      end;
      }
      if Solver is TEvolElitist then
      begin
        lblImports.Caption := Format('%d ', [TEvolElitist(Solver).NumImports]);
        lblExports.Caption := Format('%d ', [TEvolElitist(Solver).NumExports]);
        lblColision.Caption := Format('%d ', [TEvolElitist(Solver).NumColision]);
      end;
      if (CloseClick or CancelClick) then
        Stop := True;
      Application.ProcessMessages;
    end;
  end;
end;

procedure TProgressForm.OnPollinate(EvolElitist: TEvolElitist);
begin
  with EvolElitist do
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

procedure TProgressForm.SetValues(APosition, ACruceProfesor: Integer;
  AProfesorFraccionamiento: Double; ACruceAulaTipo, AHoraHuecaDesubicada,
  ASesionCortada, AMateriaProhibicion, AProfesorProhibicion,
  AMateriaNoDispersa: Integer; ACruceProfesorValor, AProfesorFraccionamientoValor,
  ACruceAulaTipoValor, AHoraHuecaDesubicadaValor, ASesioncortadaValor,
  AMateriaProhibicionValor, AProfesorProhibicionValor, AMateriaNoDispersaValor,
  AValue: Double);
var
  t: TDateTime;
begin
  t := Now - FInit;
  lblElapsedTime.Caption := FormatDateTime('hh:nn:ss ', t);
  if APosition <> 0 then
    lblRemainingTime.Caption := FormatDateTime('hh:nn:ss ',
      t * (PBProgress.Max - APosition) / APosition);
  lblPosition.Caption := Format('%d ', [APosition]);
  with PBProgress do
  begin
    Position := APosition;
    Hint := Format('%d de %d', [Position, Max]);
  end;
  lblCruceProfesor.Caption := Format('%d ', [ACruceProfesor]);
  lblProfesorFraccionamiento.Caption :=
    Format('%f ', [AProfesorFraccionamiento]);
  lblCruceAulaTipo.Caption := Format('%d ', [ACruceAulaTipo]);
  lblHoraHuecaDesubicada.Caption := Format('%d ', [AHoraHuecaDesubicada]);
  lblSesionCortada.Caption := Format('%d ', [ASesionCortada]);
  lblMateriaProhibicion.Caption := Format('%d ', [AMateriaProhibicion]);
  lblProfesorProhibicion.Caption := Format('%d ', [AProfesorProhibicion]);
  lblMateriaNoDispersa.Caption := Format('%d ', [AMateriaNoDispersa]);
  lblCruceProfesorValor.Caption := Format('%8.2f ', [ACruceProfesorValor]);
  lblProfesorFraccionamientoValor.Caption :=
    Format('%8.2f ', [AProfesorFraccionamientoValor]);
  lblCruceAulaTipoValor.Caption := Format('%8.2f ', [ACruceAulaTipoValor]);
  lblHoraHuecaDesubicadaValor.Caption := Format('%8.2f ',
    [AHoraHuecaDesubicadaValor]);
  lblSesionCortadaValor.Caption := Format('%8.2f ', [ASesionCortadaValor]);
  lblMateriaProhibicionValor.Caption := Format('%8.2f ', [AMateriaProhibicionValor]);
  lblProfesorProhibicionValor.Caption := Format('%8.2f ', [AProfesorProhibicionValor]);
  lblMateriaNoDispersaValor.Caption := Format('%8.2f ', [AMateriaNoDispersaValor]);
  lblValorTotal.Caption := Format('%8.2f ', [AValue]);
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

initialization
{$IFDEF FPC}
  {$i FProgres.lrs}
{$ENDIF}

end.
