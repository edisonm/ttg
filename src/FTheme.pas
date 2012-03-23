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
    DSParticipant: TDatasource;
    DSResourceType: TDatasource;
    DBNResourceType: TDBNavigator;
    DBTResourceType: TDBText;
    DSAvailability: TDatasource;
    DbGParticipant: TDBGrid;
    DBGAvailability: TDBGrid;
    DBGResourceTypeLimit: TDBGrid;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Panel1: TPanel;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    QuAvailability: TZQuery;
    TbResource: TZTable;
    TbResourceType: TZTable;
    UpAvailability: TZUpdateSQL;
    ZConnection1: TZConnection;
    QuParticipant: TZQuery;
    UpParticipant: TZUpdateSQL;
    procedure ActFilterByResourceTypeExecute(Sender: TObject);
    procedure ActFindExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure DSResourceTypeDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FSuperTitle: string;
    procedure UpdateResourceTypeParam;
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

procedure TThemeForm.UpdateResourceTypeParam;
var
  IdResourceType: Integer;
begin
  IdResourceType := TbResourceType.FindField('IdResourceType').AsInteger;
  QuAvailability.ParamByName('IdResourceType').AsInteger := IdResourceType;
  QuParticipant.ParamByName('IdResourceType').AsInteger := IdResourceType;
end;

procedure TThemeForm.DSResourceTypeDataChange(Sender: TObject; Field: TField);
begin
  UpdateResourceTypeParam;
  QuAvailability.Refresh;
  QuParticipant.Refresh;
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
  with ActFilterByResourceType do
  begin
    if Checked then
    begin
      TbResource.MasterFields := 'IdResourceType';
      TbResource.LinkedFields := 'IdResourceType';
      TbResource.MasterSource := DSResourceType;
      DSResourceType.OnDataChange := DSResourceTypeDataChange;
      with QuAvailability.SQL do Add(' AND Resource.IdResourceType=:IdResourceType');
      with QuParticipant.SQL  do Add(' AND Resource.IdResourceType=:IdResourceType');
      UpdateResourceTypeParam;
    end
    else
    begin
      TbResource.MasterSource := nil;
      TbResource.LinkedFields := '';
      TbResource.MasterFields := '';
      DSResourceType.OnDataChange := nil;
      with QuAvailability.SQL do Delete(Count - 1);
      with QuParticipant.SQL do Delete(Count - 1);
    end;
    DBTResourceType.Enabled := Checked;
    DBNResourceType.Enabled := Checked;
    QuAvailability.FindField('NaResourceType').Visible := not Checked;
    QuParticipant.FindField('NaResourceType').Visible := not Checked;
  end;
  QuAvailability.Close;
  QuAvailability.Open;
  QuParticipant.Close;
  QuParticipant.Open;
  TbResource.Refresh;
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

procedure TThemeForm.FormActivate(Sender: TObject);
begin
  SourceDataModule.TbTheme.Locate('IdTheme', (Sender as TCustomForm).Tag, []);
end;

procedure TThemeForm.FormCreate(Sender: TObject);
begin
  inherited;
  TbResourceType.Open;
  TbResource.Open;
  with SourceDataModule do
  begin
    FSuperTitle := Description[TbTheme];
    TbResourceTypeLimit.MasterFields := 'IdTheme';
    TbResourceTypeLimit.LinkedFields := 'IdTheme';
    TbResourceTypeLimit.MasterSource := DSTheme;
    TbActivity.MasterFields := 'IdTheme';
    TbActivity.LinkedFields := 'IdTheme';
    TbActivity.MasterSource := DSTheme;
  end;
  PrepareDataSetFields(QuAvailability);
  NewLookupField(QuAvailability, TbResource, 'IdResource', 'NaResource');
  with QuAvailability do
  begin
    Open;
    FindField('IdResourceType').Visible := False;
    FindField('IdResourceType').ReadOnly := True;
    FindField('IdResource').Visible := False;
    FindField('IdTheme').Visible := False;
    FindField('NaResourceType').DisplayLabel := SFlResource_IdResourceType;
    FindField('NaResource').DisplayLabel := SFlAvailability_IdResource;
    FindField('NumResource').DisplayLabel := SFlAvailability_NumResource;
  end;
  PrepareDataSetFields(QuParticipant);
  NewLookupField(QuParticipant, TbResource, 'IdResource', 'NaResource');
  with QuParticipant do
  begin
    Open;
    FindField('IdResourceType').Visible := False;
    FindField('IdResourceType').ReadOnly := True;
    FindField('IdResource').Visible := False;
    FindField('IdActivity').Visible := False;
    FindField('NaResourceType').DisplayLabel := SFlResource_IdResourceType;
    FindField('NaResource').DisplayLabel := SFlAvailability_IdResource;
    FindField('NumResource').DisplayLabel := SFlParticipant_NumResource;
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
