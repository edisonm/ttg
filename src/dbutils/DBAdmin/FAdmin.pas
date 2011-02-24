unit FAdmin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ToolWin, ComCtrls, MenuBar, ExtCtrls, DBCtrls, Grids, DBGrids,
  StdCtrls, Db, kbmMemTable;

type
  TAdminForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
    N1: TMenuItem;
    Salir1: TMenuItem;
    ControlBar1: TControlBar;
    MenuBar1: TMenuBar;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    ComboBox1: TComboBox;
    Label1: TLabel;
    DataSource1: TDataSource;
    Abrir1: TMenuItem;
    Guardarcomo1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure Guardarcomo1Click(Sender: TObject);
  private
    function DataSetByName(const AName: string): TDataSet;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AdminForm: TAdminForm;

implementation

uses DAdmin;

{$R *.DFM}

procedure TAdminForm.ComboBox1Change(Sender: TObject);
begin
  DataSource1.DataSet := DataSetByName(ComboBox1.Text);
  DataSource1.DataSet.Open;
end;

function TAdminForm.DataSetByName(const AName: string): TDataSet;
var
  i: Integer;
begin
  with AdminDM do
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      if Components[i] is TDataSet then
      begin
        if TDataSet(Components[i]).Name = AName then
        begin
          result := TDataSet(Components[i]);
          exit;
        end;
      end;
    end;
    result := nil;
  end;
end;

procedure TAdminForm.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  with ComboBox1.Items do
  begin
    Clear;
    with AdminDM do
    begin
      for i := 0 to ComponentCount - 1 do
      begin
        if Components[i] is TDataSet then
        begin
          Add(TDataSet(Components[i]).Name);
        end;
      end;
    end;
  end;
end;

procedure TAdminForm.Salir1Click(Sender: TObject);
begin
  Close;
end;

procedure TAdminForm.Abrir1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    AdminDM.LoadFromBinaryFile(OpenDialog1.FileName);
  end;
end;

procedure TAdminForm.Guardarcomo1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    AdminDM.SaveToBinaryFile(SaveDialog1.FileName, [mtfSaveData, mtfSaveBlobs]);
  end;
end;

end.

