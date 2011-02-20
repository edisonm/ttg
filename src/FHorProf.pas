unit FHorProf;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, FCrsMME0, Db, FCrsMME1, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset,
  ImgList, ComCtrls, ToolWin, DBCtrls, Variants, DBGrids;

type
  THorarioProfesorForm = class(TCrossManyToManyEditor1Form)
    QuHorarioProfesor: TZQuery;
    cbVerProfesor: TComboBox;
    QuHorarioProfesorCodNivel: TIntegerField;
    QuHorarioProfesorCodEspecializacion: TIntegerField;
    QuHorarioProfesorCodParaleloId: TIntegerField;
    QuHorarioProfesorCodHora: TIntegerField;
    QuHorarioProfesorCodDia: TIntegerField;
    QuHorarioProfesorCodMateria: TIntegerField;
    QuHorarioProfesorNomMateria: TWideStringField;
    QuHorarioProfesorNombre: TWideStringField;
    QuHorarioProfesorAbrNivel: TWideStringField;
    QuHorarioProfesorAbrEspecializacion: TWideStringField;
    QuHorarioProfesorNomParaleloId: TWideStringField;
    DSProfesor: TDataSource;
    DBNavigator: TDBNavigator;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    QuProfesor: TZQuery;
    QuProfesorCodHorario: TIntegerField;
    QuProfesorCodProfesor: TIntegerField;
    QuProfesorApeProfesor: TWideStringField;
    QuProfesorNomProfesor: TWideStringField;
    QuHorarioProfesorCodHorario: TIntegerField;
    QuHorarioProfesorCodProfesor: TIntegerField;
    procedure BtnMostrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QuHorarioProfesorCalcFields(DataSet: TDataSet);
    procedure DSProfesorDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    FNombre: string;
  protected
  public
    { Public declarations }
  end;

implementation
uses
  HorColCm, FConfig, DMaster, DSource, RelUtils;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

Procedure THorarioProfesorForm.BtnMostrarClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    Caption := Format('[%s %d] - %s %s', [SuperTitle,
      QuProfesor.FindField('CodHorario').AsInteger,
      QuProfesor.FindField('ApeProfesor').AsString,
      QuProfesor.FindField('NomProfesor').AsString]);
    FNombre := MasterDataModule.StringsShowProfesor.Values[cbVerProfesor.Text];
    ShowEditor(TbDia, TbHora, QuHorarioProfesor, TbPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
  end;
end;

procedure THorarioProfesorForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuProfesor.Open;
  cbVerProfesor.Items.Clear;
  QuHorarioProfesor.Open;
  LoadNames(MasterDataModule.StringsShowProfesor, cbVerProfesor.Items);
  cbVerProfesor.Text := cbVerProfesor.Items[0];
end;

procedure THorarioProfesorForm.QuHorarioProfesorCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FNombre <> '' then
    DataSet['Nombre'] := VarArrToStr(DataSet[FNombre], ' ');
end;

procedure THorarioProfesorForm.DSProfesorDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  BtnMostrarClick(nil);
end;

initialization
{$IFDEF FPC}
  {$i FHorProf.lrs}
{$ENDIF}

end.
