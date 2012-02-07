{ -*- mode: Delphi -*- }
unit FTeacher;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, Grids, Buttons, DBCtrls, Variants, ExtCtrls,
  ComCtrls, Printers, ActnList, FMasterDetailEditor, FCrossManytoManyEditorR;

type

  { TTeacherForm }

  TTeacherForm	= class(TMasterDetailEditorForm)
    BtnTeacherRestriction: TToolButton;
    ActTeacherRestriction: TAction;
    procedure ActFindExecute(Sender: TObject);
    procedure ActTeacherRestrictionExecute(Sender: TObject);
    procedure DataSourceStateChange(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FSuperTitle: string;
    FTeacherRestrictionForm: TCrossManyToManyEditorRForm;
    function GetCurrentLoad: Integer;
  public
    { Public declarations }
  end;

var
  TeacherForm: TTeacherForm;

implementation

uses
  DMaster, FConfig, DSource, FEditor, UTTGDBUtils, UTTGConsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TTeacherForm.ActTeacherRestrictionExecute(Sender: TObject);
begin
  with SourceDataModule do
  if TCrossManyToManyEditorRForm.ToggleEditor(Self, FTeacherRestrictionForm,
    ConfigStorage, ActTeacherRestriction) then
  with FTeacherRestrictionForm do
  begin
    Tag := TbTeacher.FindField('IdTeacher').AsInteger;
    TbTeacherRestriction.MasterSource := DSTeacher;
    TbTeacherRestriction.MasterFields := 'IdTeacher';
    TbTeacherRestriction.LinkedFields := 'IdTeacher';
    Caption := Format('%s %s %s - %s %s', [NameDataSet[TbTeacher],
      TbTeacher.FindField('LnTeacher').AsString,
      TbTeacher.FindField('NaTeacher').AsString,
      SEditing,
      Description[TbTeacherRestriction]]);
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [Description[TbTeacherRestriction], Description[TbDay], Description[TbHour]]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda',
      [NameDataSet[TbTeacherRestrictionType], Description[TbTeacherRestrictionType]]);
    ShowEditor(TbDay, TbHour, TbTeacherRestrictionType, TbTeacherRestriction,
	    TbTimeSlot, 'IdDay', 'NaDay', 'IdDay', 'IdDay', 'IdHour', 'NaHour',
      'IdHour', 'IdHour', 'IdTeacherRestrictionType', 'NaTeacherRestrictionType',
      'ColTeacherRestrictionType', 'IdTeacherRestrictionType');
  end
  else
  begin
    TbTeacherRestriction.MasterSource := nil;
  end;
end;

procedure TTeacherForm.DataSourceStateChange(Sender: TObject);
begin
  inherited;
end;

procedure TTeacherForm.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TTeacherForm.ActFindExecute(Sender: TObject);
begin
  inherited;
end;

procedure TTeacherForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
end;

procedure TTeacherForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
end;

procedure TTeacherForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  Caption := FSuperTitle + Format(' - %s: %d', [SLoad, GetCurrentLoad]);
end;

procedure TTeacherForm.FormActivate(Sender: TObject);
begin
  SourceDataModule.TbTeacher.Locate('IdTeacher', (Sender as TCustomForm).Tag, []);
end;

function TTeacherForm.GetCurrentLoad: Integer;
var
  VBookmark: TBookmark;
  FieldComposition: TField;
begin
  Result := 0;
  with SourceDataModule, TbDistribution do
  begin
    VBookmark := GetBookmark;
    DisableControls;
    try
      First;
      FieldComposition := FindField('Composition');
      while not Eof do
      begin
        Inc(Result, CompositionToDuration(FieldComposition.AsString));
        Next;
      end;
    finally
      GotoBookmark(VBookmark);
      EnableControls;
    end;
  end;
end;

procedure TTeacherForm.FormCreate(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    FSuperTitle := Description[TbTeacher];
    TbDistribution.MasterFields := 'IdTeacher';
    TbDistribution.LinkedFields := 'IdTeacher';
    TbDistribution.MasterSource := DSTeacher;
  end
end;

procedure TTeacherForm.FormDestroy(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbDistribution.MasterSource := nil;
end;

initialization

{$IFDEF FPC}
  {$i fteacher.lrs}
{$ENDIF}

end.
