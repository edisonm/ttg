unit FSelPeIn;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Buttons, ExtCtrls, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset, DBCtrls,
  DMaster, DSource;

type
  TSelPeriodoForm = class(TForm)
    BBAceptar: TBitBtn;
    BBCancelar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    CbDia: TDBLookupComboBox;
    Label3: TLabel;
    CbHora: TDBLookupComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function SeleccionarPeriodo(var ACodDia, ACodHora: Integer): Boolean;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

function SeleccionarPeriodo(var ACodDia, ACodHora: Integer): Boolean;
var
  FSelPeriodoForm: TSelPeriodoForm;
begin
  FSelPeriodoForm := TSelPeriodoForm.Create(Application);
  try
    Result := FSelPeriodoForm.ShowModal = mrOk;
    if Result then
    begin
      ACodDia := FSelPeriodoForm.CbDia.KeyValue;
      ACodHora := FSelPeriodoForm.CbHora.KeyValue;
    end;
  finally
    FSelPeriodoForm.Release;
  end;
end;

initialization
{$IFDEF FPC}
  {$i FSelPeIn.lrs}
{$ENDIF}

end.
