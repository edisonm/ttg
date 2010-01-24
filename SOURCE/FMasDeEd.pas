unit FMasDeEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, RXCtrls, RXDBCtrl, StdCtrls,
  DBIndex, Buttons, DBBBtn, DBCtrls, ExtCtrls, RXSplit, ImgList, ComCtrls, ToolWin;

type
  TMasterDetailEditorForm = class(TSingleEditorForm)
    DataSourceDetail: TDataSource;
    DBGridDetail: TRxDBGrid;
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
  DBBtnCmn, QMaDeRep, Printers, FMain;
{$R *.DFM}

procedure TMasterDetailEditorForm.DBGridEnter(Sender: TObject);
begin
  inherited;
  SLState.DataSource := (Sender as TRxDBGrid).DataSource;
  SLRecordNo.DataSource := (Sender as TRxDBGrid).DataSource;
end;

procedure TMasterDetailEditorForm.btn97ShowClick(Sender: TObject);
begin
  PreviewMasterDetailReport(DataSource.DataSet, DataSourceDetail.DataSet,
    '', '', '', SuperTitle, Caption, poPortrait, MainForm.PrepareReport);
end;

end.

