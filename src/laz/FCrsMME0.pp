unit FCrsMME0;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, FCrsMMEd, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  ImgList, ToolWin, Grids;

type
  TCrossManyToManyEditor0Form = class(TCrossManyToManyEditorForm)
    Panel2: TPanel;
    ListBox: TListBox;
    Splitter: TSplitter;
    procedure DrawGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure DrawGridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBoxClick(Sender: TObject);
    procedure ListBoxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
  private
    { Private declarations }
    FRel: TDynamicBooleanArrayArray;
    procedure ClearSelection;
  protected
    function RelRecordExists(i, j: Integer): Boolean; override;
    procedure InitRelArray; override;
    procedure WriteRelRecord(i, j: Integer); override;
    procedure UpdateRelRecord(i, j: Integer); override;
    procedure ReadRelRecord(i, j: Integer); override;
    function GetColorHighLight(i, j: Integer): TColor; override;
    function GetText(i, j: Integer): string; override;
    property Rel: TDynamicBooleanArrayArray read FRel;
  public
    { Public declarations }
  end;

const
  LstSelection: array[0..1] of Boolean = (False, True);
  LstColor: array[0..1] of TColor = (clWhite, clRed);

var
  CrossManyToManyEditor0Form: TCrossManyToManyEditor0Form;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

{ TFCrMMEditor0 }

function TCrossManyToManyEditor0Form.GetColorHighLight(i, j: Integer): TColor;
begin
  if RelRecordExists(i, j) then
    Result := clRed
  else
    Result := inherited GetColorHighLight(i, j);
end;

procedure TCrossManyToManyEditor0Form.InitRelArray;
var
  j, k: Integer;
begin
  SetLength(FRel, ColDataset.RecordCount, RowDataset.RecordCount);
  for j := 0 to ColDataset.RecordCount - 1 do
    for k := 0 to RowDataset.RecordCount - 1 do
      FRel[j, k] := False;
end;

procedure TCrossManyToManyEditor0Form.WriteRelRecord(i, j: Integer);
begin
  RelDataSet.Append;
  ColField.AsInteger := ColKey[i];
  RowField.AsInteger := RowKey[j];
  RelDataSet.Post;
end;

procedure TCrossManyToManyEditor0Form.UpdateRelRecord(i, j: Integer);
begin
end;

procedure TCrossManyToManyEditor0Form.ReadRelRecord(i, j: Integer);
begin
  FRel[i, j] := True;
end;

function TCrossManyToManyEditor0Form.RelRecordExists(i, j: Integer): Boolean;
begin
  try
    Result := RelRecordIsValid(i, j) and FRel[i, j]
  except
    Result := False;
  end;
end;

var
  FCol, FRow: Integer;
  FSelected: Boolean;

procedure TCrossManyToManyEditor0Form.DrawGridSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  inherited DrawGridSelectCell(Sender, ACol, ARow, CanSelect);
  FSelected := (FCol = ACol) and (FRow = ARow);
  FCol := ACol;
  FRow := ARow;
end;

procedure TCrossManyToManyEditor0Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited FormClose(Sender, Action);
end;

procedure TCrossManyToManyEditor0Form.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited FormCloseQuery(Sender, CanClose);
end;

procedure TCrossManyToManyEditor0Form.FormDestroy(Sender: TObject);
begin
  inherited FormDestroy(Sender);
end;

function TCrossManyToManyEditor0Form.GetText(i, j: Integer): string;
begin
  Result := '';
end;

procedure TCrossManyToManyEditor0Form.ListBoxDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  VRect: TRect;
  BrushColor: TColor;
begin
  inherited;
  with Control as TListBox do
  begin
    BrushColor := Canvas.Brush.Color;
    VRect.TopLeft := Rect.TopLeft;
    VRect.Bottom := Rect.Bottom;
    VRect.Right := Rect.Left + (Rect.Bottom - Rect.Top);
    Rect.Left := VRect.Right;
    Canvas.Brush.Color := LstColor[Index];
    Canvas.FillRect(VRect);
    {
    Canvas.Brush.Color := clBlack;
    Canvas.FrameRect(VRect);
    }
    Canvas.Brush.Color := BrushColor;
    Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left + 2, Rect.Top, Items[Index]);
  end;
end;

procedure TCrossManyToManyEditor0Form.DrawGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  inherited DrawGridDrawCell(Sender, ACol, ARow, Rect, State);
end;

procedure TCrossManyToManyEditor0Form.DrawGridKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 46 then
    ClearSelection;
end;

procedure TCrossManyToManyEditor0Form.BtnCancelClick(Sender: TObject);
begin
  inherited BtnCancelClick(Sender);
end;

procedure TCrossManyToManyEditor0Form.BtnOkClick(Sender: TObject);
begin
  inherited BtnOkClick(Sender);
end;

procedure TCrossManyToManyEditor0Form.ClearSelection;
var
  VCol, VRow: Longint;
begin
  with DrawGrid do
  begin
    Edit;
    for VCol := Selection.Left to Selection.Right do
      for VRow := Selection.Top to Selection.Bottom do
      begin
        FRel[VCol - 1, VRow - 1] := False;
{$IFDEF FPC}
	InvalidateCell(VCol, VRow);
{$ENDIF}
      end;
    ListBox.ItemIndex := -1;
  end;
end;


procedure TCrossManyToManyEditor0Form.ListBoxClick(Sender: TObject);
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
        FRel[VCol - 1, VRow - 1] := LstSelection[ListBox.ItemIndex];
{$IFDEF FPC}
	InvalidateCell(VCol, VRow);
{$ENDIF}
      end;
  end;
end;

procedure TCrossManyToManyEditor0Form.ListBoxKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 46 then
    ClearSelection;
end;

initialization
{$IFDEF FPC}
  {$i FCrsMME0.lrs}
{$ENDIF}

end.
