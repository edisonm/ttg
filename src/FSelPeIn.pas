unit FSelPeIn;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Buttons, ExtCtrls, kbmMemTable, DBCtrls,
  DMaster, DSource;

type
  TSelPeriodoForm = class(TForm)
    TbDiaHora: TkbmMemTable;
    DSDiaHora: TDataSource;
    TbDiaHoraCodDia: TIntegerField;
    TbDiaHoraCodHora: TIntegerField;
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

end.
