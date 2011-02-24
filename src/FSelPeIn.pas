unit FSelPeIn;

{$I TTG.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, Messages, SysUtils, Classes, Forms,
  Graphics, Controls, Dialogs, Db, StdCtrls, Buttons, ExtCtrls, ZConnection, ZDataset,
  ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, DBCtrls, DMaster, DSource;

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

initialization
{$IFDEF FPC}
  {$i FSelPeIn.lrs}
{$ENDIF}

end.
