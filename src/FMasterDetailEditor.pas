{ -*- mode: Delphi -*- }
unit FMasterDetailEditor;

{$I ttg.inc}

interface

uses
  LResources, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db, Grids,
  FSingleEditor, DBGrids, Buttons, UConfigStorage, DBCtrls, ExtCtrls, ActnList,
  StdCtrls, ComCtrls, ZDataset;

type

  { TMasterDetailEditorForm }

  TMasterDetailEditorForm = class(TSingleEditorForm)
    DataSourceDetail: TDataSource;
    DBGridDetail: TDBGrid;
    GrBDetail: TGroupBox;
    PnDetail: TPanel;
    Splitter1: TSplitter;
    procedure ActFindExecute(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var AAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure SetDataSetDetail(ADataSetDetail: TDataSet);
  protected
    procedure doLoadConfig; override;
    procedure doSaveConfig; override;
  public
    { Public declarations }
    class function ToggleMasterDetailEditor(AOwner: TComponent;
                                            var AForm;
                                            AConfigStorage: TConfigStorage;
                                            AAction: TAction;
                                            ADataSet, ADataSetDetail: TDataSet): Boolean;
    property DataSetDetail: TDataSet write SetDataSetDetail;
  end;

var
  MasterDetailEditorForm: TMasterDetailEditorForm;

implementation

class function TMasterDetailEditorForm.ToggleMasterDetailEditor(AOwner: TComponent;
                                                                var AForm;
                                                                AConfigStorage: TConfigStorage;
                                                                AAction: TAction;
                                                                ADataSet, ADataSetDetail: TDataSet): Boolean;
begin
   Result := ToggleSingleEditor(AOwner, AForm, AConfigStorage, AAction, ADataSet);
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
  var AAction: TCloseAction);
begin
  DataSourceDetail.DataSet := nil;
  inherited;
end;

procedure TMasterDetailEditorForm.ActFindExecute(Sender: TObject);
begin
  inherited;
end;

procedure TMasterDetailEditorForm.DataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
end;

procedure TMasterDetailEditorForm.DataSourceStateChange(Sender: TObject);
begin
  inherited;
end;

procedure TMasterDetailEditorForm.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TMasterDetailEditorForm.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
  inherited;
end;

procedure TMasterDetailEditorForm.FormDestroy(Sender: TObject);
begin
  inherited;
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

initialization

{$I FMasterDetailEditor.lrs}

end.
