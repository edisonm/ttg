unit FMateria;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, StdCtrls, DBIndex, Buttons,
  DBCtrls, ExtCtrls, Printers, ImgList, ComCtrls, ToolWin,
  RXDBCtrl, RXCtrls;

type
  TMateriaForm = class(TSingleEditorForm)
    btn97MateriaProhibicion: TToolButton;
    procedure btn97MateriaProhibicionClick(Sender: TObject);
  private
    procedure FormActivate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MateriaForm: TMateriaForm;

implementation
uses
  DMaster, FCrsMMER, FCrsMMEd, SGHCUtls, FConfig, DSource;
{$R *.DFM}

procedure TMateriaForm.btn97MateriaProhibicionClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule, TCrossManyToManyEditorRForm.Create(Self) do
  begin
    with FormStorage do
    begin
      IniSection := IniSection + '\MMEdR' + TbMateriaProhibicion.Name;
      Active := True;
      RestoreFormPlacement;
    end;
    Caption := Format('%s %s - Editando %s', [SourceDataModule.Name[TbMateria],
      TbMateriaNomMateria.Value, Description[TbMateriaProhibicion]]);
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

