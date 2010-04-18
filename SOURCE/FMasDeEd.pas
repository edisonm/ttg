unit FMasDeEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, StdCtrls,
  DBIndex, Buttons, DBCtrls, ExtCtrls, ImgList, ComCtrls, ToolWin,
  ActnList;

type
  TMasterDetailEditorForm = class(TSingleEditorForm)
    DataSourceDetail: TDataSource;
    DBGridDetail: TDBGrid;
    Splitter1: TSplitter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnShowClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetDataSetDetail(ADataSetDetail: TDataSet);
  protected
    procedure doLoadConfig; override;
    procedure doSaveConfig; override;
  public
    { Public declarations }
    class function ToggleMasterDetailEditor(var AForm;
                                            AConfigStrings: TStrings;
                                            AAction: TAction;
                                            ADataSet, ADataSetDetail: TDataSet): Boolean;
    property DataSetDetail: TDataSet write SetDataSetDetail;
  end;

var
  MasterDetailEditorForm: TMasterDetailEditorForm;

implementation
uses
  QMaDeRep, Printers, FMain;
{$R *.DFM}

class function TMasterDetailEditorForm.ToggleMasterDetailEditor(var AForm;
                                                                AConfigStrings: TStrings;
                                                                AAction: TAction;
                                                                ADataSet, ADataSetDetail: TDataSet): Boolean;
begin
   Result := ToggleSingleEditor(AForm, AConfigStrings, AAction, ADataSet);
   if Result then
   begin
      TMasterDetailEditorForm(AForm).DataSetDetail := ADataSetDetail;
   end;
end;

procedure TMasterDetailEditorForm.SetDataSetDetail(ADataSetDetail: TDataSet);
begin
  DataSourceDetail.DataSet := ADataSetDetail;
end;

procedure TMasterDetailEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DataSourceDetail.DataSet := nil;
  inherited;
end;

procedure TMasterDetailEditorForm.BtnShowClick(Sender: TObject);
begin
  PreviewMasterDetailReport(DataSource.DataSet, DataSourceDetail.DataSet,
    '', '', '', SuperTitle, Caption, poPortrait, MainForm.PrepareReport);
end;

procedure TMasterDetailEditorForm.doLoadConfig;
begin
  inherited;
  DBGridDetail.Height := ConfigIntegers['DBGridDetail_Height'];
end;

procedure TMasterDetailEditorForm.doSaveConfig;
begin
  inherited;
  ConfigIntegers['DBGridDetail_Height'] := DBGridDetail.Height;
end;

end.
