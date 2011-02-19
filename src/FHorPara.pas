unit FHorPara;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  FCrsMMER, StdCtrls, Buttons, ExtCtrls, Grids, Variants, FCrsMME1, DBCtrls,
  ZConnection, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset, ImgList, ComCtrls, ToolWin;

type
  THorarioParaleloForm = class(TCrossManyToManyEditor1Form)
    QuHorarioParalelo: TZQuery;
    BtnIntercambiarPeriodos: TToolButton;
    cbVerParalelo: TComboBox;
    BtnPrior: TToolButton;
    BtnNext: TToolButton;
    QuHorarioParaleloCodMateria: TIntegerField;
    QuHorarioParaleloCodNivel: TIntegerField;
    QuHorarioParaleloCodEspecializacion: TIntegerField;
    QuHorarioParaleloCodParaleloId: TIntegerField;
    QuHorarioParaleloCodHora: TIntegerField;
    QuHorarioParaleloCodDia: TIntegerField;
    QuHorarioParaleloCodProfesor: TIntegerField;
    QuHorarioParaleloNomMateria: TStringField;
    QuHorarioParaleloApeNomProfesor: TStringField;
    QuHorarioParaleloNombre: TStringField;
    dlcParalelo: TDBLookupComboBox;
    DSParalelo: TDataSource;
    procedure BtnMostrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IntercambiarPeriodosClick(Sender: TObject);
    procedure BtnPriorClick(Sender: TObject);
    procedure BtnNextClick(Sender: TObject);
    procedure QuHorarioParaleloCalcFields(DataSet: TDataSet);
    procedure DSParaleloDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    FCodHorario: Integer;
    FNombre: string;
    function GetCodDia: Integer;
    function GetCodHora: Integer;
  public
    { Public declarations }
    property CodHorario: Integer read FCodHorario write FCodHorario;
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
  Caption := Format('[%s %d] - %s', [SuperTitle, CodHorario,
    SourceDataModule.TbParalelo.FindField('NomParalelo').AsString]);
  FNombre := MasterDataModule.StringsShowParalelo.Values[cbVerParalelo.Text];
  with SourceDataModule do
    ShowEditor(TbDia, TbHora, QuHorarioParalelo, TbPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
end;

procedure THorarioParaleloForm.FormCreate(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbParalelo.First;
  CodHorario := SourceDataModule.TbHorario.FindField('CodHorario').AsInteger;
  cbVerParalelo.Items.Clear;
  QuHorarioParalelo.ParamByName('CodHorario').AsInteger := CodHorario;
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
      MasterDataModule.IntercambiarPeriodos(CodHorario,
        TbParalelo.FindField('CodNivel').AsInteger,
        TbParalelo.FindField('CodEspecializacion').AsInteger,
        TbParalelo.FindField('CodParaleloId').AsInteger,
        CodDia, CodHora, iCodDia, iCodHora);
    BtnMostrarClick(nil);
  end;
end;

procedure THorarioParaleloForm.BtnPriorClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbParalelo.Prior;
end;

procedure THorarioParaleloForm.BtnNextClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbParalelo.Next;
end;

procedure THorarioParaleloForm.QuHorarioParaleloCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FNombre <> '' then
    DataSet['Nombre'] := VarArrToStr(DataSet[FNombre], ' ');
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

