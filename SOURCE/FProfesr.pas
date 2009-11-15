unit FProfesr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, StdCtrls, DBIndex, Buttons,
  DBBBtn, DBCtrls, ExtCtrls, ComCtrls, RXCtrls, RXDBCtrl, TB97Tlbr, TB97,
  DBTables, TB97Ctls, DB97Btn, Printers, RXSplit, CDBFmlry,
  DBFmlry;

type
  TProfesorForm = class(TSingleEditorForm)
    btn97ProfesorProhibicion: TDBToolbarButton97;
    btn97CargaAcademica: TDBToolbarButton97;
    procedure btn97ProfesorProhibicionClick(Sender: TObject);
    procedure btn97CargaAcademicaClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure btn97CloseClick(Sender: TObject);
  private
    { Private declarations }
    FLbCarga: TLabel;
    FSuperTitle: string;
    FFSingleEditor: TSingleEditorForm;
    procedure EdQuProfesorCargaAcademicaDestroy(Sender: TObject);
    procedure LbCargaDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  public
    { Public declarations }
  end;

var
  ProfesorForm: TProfesorForm;

implementation

uses
  DMaster, FCrsMMER, SGHCUtls, FConfig, QMaDeRep, QSingRep;

{$R *.DFM}

procedure TProfesorForm.btn97ProfesorProhibicionClick(Sender: TObject);
begin
  inherited;
  with MasterDataModule, TCrossManyToManyEditorRForm.Create(Self) do
  begin
    with FormStorage do
    begin
      IniSection := IniSection + '\MMEdR' + TbProfesorProhibicion.TableName;
      Active := True;
      RestoreFormPlacement;
    end;
    Caption := Format('%s %s - Editando %s', [TbProfesor.TableName,
      TbProfesorApeNomProfesor.Value, GetDescription(TbProfesorProhibicion)]);
    RxDrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [GetDescription(TbProfesorProhibicion), GetDescription(TbDia),
      GetDescription(TbHora)]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda',
      [TbProfesorProhibicionTipo.Name,
      GetDescription(TbProfesorProhibicionTipo)]);
    ShowEditor(TbDia, TbHora, TbProfesorProhibicionTipo, TbProfesorProhibicion,
      TbHorarioLaborable, 'CodDia', 'NomDia', 'CodDia', 'CodDia', 'CodHora',
      'NomHora', 'CodHora', 'CodHora', 'CodProfProhibicionTipo',
      'NomProfProhibicionTipo', 'ColProfProhibicionTipo',
      'CodProfProhibicionTipo');
    Tag := TbProfesorCodProfesor.Value;
    OnActivate := FormActivate;
  end;
end;

procedure TProfesorForm.FormActivate(Sender: TObject);
begin
  with MasterDataModule do
  begin
    TbProfesor.Locate('CodProfesor', (Sender as TCustomForm).Tag, []);
  end;
end;

procedure TProfesorForm.btn97CargaAcademicaClick(Sender: TObject);
begin
  inherited;
  with MasterDataModule do
  begin
    TbParalelo.Open;
    TbAsignatura.Open;
    with TbCargaAcademica do
    begin
      DisableControls;
      try
        btn97CargaAcademica.Enabled := False;
        MasterSource := DSProfesor;
        MasterFields := 'CodProfesor';
        IndexFieldNames := 'CodProfesor';
      finally
        EnableControls;
      end;
      FFSingleEditor := TSingleEditorForm.Create(Self);
      FFSingleEditor.DBIndexCombo.Enabled := False;
      FFSingleEditor.btn97Find.Enabled := False;
      Self.DataSource.OnDataChange := DataSourceDataChange;
      FLbCarga.Parent := FFSingleEditor.pnlStatus;
      FLbCarga.Top := 1;
      FLbCarga.Left := 400;
      FLbCarga.OnDblClick := LbCargaDblClick;
      MySingleShowEditor(FFSingleEditor,
        TbCargaAcademica, ConfiguracionForm.edtNomColegio.Text,
        EdQuProfesorCargaAcademicaDestroy);
      FSuperTitle := FFSingleEditor.Caption;
      DataSourceDataChange(nil, nil);
    end;
  end;
end;

procedure TProfesorForm.LbCargaDblClick(Sender: TObject);
begin
  DataSourceDataChange(nil, nil);
end;

procedure TProfesorForm.EdQuProfesorCargaAcademicaDestroy(Sender: TObject);
begin
  if Assigned(btn97CargaAcademica) then
    btn97CargaAcademica.Enabled := True;
  DataSource.OnDataChange := nil;
  FLbCarga.Parent := nil;
end;

procedure TProfesorForm.DataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  FLbCarga.Caption := Format('Carga: %d', [MasterDataModule.GetCargaActual]);
  FFSingleEditor.Caption := FSuperTitle + ' - ' +
    MasterDataModule.TbProfesorApeNomProfesor.AsString;
end;

procedure TProfesorForm.FormCreate(Sender: TObject);
begin
  inherited;
  FLbCarga := TLabel.Create(Self);
end;

procedure TProfesorForm.btn97CloseClick(Sender: TObject);
begin
  inherited;
  if Assigned(FFSingleEditor) then
  begin
    FFSingleEditor.OnDestroy := nil;
    DataSource.OnDataChange := nil;
    FLbCarga.Free;
  end;
  Close;
end;

end.

