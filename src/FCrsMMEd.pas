unit FCrsMMEd;

{$I TTG.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Buttons, ExtCtrls, DB, Variants, FEditor, ComCtrls,
  ImgList, ToolWin, Grids;

type
  PIntegerArray = ^TIntegerArray;
  TIntegerArray = array[0..8191] of Integer;
  PStringArray = ^TStringArray;
  TStringArray = array[0..8191] of string;
  TColorArray = array[0..8191] of TColor;
  TDynamicStringArrayArray = array of array of string;
  TDynamicIntegerArrayArray = array of array of Integer;
  TDynamicBooleanArrayArray = array of array of Boolean;
  TGetColNameNotifyEvent = procedure(Sender: TObject; ACol: Integer; var
    AColName: string) of object;
  TGetRowNameNotifyEvent = procedure(Sender: TObject; ARow: Integer; var
    ARowName: string) of object;

  TCrossManyToManyEditorForm = class(TEditorForm)
    DrawGrid: TDrawGrid;
    BtnOk: TToolButton;
    BtnCancel: TToolButton;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure DrawGridPrepareCanvas(sender: TObject; aCol, aRow: Integer;
      aState: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DrawGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
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
    FKeyCol,
      FKeyRow,
      FRowKey,
      FColKey: TIntegerArray;
    FColName, FRowName: array[0..8191] of string;
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
    procedure ReadDataSet(ADataset: TDataset; AFieldKey,
      AFieldName: TField; var AMin, AMax: Integer; var APosKey,
      AKeyPos: array of Integer; var APosName: array of string);
    procedure InvalidateData; virtual;
    function RelRecordExists(i, j: Integer): Boolean; virtual; abstract;
    function ColRowIsValid(i, j: Integer): Boolean;
    function RelRecordIsValid(i, j: Integer): Boolean;
    procedure WriteRelRecord(i, j: Integer); virtual; abstract;
    procedure DeleteRelRecord(i, j: Integer); virtual;
    procedure ReadRelRecord(i, j: Integer); virtual; abstract;
    procedure UpdateRelRecord(i, j: Integer); virtual; abstract;
    procedure InitRelArray; virtual; abstract;
    function GetColorHighLight(i, j: Integer): TColor; virtual;
    function GetText(i, j: Integer): string; virtual; abstract;
    property ColDataset: TDataset read FColDataset;
    property RowDataset: TDataset read FRowDataset;
    property RelDataset: TDataset read FRelDataset;
    property ColKey: TIntegerArray read FColKey;
    property RowKey: TIntegerArray read FRowKey;
    property RowField: TField read FRowField;
    property ColField: TField read FColField;
  public
    { Public declarations }
    procedure ShowEditor(AColDataSet, ARowDataSet, ARelDataSet, ASelDataSet:
      TDataSet;
      const AColFieldKey, AColFieldName, AColField, AColFieldSel, ARowFieldKey,
      ARowFieldName, ARowField, ARowFieldSel: string);
    property ColorHighLight[i, j: Integer]: TColor read GetColorHighLight;
    property Editing: Boolean read FEditing;
    property Sel: TDynamicBooleanArrayArray read FSel;
    property RowName[ARow: Integer]: string read GetRowName;
    property ColName[ACol: Integer]: string read GetColName;
    property OnGetColName: TGetColNameNotifyEvent read FOnGetColName
      write FOnGetColName;
    property OnGetRowName: TGetRowNameNotifyEvent read FOnGetRowName
      write FOnGetRowName;
  end;

var
  CrossManyToManyEditorForm: TCrossManyToManyEditorForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TCrossManyToManyEditorForm.CheckDataSetEmpty(DataSet: TDataSet);
var
  s: string;
begin
  if DataSet.IsEmpty then
  begin
    Release;
    s := DataSet.Name;
    raise Exception.CreateFmt('%s esta vacio', [s]);
  end;
end;

procedure TCrossManyToManyEditorForm.ShowEditor;
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
    {$IFDEF FPC}
    DrawGrid.OnPrepareCanvas := DrawGridPrepareCanvas;
    {$ENDIF}
    DrawGrid.OnDrawCell := DrawGridDrawCell;
    ReadData;
    {if not Visible then
      ShowModal;}
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
  AFieldName: TField; var AMin, AMax: Integer; var APosKey, AKeyPos: array of Integer;
  var APosName: array of string);
var
  i: Integer;
begin
  with ADataset do
  begin
    AMin := MaxLongint;
    AMax := -MaxLongint - 1;
    First;
    for i := 0 to RecordCount - 1 do
    begin
      APosKey[i] := AFieldKey.AsInteger;
      APosName[i] := AFieldName.AsString;
      if AMin > AKeyPos[i] then
        AMin := AKeyPos[i];
      if AMax < AKeyPos[i] then
        AMax := AKeyPos[i];
      Next;
    end;
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
  DrawGrid.ColCount := FColDataset.RecordCount + 1;
  DrawGrid.RowCount := FRowDataset.RecordCount + 1;
  if Assigned(FSelDataSet) and FSelDataSet.Active then
  begin
    FSelDataSet.First;
    SetLength(FSel, FColDataSet.RecordCount, FRowDataSet.RecordCount);
    for j := 0 to FColDataSet.RecordCount - 1 do
      for k := 0 to FColDataSet.RecordCount - 1 do
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
  InvalidateData;
end;

procedure TCrossManyToManyEditorForm.InvalidateData;
begin
  DrawGrid.Invalidate;
end;

procedure TCrossManyToManyEditorForm.WriteData;
var
  i, j: Integer;
begin
  try
    for i := 0 to FColDataSet.RecordCount - 1 do
      for j := 0 to FRowDataSet.RecordCount - 1 do
        if not Assigned(FSelDataSet) or FSel[i, j] then
        begin
          if RelRecordExists(i, j) then
          begin
            if not FRelDataSet.Locate(FColField.FieldName + ';' +
              FRowField.FieldName,
              VarArrayOf([FColKey[i], FRowKey[j]]), []) then
              WriteRelRecord(i, j)
            else
              UpdateRelRecord(i, j);
          end
          else
          begin
            if FRelDataSet.Locate(FColField.FieldName + ';' +
              FRowField.FieldName,
              VarArrayOf([FColKey[i], FRowKey[j]]), []) then
              DeleteRelRecord(i, j);
          end;
        end;
    FEditing := False;
  except
    FRelDataSet.Cancel;
    raise;
  end;
end;

procedure TCrossManyToManyEditorForm.BtnOkClick(Sender: TObject);
begin
  WriteData;
end;

procedure TCrossManyToManyEditorForm.BtnCancelClick(Sender: TObject);
begin
  ReadData;
end;

procedure TCrossManyToManyEditorForm.DrawGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
  function GetValue: string;
  begin
    with (Sender as TDrawGrid) do
    begin
      if (ACol = 0) and (ARow > 0) then
        Result := RowName[ARow]
      else if (ACol > 0) and (ARow = 0) then
        Result := ColName[ACol]
      else if not RelRecordExists(ACol - 1, ARow - 1) then
        Result := ''
      else
        Result := GetText(ACol - 1, ARow - 1);
    end;
  end;
begin
{$IFNDEF FPC}
  DrawGridPrepareCanvas(Sender, ACol, ARow, State);
{$ENDIF}
  TDrawGrid(Sender).Canvas.TextRect(Rect, Rect.Left+2, Rect.Top+2, GetValue);
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

procedure TCrossManyToManyEditorForm.FormClose(Sender: TObject; var Action:
  TCloseAction);
begin
  inherited FormClose(Sender, Action);
end;

procedure TCrossManyToManyEditorForm.DrawGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
{$IFDEF FPC}
  {with (Sender as TDrawGrid) do
  begin
    if ACol <> Col then InvalidateCell(Col, 0);
    if ARow <> Row then InvalidateCell(0, Row);
  end;}
{$ENDIF}
  if Assigned(FSelDataSet) then
    CanSelect := FSel[ACol - 1, ARow - 1];
end;


function TCrossManyToManyEditorForm.ColRowIsValid(i, j: Integer): Boolean;
begin
  Result := (i >= 0) and (i < FColDataSetRecordCount) and (j >= 0)
    and (j < FRowDataSetRecordCount);
end;

procedure TCrossManyToManyEditorForm.FormDestroy(Sender: TObject);
begin
  inherited FormDestroy(Sender);
end;

procedure TCrossManyToManyEditorForm.Edit;
begin
  FEditing := True;
end;

procedure TCrossManyToManyEditorForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Editing then
    case MessageDlg('Desea guardar los cambios efectuados?', mtConfirmation,
      [mbYes, mbNo, MbCancel], 0) of
      mrYes: WriteData;
      mrNo: {Nothing to do};
      mrCancel: CanClose := False;
    end;
end;

procedure TCrossManyToManyEditorForm.DeleteRelRecord(i, j: Integer);
begin
  FRelDataSet.Delete;
end;

function TCrossManyToManyEditorForm.RelRecordIsValid(i, j: Integer): Boolean;
begin
  Result := ColRowIsValid(i, j) and (not Assigned(FSelDataSet) or FSel[i, j]);
end;

function TCrossManyToManyEditorForm.GetColorHighLight(i, j: Integer): TColor;
begin
  if RelRecordIsValid(i, j) then
    Result := clWindow
  else
    Result := clScrollBar;
end;

initialization
{$IFDEF FPC}
  {$i FCrsMMEd.lrs}
{$ENDIF}

end.

