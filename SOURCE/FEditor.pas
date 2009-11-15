unit FEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Mask, DBCtrls, Grids, DBGrids, Buttons,
  ExtCtrls, DBBBtn, Placemnt, DBIndex, ComCtrls, RXCtrls, RXDBCtrl, TB97,
  TB97Tlbr, TB97Ctls, DB97Btn, RXSplit, CDBFmlry, DBFmlry;

type
  TEditorForm = class(TForm)
    pnlStatus: TPanel;
    FormStorage: TFormStorage;
    do97Top: TDock97;
    tb97Navigation: TToolbar97;
    do97Right: TDock97;
    do97Bottom: TDock97;
    do97Left: TDock97;
    tb97Edit: TToolbar97;
    tb97Show: TToolbar97;
    btn97Show: TToolbarButton97;
    Panel1: TPanel;
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

