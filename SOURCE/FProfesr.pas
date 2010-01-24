unit FProfesr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, StdCtrls, DBIndex, Buttons,
  DBBBtn, DBCtrls, ExtCtrls, ComCtrls, RXCtrls, RXDBCtrl,
  Printers, RXSplit, CDBFmlry, DBFmlry, ImgList, ToolWin;

type
  TProfesorForm = class(TSingleEditorForm)
    btn97ProfesorProhibicion: TToolButton;
    btn97Distributivo: TToolButton;
    procedure btn97ProfesorProhibicionClick(Sender: TObject);
    procedure btn97DistributivoClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FLbCarga: TLabel;
    FSuperTitle: string;
    FFSingleEditor: TSingleEditorForm;
    procedure EdQuProfesorDistributivoDestroy(Sender: TObject);
    procedure LbCargaDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  public
    { Public declarations }
  end;

var
  ProfesorForm: TProfesorForm;

implementation

uses
  DMaster, FCrsMMER, SGHCUtls, FConfig, QMaDeRep, QSingRep, DSource;

{$R *.DFM}

procedure TProfesorForm.btn97ProfesorProhibicionClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule, TCrossManyToManyEditorRForm.Create(Self) do
  begin
    with FormStorage do
    begin
      IniSection := IniSection + '\MMEdR' + kbmProfesorProhibicion.Name;
      Active := True;
      RestoreFormPlacement;
    end;
    Caption := Format('%s %s - Editando %s', [SourceDataModule.Name[kbmProfesor],
      kbmProfesorApeNomProfesor.Value, Description[kbmProfesorProhibicion]]);
    RxDrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [Description[kbmProfesorProhibicion], Description[kbmDia], Description[kbmHora]]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda',
      [SourceDataModule.Name[kbmProfesorProhibicionTipo],
      Description[kbmProfesorProhibicionTipo]]);
    ShowEditor(kbmDia, kbmHora, kbmProfesorProhibicionTipo, kbmProfesorProhibicion,
      kbmPeriodo, 'CodDia', 'NomDia', 'CodDia', 'CodDia', 'CodHora',
      'NomHora', 'CodHora', 'CodHora', 'CodProfProhibicionTipo',
      'NomProfProhibicionTipo', 'ColProfProhibicionTipo',
      'CodProfProhibicionTipo');
    Tag := kbmProfesorCodProfesor.Value;
    OnActivate := FormActivate;
  end;
end;

procedure TProfesorForm.FormActivate(Sender: TObject);
begin
  with SourceDataModule do
  begin
    kbmProfesor.Locate('CodProfesor', (Sender as TCustomForm).Tag, []);
  end;
end;

procedure TProfesorForm.btn97DistributivoClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    kbmParalelo.First;
    kbmDistributivo.First;
    with kbmDistributivo do
    begin
      DisableControls;
      try
        btn97Distributivo.Enabled := False;
        IndexFieldNames := 'CodProfesor';
        MasterFields := 'CodProfesor';
        MasterSource := dsProfesor;
      finally
        EnableControls;
      end;
      FFSingleEditor := TSingleEditorForm.Create(Self);
      FFSingleEditor.btn97Find.Enabled := False;
      Self.DataSource.OnDataChange := DataSourceDataChange;
      FLbCarga.Parent := FFSingleEditor.pnlStatus;
      FLbCarga.Top := 1;
      FLbCarga.Left := 400;
      FLbCarga.OnDblClick := LbCargaDblClick;
      MySingleShowEditor(FFSingleEditor,
        kbmDistributivo, ConfiguracionForm.edtNomColegio.Text,
        EdQuProfesorDistributivoDestroy);
      FSuperTitle := FFSingleEditor.Caption;
      DataSourceDataChange(nil, nil);
    end;
  end;
end;

procedure TProfesorForm.LbCargaDblClick(Sender: TObject);
begin
  DataSourceDataChange(nil, nil);
end;

procedure TProfesorForm.EdQuProfesorDistributivoDestroy(Sender: TObject);
begin
  if Assigned(btn97Distributivo) then
    btn97Distributivo.Enabled := True;
  DataSource.OnDataChange := nil;
  FLbCarga.Parent := nil;
end;

procedure TProfesorForm.DataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  FLbCarga.Caption := Format('Carga: %d', [MasterDataModule.GetCargaActual]);
  FFSingleEditor.Caption := FSuperTitle + ' - ' +
    SourceDataModule.kbmProfesorApeNomProfesor.AsString;
end;

procedure TProfesorForm.FormCreate(Sender: TObject);
begin
  inherited;
  FLbCarga := TLabel.Create(Self);
end;

procedure TProfesorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with SourceDataModule.kbmDistributivo do
  begin
    MasterSource := nil;
    MasterFields := '';
    IndexFieldNames := '';
  end;
  if Assigned(FFSingleEditor) then
  begin
    FFSingleEditor.OnDestroy := nil;
    DataSource.OnDataChange := nil;
    FLbCarga.Free;
  end;
  inherited;
end;

end.

