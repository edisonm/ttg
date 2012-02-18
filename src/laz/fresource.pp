{ -*- mode: Delphi -*- }
unit FResource;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, Grids, Buttons, DBCtrls, Variants, ExtCtrls,
  ComCtrls, Printers, ActnList, StdCtrls, DBGrids, FMasterDetailEditor,
  FCrossManytoManyEditorR;

type

  { TResourceForm }

  TResourceForm	= class(TMasterDetailEditorForm)
    TBResourceRestriction: TToolButton;
    ActResourceRestriction: TAction;
    DbGRequirements: TDBGrid;
    DbGJoinedCluster: TDBGrid;
    GroupBox3: TGroupBox;
    GBJoinedCluster: TGroupBox;
    Panel3: TPanel;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    procedure ActFindExecute(Sender: TObject);
    procedure ActResourceRestrictionExecute(Sender: TObject);
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
    FResourceRestrictionForm: TCrossManyToManyEditorRForm;
    function GetCurrentLoad: Integer;
  public
    { Public declarations }
  end;

var
  ResourceForm: TResourceForm;

implementation

uses
  DMaster, FConfig, DSource, FEditor, UTTGDBUtils, UTTGConsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TResourceForm.ActResourceRestrictionExecute(Sender: TObject);
begin
  with SourceDataModule do
  if TCrossManyToManyEditorRForm.ToggleEditor(Self, FResourceRestrictionForm,
    ConfigStorage, ActResourceRestriction) then
  with FResourceRestrictionForm do
  begin
    Tag := TbResource.FindField('IdResource').AsInteger;
    TbResourceRestriction.MasterSource := DSResource;
    TbResourceRestriction.MasterFields := 'IdResource';
    TbResourceRestriction.LinkedFields := 'IdResource';
    Caption := Format('%s %s  - %s %s', [NameDataSet[TbResource],
      TbResource.FindField('NaResource').AsString,
      SEditing, Description[TbResourceRestriction]]);
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [Description[TbResourceRestriction], Description[TbDay], Description[TbHour]]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda',
      [NameDataSet[TbResourceRestrictionType], Description[TbResourceRestrictionType]]);
    ShowEditor(TbDay, TbHour, TbResourceRestrictionType, TbResourceRestriction,
	    TbTimeSlot, 'IdDay', 'NaDay', 'IdDay', 'IdDay', 'IdHour', 'NaHour',
      'IdHour', 'IdHour', 'IdResourceRestrictionType', 'NaResourceRestrictionType',
      'ColResourceRestrictionType', 'IdResourceRestrictionType');
  end
  else
  begin
    TbResourceRestriction.MasterSource := nil;
  end;
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

procedure TResourceForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  Caption := FSuperTitle + Format(' - %s: %d', [SLoad, GetCurrentLoad]);
end;

procedure TResourceForm.FormActivate(Sender: TObject);
begin
  SourceDataModule.TbResource.Locate('IdResource', (Sender as TCustomForm).Tag, []);
end;

function TResourceForm.GetCurrentLoad: Integer;
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

procedure TResourceForm.FormCreate(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    FSuperTitle := Description[TbResource];
    TbDistribution.MasterFields := 'IdResource';
    TbDistribution.LinkedFields := 'IdResource';
    TbDistribution.MasterSource := DSResource;
    TbRequirement.MasterFields := 'IdTheme;IdCategory;IdParallel';
    TbRequirement.LinkedFields := 'IdTheme;IdCategory;IdParallel';
    TbRequirement.MasterSource := SourceDataModule.DSDistribution;
    TbJoinedCluster.MasterFields := 'IdTheme;IdCategory;IdParallel';
    TbJoinedCluster.LinkedFields := 'IdTheme;IdCategory;IdParallel';
    TbJoinedCluster.MasterSource := SourceDataModule.DSDistribution;
    {TbRequirement.Close;
    QuResource.Close;
    QuResource.Open;
    TbRequirement.Open;}
  end;
end;

procedure TResourceForm.FormDestroy(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbRequirement.MasterSource := nil;
  SourceDataModule.TbDistribution.MasterSource := nil;
end;

initialization

{$IFDEF FPC}
  {$i fteacher.lrs}
{$ENDIF}

end.
