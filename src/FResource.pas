{ -*- mode: Delphi -*- }
unit FResource;

{$I ttg.inc}

interface

uses
  LResources, SysUtils, Classes, db, Graphics, Controls, Forms,
  Dialogs, FSingleEditor, Grids, Buttons, DBCtrls, ExtCtrls, Printers, ComCtrls,
  ActnList, FCrossManytoManyEditorR, ZDataset, DSource;

type

  { TResourceForm }

  TResourceForm = class(TSingleEditorForm)
    DSResource: TDatasource;
    DSResourceType: TDatasource;
    DSRestriction: TDatasource;
    TbResource: TZTable;
    TbResourceType: TZTable;
    TbRestrictionType: TZTable;
    TBtRestriction: TToolButton;
    ActRestriction: TAction;
    TbRestriction: TZTable;
    procedure ActFindExecute(Sender: TObject);
    procedure ActRestrictionExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FRestrictionForm: TCrossManyToManyEditorRForm;
  public
    { Public declarations }
  end;

var
  ResourceForm: TResourceForm;

implementation
uses
  DMaster, FCrossManyToManyEditor, FConfig, UTTGConsts, DSourceConsts, UTTGDBUtils;

procedure TResourceForm.ActRestrictionExecute(Sender: TObject);
var
  TbDay, TbHour, TbPeriod: TDataSet;
begin
  with SourceDataModule do
  if TCrossManyToManyEditorRForm.ToggleEditor(Self, FRestrictionForm,
    ConfigStorage, ActRestriction) then
  with FRestrictionForm do
  begin
    Tag := TbResource.FindField('IdResource').AsInteger;
    Caption := Format('%s %s  - %s %s', [NameDataSet[TbResource],
      TbResource.FindField('NaResource').AsString,
      SEditing, Description[TbRestriction]]);
    DrawGrid.Hint := Format(SRelColsRows, [STbRestriction, STbDay, STbHour]);
    ListBox.Hint := Format('%s|%s. %s',
      [NameDataSet[TbRestrictionType], Description[TbRestrictionType], SDeleteCell]);
    TbDay := NewTable('Day', FRestrictionForm);
    TbHour := NewTable('Hour', FRestrictionForm);
    TbPeriod :=  NewTable('Period', FRestrictionForm);
    TbDay.Open;
    TbHour.Open;
    TbPeriod.Open;
    ShowEditor(TbDay, TbHour, TbRestrictionType, TbRestriction, TbPeriod,
      'IdDay', 'NaDay', 'IdDay', 'IdDay', 'IdHour', 'NaHour', 'IdHour', 'IdHour',
      'IdRestrictionType', 'NaRestrictionType', 'ColRestrictionType', 'IdRestrictionType');
  end;
end;

procedure TResourceForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
end;

procedure TResourceForm.DataSourceStateChange(Sender: TObject);
begin
  inherited;
end;

procedure TResourceForm.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TResourceForm.ActFindExecute(Sender: TObject);
begin
  inherited;
end;

procedure TResourceForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
end;

procedure TResourceForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
end;

procedure TResourceForm.FormActivate(Sender: TObject);
begin
  TbResource.Locate('IdResource', (Sender as TCustomForm).Tag, []);
end;

procedure TResourceForm.FormCreate(Sender: TObject);
begin
  inherited;
  SourceDataModule.PrepareTable(TbResourceType);
  SourceDataModule.PrepareTable(TbResource);
  SourceDataModule.PrepareTable(TbRestrictionType);
  SourceDataModule.PrepareTable(TbRestriction);
  NewLookupField(TbRestriction, TbRestrictionType, 'IdRestrictionType', 'NaRestrictionType');
  NewLookupField(TbResource, TbResourceType, 'IdResourceType', 'NaResourceType');
  TbResourceType.Open;
  TbResource.Open;
  TbRestrictionType.Open;
  TbRestriction.Open;
end;

procedure TResourceForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

initialization

{$I FResource.lrs}

end.
