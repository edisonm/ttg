unit FMateria;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Grids, DBGrids, StdCtrls, Buttons,
  DBCtrls, ExtCtrls, Printers, ImgList, ComCtrls, ToolWin, ActnList, FCrsMMER;

type
  TMateriaForm = class(TSingleEditorForm)
    BtnMateriaProhibicion: TToolButton;
    ActMateriaProhibicion: TAction;
    procedure ActMateriaProhibicionExecute(Sender: TObject);
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
  DMaster, FCrsMMEd, TTGUtls, FConfig, DSource;
{$R *.DFM}

procedure TMateriaForm.ActMateriaProhibicionExecute(Sender: TObject);
begin
  if TCrossManyToManyEditorRForm.ToggleEditor(Self,
                                              FMateriaProhibicionForm,
					      ConfigStorage,
					      ActMateriaProhibicion) then
  with SourceDataModule, FMateriaProhibicionForm do
  begin
    Caption := Format('%s %s - Editando %s', [
		      SourceDataModule.NameDataSet[TbMateria],
		      TbMateriaNomMateria.Value,
		      Description[TbMateriaProhibicion]]);
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [Description[TbMateriaProhibicion], Description[TbDia],
      Description[TbHora]]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda',
      [Description[TbMateriaProhibicionTipo],
      Description[TbMateriaProhibicionTipo]]);
    ShowEditor(TbDia, TbHora, TbMateriaProhibicionTipo, TbMateriaProhibicion,
      TbPeriodo, 'CodDia', 'NomDia', 'CodDia', 'CodDia', 'CodHora',
      'NomHora', 'CodHora', 'CodHora', 'CodMateProhibicionTipo',
      'NomMateProhibicionTipo', 'ColMateProhibicionTipo',
      'CodMateProhibicionTipo');
    Tag := TbMateriaCodMateria.Value;
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


end.

