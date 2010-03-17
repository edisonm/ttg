unit FMateria;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Grids, DBGrids, StdCtrls, DBIndex, Buttons, DBCtrls, ExtCtrls,
  Printers, ImgList, ComCtrls, ToolWin;

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
    (*
    with FormStorage do
    begin
      IniSection := IniSection + '\MMEdR' + kbmMateriaProhibicion.Name;
      Active := True;
      RestoreFormPlacement;
    end;
    *)
    Caption := Format('%s %s - Editando %s', [SourceDataModule.Name[kbmMateria],
      kbmMateriaNomMateria.Value, Description[kbmMateriaProhibicion]]);
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [Description[kbmMateriaProhibicion], Description[kbmDia],
      Description[kbmHora]]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda',
      [Description[kbmMateriaProhibicionTipo],
      Description[kbmMateriaProhibicionTipo]]);
    ShowEditor(kbmDia, kbmHora, kbmMateriaProhibicionTipo, kbmMateriaProhibicion,
      kbmPeriodo, 'CodDia', 'NomDia', 'CodDia', 'CodDia', 'CodHora',
      'NomHora', 'CodHora', 'CodHora', 'CodMateProhibicionTipo',
      'NomMateProhibicionTipo', 'ColMateProhibicionTipo',
      'CodMateProhibicionTipo');
    Tag := kbmMateriaCodMateria.Value;
    OnActivate := FormActivate;
  end;
end;

procedure TMateriaForm.FormActivate(Sender: TObject);
begin
  with SourceDataModule do
  begin
    kbmMateria.Locate('CodMateria', (Sender as TCustomForm).Tag, []);
  end;
end;


end.

