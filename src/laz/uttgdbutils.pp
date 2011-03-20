unit UTTGDBUtils;

{$I ttg.inc}

interface

uses
  Classes, Forms, Db, DSource, ActnList;

procedure CrossBatchMove(AColDataSet, ARowDataSet, ARelDataSet, ADestination:
  TDataSet; const AColFieldKey, AColFieldName, AColField, ARowFieldsKey,
  ARowFieldName, ARowFields, ARelFieldKey: string);

implementation

uses
  SysUtils, DMaster;

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

end.

