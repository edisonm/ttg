unit FMateria;

{$I TTG.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, FSingEdt, DB, Grids, Buttons, DBCtrls, ExtCtrls,
  Printers, ComCtrls, ToolWin, ActnList, FCrsMMER, ImgList, DBGrids, StdCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TMateriaForm = class(TSingleEditorForm)
    BtnMateriaProhibicion: TToolButton;
    ActMateriaProhibicion: TAction;
    QuMateriaProhibicion: TZQuery;
    procedure ActMateriaProhibicionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  DMaster, FCrsMMEd, FConfig, DSource;

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

initialization

{$IFDEF FPC}
{$i FMateria.lrs}
{$ENDIF}

end.
