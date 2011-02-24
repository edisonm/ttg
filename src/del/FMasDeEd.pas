unit FMasDeEd;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, FSingEdt, Db, Grids, DBGrids, UConfig, Buttons,
  DBCtrls, ExtCtrls, ComCtrls, ActnList, ImgList, ToolWin, StdCtrls;

type
  TMasterDetailEditorForm = class(TSingleEditorForm)
    DataSourceDetail: TDataSource;
    DBGridDetail: TDBGrid;
    Splitter1: TSplitter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
uses
  Printers;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

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
  var Action: TCloseAction);
begin
  DataSourceDetail.DataSet := nil;
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
{$IFDEF FPC}
  {$i FMasDeEd.lrs}
{$ENDIF}

end.
