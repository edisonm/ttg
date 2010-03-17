unit FEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Mask, DBCtrls, Grids, DBGrids, Buttons, ExtCtrls, DBIndex,
  ComCtrls, ImgList, ToolWin;

type
  TEditorForm = class(TForm)
    pnlStatus: TPanel;
    tb97Show: TToolBar;
    btn97Show: TToolButton;
    Panel1: TPanel;
    ImageList: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FSuperTitle: string;
  protected
    property SuperTitle: string read FSuperTitle;
  public
    { Public declarations }
  end;

implementation

uses
  QSingRep, Printers;
{$R *.DFM}

procedure TEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

