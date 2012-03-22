{ -*- mode: Delphi -*- }
unit FResource;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, FSingleEditor, Grids, Buttons, DBCtrls, ExtCtrls,
  Printers, ComCtrls, ActnList, FCrossManytoManyEditorR, db;

type

  { TResourceForm }

  TResourceForm = class(TSingleEditorForm)
    TBRestriction: TToolButton;
    ActRestriction: TAction;
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
  DMaster, FCrossManyToManyEditor, FConfig, DSource, UTTGConsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TResourceForm.ActRestrictionExecute(Sender: TObject);
begin
  with SourceDataModule do
  if TCrossManyToManyEditorRForm.ToggleEditor(Self, FRestrictionForm,
    ConfigStorage, ActRestriction) then
  with FRestrictionForm do
  begin
    Tag := TbResource.FindField('IdResource').AsInteger;
    TbRestriction.MasterSource := DSResource;
    TbRestriction.MasterFields := 'IdResource';
    TbRestriction.LinkedFields := 'IdResource';
    Caption := Format('%s %s  - %s %s', [NameDataSet[TbResource],
      TbResource.FindField('NaResource').AsString,
      SEditing, Description[TbRestriction]]);
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [Description[TbRestriction], Description[TbDay], Description[TbHour]]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda',
      [NameDataSet[TbRestrictionType], Description[TbRestrictionType]]);
    ShowEditor(TbDay, TbHour, TbRestrictionType, TbRestriction,
	    TbPeriod, 'IdDay', 'NaDay', 'IdDay', 'IdDay', 'IdHour', 'NaHour',
      'IdHour', 'IdHour', 'IdRestrictionType', 'NaRestrictionType',
      'ColRestrictionType', 'IdRestrictionType');
  end
  else
  begin
    TbRestriction.MasterSource := nil;
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

procedure TResourceForm.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
end;

procedure TResourceForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
end;

procedure TResourceForm.FormActivate(Sender: TObject);
begin
  with SourceDataModule do
  begin
    TbResource.Locate('IdResource', (Sender as TCustomForm).Tag, []);
  end;
end;

procedure TResourceForm.FormCreate(Sender: TObject);
begin
  inherited;
end;

procedure TResourceForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

initialization

{$IFDEF FPC}
{$i FResource.lrs}
{$ENDIF}

end.
