unit FCrsMME0;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FCrsMMEd, StdCtrls, Buttons, ExtCtrls, Grids, ImgList, ComCtrls, ToolWin;

type
  TCrossManyToManyEditor0Form = class(TCrossManyToManyEditorForm)
    Panel2: TPanel;
    ListBox: TListBox;
    Splitter: TSplitter;
    procedure DrawGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DrawGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure DrawGridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBoxClick(Sender: TObject);
    procedure ListBoxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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

{$R *.DFM}

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
  inherited;
  FSelected := (FCol = ACol) and (FRow = ARow);
  FCol := ACol;
  FRow := ARow;
end;

function TCrossManyToManyEditor0Form.GetText(i, j: Integer): string;
begin
  Result := '';
end;

procedure TCrossManyToManyEditor0Form.DrawGridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
{var
  VCol, VRow: Longint;}
begin
  inherited;
{  with DrawGrid do
    if (FSelected) or (Selection.Left <> Selection.Right) or
      (Selection.Top <> Selection.Bottom) then
    begin
      Edit;
      for VCol := Selection.Left to Selection.Right do
        for VRow := Selection.Top to Selection.Bottom do
        begin
          if (not Assigned(Sel)) or (Sel[VCol - 1, VRow - 1]) then
            FRel[VCol - 1, VRow - 1] := not FRel[VCol - 1, VRow - 1];
          InvalidateCell(VCol, VRow);
        end;
      FSelected := False;
    end
}
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
    begin
      BrushColor := Canvas.Brush.Color;
      VRect.TopLeft := Rect.TopLeft;
      VRect.Bottom := Rect.Bottom;
      VRect.Right := Rect.Left + (Rect.Bottom - Rect.Top);
      Rect.Left := VRect.Right;
      Canvas.Brush.Color := LstColor[Index];
      Canvas.FillRect(VRect);
      {Canvas.Brush.Color := clBlack;
      Canvas.FrameRect(VRect);}
      Canvas.Brush.Color := BrushColor;
    end;
    Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left + 2, Rect.Top, Items[Index]);
  end;
end;

procedure TCrossManyToManyEditor0Form.DrawGridKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 46 then
    ClearSelection;
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

end.

