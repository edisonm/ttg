{ -*- mode: Delphi -*- }
unit FTheme;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, Grids, Buttons, DBCtrls, Variants, ExtCtrls,
  Printers, ActnList, StdCtrls, DBGrids, ComCtrls, FMasterDetailEditor,
  FCrossManytoManyEditorR, ZSqlUpdate, ZDataset, ZConnection;

type

  { TThemeForm }

  TThemeForm	= class(TMasterDetailEditorForm)
    ActFilterByResourceType: TAction;
    CBFilterByResourceType: TCheckBox;
    DSAvailability: TDatasource;
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
    QuAvailability: TZQuery;
    UpAvailability: TZUpdateSQL;
    ZConnection1: TZConnection;
    procedure ActFilterByResourceTypeExecute(Sender: TObject);
    procedure ActFindExecute(Sender: TObject);
    procedure CBFilterByResourceTypeChange(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DSResourceTypeDataChange(Sender: TObject; Field: TField);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QuAvailabilityFilterRecord(DataSet: TDataSet; var Accept: Boolean
      );
    procedure ZConnection1AfterConnect(Sender: TObject);
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
  DMaster, FConfig, DSource, FEditor, URelUtils, DSourceBaseConsts;

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

procedure TThemeForm.CBFilterByResourceTypeChange(Sender: TObject);
begin

end;

procedure TThemeForm.ActFilterByResourceTypeExecute(Sender: TObject);
begin
  with SourceDataModule do
  begin
    with ActFilterByResourceType do
    begin
      DBLResourceType.Enabled := not Checked;
      QuAvailability.Filtered := not Checked;
      if not Checked then
      begin
        TbResource.MasterFields := 'IdResourceType';
        TbResource.LinkedFields := 'IdResourceType';
        TbResource.MasterSource := DSResourceType;
      end
      else
      begin
        TbResource.MasterSource := nil;
        TbResource.LinkedFields := '';
        TbResource.MasterFields := '';
      end;
      TbResource.Refresh;
      TbResourceTypeLimit.Refresh;
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

procedure TThemeForm.FormCreate(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    FSuperTitle := Description[TbTheme];
    TbResourceTypeLimit.MasterFields := 'IdTheme';
    TbResourceTypeLimit.LinkedFields := 'IdTheme';
    TbResourceTypeLimit.MasterSource := DSTheme;
    TbActivity.MasterFields := 'IdTheme';
    TbActivity.LinkedFields := 'IdTheme';
    TbActivity.MasterSource := DSTheme;
    TbParticipant.MasterFields := 'IdActivity';
    TbParticipant.LinkedFields := 'IdActivity';
    TbParticipant.MasterSource := DSActivity;
    PrepareDataSetFields(QuAvailability);
    NewLookupField(QuAvailability, TbResource, 'IdResource', 'NaResource');
    with QuAvailability do
    begin
      Open;
      FindField('IdResourceType').Visible := False;
      FindField('IdResource').Visible := False;
      FindField('IdTheme').Visible := False;
      FindField('NumResource').DisplayLabel := SFlAvailability_NumResource;
    end;
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

procedure TThemeForm.QuAvailabilityFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := QuAvailability.FindField('IdResourceType').AsInteger
    = DBLResourceType.KeyValue;
//    = SourceDataModule.TbResourceType.FindField('IdResourceType').AsInteger;
end;

procedure TThemeForm.ZConnection1AfterConnect(Sender: TObject);
begin

end;

initialization

{$IFDEF FPC}
  {$i FTheme.lrs}
{$ENDIF}

end.
