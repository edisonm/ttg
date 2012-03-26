{ -*- mode: Delphi -*- }
unit FMessageView;

{$I ttg.inc}

interface

uses
  LResources, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  Buttons, ExtCtrls;

type

  { TMessageViewForm }

  TMessageViewForm = class(TForm)
    MemLog: TMemo;
    MemSummary: TMemo;
    Panel2: TPanel;
    BBClose: TBitBtn;
    LbMessage: TLabel;
    Panel1: TPanel;
    Splitter1: TSplitter;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MessageViewForm: TMessageViewForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

initialization
{$IFDEF FPC}
  {$i FMessageView.lrs}
{$ENDIF}

end.
