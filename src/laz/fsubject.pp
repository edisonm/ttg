{ -*- mode: Delphi -*- }
unit FSubject;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, FSingleEditor, Grids, Buttons, DBCtrls, ExtCtrls,
  Printers, ComCtrls, ActnList, FCrossManytoManyEditorR, ZDataset, db;

type

  { TSubjectForm }

  TSubjectForm = class(TSingleEditorForm)
    BtnSubjectRestriction: TToolButton;
    ActSubjectRestriction: TAction;
    QuSubjectRestriction: TZQuery;
    procedure ActFindExecute(Sender: TObject);
    procedure ActSubjectRestrictionExecute(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FSubjectRestrictionForm: TCrossManyToManyEditorRForm;
    procedure FormActivate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SubjectForm: TSubjectForm;

implementation
uses
  DMaster, FCrossManyToManyEditor, FConfiguracion, DSource;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TSubjectForm.ActSubjectRestrictionExecute(Sender: TObject);
begin
  with SourceDataModule do
  if TCrossManyToManyEditorRForm.ToggleEditor(Self,
    FSubjectRestrictionForm, ConfigStorage, ActSubjectRestriction) then
  with FSubjectRestrictionForm do
  begin
    Caption := Format('%s %s - Editando %s', [
		      SourceDataModule.NameDataSet[TbSubject],
		      TbSubject.FindField('NaSubject').AsString,
		      Description[TbSubjectRestriction]]);
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [Description[TbSubjectRestriction], Description[TbDay],
      Description[TbHour]]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda',
      [Description[TbSubjectRestrictionType],
      Description[TbSubjectRestrictionType]]);
    ShowEditor(TbDay, TbHour, TbSubjectRestrictionType, QuSubjectRestriction,
      TbTimeSlot, 'IdDay', 'NaDay', 'IdDay', 'IdDay', 'IdHour', 'NaHour',
      'IdHour', 'IdHour', 'IdSubjectRestrictionType', 'NaSubjectRestrictionType',
      'ColSubjectRestrictionType', 'IdSubjectRestrictionType');
    Tag := TbSubject.FindField('IdSubject').AsInteger;
    OnActivate := FormActivate;
  end;
end;

procedure TSubjectForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
end;

procedure TSubjectForm.DataSourceStateChange(Sender: TObject);
begin
  inherited;
end;

procedure TSubjectForm.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TSubjectForm.ActFindExecute(Sender: TObject);
begin
  inherited;
end;

procedure TSubjectForm.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
end;

procedure TSubjectForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
end;

procedure TSubjectForm.FormActivate(Sender: TObject);
begin
  with SourceDataModule do
  begin
    TbSubject.Locate('IdSubject', (Sender as TCustomForm).Tag, []);
  end;
end;

procedure TSubjectForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuSubjectRestriction.Open;
end;

procedure TSubjectForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

initialization

{$IFDEF FPC}
{$i fsubject.lrs}
{$ENDIF}

end.
