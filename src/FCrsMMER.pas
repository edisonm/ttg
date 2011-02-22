unit FCrsMMER;

{$I TTG.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DB, FCrsMMEd,
  ImgList, ComCtrls, ToolWin;

type
  TCrossManyToManyEditorRForm = class(TCrossManyToManyEditorForm)
    Panel2: TPanel;
    Splitter: TSplitter;
    ListBox: TListBox;
    procedure DrawGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBoxClick(Sender: TObject);
    procedure DrawGridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBoxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DrawGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FRestaurar: Boolean;
    FLstDataSet: TDataSet;
    FLstFieldKey, FLstFieldName, FLstFieldColor, FLstField: TField;
    FLstMin, FLstMax: Integer;
    FKeyLst, FLstKey: TIntegerArray;
    FLstName: TStringArray;
    FLstColor: TColorArray;
    FRel: TDynamicIntegerArrayArray;
    procedure ClearSelection;
  protected
    procedure InvalidateData; override;
    procedure InitRelArray; override;
    function RelRecordExists(i, j: Integer): Boolean; override;
    procedure ReadRelRecord(i, j: Integer); override;
    procedure WriteRelRecord(i, j: Integer); override;
    procedure UpdateRelRecord(i, j: Integer); override;
    function GetColorHighLight(i, j: Integer): TColor; override;
    function GetText(i, j: Integer): string; override;
    property LstKey: TIntegerArray read FLstKey;
    property Rel: TDynamicIntegerArrayArray read FRel;
  public
    { Public declarations }
    procedure ShowEditor(AColDataSet, ARowDataSet, ALstDataSet,
      ARelDataSet, ASelDataSet: TDataSet; const AColFieldKey, AColFieldName,
      AColField, AColFieldSel, ARowFieldKey, ARowFieldName, ARowField,
      ARowFieldSel, ALstFieldKey, ALstFieldName, ALstFieldColor, ALstField: string);
    property LstDataset: TDataset read FLstDataset; // write FColDataset;
  end;

var
  CrossManyToManyEditorRForm: TCrossManyToManyEditorRForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

{ TFCrMMEditorR }

procedure TCrossManyToManyEditorRForm.ShowEditor(AColDataSet, ARowDataSet,
  ALstDataSet, ARelDataSet, ASelDataSet: TDataSet; const AColFieldKey,
  AColFieldName, AColField, AColFieldSel, ARowFieldKey, ARowFieldName,
  ARowField, ARowFieldSel, ALstFieldKey, ALstFieldName, ALstFieldColor,
  ALstField: string);
begin
  FLstDataSet := ALstDataSet;
  FLstDataSet.DisableControls;
  try
    FLstDataSet.First;
    CheckDataSetEmpty(FLstDataSet);
    FLstFieldKey := ALstDataSet.FindField(ALstFieldKey);
    FLstFieldName := ALstDataSet.FindField(ALstFieldName);
    if ALstFieldColor = '' then
      FLstFieldColor := nil
    else
      FLstFieldColor := ALstDataSet.FindField(ALstFieldColor);
    FLstField := ARelDataSet.FindField(ALstField);
    inherited ShowEditor(AColDataSet, ARowDataSet, ARelDataSet, ASelDataSet,
      AColFieldKey, AColFieldName, AColField, AColFieldSel, ARowFieldKey,
      ARowFieldName, ARowField, ARowFieldSel);
  finally
    FLstDataSet.EnableControls;
  end;
end;

procedure TCrossManyToManyEditorRForm.DrawGridSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  inherited DrawGridSelectCell(Sender, ACol, ARow, CanSelect);
  if CanSelect and (ACol < Length(FRel)) and (ARow < Length(FRel[0])) then
  begin
    with DrawGrid do
      ListBox.ItemIndex := FRel[ACol - 1, ARow - 1];
  end;
  FRestaurar := not CanSelect;
end;

procedure TCrossManyToManyEditorRForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited FormClose(Sender, Action);
end;

procedure TCrossManyToManyEditorRForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited FormCloseQuery(Sender, CanClose);
end;

procedure TCrossManyToManyEditorRForm.FormCreate(Sender: TObject);
begin
  inherited;
  SetLength(FRel, DrawGrid.ColCount, DrawGrid.RowCount);
end;

procedure TCrossManyToManyEditorRForm.FormDestroy(Sender: TObject);
begin
  inherited FormDestroy(Sender);
end;

procedure TCrossManyToManyEditorRForm.InitRelArray;
var
  i, j, k: Integer;
begin
  ReadDataSet(FLstDataSet, FLstFieldKey, FLstFieldName, FLstMin, FLstMax,
    FLstKey, FKeyLst, FLstName);
  if Assigned(FLstFieldColor) then
    with FLstDataSet do
    begin
      First;
      for i := 0 to RecordCount - 1 do
      begin
        FLstColor[i] := FLstFieldColor.AsInteger;
        Next;
      end;
      First;
    end;
  SetLength(FRel, ColDataSet.RecordCount, RowDataSet.RecordCount);
  for j := 0 to ColDataset.RecordCount - 1 do
    for k := 0 to RowDataset.RecordCount - 1 do
      FRel[j, k] := -1;
  with ListBox.Items do
  begin
    Clear;
    Capacity := FLstDataSet.RecordCount;
    BeginUpdate;
    try
      for j := 0 to FLstDataSet.RecordCount - 1 do
      begin
        Add(FLstName[j]);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCrossManyToManyEditorRForm.InvalidateData;
begin
  ListBox.ItemIndex := FRel[DrawGrid.Col - 1, DrawGrid.Row - 1];
  inherited;
end;

procedure TCrossManyToManyEditorRForm.ReadRelRecord(i, j: Integer);
begin
  FRel[i, j] := FKeyLst[FLstField.AsInteger - FLstMin];
end;

procedure TCrossManyToManyEditorRForm.UpdateRelRecord(i, j: Integer);
begin
  if FLstField.AsInteger <> FLstKey[FRel[i, j]] then
  begin
    RelDataSet.Edit;
    FLstField.AsInteger := FLstKey[FRel[i, j]];
    RelDataSet.Post;
  end;
end;

procedure TCrossManyToManyEditorRForm.WriteRelRecord(i, j: Integer);
begin
  RelDataSet.Insert;
  ColField.AsInteger := ColKey[i];
  RowField.AsInteger := RowKey[j];
  FLstField.AsInteger := FLstKey[FRel[i, j]];
  RelDataSet.Post;
end;

function TCrossManyToManyEditorRForm.RelRecordExists(i, j: Integer): Boolean;
begin
  Result := RelRecordIsValid(i, j) and (FRel[i, j] >= 0);
end;

function TCrossManyToManyEditorRForm.GetColorHighLight(i, j: Integer): TColor;
begin
  if FRel[i, j] >= 0 then
  begin
    if Assigned(FLstFieldColor) then
      Result := FLstColor[FRel[i, j]]
    else
      Result := clBtnFace;
  end
  else
    Result := inherited GetColorHighLight(i, j);
end;

function TCrossManyToManyEditorRForm.GetText(i, j: Integer): string;
begin
  if ColRowIsValid(i, j) then
    Result := FLstName[FRel[i, j]]
  else
    Result := '';
end;

procedure TCrossManyToManyEditorRForm.ListBoxDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  VRect: TRect;
  VColor: TColor;
begin
  inherited;
  with Control as TListBox do
  begin
    if Assigned(FLstFieldColor) then
    begin
      VColor := Canvas.Brush.Color;
      VRect.TopLeft := Rect.TopLeft;
      VRect.Bottom := Rect.Bottom;
      VRect.Right := Rect.Left + (Rect.Bottom - Rect.Top);
      Rect.Left := VRect.Right;
      Canvas.Brush.Color := FLstColor[Index];
      Canvas.FillRect(VRect);
      Canvas.Brush.Color := VColor;
    end;
    Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left + 2, Rect.Top, Items[Index]);
  end;
end;

procedure TCrossManyToManyEditorRForm.ListBoxClick(Sender: TObject);
var
  VCol, VRow: Longint;
begin
  inherited;
  with DrawGrid do
  begin
    Edit;
    for VCol := Selection.Left to Selection.Right do
      for VRow := Selection.Top to Selection.Bottom do
      begin
        if Sel[VCol - 1, VRow - 1] then
          FRel[VCol - 1, VRow - 1] := ListBox.ItemIndex;
{$IFDEF FPC}
	InvalidateCell(VCol, VRow);
{$ELSE}
        Invalidate;
{$ENDIF}
      end;
  end;
end;

procedure TCrossManyToManyEditorRForm.DrawGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  inherited DrawGridDrawCell(Sender, ACol, ARow, Rect, State);
end;

procedure TCrossManyToManyEditorRForm.DrawGridKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 46 then
    ClearSelection;
end;

procedure TCrossManyToManyEditorRForm.BtnCancelClick(Sender: TObject);
begin
  inherited BtnCancelClick(Sender);
end;

procedure TCrossManyToManyEditorRForm.BtnOkClick(Sender: TObject);
begin
  inherited BtnOkClick(Sender);
end;

procedure TCrossManyToManyEditorRForm.ClearSelection;
var
  VCol, VRow: Longint;
begin
  with DrawGrid do
  begin
    Edit;
    for VCol := Selection.Left to Selection.Right do
      for VRow := Selection.Top to Selection.Bottom do
      begin
        FRel[VCol - 1, VRow - 1] := -1;
{$IFDEF FPC}
	InvalidateCell(VCol, VRow);
{$ELSE}
        Invalidate;
{$ENDIF}
      end;
    ListBox.ItemIndex := -1;
  end;
end;

procedure TCrossManyToManyEditorRForm.ListBoxKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 46 then
    ClearSelection;
end;

procedure TCrossManyToManyEditorRForm.DrawGridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  S: TGridRect;
begin
  inherited;
  if FRestaurar then
  begin
    S.Top := DrawGrid.Row;
    S.Bottom := DrawGrid.Row;
    S.Left := DrawGrid.Col;
    S.Right := DrawGrid.Col;
    DrawGrid.Selection := S;
    FRestaurar := False;
  end;
end;

initialization

{$IFDEF FPC}
  {$i FCrsMMER.lrs}
{$ENDIF}

end.
