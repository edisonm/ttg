unit FHorAulT;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, FCrsMME0, Db, FCrsMME1, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset,
  ImgList, ComCtrls, ToolWin, DBCtrls, Variants, DBGrids;

type
  THorarioAulaTipoForm = class(TCrossManyToManyEditor1Form)
    QuHorarioAulaTipo: TZQuery;
    cbVerAulaTipo: TComboBox;
    QuHorarioAulaTipoCodMateria: TIntegerField;
    QuHorarioAulaTipoCodNivel: TIntegerField;
    QuHorarioAulaTipoCodEspecializacion: TIntegerField;
    QuHorarioAulaTipoCodParaleloId: TIntegerField;
    QuHorarioAulaTipoCodHora: TIntegerField;
    QuHorarioAulaTipoCodDia: TIntegerField;
    QuHorarioAulaTipoNomMateria: TWideStringField;
    QuHorarioAulaTipoAbrNivel: TWideStringField;
    QuHorarioAulaTipoAbrEspecializacion: TWideStringField;
    QuHorarioAulaTipoNomParaleloId: TWideStringField;
    QuHorarioAulaTipoNombre: TWideStringField;
    DSAulaTipo: TDataSource;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    QuAulaTipo: TZQuery;
    QuAulaTipoCodHorario: TIntegerField;
    QuAulaTipoCodAulaTipo: TIntegerField;
    QuAulaTipoAbrAulaTipo: TWideStringField;
    QuHorarioAulaTipoCodHorario: TIntegerField;
    QuHorarioAulaTipoCodAulaTipo: TIntegerField;
    DBNavigator: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure QuHorarioAulaTipoCalcFields(DataSet: TDataSet);
    procedure DSAulaTipoDataChange(Sender: TObject; Field: TField);
    procedure BtnMostrarClick(Sender: TObject);
  private
    { Private declarations }
    FNombre: string;
  protected
  public
    { Public declarations }
  end;

implementation
uses
  DMaster, HorColCm, FConfig, DSource, RelUtils;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure THorarioAulaTipoForm.BtnMostrarClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule, MasterDataModule do
  begin
    Caption := Format('[%s %d] - %s', [SuperTitle,
      QuAulaTipo.FindField('CodHorario').AsInteger,
      QuAulaTipo.FindField('AbrAulaTipo').AsString]);
    FNombre := StringsShowAulaTipo.Values[cbVerAulaTipo.Text];
    ShowEditor(TbDia, TbHora, QuHorarioAulaTipo, TbPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
  end;
end;

procedure THorarioAulaTipoForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuAulaTipo.Open;
  cbVerAulaTipo.Items.Clear;
  QuHorarioAulaTipo.Open;
  LoadNames(MasterDataModule.StringsShowAulaTipo, cbVerAulaTipo.Items);
  cbVerAulaTipo.Text := cbVerAulaTipo.Items[0];
end;

procedure THorarioAulaTipoForm.QuHorarioAulaTipoCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FNombre <> '' then
    DataSet['Nombre'] := VarArrToStr(DataSet[FNombre], ' ');
end;

procedure THorarioAulaTipoForm.DSAulaTipoDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  BtnMostrarClick(nil);
end;

initialization
{$IFDEF FPC}
  {$i FHorAulT.lrs}
{$ENDIF}

end.
