unit FMasDeEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, StdCtrls,
  DBIndex, Buttons, DBCtrls, ExtCtrls, ImgList, ComCtrls, ToolWin;
(*
  FormStorage:
  DBGridDetail.Height
*)

type
  TMasterDetailEditorForm = class(TSingleEditorForm)
    DataSourceDetail: TDataSource;
    DBGridDetail: TDBGrid;
    Splitter1: TSplitter;
    procedure DBGridEnter(Sender: TObject);
    procedure btn97ShowClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MasterDetailEditorForm: TMasterDetailEditorForm;

implementation
uses
  Printers, FMain;
{$R *.DFM}

procedure TMasterDetailEditorForm.DBGridEnter(Sender: TObject);
begin
  inherited;
  //SLState.DataSource := (Sender as TDBGrid).DataSource;
  //SLRecordNo.DataSource := (Sender as TDBGrid).DataSource;
end;

procedure TMasterDetailEditorForm.btn97ShowClick(Sender: TObject);
begin
(*
  PreviewMasterDetailReport(DataSource.DataSet, DataSourceDetail.DataSet,
    '', '', '', SuperTitle, Caption, poPortrait, MainForm.PrepareReport);
*)
end;

end.

