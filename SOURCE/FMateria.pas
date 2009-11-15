unit FMateria;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, StdCtrls, DBIndex, Buttons,
  DBBBtn, DBCtrls, ExtCtrls, RXCtrls, RXDBCtrl, TB97Tlbr, TB97, TB97Ctls,
  DB97Btn, DBTables, Printers, RXSplit, CDBFmlry, DBFmlry;

type
  TMateriaForm = class(TSingleEditorForm)
    btn97MateriaProhibicion: TDBToolbarButton97;
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
  DMaster, FCrsMMER, FCrsMMEd, SGHCUtls, FConfig, QMaDeRep, QSingRep;
{$R *.DFM}

procedure TMateriaForm.btn97MateriaProhibicionClick(Sender: TObject);
begin
  inherited;
  with MasterDataModule, TCrossManyToManyEditorRForm.Create(Self) do
  begin
    with FormStorage do
    begin
      IniSection := IniSection + '\MMEdR' + TbMateriaProhibicion.TableName;
      Active := True;
      RestoreFormPlacement;
    end;
    Caption := Format('%s %s - Editando %s', [TbMateria.TableName,
      TbMateriaNomMateria.Value, GetDescription(TbMateriaProhibicion)]);
    RxDrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [GetDescription(TbMateriaProhibicion), GetDescription(TbDia),
      GetDescription(TbHora)]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda',
      [GetDescription(TbMateriaProhibicionTipo),
      GetDescription(TbMateriaProhibicionTipo)]);
    ShowEditor(TbDia, TbHora, TbMateriaProhibicionTipo, TbMateriaProhibicion,
      TbHorarioLaborable, 'CodDia', 'NomDia', 'CodDia', 'CodDia', 'CodHora',
      'NomHora', 'CodHora', 'CodHora', 'CodMateProhibicionTipo',
      'NomMateProhibicionTipo', 'ColMateProhibicionTipo',
      'CodMateProhibicionTipo');
    Tag := TbMateriaCodMateria.Value;
    OnActivate := FormActivate;
  end;
end;

procedure TMateriaForm.FormActivate(Sender: TObject);
begin
  with MasterDataModule do
  begin
    TbMateria.Locate('CodMateria', (Sender as TCustomForm).Tag, []);
  end;
end;


end.

