unit FLogstic;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TLogisticForm = class(TForm)
    MemLogistic: TMemo;
    Panel2: TPanel;
    bbtnClose: TBitBtn;
    lblMsg: TLabel;
    MemResumen: TMemo;
    Panel1: TPanel;
    Splitter1: TSplitter;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LogisticForm: TLogisticForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

initialization
{$IFDEF FPC}
  {$i FLogstic.lrs}
{$ENDIF}

end.
