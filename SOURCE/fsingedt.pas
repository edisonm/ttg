unit FSingEdt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Mask, DBCtrls, Grids, DBGrids, Buttons,
  ExtCtrls, DBBBtn, Placemnt, DBIndex, ComCtrls, RXCtrls, RXDBCtrl, TB97,
  TB97Tlbr, TB97Ctls, DB97Btn, RXSplit, CDBFmlry, DBFmlry, FEditor, kbmMemTable;

type
  TSingleEditorForm = class(TEditorForm)
    DBNavigator: TDBNavigator;
    DataSource: TDataSource;
    SLRecordNo: TDBStatusLabel;
    SLState: TDBStatusLabel;
    DBGrid: TRxDBGrid;
    btn97Find: TDBToolbarButton97;
    RxSplitter1: TRxSplitter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn97FindClick(Sender: TObject);
    procedure btn97ShowClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBGridCheckButton(Sender: TObject; ACol: Integer;
      Field: TField; var Enabled: Boolean);
    procedure DBGridGetBtnParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; var SortMarker: TSortMarker;
      IsDown: Boolean);
    procedure DBGridTitleBtnClick(Sender: TObject; ACol: Integer;
      Field: TField);
    procedure DBGridDblClick(Sender: TObject);
  private
    { Private declarations }
    FSuperTitle: string;
  protected
    property SuperTitle: string read FSuperTitle;
  public
    { Public declarations }
    procedure ShowEditor(ADataSet: TDataSet; const ASuperTitle: string);
  end;

implementation

uses
  HorColCm, QSingRep, Printers, FMain, DMaster;
{$R *.DFM}

procedure TSingleEditorForm.ShowEditor(ADataSet: TDataSet; const ASuperTitle:
  string);
begin
  with DataSource do
  try
    DataSet := ADataSet;
    FSuperTitle := ASuperTitle;
  except
    Close;
    raise;
  end;
end;

procedure TSingleEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with DataSource do
  begin
    //if Assigned(DataSet) then DataSet.Close;
    DataSet := nil;
  end;
  inherited;
end;

procedure TSingleEditorForm.btn97FindClick(Sender: TObject);
begin
  SearchInDBGrid(DBGrid);
end;

procedure TSingleEditorForm.btn97ShowClick(Sender: TObject);
begin
  PreviewSingleReport(DataSource.DataSet, '', '', SuperTitle, Caption,
    poPortrait, MainForm.PrepareReport);
end;

procedure TSingleEditorForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  with DataSource do
    CanClose := not (Assigned(DataSet) and (DataSet.State in dsEditModes));
end;

procedure TSingleEditorForm.DBGridCheckButton(Sender: TObject;
  ACol: Integer; Field: TField; var Enabled: Boolean);
begin
  inherited;
  Enabled := (TRxDBGrid(Sender).DataSource.DataSet is TKbmMemTable) and
    (Field <> nil) and not (Field is TBlobField) and
    (TKbmMemTable(TRxDBGrid(Sender).DataSource.DataSet).IndexDefs.Count > 0);
end;

procedure TSingleEditorForm.DBGridGetBtnParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor;
  var SortMarker: TSortMarker; IsDown: Boolean);
begin
  inherited;
  if (TRxDBGrid(Sender).DataSource.DataSet is TKbmMemTable) and (Field <> nil) and
    ((Field.IsIndexField) or ((Field.FieldKind = fkLookup)
    and(TRxDBGrid(Sender).DataSource.DataSet.FindField(Field.KeyFields).IsIndexField))) then
  begin
    SortMarker := smDown;
  end;
end;

procedure TSingleEditorForm.DBGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Field: TField);
begin
  inherited;
  if TRxDBGrid(Sender).DataSource.DataSet is TKbmMemTable then
    with TKbmMemTable(TRxDBGrid(Sender).DataSource.DataSet) do
    try
      if Field.FieldKind = fkLookup then
        IndexFieldNames :=IndexDefs.FindIndexForFields(FindField(Field.KeyFields).FieldName).Fields
      else
       IndexFieldNames := IndexDefs.FindIndexForFields(Field.FieldName).Fields;
    except
      IndexFieldNames := '';
    end;
end;

procedure TSingleEditorForm.DBGridDblClick(Sender: TObject);
begin
  inherited;
  if TRxDBGrid(Sender).DataSource.DataSet is TKbmMemTable then
    with TKbmMemTable(TRxDBGrid(Sender).DataSource.DataSet) do
      IndexFieldNames := '';
end;

end.

