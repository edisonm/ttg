unit FCrsMMEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, DB, Placemnt, Variants,
  FEditor, ImgList, ComCtrls, ToolWin;

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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DrawGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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

{$R *.DFM}

procedure TCrossManyToManyEditorForm.CheckDataSetEmpty(DataSet: TDataSet);
var
  s: string;
begin
  if DataSet.IsEmpty then
  begin
    Release;
    s := DataSet.Name;
    raise Exception.CreateFmt('%s está vacío', [s]);
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
    FRelDataSet.First;
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
  ReadDataSet(FColDataset, FColFieldKey, FColFieldName, FColMin, FColMax,
    FColKey, FKeyCol, FColName);
  ReadDataSet(FRowDataset, FRowFieldKey, FRowFieldName, FRowMin, FRowMax,
    FRowKey, FKeyRow, FRowName);
  DrawGrid.ColCount := FColDataset.RecordCount + 1;
  DrawGrid.RowCount := FRowDataset.RecordCount + 1;
  if Assigned(FSelDataSet) then
  begin
    FSelDataSet.First;
    SetLength(FSel, FColDataset.RecordCount, FRowDataset.RecordCount);
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
    for i := 0 to FColDataset.RecordCount - 1 do
      for j := 0 to FRowDataset.RecordCount - 1 do
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
var
  S: string;
  VColor: TColor;
  procedure DrawCellText;
  begin
    with (Sender as TDrawGrid) do begin
      if ((ARow = Row) or (ACol = Col)) and (gdFixed in State) then
      begin
        VColor := Canvas.Font.Color;
        Canvas.Font.Color := clSilver;
        ExtTextOut(Canvas.Handle, Rect.Left + 4, Rect.Top + 4,
          ETO_CLIPPED or ETO_OPAQUE, @Rect, PChar(S), Length(S), nil);
        Canvas.Font.Color := VColor;
        Canvas.Brush.Style := bsClear;
        ExtTextOut(Canvas.Handle, Rect.Left + 2, Rect.Top + 2, ETO_CLIPPED,
          @Rect, PChar(S), Length(S), nil);
      end
      else
      begin
        if ColRowIsValid(ACol - 1, ARow - 1) and not (gdSelected in State) then
          Canvas.Brush.Color := ColorHighLight[ACol - 1, ARow - 1];
        ExtTextOut(Canvas.Handle, Rect.Left + 2, Rect.Top + 2,
          ETO_CLIPPED or ETO_OPAQUE, @Rect, PChar(S), Length(S), nil);
      end;
    end;
  end;
  procedure GetValue;
  begin
    with DrawGrid do
    begin
      if (ACol = 0) and (ARow > 0) then
        s := RowName[ARow]
      else if (ACol > 0) and (ARow = 0) then
        s := ColName[ACol]
      else if not RelRecordExists(ACol - 1, ARow - 1) then
        s := ''
      else
        s := GetText(ACol - 1, ARow - 1);
    end;
  end;
begin
{$IFDEF FPC}
  if State = [gdSelected, gdFocused] then
  begin
    (Sender as TDrawGrid).InvalidateCell(ACol, 0);
    (Sender as TDrawGrid).InvalidateCell(0, ARow);
  end;
{$ENDIF}
  if Assigned(FColDataSet) and Assigned(FRowDataSet) then
  begin
    GetValue;
    DrawCellText;
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
  {if Assigned(FRelDataSet) then
    FRelDataSet.Close;}
  Action := caFree;
end;

procedure TCrossManyToManyEditorForm.DrawGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  with (Sender as TDrawGrid) do
  begin
{$IFDEF FPC}
    if ACol <> Col then InvalidateCell(Col, 0);
    if ARow <> Row then InvalidateCell(0, Row);
{$ENDIF}
  end;
  if Assigned(FSelDataSet) then
    CanSelect := FSel[ACol - 1, ARow - 1];
end;


function TCrossManyToManyEditorForm.ColRowIsValid(i, j: Integer): Boolean;
begin
  Result := (i >= 0) and (i < FColDataSetRecordCount) and (j >= 0)
    and (j < FRowDataSetRecordCount);
end;

procedure TCrossManyToManyEditorForm.FormCreate(Sender: TObject);
begin
  FEditing := False;
end;

procedure TCrossManyToManyEditorForm.Edit;
begin
  FEditing := True;
end;

procedure TCrossManyToManyEditorForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Editing then
    case MessageDlg('¿Desea guardar los cambios efectuados?', mtConfirmation,
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

end.
