unit SGHCUtls;

interface

uses
  Classes, Forms, Db, DbTables, FCrsMMEd, FCrsMMER, FSingEdt, FMasDeEd;

procedure MyMasterDetailShowEditor(MasterDetailEditorForm:
  TMasterDetailEditorForm;
  DataSet, DataSetDetail: TDataSet; const SuperTitle: string; DestroyEvent:
  TNotifyEvent);
procedure MySingleShowEditor(FSingleEditor: TSingleEditorForm; DataSet:
  TDataSet;
  const SuperTitle: string; DestroyEvent: TNotifyEvent);
procedure LoadCaption(AForm: TForm; ATable: TTable);
function ComposicionADuracion(const s: string): Integer;
procedure LoadHints(ACrossManyToManyEditorForm: TCrossManyToManyEditorForm;
  AColDataSet, ARowDataSet, ARelDataSet: TTable); overload;
procedure LoadHints(ACrossManyToManyEditorForm: TCrossManyToManyEditorRForm;
  AColDataSet, ARowDataSet, ALstDataSet, ARelDataSet: TTable); overload;
{procedure LoadHints(ACrossManyToManyEditorForm: TFCubicalEditor2; AColDataSet,
  ARowDataSet, ALstDataSet, ARelDataSet: TTable); overload;}
procedure CrossBatchMove(AColDataSet, ARowDataSet, ARelDataSet, ADestination:
  TDataSet; const AColFieldKey, AColFieldName, AColField, ARowFieldsKey,
  ARowFieldName, ARowFields, ARelFieldKey: string);

implementation

uses
  SysUtils, RxGrids, DMaster, DMain, Consts, ArDBUtls;

procedure LoadHints(ACrossManyToManyEditorForm: TCrossManyToManyEditorForm;
  AColDataSet, ARowDataSet, ARelDataSet: TTable);
begin
  with MasterDataModule, ACrossManyToManyEditorForm do
  begin
    RxDrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [GetDescription(ARelDataSet), GetDescription(AColDataSet),
      GetDescription(ARowDataSet)]);
  end;
end;

procedure LoadHints(ACrossManyToManyEditorForm: TCrossManyToManyEditorRForm;
  AColDataSet, ARowDataSet, ALstDataSet, ARelDataSet: TTable);
begin
  with MasterDataModule, ACrossManyToManyEditorForm do
  begin
    RxDrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [GetDescription(ARelDataSet), GetDescription(AColDataSet),
      GetDescription(ARowDataSet)]);
    ListBox.Hint := Format('%s|%s', [ALstDataSet.Name,
      GetDescription(ALstDataSet)]);
  end;
end;
{
procedure LoadHints(ACrossManyToManyEditorForm: TFCubicalEditor2; AColDataSet,
  ARowDataSet, ALstDataSet, ARelDataSet: TTable);
begin
  with MasterDataModule, ACrossManyToManyEditorForm do
  begin
    RxDrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [GetDescription(ARelDataSet), GetDescription(AColDataSet),
      GetDescription(ARowDataSet)]);
    CheckListBox.Hint := Format('%s|%s', [ALstDataSet.Name,
      GetDescription(ALstDataSet)]);
  end;
end;
}
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
      raise Exception.Create(SInvalidNumber);
    Inc(Result, d);
  end;
end;


procedure LoadCaption(AForm: TForm; ATable: TTable);
begin
  AForm.Caption := MasterDataModule.GetDescription(ATable);
end;

procedure MyMasterDetailShowEditor(MasterDetailEditorForm:
  TMasterDetailEditorForm;
  DataSet, DataSetDetail: TDataSet; const SuperTitle: string; DestroyEvent:
  TNotifyEvent);
begin
  MasterDetailEditorForm.DatasourceDetail.DataSet := DataSetDetail;
  MySingleShowEditor(MasterDetailEditorForm, DataSet, SuperTitle, DestroyEvent);
end;

procedure MySingleShowEditor(FSingleEditor: TSingleEditorForm; DataSet:
  TDataSet; const SuperTitle: string; DestroyEvent: TNotifyEvent);
var
  s: string;
begin
  if DataSet is TTable then
  begin
    LoadCaption(FSingleEditor, DataSet as TTable);
    s := (DataSet as TTable).TableName;
  end
  else
  begin
    s := DataSet.Name;
  end;
  with FSingleEditor do
  begin
    OnDestroy := DestroyEvent;
    with FormStorage do
    begin
      if not Active then
      begin
        IniSection := IniSection + '\SE' + s;
        Active := True;
        RestoreFormPlacement;
      end;
    end;
    ShowEditor(DataSet, SuperTitle);
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
    AColDataSet.Open;
    ARowDataSet.Open;
    ARelDataSet.Open;
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
      Open;
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

