{ -*- mode: Delphi -*- }
unit FCrossManyToManyEditor0;

{$I ttg.inc}

interface

uses
  LResources, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  FCrossManyToManyEditor, Buttons, ExtCtrls, Grids;

type

  { TCrossManyToManyEditor0Form }

  TCrossManyToManyEditor0Form = class(TCrossManyToManyEditorForm)
    Panel2: TPanel;
    ListBox: TListBox;
    Splitter: TSplitter;
    procedure DrawGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure DrawGridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBoxClick(Sender: TObject);
    procedure ListBoxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var AAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure BtOkClick(Sender: TObject);
    procedure BtCancelClick(Sender: TObject);
  private
    { Private declarations }
    FRel: TDynamicBooleanArrayArray;
    procedure ClearSelection;
  protected
    function RelRecordExists(ACol, ARow: Integer): Boolean; override;
    procedure InitRelArray; override;
    procedure WriteRelRecord(ACol, ARow: Integer); override;
    procedure UpdateRelRecord(ACol, ARow: Integer); override;
    procedure ReadRelRecord(ACol, ARow: Integer); override;
    function GetColorHighLight(ACol, ARow: Integer): TColor; override;
    function GetText(ACol, ARow: Integer): string; override;
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

uses
  UTTGConsts;

{ TFCrMMEditor0 }

function TCrossManyToManyEditor0Form.GetColorHighLight(ACol, ARow: Integer): TColor;
begin
  if RelRecordExists(ACol, ARow) then
    Result := clRed
  else
    Result := inherited GetColorHighLight(ACol, ARow);
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

procedure TCrossManyToManyEditor0Form.WriteRelRecord(ACol, ARow: Integer);
begin
  RelDataSet.Append;
  ColField.AsInteger := ColKey[ACol];
  RowField.AsInteger := RowKey[ARow];
  RelDataSet.Post;
end;

procedure TCrossManyToManyEditor0Form.UpdateRelRecord(ACol, ARow: Integer);
begin
end;

procedure TCrossManyToManyEditor0Form.ReadRelRecord(ACol, ARow: Integer);
begin
  FRel[ACol, ARow] := True;
end;

function TCrossManyToManyEditor0Form.RelRecordExists(ACol, ARow: Integer): Boolean;
begin
  try
    Result := RelRecordIsValid(ACol, ARow) and FRel[ACol, ARow]
  except
    Result := False;
  end;
end;

procedure TCrossManyToManyEditor0Form.DrawGridSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
end;

procedure TCrossManyToManyEditor0Form.FormCreate(Sender: TObject);
begin
  with ListBox.Items do
  begin
    Clear;
    Add(SRelease);
    Add(SAssign);
  end;
end;

procedure TCrossManyToManyEditor0Form.FormClose(Sender: TObject;
  var AAction: TCloseAction);
begin
  inherited;
end;

procedure TCrossManyToManyEditor0Form.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
end;

procedure TCrossManyToManyEditor0Form.FormDestroy(Sender: TObject);
begin
  inherited;
end;

function TCrossManyToManyEditor0Form.GetText(ACol, ARow: Integer): string;
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
  inherited;
end;

procedure TCrossManyToManyEditor0Form.DrawGridKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 46 then
    ClearSelection;
end;

procedure TCrossManyToManyEditor0Form.BtCancelClick(Sender: TObject);
begin
  inherited;
end;

procedure TCrossManyToManyEditor0Form.BtOkClick(Sender: TObject);
begin
  inherited;
end;

procedure TCrossManyToManyEditor0Form.ClearSelection;
var
  VCol, VRow: Integer;
begin
  with DrawGrid do
  begin
    Edit;
    for VCol := Selection.Left to Selection.Right do
      for VRow := Selection.Top to Selection.Bottom do
      begin
        FRel[VCol - 1, VRow - 1] := False;
	InvalidateCell(VCol, VRow);
      end;
    ListBox.ItemIndex := -1;
  end;
end;


procedure TCrossManyToManyEditor0Form.ListBoxClick(Sender: TObject);
var
  VCol, VRow: Integer;
begin
  inherited;
  with DrawGrid do
  begin
    Edit;
    for VCol := Selection.Left to Selection.Right do
      for VRow := Selection.Top to Selection.Bottom do
      begin
        FRel[VCol - 1, VRow - 1] := LstSelection[ListBox.ItemIndex];
	InvalidateCell(VCol, VRow);
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

{$I FCrossManyToManyEditor0.lrs}

end.
