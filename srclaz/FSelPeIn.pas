unit FSelPeIn;

{$I TTG.inc}

interface

uses
  LResources, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Buttons, ExtCtrls, Sqlite3DS, DBCtrls,
  DMaster, DSource;

type
  TSelPeriodoForm = class(TForm)
    TbDiaHora: TSqlite3Dataset;
    DSDiaHora: TDataSource;
    TbDiaHoraCodDia: TLongIntField;
    TbDiaHoraCodHora: TLongIntField;
    TbDiaHoraNomDia: TStringField;
    TbDiaHoraNomHora: TStringField;
    BBAceptar: TBitBtn;
    BBCancelar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    Label3: TLabel;
    DBLookupComboBox2: TDBLookupComboBox;
    procedure FormShow(Sender: TObject);
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
      ACodDia := FSelPeriodoForm.TbDiaHoraCodDia.Value;
      ACodHora := FSelPeriodoForm.TbDiaHoraCodHora.Value;
    end;
  finally
    FSelPeriodoForm.Release;
  end;
end;

procedure TSelPeriodoForm.FormShow(Sender: TObject);
begin
  TbDiaHora.Open;
end;

initialization
{$IFDEF FPC}
  {$i FSelPeIn.lrs}
{$ENDIF}

end.
