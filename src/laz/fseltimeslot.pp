{ -*- mode: Delphi -*- }
unit FSelTimeSlot;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, Classes, SysUtils, FileUtil,
  Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons, DbCtrls, DSource;

type

  { TSelTimeSlotForm }

  TSelTimeSlotForm = class(TForm)
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
    class function SeleccionarTimeSlot(out AIdDay, AIdHour: Integer): Boolean;
  end;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

{ TSelTimeSlotForm }

class function TSelTimeSlotForm.SeleccionarTimeSlot(out AIdDay, AIdHour: Integer): Boolean;
var
  FSelTimeSlotForm: TSelTimeSlotForm;
begin
  FSelTimeSlotForm := TSelTimeSlotForm.Create(Application);
  try
    Result := FSelTimeSlotForm.ShowModal = mrOk;
    if Result then
    begin
      with FSelTimeSlotForm do
      begin
        AIdDay := CbDay.ListSource.DataSet.FindField('IdDay').AsInteger;
        AIdHour := CbHour.ListSource.DataSet.FindField('IdHour').AsInteger;
      end;
    end;
  finally
    FSelTimeSlotForm.Release;
  end;
end;

initialization

{$IFDEF FPC}
  {$I fseltimeslot.lrs}
{$ENDIF}

end.

