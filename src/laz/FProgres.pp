unit FProgres;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, KerModel;

type

  { TProgressForm }

  TProgressForm = class(TForm)
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
    Panel5: TPanel;
    lblImportaciones: TLabel;
    Panel6: TPanel;
    lblExportaciones: TLabel;
    Panel4: TPanel;
    lblColisiones: TLabel;
    pnlPosition: TPanel;
    lblPosition: TLabel;
    procedure bbtnCancelClick(Sender: TObject);
    procedure bbtnCloseClick(Sender: TObject);
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
      AMateriaNoDispersa, ANumImportacion, ANumExportacion, ANumColision: Integer;
      ACruceProfesorValor, AProfesorFraccionamientoValor, ACruceAulaTipoValor,
      AHoraHuecaDesubicadaValor, ASesioncortadaValor, AMateriaProhibicionValor,
      AProfesorProhibicionValor, AMateriaNoDispersaValor, AValue: Double);
    { Public declarations }
    procedure ShowProgressForm;
    procedure CloseProgressForm;
    property CloseClick: Boolean read FCloseClick write FCloseClick;
    property CancelClick: Boolean read FCancelClick write FCancelClick;
    property ProgressMax: Integer read GetProgressMax write SetProgressMax;
    procedure OnProgress(Position, Step: Integer; Sender: TTimeTable;
      var Stop: Boolean);
  end;

var
  ProgressForm: TProgressForm;

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
  Sender: TTimeTable; var Stop: Boolean);
begin
  with Sender do
  begin
    if Position mod Step = 0 then
    begin
      Application.ProcessMessages;
      ProgressForm.SetValues(Position,
                             CruceProfesor,
                             ProfesorFraccionamiento,
                             CruceAulaTipo,
                             HoraHuecaDesubicada,
                             SesionCortada,
                             MateriaProhibicion,
                             ProfesorProhibicion,
                             MateriaNoDispersa,
                             0, //NumImportacion,
                             0, //NumExportacion,
                             0, //NumColision,
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
	        TimeTableModel.Configurar(CruceProfesor,
                                   ProfesorFraccionamiento,
                                   CruceAulaTipo,
                                   HoraHueca,
                                   SesionCortada,
                                   MateriaNoDispersa);
        FAjustar := False;
      end;
      }
      if (ProgressForm.CloseClick or ProgressForm.CancelClick) then
        Stop := True;
    end;
  end;
end;

procedure TProgressForm.SetProgressMax(const Value: Integer);
begin
  PBProgress.Max := Value;
end;

procedure TProgressForm.SetValues(APosition, ACruceProfesor: Integer;
  AProfesorFraccionamiento: Double; ACruceAulaTipo, AHoraHuecaDesubicada,
  ASesionCortada, AMateriaProhibicion, AProfesorProhibicion, AMateriaNoDispersa,
  ANumImportacion, ANumExportacion, ANumColision: Integer; ACruceProfesorValor,
  AProfesorFraccionamientoValor, ACruceAulaTipoValor, AHoraHuecaDesubicadaValor,
  ASesioncortadaValor, AMateriaProhibicionValor, AProfesorProhibicionValor,
  AMateriaNoDispersaValor, AValue: Double);
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
  lblImportaciones.Caption := Format('%d ', [ANumImportacion]);
  lblExportaciones.Caption := Format('%d ', [ANumExportacion]);
  lblColisiones.Caption := Format('%d ', [ANumColision]);
end;


procedure TProgressForm.ShowProgressForm;
begin
  // HelpContext := ActElaborarHorario.HelpContext;
  FInit := Now;
  lblInit.Caption := FormatDateTime(Format('%s %s ', [ShortDateFormat,
    LongTimeFormat]), FInit);
  FCloseClick := False;
  FCancelClick := False;
  Show;
  Application.ProcessMessages;
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

procedure TProgressForm.CloseProgressForm;
begin
  ProgressForm.Close;
end;

initialization
{$IFDEF FPC}
  {$i FProgres.lrs}
{$ENDIF}

end.
