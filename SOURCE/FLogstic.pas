unit FLogstic;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;
(*
  FormStorage:
  memResumen.Height
*)

type
  TLogisticForm = class(TForm)
    memLogistic: TMemo;
    Panel2: TPanel;
    bbtnClose: TBitBtn;
    lblMsg: TLabel;
    memResumen: TMemo;
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

{$R *.DFM}

end.
