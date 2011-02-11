unit FProfesr;

{$I TTG.inc}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Grids, StdCtrls, Buttons, DBCtrls,
  ExtCtrls, ComCtrls, Printers, ImgList, ToolWin, ActnList, FCrsMMER, DBGrids;

type
  TProfesorForm	= class(TSingleEditorForm)
    BtnProfesorProhibicion: TToolButton;
    BtnDistributivo: TToolButton;
    ActDistributivo: TAction;
    ActProfesorProhibicion: TAction;
    procedure ActProfesorProhibicionExecute(Sender: TObject);
    procedure ActDistributivoExecute(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FLbCarga: TLabel;
    FSuperTitle: string;
    FDistributivoForm: TSingleEditorForm;
    FProfesorProhibicionForm: TCrossManyToManyEditorRForm;
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
  DMaster, FConfig, DSource, FEditor;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TProfesorForm.ActProfesorProhibicionExecute(Sender: TObject);
begin
  if TCrossManyToManyEditorRForm.ToggleEditor(Self,
					      FProfesorProhibicionForm,
					      ConfigStorage,
                                              ActProfesorProhibicion) then
  with SourceDataModule, FProfesorProhibicionForm do
  begin
    Caption := Format('%s %s - Editando %s', [
    		      NameDataSet[TbProfesor],
		      TbProfesorApeNomProfesor.Value,
		      Description[TbProfesorProhibicion]]);
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ', [
			    Description[TbProfesorProhibicion],
			    Description[TbDia],
			    Description[TbHora]]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda', [
			   NameDataSet[TbProfesorProhibicionTipo],
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
  SourceDataModule.TbProfesor.Locate('CodProfesor', (Sender as TCustomForm).Tag, []);
end;

procedure TProfesorForm.ActDistributivoExecute(Sender: TObject);
begin
   if TSingleEditorForm.ToggleSingleEditor(Self,
					   FDistributivoForm,
					   ConfigStorage,
					   ActDistributivo,
					   SourceDataModule.TbDistributivo) then
      with SourceDataModule do
      begin
         TbParalelo.First;
         TbDistributivo.First;
	 with TbDistributivo do
	 begin
	    DisableControls;
	    try
               IndexFieldNames := 'CodProfesor';
               MasterFields := 'CodProfesor';
               MasterSource := DSProfesor;
	    finally
               EnableControls;
            end
         end;
         Self.DataSource.OnDataChange := DataSourceDataChange;
	 FLbCarga.Parent := FDistributivoForm.pnlStatus;
	 FLbCarga.Top := 1;
	 FLbCarga.Left := 400;
	 FLbCarga.OnDblClick := LbCargaDblClick;
	 FDistributivoForm.OnDestroy := EdQuProfesorDistributivoDestroy;
	 FSuperTitle := FDistributivoForm.Caption;
	 DataSourceDataChange(nil, nil);
      end;
end;

procedure TProfesorForm.LbCargaDblClick(Sender: TObject);
begin
  DataSourceDataChange(nil, nil);
end;

procedure TProfesorForm.EdQuProfesorDistributivoDestroy(Sender: TObject);
begin
  (Sender as TEditorForm).FormDestroy(Sender);
  DataSource.OnDataChange := nil;
  FLbCarga.Parent := nil;
end;

procedure TProfesorForm.DataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  FLbCarga.Caption := Format('Carga: %d', [MasterDataModule.GetCargaActual]);
  FDistributivoForm.Caption := FSuperTitle + ' - ' +
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
  if Assigned(FDistributivoForm) then
  begin
    FDistributivoForm.OnDestroy := nil;
    DataSource.OnDataChange := nil;
    FLbCarga.Free;
  end;
  inherited;
end;

initialization

{$IFDEF FPC}
  {$i FProfesr.lrs}
{$ENDIF}

end.
