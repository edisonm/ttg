unit FMessageView;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls;

type

  { TMessageViewForm }

  TMessageViewForm = class(TForm)
    MemLog: TMemo;
    MemSummary: TMemo;
    Panel2: TPanel;
    bbtnClose: TBitBtn;
    lblMsg: TLabel;
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
  {$i fmessageview.lrs}
{$ENDIF}

end.
