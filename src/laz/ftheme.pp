{ -*- mode: Delphi -*- }
unit FTheme;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, FSingleEditor, Grids, Buttons, DBCtrls, ExtCtrls,
  Printers, ComCtrls, ActnList, FCrossManytoManyEditorR, ZDataset, db;

type

  { TThemeForm }

  TThemeForm = class(TSingleEditorForm)
    BtThemeRestriction: TToolButton;
    ActThemeRestriction: TAction;
    QuThemeRestriction: TZQuery;
    procedure ActFindExecute(Sender: TObject);
    procedure ActThemeRestrictionExecute(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FThemeRestrictionForm: TCrossManyToManyEditorRForm;
    procedure FormActivate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ThemeForm: TThemeForm;

implementation
uses
  DMaster, FCrossManyToManyEditor, FConfig, DSource, UTTGConsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TThemeForm.ActThemeRestrictionExecute(Sender: TObject);
begin
  with SourceDataModule do
  if TCrossManyToManyEditorRForm.ToggleEditor(Self,
    FThemeRestrictionForm, ConfigStorage, ActThemeRestriction) then
  with FThemeRestrictionForm do
  begin
    Caption := Format('%s %s - %s %s', [
		      SourceDataModule.NameDataSet[TbTheme],
		      TbTheme.FindField('NaTheme').AsString,
                      SEditing, Description[TbThemeRestriction]]);
    DrawGrid.Hint := Format(SRelColsRows,
      [Description[TbThemeRestriction], Description[TbDay],
      Description[TbHour]]);
    ListBox.Hint := Format('%s|%s. %s',
      [Description[TbThemeRestrictionType],
       Description[TbThemeRestrictionType],
       SPressDelToClearCell]);
    ShowEditor(TbDay, TbHour, TbThemeRestrictionType, QuThemeRestriction,
      TbPeriod, 'IdDay', 'NaDay', 'IdDay', 'IdDay', 'IdHour', 'NaHour',
      'IdHour', 'IdHour', 'IdThemeRestrictionType', 'NaThemeRestrictionType',
      'ColThemeRestrictionType', 'IdThemeRestrictionType');
    Tag := TbTheme.FindField('IdTheme').AsInteger;
    OnActivate := FormActivate;
  end;
end;

procedure TThemeForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
end;

procedure TThemeForm.DataSourceStateChange(Sender: TObject);
begin
  inherited;
end;

procedure TThemeForm.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TThemeForm.ActFindExecute(Sender: TObject);
begin
  inherited;
end;

procedure TThemeForm.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
end;

procedure TThemeForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
end;

procedure TThemeForm.FormActivate(Sender: TObject);
begin
  with SourceDataModule do
  begin
    TbTheme.Locate('IdTheme', (Sender as TCustomForm).Tag, []);
  end;
end;

procedure TThemeForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuThemeRestriction.Open;
end;

procedure TThemeForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

initialization

{$IFDEF FPC}
{$i ftheme.lrs}
{$ENDIF}

end.
