{ -*- mode: Delphi -*- }
unit FSelPeriod;

{$I ttg.inc}

interface

uses
  LResources, Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, DbCtrls, DSource;

type

  { TSelPeriodForm }

  TSelPeriodForm = class(TForm)
    bbtAceptar: TBitBtn;
    BBCancel: TBitBtn;
    CBDay: TDBLookupComboBox;
    CBHour: TDBLookupComboBox;
    LbPeriod: TLabel;
    LbDay: TLabel;
    LbHour: TLabel;
  private
    { private declarations }
  public
    { public declarations }
    class function SeleccionarPeriod(out AIdDay, AIdHour: Integer): Boolean;
  end;

implementation

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

{$I FSelPeriod.lrs}

end.
