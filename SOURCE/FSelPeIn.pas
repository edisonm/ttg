unit FSelPeIn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Buttons, ExtCtrls, CDBFmlry, DBFmlry, kbmMemTable;

type
  TSelPeriodoForm = class(TForm)
    rxmDiaHora: TkbmMemTable;
    DSDiaHora: TDataSource;
    rxmDiaHoraCodDia: TIntegerField;
    rxmDiaHoraCodHora: TIntegerField;
    rxmDiaHoraNomDia: TStringField;
    rxmDiaHoraNomHora: TStringField;
    DBFormulary1: TDBFormulary;
    BBAceptar: TBitBtn;
    BBCancelar: TBitBtn;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function SeleccionarPeriodo(var ACodDia, ACodHora: Integer): Boolean;

implementation

uses DMaster;
{$R *.DFM}

function SeleccionarPeriodo(var ACodDia, ACodHora: Integer): Boolean;
var
  FSelPeriodoForm: TSelPeriodoForm;
begin
  FSelPeriodoForm := TSelPeriodoForm.Create(Application);
  try
    Result := FSelPeriodoForm.ShowModal = mrOk;
    if Result then
    begin
      ACodDia := FSelPeriodoForm.rxmDiaHoraCodDia.Value;
      ACodHora := FSelPeriodoForm.rxmDiaHoraCodHora.Value;
    end;
  finally
    FSelPeriodoForm.Release;
  end;
end;

procedure TSelPeriodoForm.FormShow(Sender: TObject);
begin
  rxmDiaHora.Open;
end;

end.

