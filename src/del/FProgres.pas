unit FProgres;

{$I TTG.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, Messages, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
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
    pnlNumGeneracion: TPanel;
    lblNumGeneracion: TLabel;
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
    PBNumMaxGeneracion: TProgressBar;
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
  private
    function GetNumMaxGeneracion: Integer;
    procedure SetNumMaxGeneracion(const Value: Integer);
    { Private declarations }
  public
    procedure SetValues(AElapsed: TDateTime; ANumGeneracion,
      ACruceProfesor: Integer; AProfesorFraccionamiento: Double; ACruceAulaTipo,
      AHoraHuecaDesubicada, ASesionCortada, AMateriaProhibicion,
      AProfesorProhibicion, AMateriaNoDispersa, ANumImportacion,
      ANumExportacion, ANumColision: Integer;
      ACruceProfesorValor, AProfesorFraccionamientoValor, ACruceAulaTipoValor,
      AHoraHuecaDesubicadaValor, ASesioncortadaValor, AMateriaProhibicionValor,
      AProfesorProhibicionValor, AMateriaNoDispersaValor, AValue: Double);
    { Public declarations }
    property NumMaxGeneracion: Integer read GetNumMaxGeneracion write
      SetNumMaxGeneracion;
  end;

var
  ProgressForm: TProgressForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

{ TFProgress }

function TProgressForm.GetNumMaxGeneracion: Integer;
begin
  Result := PBNumMaxGeneracion.Max;
end;

procedure TProgressForm.SetNumMaxGeneracion(const Value: Integer);
begin
  PBNumMaxGeneracion.Max := Value;
end;

procedure TProgressForm.SetValues(AElapsed: TDateTime; ANumGeneracion,
  ACruceProfesor: Integer; AProfesorFraccionamiento: Double; ACruceAulaTipo,
  AHoraHuecaDesubicada, ASesionCortada, AMateriaProhibicion,
  AProfesorProhibicion, AMateriaNoDispersa, ANumImportacion, ANumExportacion,
  ANumColision: Integer;
  ACruceProfesorValor, AProfesorFraccionamientoValor, ACruceAulaTipoValor,
  AHoraHuecaDesubicadaValor, ASesioncortadaValor, AMateriaProhibicionValor,
  AProfesorProhibicionValor, AMateriaNoDispersaValor, AValue: Double);
begin
  lblElapsedTime.Caption := FormatDateTime('hh:nn:ss' + ' ', AElapsed);
  lblNumGeneracion.Caption := Format('%d ', [ANumGeneracion]);
  with PBNumMaxGeneracion do
  begin
    Position := ANumGeneracion;
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
  lblMateriaProhibicionValor.Caption := Format('%8.2f ',
    [AMateriaProhibicionValor]);
  lblProfesorProhibicionValor.Caption := Format('%8.2f ',
    [AProfesorProhibicionValor]);
  lblMateriaNoDispersaValor.Caption := Format('%8.2f ',
    [AMateriaNoDispersaValor]);
  lblValorTotal.Caption := Format('%8.2f ', [AValue]);
  lblImportaciones.Caption := Format('%d ', [ANumImportacion]);
  lblExportaciones.Caption := Format('%d ', [ANumExportacion]);
  lblColisiones.Caption := Format('%d ', [ANumColision]);
end;

initialization
{$IFDEF FPC}
  {$i FProgres.lrs}
{$ENDIF}

end.
