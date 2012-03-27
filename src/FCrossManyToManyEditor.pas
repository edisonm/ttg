{ -*- mode: Delphi -*- }
unit FCrossManyToManyEditor;

{$I ttg.inc}

interface

uses
  LResources, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Buttons,
  ExtCtrls, DB, Variants, FEditor, ComCtrls, Grids;

type
  TDynamicStringArray = array of string;
  TDynamicIntegerArray = array of Integer;
  TDynamicStringArrayArray = array of array of string;
  TDynamicIntegerArrayArray = array of array of Integer;
  TDynamicBooleanArrayArray = array of array of Boolean;
  TGetColNameNotifyEvent = procedure(Sender: TObject; ACol: Integer; var
    AColName: string) of object;
  TGetRowNameNotifyEvent = procedure(Sender: TObject; ARow: Integer; var
    ARowName: string) of object;

  { TCrossManyToManyEditorForm }

  TCrossManyToManyEditorForm = class(TEditorForm)
    DrawGrid: TDrawGrid;
    BtOk: TToolButton;
    BtCancel: TToolButton;
    procedure BtOkClick(Sender: TObject);
    procedure BtCancelClick(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
{
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
}
    procedure DrawGridPrepareCanvas(sender: TObject; aCol, aRow: Integer;
      aState: TGridDrawState);
    procedure DrawGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FColDataSetRecordCount,
    FRowDataSetRecordCount: Integer;
    FColDataSet,
      FRowDataSet,
      FRelDataSet,
      FSelDataSet: TDataSet;
    FColFieldKey, {Field used in ColDataSet}
      FColFieldName, {Field used as caption in columns}
      FColField, {Field used in RelDataSet, related to ColDataSet}
      FColFieldSel,
      FRowFieldKey, {Field used in RowDataSet}
      FRowFieldName, {Field used as caption in rows}
      FRowField, {Field used in RelDataSet, related to RowDataSet}
      FRowFieldSel
      : TField;
    FColMin, FRowMin, FColMax, FRowMax: Integer;
    FKeyCol, FKeyRow, FColKey, FRowKey: TDynamicIntegerArray;
    FColName, FRowName: TDynamicStringArray;
    FOnGetColName: TGetColNameNotifyEvent;
    FOnGetRowName: TGetRowNameNotifyEvent;
    FEditing: Boolean;
    FSel: TDynamicBooleanArrayArray;
    procedure ReadData;
    procedure WriteData;
  protected
    procedure Edit;
    function GetColName(ACol: Integer): string; virtual;
    function GetRowName(ARow: Integer): string; virtual;
    procedure CheckDataSetEmpty(DataSet: TDataSet);
    procedure ReadDataSet(ADataset: TDataset; AFieldKey, AFieldName: TField;
      var AMin, AMax: Integer; var APosKey, AKeyPos: TDynamicIntegerArray;
      var APosName: TDynamicStringArray);
    procedure InvalidateData; virtual;
    function RelRecordExists(ACol, ARow: Integer): Boolean; virtual; abstract;
    function ColRowIsValid(ACol, ARow: Integer): Boolean;
    function RelRecordIsValid(ACol, ARow: Integer): Boolean;
    procedure WriteRelRecord(ACol, ARow: Integer); virtual; abstract;
    procedure DeleteRelRecord(ACol, ARow: Integer); virtual;
    procedure ReadRelRecord(ACol, ARow: Integer); virtual; abstract;
    procedure UpdateRelRecord(ACol, ARow: Integer); virtual; abstract;
    procedure InitRelArray; virtual; abstract;
    function GetColorHighLight(ACol, ARow: Integer): TColor; virtual;
    function GetText(ACol, ARow: Integer): string; virtual; abstract;
    property ColDataset: TDataset read FColDataset;
    property RowDataset: TDataset read FRowDataset;
    property RelDataset: TDataset read FRelDataset;
    property ColKey: TDynamicIntegerArray read FColKey;
    property RowKey: TDynamicIntegerArray read FRowKey;
    property RowField: TField read FRowField;
    property ColField: TField read FColField;
  public
    { Public declarations }
    procedure LoadHints(AColDataSet, ARowDataSet, ARelDataSet: TDataSet);
    procedure ShowEditor(AColDataSet, ARowDataSet, ARelDataSet, ASelDataSet:
      TDataSet; const AColFieldKey, AColFieldName, AColField, AColFieldSel, ARowFieldKey,
      ARowFieldName, ARowField, ARowFieldSel: string);
    property ColorHighLight[ACol, ARow: Integer]: TColor read GetColorHighLight;
    property Editing: Boolean read FEditing;
    property Sel: TDynamicBooleanArrayArray read FSel;
    property RowName[ARow: Integer]: string read GetRowName;
    property ColName[ACol: Integer]: string read GetColName;
    property OnGetColName: TGetColNameNotifyEvent read FOnGetColName
      write FOnGetColName;
    property OnGetRowName: TGetRowNameNotifyEvent read FOnGetRowName
      write FOnGetRowName;
  end;

implementation

uses
  DSource, UTTGConsts;

procedure TCrossManyToManyEditorForm.LoadHints(AColDataSet, ARowDataSet,
  ARelDataSet: TDataSet);
begin
  with SourceDataModule do
  begin
    DrawGrid.Hint := Format(SRelColsRows, [Description[ARelDataSet],
      Description[AColDataSet], Description[ARowDataSet]]);
  end;
end;

procedure TCrossManyToManyEditorForm.CheckDataSetEmpty(DataSet: TDataSet);
var
  s: string;
begin
  if DataSet.IsEmpty then
  begin
    Release;
    s := DataSet.Name;
    raise Exception.CreateFmt(SIsEmpty, [s]);
  end;
end;

procedure TCrossManyToManyEditorForm.ShowEditor(AColDataSet, ARowDataSet,
  ARelDataSet, ASelDataSet: TDataSet; const AColFieldKey, AColFieldName,
  AColField, AColFieldSel, ARowFieldKey, ARowFieldName, ARowField,
  ARowFieldSel: string);
begin
  FColDataSet := AColDataSet;
  FRowDataSet := ARowDataSet;
  FRelDataSet := ARelDataSet;
  FSelDataSet := ASelDataSet;
  FColDataSet.DisableControls;
  FRowDataSet.DisableControls;
  FRelDataSet.DisableControls;
  if Assigned(FSelDataSet) then
  begin
    FSelDataSet.DisableControls;
  end;
  try
    FColDataSet.First;
    FRowDataSet.First;
    if FRelDataSet.Active then FRelDataSet.First;
    FColDataSetRecordCount := FColDataSet.RecordCount;
    FRowDataSetRecordCount := FRowDataSet.RecordCount;
    CheckDataSetEmpty(AColDataSet);
    CheckDataSetEmpty(ARowDataSet);
    if Assigned(FSelDataSet) then
    begin
      FSelDataSet.First;
      FColFieldSel := FSelDataSet.FindField(AColFieldSel);
      FRowFieldSel := FSelDataSet.FindField(ARowFieldSel);
    end;
    FColFieldKey := AColDataSet.FindField(AColFieldKey);
    FColFieldName := AColDataSet.FindField(AColFieldName);
    FColField := ARelDataSet.FindField(AColField);
    FRowFieldKey := ARowDataSet.FindField(ARowFieldKey);
    FRowFieldName := ARowDataSet.FindField(ARowFieldName);
    FRowField := ARelDataSet.FindField(ARowField);
    ReadData;
    DrawGrid.OnPrepareCanvas := DrawGridPrepareCanvas;
    DrawGrid.OnDrawCell := DrawGridDrawCell;
    DrawGrid.OnSelectCell := DrawGridSelectCell;
    InvalidateData;
  finally
    FColDataSet.EnableControls;
    FRowDataSet.EnableControls;
    FRelDataSet.EnableControls;
    if Assigned(FSelDataSet) then
    begin
      FSelDataSet.EnableControls;
    end;
  end;
end;

procedure TCrossManyToManyEditorForm.ReadDataSet(ADataset: TDataset; AFieldKey,
  AFieldName: TField; var AMin, AMax: Integer;
  var APosKey, AKeyPos: TDynamicIntegerArray; var APosName: TDynamicStringArray);
var
  i: Integer;
begin
  with ADataset do
  begin
    AMin := MaxLongint;
    AMax := -MaxLongint - 1;
    SetLength(APosKey, RecordCount);
    SetLength(APosName, RecordCount);
    First;
    for i := 0 to RecordCount - 1 do
    begin
      APosKey[i] := AFieldKey.AsInteger;
      APosName[i] := AFieldName.AsString;
      if AMin > APosKey[i] then
        AMin := APosKey[i];
      if AMax < APosKey[i] then
        AMax := APosKey[i];
      Next;
    end;
    SetLength(AKeyPos, AMax - AMin + 1);
    First;
    for i := 0 to RecordCount - 1 do
    begin
      AKeyPos[AFieldKey.AsInteger - AMin] := i;
      Next;
    end;
    First;
  end;
end;

procedure TCrossManyToManyEditorForm.ReadData;
var
  j, k: Integer;
begin
  ReadDataSet(FColDataSet, FColFieldKey, FColFieldName, FColMin, FColMax,
    FColKey, FKeyCol, FColName);
  ReadDataSet(FRowDataSet, FRowFieldKey, FRowFieldName, FRowMin, FRowMax,
    FRowKey, FKeyRow, FRowName);
  if Assigned(FSelDataSet) and FSelDataSet.Active then
  begin
    FSelDataSet.First;
    SetLength(FSel, FColDataSet.RecordCount, FRowDataSet.RecordCount);
    for j := 0 to FColDataSet.RecordCount - 1 do
      for k := 0 to FRowDataSet.RecordCount - 1 do
        FSel[j, k] := False;
    while not FSelDataSet.Eof do
    begin
      j := FKeyCol[FColFieldSel.AsInteger - FColMin];
      k := FKeyRow[FRowFieldSel.AsInteger - FRowMin];
      FSel[j, k] := True;
      FSelDataSet.Next;
    end;
    FSelDataSet.First;
  end;
  InitRelArray;
  if FRelDataSet.Active then
  begin
    FRelDataSet.First;
    while not FRelDataSet.Eof do
    begin
      j := FKeyCol[FColField.AsInteger - FColMin];
      k := FKeyRow[FRowField.AsInteger - FRowMin];
      ReadRelRecord(j, k);
      FRelDataSet.Next;
    end;
    FRelDataSet.First;
  end;
  FEditing := False;
  DrawGrid.ColCount := FColDataset.RecordCount + 1;
  DrawGrid.RowCount := FRowDataset.RecordCount + 1;
end;

procedure TCrossManyToManyEditorForm.InvalidateData;
begin
  DrawGrid.Invalidate;
end;

procedure TCrossManyToManyEditorForm.WriteData;
var
  j, k: Integer;
begin
  try
    for j := 0 to FColDataSet.RecordCount - 1 do
      for k := 0 to FRowDataSet.RecordCount - 1 do
        if not Assigned(FSelDataSet) or FSel[j, k] then
        begin
          if RelRecordExists(j, k) then
          begin
            if not FRelDataSet.Locate(FColField.FieldName + ';' +
              FRowField.FieldName,
              VarArrayOf([FColKey[j], FRowKey[k]]), []) then
              WriteRelRecord(j, k)
            else
              UpdateRelRecord(j, k);
          end
          else
          begin
            if FRelDataSet.Locate(FColField.FieldName + ';' +
              FRowField.FieldName,
              VarArrayOf([FColKey[j], FRowKey[k]]), []) then
              DeleteRelRecord(j, k);
          end;
        end;
    FEditing := False;
  except
    FRelDataSet.Cancel;
    raise;
  end;
end;

procedure TCrossManyToManyEditorForm.BtOkClick(Sender: TObject);
begin
  WriteData;
end;

procedure TCrossManyToManyEditorForm.BtCancelClick(Sender: TObject);
begin
  ReadData;
  InvalidateData;
end;

procedure TCrossManyToManyEditorForm.DrawGridDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
  function GetValue: string;
  begin
    with (Sender as TDrawGrid) do
    begin
      if (aCol = 0) and (aRow > 0) then
        Result := RowName[ARow]
      else if (aCol > 0) and (aRow = 0) then
        Result := ColName[aCol]
      else if not RelRecordExists(aCol - 1, aRow - 1) then
        Result := ''
      else
        Result := GetText(aCol - 1, aRow - 1);
    end;
  end;
begin
  TDrawGrid(Sender).Canvas.TextRect(aRect, aRect.Left+2, aRect.Top+2, GetValue);
end;

procedure TCrossManyToManyEditorForm.DrawGridPrepareCanvas(sender: TObject;
  aCol, aRow: Integer; aState: TGridDrawState);
begin
  with (Sender as TDrawGrid) do
  begin
    if ((aRow <> Row) and (aCol <> Col)) or not (gdFixed in aState) then
    begin
      if ColRowIsValid(ACol - 1, ARow - 1) and not (gdSelected in aState) then
      begin
        Canvas.Brush.Style := bsSolid;
        Canvas.Brush.Color := ColorHighLight[ACol - 1, ARow - 1];
      end;
    end;
  end;
end;

function TCrossManyToManyEditorForm.GetRowName(ARow: Integer): string;
begin
  Result := FRowName[ARow - 1];
  if Assigned(FOnGetRowName) then
    FOnGetRowName(Self, ARow, Result);
end;

function TCrossManyToManyEditorForm.GetColName(ACol: Integer): string;
begin
  Result := FColName[ACol - 1];
  if Assigned(FOnGetColName) then
    FOnGetColName(Self, ACol, Result);
end;

procedure TCrossManyToManyEditorForm.DrawGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if Assigned(FSelDataSet) then
    CanSelect := FSel[ACol - 1, ARow - 1];
end;

procedure TCrossManyToManyEditorForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  inherited;
end;


function TCrossManyToManyEditorForm.ColRowIsValid(ACol, ARow: Integer): Boolean;
begin
  Result := (ACol >= 0) and (ACol < FColDataSetRecordCount)
    and (ARow >= 0) and (ARow < FRowDataSetRecordCount);
end;

procedure TCrossManyToManyEditorForm.Edit;
begin
  FEditing := True;
end;

procedure TCrossManyToManyEditorForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Editing then
    case MessageDlg(SSaveChanges, mtConfirmation, [mbYes, mbNo, MbCancel], 0) of
      mrYes: WriteData;
      mrNo: {Nothing to do};
      mrCancel: CanClose := False;
    end;
end;

procedure TCrossManyToManyEditorForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TCrossManyToManyEditorForm.DeleteRelRecord(ACol, ARow: Integer);
begin
  FRelDataSet.Delete;
end;

function TCrossManyToManyEditorForm.RelRecordIsValid(ACol, ARow: Integer): Boolean;
begin
  Result := ColRowIsValid(ACol, ARow) and (not Assigned(FSelDataSet) or FSel[ACol, ARow]);
end;

function TCrossManyToManyEditorForm.GetColorHighLight(ACol, ARow: Integer): TColor;
begin
  if RelRecordIsValid(ACol, ARow) then
    Result := clWindow
  else
    Result := clScrollBar;
end;

initialization

{$I FCrossManyToManyEditor.lrs}

end.
