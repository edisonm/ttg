unit FHorProf;

{$I TTG.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, Messages, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Db,
  FCrsMME0, FCrsMME1, ImgList, ComCtrls, ToolWin, DBCtrls, Variants, DBGrids,
  ZConnection, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset;

type
  THorarioProfesorForm = class(TCrossManyToManyEditor1Form)
    QuHorarioProfesor: TZQuery;
    cbVerProfesor: TComboBox;
    QuHorarioProfesorCodNivel: TLongintField;
    QuHorarioProfesorCodEspecializacion: TLongintField;
    QuHorarioProfesorCodParaleloId: TLongintField;
    QuHorarioProfesorCodHora: TLongintField;
    QuHorarioProfesorCodDia: TLongintField;
    QuHorarioProfesorCodMateria: TLongintField;
    QuHorarioProfesorNomMateria: TStringField;
    QuHorarioProfesorNombre: TStringField;
    QuHorarioProfesorAbrNivel: TStringField;
    QuHorarioProfesorAbrEspecializacion: TStringField;
    QuHorarioProfesorNomParaleloId: TStringField;
    DSProfesor: TDataSource;
    DBNavigator: TDBNavigator;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    QuProfesor: TZQuery;
    QuProfesorCodHorario: TLongintField;
    QuProfesorCodProfesor: TLongintField;
    QuProfesorApeProfesor: TStringField;
    QuProfesorNomProfesor: TStringField;
    QuHorarioProfesorCodHorario: TLongintField;
    QuHorarioProfesorCodProfesor: TLongintField;
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
