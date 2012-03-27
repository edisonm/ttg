{ -*- mode: Delphi -*- }
unit FCrossManyToManyEditor1;

{$I ttg.inc}

interface

uses
  LResources, SysUtils, Classes, Graphics, Dialogs, Controls, Forms, Buttons,
  FCrossManyToManyEditor, ExtCtrls, Grids, DB;

type

  { TCrossManyToManyEditor1Form }

  TCrossManyToManyEditor1Form = class(TCrossManyToManyEditorForm)
    procedure BtCancelClick(Sender: TObject);
    procedure BtOkClick(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure DrawGridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure DrawGridSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure DrawGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FRelFieldKey: TField;
    FRel: TDynamicStringArrayArray;
  protected
    function RelRecordExists(i, j: Integer): Boolean; override;
    procedure InitRelArray; override;
    procedure WriteRelRecord(i, j: Integer); override;
    procedure UpdateRelRecord(i, j: Integer); override;
    procedure ReadRelRecord(i, j: Integer); override;
    function GetColorHighLight(i, j: Integer): TColor; override;
    function GetText(i, j: Integer): string; override;
  public
    { Public declarations }
    procedure ShowEditor(AColDataSet, ARowDataSet, ARelDataSet, ASelDataSet:
      TDataSet; const AColFieldKey, AColFieldName, AColField, AColFieldSel,
      ARowFieldKey, ARowFieldName, ARowField, ARowFieldSel, ARelFieldKey:
        string);
    property RelFieldKey: TField read FRelFieldKey;
    property Rel: TDynamicStringArrayArray read FRel;
  end;

var
  CrossManyToManyEditor1Form: TCrossManyToManyEditor1Form;

implementation

{ TFCrMMEditor1 }

function TCrossManyToManyEditor1Form.GetColorHighLight(i, j: Integer): TColor;
begin
  if RelRecordExists(i, j) then
    Result := clScrollBar
  else
    Result := DrawGrid.Canvas.Brush.Color;
end;

procedure TCrossManyToManyEditor1Form.InitRelArray;
var
  j, k: Integer;
begin
  SetLength(FRel, ColDataset.RecordCount, RowDataset.RecordCount);
  for j := 0 to ColDataset.RecordCount - 1 do
    for k := 0 to RowDataset.RecordCount - 1 do
      FRel[j, k] := '';
end;

procedure TCrossManyToManyEditor1Form.ReadRelRecord(i, j: Integer);
begin
  if FRel[i, j] = '' then
    FRel[i, j] := FRelFieldKey.AsString
  else
    FRel[i, j] := FRel[i, j] + '; ' + FRelFieldKey.AsString;
end;

function TCrossManyToManyEditor1Form.RelRecordExists(i, j: Integer): Boolean;
begin
  try
    Result := RelRecordIsValid(i, j) and (FRel[i, j] <> '');
  except
    Result := False;
  end;
end;

procedure TCrossManyToManyEditor1Form.ShowEditor(AColDataSet, ARowDataSet,
  ARelDataSet, ASelDataSet: TDataSet; const AColFieldKey, AColFieldName,
  AColField, AColFieldSel, ARowFieldKey, ARowFieldName, ARowField, ARowFieldSel,
  ARelFieldKey: string);
begin
  FRelFieldKey := ARelDataSet.FindField(ARelFieldKey);
  inherited ShowEditor(AColDataSet, ARowDataSet,
    ARelDataSet, ASelDataSet, AColFieldKey, AColFieldName, AColField,
    AColFieldSel, ARowFieldKey, ARowFieldName, ARowField, ARowFieldSel);
end;

procedure TCrossManyToManyEditor1Form.WriteRelRecord(i, j: Integer);
begin
  RelDataSet.Append;
  ColField.AsInteger := ColKey[i];
  RowField.AsInteger := RowKey[j];
  FRelFieldKey.Value := FRel[i, j];
  RelDataSet.Post;
end;

procedure TCrossManyToManyEditor1Form.UpdateRelRecord(i, j: Integer);
begin
  if FRelFieldKey.Value <> FRel[i, j] then
  begin
    RelDataSet.Edit;
    FRelFieldKey.Value := FRel[i, j];
    RelDataSet.Post;
  end;
end;

procedure TCrossManyToManyEditor1Form.BtCancelClick(Sender: TObject);
begin
  inherited;
end;

procedure TCrossManyToManyEditor1Form.BtOkClick(Sender: TObject);
begin
  inherited;
end;

procedure TCrossManyToManyEditor1Form.DrawGridDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  inherited;
end;

procedure TCrossManyToManyEditor1Form.DrawGridGetEditText(Sender: TObject;
  ACol,
  ARow: Integer; var Value: string);
begin
  inherited;
  try
    Value := FRel[ACol - 1, ARow - 1];
  except
    Value := ''
  end;
end;

procedure TCrossManyToManyEditor1Form.DrawGridSelectCell(Sender: TObject;
  aCol, aRow: Integer; var CanSelect: Boolean);
begin
  inherited;
end;

procedure TCrossManyToManyEditor1Form.DrawGridSetEditText(Sender: TObject;
  ACol,
  ARow: Integer; const Value: string);
begin
  inherited;
  Edit;
  FRel[ACol - 1, ARow - 1] := Value;
end;

procedure TCrossManyToManyEditor1Form.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  inherited;
end;

procedure TCrossManyToManyEditor1Form.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
  inherited;
end;

procedure TCrossManyToManyEditor1Form.FormDestroy(Sender: TObject);
begin
  inherited;
end;

function TCrossManyToManyEditor1Form.GetText(i, j: Integer): string;
begin
  if ColRowIsValid(i, j) then
    Result := FRel[i, j]
  else
    Result := '';
end;

initialization

{$I FCrossManyToManyEditor1.lrs}

end.
