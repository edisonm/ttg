unit FSelPeIn;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, Classes, SysUtils, FileUtil,
  Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons, DbCtrls, DSource;

type

  { TSelPeriodoForm }

  TSelPeriodoForm = class(TForm)
    BBAceptar: TBitBtn;
    BBCancelar: TBitBtn;
    CBDia: TDBLookupComboBox;
    CBHora: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    class function SeleccionarPeriodo(var ACodDia, ACodHora: Integer): Boolean;
  end;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

{ TSelPeriodoForm }

class function TSelPeriodoForm.SeleccionarPeriodo(var ACodDia, ACodHora: Integer): Boolean;
var
  FSelPeriodoForm: TSelPeriodoForm;
begin
  FSelPeriodoForm := TSelPeriodoForm.Create(Application);
  try
    Result := FSelPeriodoForm.ShowModal = mrOk;
    if Result then
    begin
      with FSelPeriodoForm do
      begin
        ACodDia := CbDia.ListSource.DataSet.FindField('CodDia').AsInteger;
        ACodHora := CbHora.ListSource.DataSet.FindField('CodHora').AsInteger;
      end;
    end;
  finally
    FSelPeriodoForm.Release;
  end;
end;

procedure TSelPeriodoForm.FormCreate(Sender: TObject);
begin

end;

initialization

{$IFDEF FPC}
  {$I FSelPeIn.lrs}
{$ENDIF}

end.

