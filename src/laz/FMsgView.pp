unit FMsgView;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, Messages, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TMessageViewForm = class(TForm)
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
  MessageViewForm: TMessageViewForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

initialization
{$IFDEF FPC}
  {$i FMsgView.lrs}
{$ENDIF}

end.
