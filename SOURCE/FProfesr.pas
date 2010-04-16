unit FProfesr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, StdCtrls, DBIndex, Buttons, DBCtrls,
  ExtCtrls, ComCtrls, RXCtrls, RXDBCtrl, Printers, RXSplit, ImgList, ToolWin;

type
  TProfesorForm = class(TSingleEditorForm)
    BtnProfesorProhibicion: TToolButton;
    BtnDistributivo: TToolButton;
    procedure BtnProfesorProhibicionClick(Sender: TObject);
    procedure BtnDistributivoClick(Sender: TObject);
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
  DMaster, FCrsMMER, SGHCUtls, FConfig, DSource;

{$R *.DFM}

procedure TProfesorForm.BtnProfesorProhibicionClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule, TCrossManyToManyEditorRForm.Create(Self) do
  begin
    with FormStorage do
    begin
      IniSection := IniSection + '\MMEdR' + TbProfesorProhibicion.Name;
      Active := True;
      RestoreFormPlacement;
    end;
    Caption := Format('%s %s - Editando %s', [SourceDataModule.Name[TbProfesor],
      TbProfesorApeNomProfesor.Value, Description[TbProfesorProhibicion]]);
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [Description[TbProfesorProhibicion], Description[TbDia], Description[TbHora]]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda',
      [SourceDataModule.Name[TbProfesorProhibicionTipo],
      Description[TbProfesorProhibicionTipo]]);
    ShowEditor(TbDia, TbHora, TbProfesorProhibicionTipo, TbProfesorProhibicion,
      TbPeriodo, 'CodDia', 'NomDia', 'CodDia', 'CodDia', 'CodHora',
      'NomHora', 'CodHora', 'CodHora', 'CodProfProhibicionTipo',
      'NomProfProhibicionTipo', 'ColProfProhibicionTipo',
      'CodProfProhibicionTipo');
    Tag := TbProfesorCodProfesor.Value;
    OnActivate := FormActivate;
  end;
end;

procedure TProfesorForm.FormActivate(Sender: TObject);
begin
  with SourceDataModule do
  begin
    TbProfesor.Locate('CodProfesor', (Sender as TCustomForm).Tag, []);
  end;
end;

procedure TProfesorForm.BtnDistributivoClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    TbParalelo.First;
    TbDistributivo.First;
    with TbDistributivo do
    begin
      DisableControls;
      try
        BtnDistributivo.Enabled := False;
        IndexFieldNames := 'CodProfesor';
        MasterFields := 'CodProfesor';
        MasterSource := DSProfesor;
      finally
        EnableControls;
      end;
      FFSingleEditor := TSingleEditorForm.Create(Self);
      FFSingleEditor.BtnFind.Enabled := False;
      Self.DataSource.OnDataChange := DataSourceDataChange;
      FLbCarga.Parent := FFSingleEditor.pnlStatus;
      FLbCarga.Top := 1;
      FLbCarga.Left := 400;
      FLbCarga.OnDblClick := LbCargaDblClick;
      MySingleShowEditor(FFSingleEditor,
        TbDistributivo, ConfiguracionForm.edtNomColegio.Text,
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
  if Assigned(BtnDistributivo) then
    BtnDistributivo.Enabled := True;
  DataSource.OnDataChange := nil;
  FLbCarga.Parent := nil;
end;

procedure TProfesorForm.DataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  FLbCarga.Caption := Format('Carga: %d', [MasterDataModule.GetCargaActual]);
  FFSingleEditor.Caption := FSuperTitle + ' - ' +
    SourceDataModule.TbProfesorApeNomProfesor.AsString;
end;

procedure TProfesorForm.FormCreate(Sender: TObject);
begin
  inherited;
  FLbCarga := TLabel.Create(Self);
end;

procedure TProfesorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with SourceDataModule.TbDistributivo do
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

