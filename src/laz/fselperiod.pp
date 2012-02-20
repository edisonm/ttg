{ -*- mode: Delphi -*- }
unit FSelPeriod;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, Classes, SysUtils, FileUtil,
  Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons, DbCtrls, DSource;

type

  { TSelPeriodForm }

  TSelPeriodForm = class(TForm)
    bbtAceptar: TBitBtn;
    BBCancel: TBitBtn;
    CBDay: TDBLookupComboBox;
    CBHour: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
  private
    { private declarations }
  public
    { public declarations }
    class function SeleccionarPeriod(out AIdDay, AIdHour: Integer): Boolean;
  end;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

{ TSelPeriodForm }

class function TSelPeriodForm.SeleccionarPeriod(out AIdDay, AIdHour: Integer): Boolean;
var
  FSelPeriodForm: TSelPeriodForm;
begin
  FSelPeriodForm := TSelPeriodForm.Create(Application);
  try
    Result := FSelPeriodForm.ShowModal = mrOk;
    if Result then
    begin
      with FSelPeriodForm do
      begin
        AIdDay := CbDay.ListSource.DataSet.FindField('IdDay').AsInteger;
        AIdHour := CbHour.ListSource.DataSet.FindField('IdHour').AsInteger;
      end;
    end;
  finally
    FSelPeriodForm.Release;
  end;
end;

initialization

{$IFDEF FPC}
  {$I fselperiod.lrs}
{$ENDIF}

end.

