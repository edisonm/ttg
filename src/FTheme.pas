{ -*- mode: Delphi -*- }
unit FTheme;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, Grids, Buttons, DBCtrls, Variants, ExtCtrls,
  Printers, ActnList, StdCtrls, DBGrids, FMasterDetailEditor,
  FCrossManytoManyEditorR;

type

  { TThemeForm }

  TThemeForm	= class(TMasterDetailEditorForm)
    ActFilterByResourceType: TAction;
    CBFilterByResourceType: TCheckBox;
    DbGParticipant: TDBGrid;
    DBGAvailability: TDBGrid;
    DBGResourceTypeLimit: TDBGrid;
    DBLResourceType: TDBLookupComboBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Panel1: TPanel;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    procedure ActFilterByResourceTypeExecute(Sender: TObject);
    procedure ActFindExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DSResourceTypeDataChange(Sender: TObject; Field: TField);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FSuperTitle: string;
    {function GetCurrentLoad: Integer;}
  public
    { Public declarations }
  end;

var
  ThemeForm: TThemeForm;

implementation

uses
  DMaster, FConfig, DSource, FEditor;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

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

procedure TThemeForm.ActFilterByResourceTypeExecute(Sender: TObject);
begin
  with SourceDataModule do
  begin
    with ActFilterByResourceType do
    begin
      //DBLResourceType.Enabled := Checked;
      if not Checked then
      begin
        TbResource.MasterFields := 'IdResourceType';
        TbResource.LinkedFields := 'IdResourceType';
        TbResource.MasterSource := DSResourceType;
      end
      else
      begin
        TbResource.MasterSource := nil;
      end;
      TbResource.Refresh;
    end;
  end;
end;

procedure TThemeForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
end;

procedure TThemeForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
end;

procedure TThemeForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  {Caption := FSuperTitle + Format(' - %s: %d', [SLoad, GetCurrentLoad]);}
end;

procedure TThemeForm.DSResourceTypeDataChange(Sender: TObject; Field: TField);
begin
end;

procedure TThemeForm.FormActivate(Sender: TObject);
begin
  SourceDataModule.TbTheme.Locate('IdTheme', (Sender as TCustomForm).Tag, []);
end;

{
function TThemeForm.GetCurrentLoad: Integer;
var
  VBookmark: TBookmark;
  FieldComposition: TField;
begin
  Result := 0;
  with SourceDataModule, TbTheme do
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
}

procedure TThemeForm.FormCreate(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    FSuperTitle := Description[TbTheme];
    TbResourceTypeLimit.MasterFields := 'IdTheme';
    TbResourceTypeLimit.LinkedFields := 'IdTheme';
    TbResourceTypeLimit.MasterSource := DSTheme;
    TbAvailability.MasterFields := 'IdTheme';
    TbAvailability.LinkedFields := 'IdTheme';
    TbAvailability.MasterSource := DSTheme;
    TbActivity.MasterFields := 'IdTheme';
    TbActivity.LinkedFields := 'IdTheme';
    TbActivity.MasterSource := DSTheme;
    TbParticipant.MasterFields := 'IdActivity';
    TbParticipant.LinkedFields := 'IdActivity';
    TbParticipant.MasterSource := DSActivity;
  end;
end;

procedure TThemeForm.FormDestroy(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbResourceTypeLimit.MasterSource := nil;
  SourceDataModule.TbAvailability.MasterSource := nil;
  SourceDataModule.TbParticipant.MasterSource := nil;
  SourceDataModule.TbActivity.MasterSource := nil;
end;

initialization

{$IFDEF FPC}
  {$i FTheme.lrs}
{$ENDIF}

end.
