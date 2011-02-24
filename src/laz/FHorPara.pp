unit FHorPara;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, Messages, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, Db, FCrsMMER, StdCtrls, Buttons, ExtCtrls,
  Grids, Variants, FCrsMME1, DBCtrls, ZConnection, ZAbstractRODataset, DBGrids,
  ZAbstractDataset, ZAbstractTable, ZDataset, ImgList, ComCtrls, ToolWin;

type
  THorarioParaleloForm = class(TCrossManyToManyEditor1Form)
    QuHorarioParalelo: TZQuery;
    BtnIntercambiarPeriodos: TToolButton;
    cbVerParalelo: TComboBox;
    QuHorarioParaleloCodMateria: TLongintField;
    QuHorarioParaleloCodNivel: TLongintField;
    QuHorarioParaleloCodEspecializacion: TLongintField;
    QuHorarioParaleloCodParaleloId: TLongintField;
    QuHorarioParaleloCodHora: TLongintField;
    QuHorarioParaleloCodDia: TLongintField;
    QuHorarioParaleloCodProfesor: TLongintField;
    QuHorarioParaleloNombre: TStringField;
    DSParalelo: TDataSource;
    QuHorarioParaleloNomMateria: TStringField;
    QuParalelo: TZQuery;
    QuParaleloCodHorario: TLongintField;
    QuParaleloCodNivel: TLongintField;
    QuParaleloCodEspecializacion: TLongintField;
    QuParaleloCodParaleloId: TLongintField;
    QuParaleloAbrNivel: TStringField;
    QuParaleloAbrEspecializacion: TStringField;
    QuParaleloNomParaleloId: TStringField;
    QuHorarioParaleloCodHorario: TLongintField;
    QuHorarioParaleloApeProfesor: TStringField;
    QuHorarioParaleloNomProfesor: TStringField;
    DBGrid1: TDBGrid;
    QuParaleloNomParalelo: TStringField;
    Splitter1: TSplitter;
    DBNavigator: TDBNavigator;
    procedure BtnMostrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IntercambiarPeriodosClick(Sender: TObject);
    procedure QuHorarioParaleloCalcFields(DataSet: TDataSet);
    procedure DSParaleloDataChange(Sender: TObject; Field: TField);
    procedure QuParaleloCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FNombre: string;
    function GetCodDia: Integer;
    function GetCodHora: Integer;
  public
    { Public declarations }
    property CodDia: Integer read GetCodDia;
    property CodHora: Integer read GetCodHora;
  end;

implementation
uses
  HorColCm, FSelPeIn, DSource, DMaster, RelUtils;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

function THorarioParaleloForm.GetCodDia: Integer;
begin
  Result := ColKey[DrawGrid.Col - 1];
end;

function THorarioParaleloForm.GetCodHora: Integer;
begin
  Result := RowKey[DrawGrid.Row - 1];
end;

procedure THorarioParaleloForm.BtnMostrarClick(Sender: TObject);
begin
  inherited;
  Caption := Format('[%s %d] - %s %s %s', [SuperTitle,
    QuParalelo.FindField('CodHorario').AsInteger,
    QuParalelo.FindField('AbrNivel').AsString,
    QuParalelo.FindField('AbrEspecializacion').AsString,
    QuParalelo.FindField('NomParaleloId').AsString]);
  FNombre := MasterDataModule.StringsShowParalelo.Values[cbVerParalelo.Text];
  with SourceDataModule do
    ShowEditor(TbDia, TbHora, QuHorarioParalelo, TbPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
end;

procedure THorarioParaleloForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuParalelo.Open;
  cbVerParalelo.Items.Clear;
  QuHorarioParalelo.Open;
  LoadNames(MasterDataModule.StringsShowParalelo, cbVerParalelo.Items);
  cbVerParalelo.Text := cbVerParalelo.Items[0];
end;

procedure THorarioParaleloForm.IntercambiarPeriodosClick(Sender: TObject);
var
  iCodDia, iCodHora: Integer;
begin
  inherited;
  if SeleccionarPeriodo(iCodDia, iCodHora) then
  begin
    with SourceDataModule do
      MasterDataModule.IntercambiarPeriodos(
        TbHorario.FindField('CodHorario').AsInteger,
        QuParalelo.FindField('CodNivel').AsInteger,
        QuParalelo.FindField('CodEspecializacion').AsInteger,
        QuParalelo.FindField('CodParaleloId').AsInteger,
        CodDia, CodHora, iCodDia, iCodHora);
    QuHorarioParalelo.Refresh;
    BtnMostrarClick(nil);
  end;
end;

procedure THorarioParaleloForm.QuHorarioParaleloCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FNombre <> '' then
    DataSet['Nombre'] := VarArrToStr(DataSet[FNombre], ' ');
end;

procedure THorarioParaleloForm.QuParaleloCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet['NomParalelo'] := VarArrToStr(DataSet['AbrNivel;AbrEspecializacion;NomParaleloId'], ' ');
end;

procedure THorarioParaleloForm.DSParaleloDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  BtnMostrarClick(nil);
end;

initialization

{$IFDEF FPC}
  {$i FHorPara.lrs}
{$ENDIF}

end.

