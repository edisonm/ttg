unit FProfesr;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, FSingEdt, Db, Grids, StdCtrls, Buttons, DBCtrls,
  RelUtils, Variants, ExtCtrls, ComCtrls, Printers, ImgList, ToolWin, ActnList,
  FMasDeEd, FCrsMMER, DBGrids, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TProfesorForm	= class(TMasterDetailEditorForm)
    BtnProfesorProhibicion: TToolButton;
    ActProfesorProhibicion: TAction;
    procedure ActProfesorProhibicionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FSuperTitle: string;
    FDistributivoForm: TSingleEditorForm;
    FProfesorProhibicionForm: TCrossManyToManyEditorRForm;
    function GetCargaActual: Integer;
  public
    { Public declarations }
  end;

var
  ProfesorForm: TProfesorForm;

implementation

uses
  DMaster, FConfig, DSource, FEditor, TTGUtls;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TProfesorForm.ActProfesorProhibicionExecute(Sender: TObject);
begin
  with SourceDataModule do
  if TCrossManyToManyEditorRForm.ToggleEditor(Self, FProfesorProhibicionForm,
    ConfigStorage, ActProfesorProhibicion) then
  with FProfesorProhibicionForm do
  begin
    Tag := TbProfesor.FindField('CodProfesor').AsInteger;
    TbProfesorProhibicion.MasterSource := DSProfesor;
    TbProfesorProhibicion.MasterFields := 'CodProfesor';
    TbProfesorProhibicion.LinkedFields := 'CodProfesor';
    Caption := Format('%s %s %s - Editando %s', [NameDataSet[TbProfesor],
      TbProfesor.FindField('ApeProfesor').AsString,
      TbProfesor.FindField('NomProfesor').AsString,
      Description[TbProfesorProhibicion]]);
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [Description[TbProfesorProhibicion], Description[TbDia], Description[TbHora]]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda',
      [NameDataSet[TbProfesorProhibicionTipo], Description[TbProfesorProhibicionTipo]]);
    ShowEditor(TbDia, TbHora, TbProfesorProhibicionTipo, TbProfesorProhibicion,
	    TbPeriodo, 'CodDia', 'NomDia', 'CodDia', 'CodDia', 'CodHora', 'NomHora',
      'CodHora', 'CodHora', 'CodProfProhibicionTipo', 'NomProfProhibicionTipo',
      'ColProfProhibicionTipo', 'CodProfProhibicionTipo');
  end
  else
  begin
    TbProfesorProhibicion.MasterSource := nil;
  end;
end;

procedure TProfesorForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  Caption := FSuperTitle + Format(' - Carga: %d', [GetCargaActual]);
end;

procedure TProfesorForm.FormActivate(Sender: TObject);
begin
  SourceDataModule.TbProfesor.Locate('CodProfesor', (Sender as TCustomForm).Tag, []);
end;

function TProfesorForm.GetCargaActual: Integer;
var
  VBookmark: TBookmark;
  FieldComposicion: TField;
begin
  Result := 0;
  with SourceDataModule, TbDistributivo do
  begin
    VBookmark := GetBookmark;
    DisableControls;
    try
      First;
      FieldComposicion := FindField('Composicion');
      while not Eof do
      begin
        Inc(Result, ComposicionADuracion(FieldComposicion.AsString));
        Next;
      end;
    finally
      GotoBookmark(VBookmark);
      EnableControls;
    end;
  end;
end;

procedure TProfesorForm.FormCreate(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    FSuperTitle := Description[TbProfesor];
    TbDistributivo.MasterFields := 'CodProfesor';
    TbDistributivo.LinkedFields := 'CodProfesor';
    TbDistributivo.MasterSource := DSProfesor;
  end
end;

procedure TProfesorForm.FormDestroy(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbDistributivo.MasterSource := nil;
end;

initialization

{$IFDEF FPC}
  {$i FProfesr.lrs}
{$ENDIF}

end.
