unit FLogstic;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Placemnt, RXSplit;

type
  TLogisticForm = class(TForm)
    memLogistic: TMemo;
    Panel2: TPanel;
    bbtnClose: TBitBtn;
    lblMsg: TLabel;
    FormStorage: TFormStorage;
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
