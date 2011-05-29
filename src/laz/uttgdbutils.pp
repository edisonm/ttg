{ -*- mode: Delphi -*- }
unit UTTGDBUtils;

{$I ttg.inc}

interface

uses
  Classes, Forms, Db, ActnList, Dialogs, DBGrids, SysUtils, Variants;

function ComposicionADuracion(const s: string): Integer;
procedure CrossBatchMove(AColDataSet, ARowDataSet, ARelDataSet, ADestination:
  TDataSet; const AColFieldKey, AColFieldName, AColField, ARowFieldsKey,
  ARowFieldName, ARowFields, ARelFieldKey: string);
function DisplayLabels(ADataSet: TDataSet; const AFieldNames: string): string;
procedure LoadStringsFromDataSet(Strings: TStrings; DataSet: TDataSet;
  FieldNames: string; Title, Column: Boolean);
procedure SearchInField(AField: TField; AValue: Variant);
procedure SearchInDBGrid(DBGrid: TDBGrid);

implementation

uses
  UTTGBasics;

function ComposicionADuracion(const s: string): Integer;
var
  VPos, d: Integer;
begin
  VPos := 1;
  Result := 0;
  while VPos <= Length(s) do
  begin
    d := StrToInt(ExtractString(s, VPos, '.'));
    if d <= 0 then
      raise Exception.Create('Composicion Erroea');
    Inc(Result, d);
  end;
end;

procedure CrossBatchMove(AColDataSet, ARowDataSet, ARelDataSet, ADestination:
  TDataSet; const AColFieldKey, AColFieldName, AColField, ARowFieldsKey,
  ARowFieldName, ARowFields, ARelFieldKey: string);
var
  vColFieldName, vColField, vRowFieldKey, vRowFieldName, vRelFieldKey: TField;
  iPos, i, iCountRowField: Integer;
  vField: TField;
  bColDataSetActive, bRowDataSetActive, bRelDataSetActive: Boolean;
begin
  bColDataSetActive := AColDataSet.Active;
  bRowDataSetActive := ARowDataSet.Active;
  bRelDataSetActive := ARelDataSet.Active;
  try
    AColDataSet.First;
    ARowDataSet.First;
    ARelDataSet.First;
    vColFieldName := AColDataSet.FindField(AColFieldName);
    vColField := ARelDataSet.FindField(AColField);
    vRowFieldName := ARowDataSet.FindField(ARowFieldName);
    vRelFieldKey := ARelDataSet.FindField(ARelFieldKey);
    with ADestination do
    begin
      Close;
      Fields.Clear;
      iPos := 1;
      iCountRowField := 0;
      while iPos <= Length(ARowFieldsKey) do
      begin
        vRowFieldKey := ARowDataSet.FindField(ExtractFieldName(ARowFieldsKey,
          iPos));
        vField := TFieldClass(vRowFieldKey.ClassType).Create(ADestination);
        with vField do
        begin
          FieldName := vRowFieldKey.FieldName;
          DisplayLabel := vRowFieldKey.DisplayName;
          DisplayWidth := vRowFieldKey.DisplayWidth;
          Size := vRowFieldKey.Size;
          Required := true;
          DataSet := ADestination;
        end;
        Inc(iCountRowField);
      end;
      vField := TFieldClass(vRowFieldName.ClassType).Create(ADestination);
      with vField do
      begin
        FieldName := vRowFieldName.FieldName;
        DisplayLabel := vRowFieldName.DisplayLabel;
        DisplayWidth := vRowFieldName.DisplayWidth;
        Size := vRowFieldName.Size;
        Required := true;
        DataSet := ADestination;
      end;
      AColDataSet.First;
      while not AColDataSet.Eof do
      begin
        vField := TFieldClass(vRelFieldKey.ClassType).Create(ADestination);
        with vField do
        begin
          FieldName := vColFieldName.AsString;
          DisplayWidth := vRelFieldKey.DisplayWidth;
          Size := vRelFieldKey.Size;
          Required := False;
          DataSet := ADestination;
        end;
        AColDataSet.Next;
      end;
      ARowDataSet.First;
      if not Active then
        Open else
        First;
      Fields[0].Visible := false;
      i := 0;
      while i < iCountRowField do
      begin
        Fields[i].Visible := false;
        Inc(i);
      end;
      while not ARowDataSet.Eof do
      begin
        Append;
        iPos := 1;
        i := 0;
        while iPos <= Length(ARowFieldsKey) do
        begin
          Fields[i].Value :=
            ARowDataSet.FindField(ExtractFieldName(ARowFieldsKey,
            iPos)).Value;
          Inc(i);
        end;
        Fields[i].Value := vRowFieldName.Value;
        ARowDataSet.Next;
      end;
      ARelDataSet.First;
      while not ARelDataSet.Eof do
      begin
        if Locate(ARowFieldsKey, ARelDataSet.FieldValues[ARowFields], []) then
        begin
          Edit;
          FindField(AColDataSet.Lookup(AColFieldKey, vColField.Value,
            AColFieldName)).Value := vRelFieldKey.Value;
          Post;
        end;
        ARelDataSet.Next;
      end;
    end;
  finally
    AColDataSet.Active := bColDataSetActive;
    ARowDataSet.Active := bRowDataSetActive;
    ARelDataSet.Active := bRelDataSetActive;
  end;
end;

function DisplayLabels(ADataSet: TDataSet; const AFieldNames: string): string;
var
  iPos: Integer;
begin
  iPos := 1;
  Result := '';
  while iPos <= Length(AFieldNames) do
  begin
    if Result <> '' then
      Result := Result + ';';
    Result := Result + ADataSet.FindField(ExtractFieldName(AFieldNames, iPos)).DisplayLabel;
  end;
end;

procedure LoadStringsFromDataSet(Strings: TStrings; DataSet: TDataSet;
  FieldNames: string; Title, Column: Boolean);
var
  k: Variant;
  VMin, VMax: Integer;
begin
  with DataSet do begin
    First;
    VMin := Strings.Count;
    if Title then Strings.Add(DisplayLabels(DataSet, FieldNames));
    while not EOF do begin
      k := FieldValues[FieldNames];
      Strings.Add(VarArrToStr(k));
      Next;
    end;
    First;
    VMax := Strings.Count - 1;
  end;
  if Column then EqualSpaced(Strings, VMin, VMax, ';');
end;

procedure SearchInDBGrid(DBGrid: TDBGrid);
var
  s: string;
begin
  if Assigned(DBGrid.DataSource) and Assigned(DBGrid.SelectedField) then
    with DBGrid.SelectedField do
    begin
      s := AsString;
      if InputQuery('Buscar por ' + DisplayLabel, DisplayName, s) then
        SearchInField(DBGrid.SelectedField, s);
    end;
end;

procedure SearchInField(AField: TField; AValue: Variant);
var
  v: Variant;
begin
  if Assigned(AField) then
  begin
    with AField do
    begin
      if FieldKind = fkData then
        DataSet.Locate(FieldName, AValue, [loCaseInsensitive, loPartialKey])
      else if FieldKind = fkLookup then
      begin
        if LookupDataSet.Locate(LookupResultField, AValue, [loCaseInsensitive,
          loPartialKey]) then
        begin
          v := LookupDataSet.FieldByName(LookupKeyFields).Value;
          DataSet.Locate(KeyFields, v, []);
        end;
      end;
    end;
  end;
end;

end.
