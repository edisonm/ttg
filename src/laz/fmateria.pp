{ -*- mode: Delphi -*- }
unit FMateria;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, FSingleEditor, Grids, Buttons, DBCtrls, ExtCtrls,
  Printers, ComCtrls, ActnList, FCrossManytoManyEditorR, ZDataset, db;

type

  { TMateriaForm }

  TMateriaForm = class(TSingleEditorForm)
    BtnMateriaProhibicion: TToolButton;
    ActMateriaProhibicion: TAction;
    QuMateriaProhibicion: TZQuery;
    procedure ActFindExecute(Sender: TObject);
    procedure ActMateriaProhibicionExecute(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FMateriaProhibicionForm: TCrossManyToManyEditorRForm;
    procedure FormActivate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MateriaForm: TMateriaForm;

implementation
uses
  DMaster, FCrossManyToManyEditor, FConfiguracion, DSource;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TMateriaForm.ActMateriaProhibicionExecute(Sender: TObject);
begin
  with SourceDataModule do
  if TCrossManyToManyEditorRForm.ToggleEditor(Self,
    FMateriaProhibicionForm, ConfigStorage, ActMateriaProhibicion) then
  with FMateriaProhibicionForm do
  begin
    Caption := Format('%s %s - Editando %s', [
		      SourceDataModule.NameDataSet[TbMateria],
		      TbMateria.FindField('NomMateria').AsString,
		      Description[TbMateriaProhibicion]]);
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [Description[TbMateriaProhibicion], Description[TbDia],
      Description[TbHora]]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda',
      [Description[TbMateriaProhibicionTipo],
      Description[TbMateriaProhibicionTipo]]);
    ShowEditor(TbDia, TbHora, TbMateriaProhibicionTipo, QuMateriaProhibicion,
      TbPeriodo, 'CodDia', 'NomDia', 'CodDia', 'CodDia', 'CodHora', 'NomHora',
      'CodHora', 'CodHora', 'CodMateProhibicionTipo', 'NomMateProhibicionTipo',
      'ColMateProhibicionTipo', 'CodMateProhibicionTipo');
    Tag := TbMateria.FindField('CodMateria').AsInteger;
    OnActivate := FormActivate;
  end;
end;

procedure TMateriaForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
end;

procedure TMateriaForm.DataSourceStateChange(Sender: TObject);
begin
  inherited;
end;

procedure TMateriaForm.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TMateriaForm.ActFindExecute(Sender: TObject);
begin
  inherited;
end;

procedure TMateriaForm.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
end;

procedure TMateriaForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
end;

procedure TMateriaForm.FormActivate(Sender: TObject);
begin
  with SourceDataModule do
  begin
    TbMateria.Locate('CodMateria', (Sender as TCustomForm).Tag, []);
  end;
end;

procedure TMateriaForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuMateriaProhibicion.Open;
end;

procedure TMateriaForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

initialization

{$IFDEF FPC}
{$i fmateria.lrs}
{$ENDIF}

end.
