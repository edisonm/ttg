unit FHorPara;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  FCrsMMER, StdCtrls, Buttons, ExtCtrls, Grids, Variants, FCrsMME1, DBCtrls,
  kbmMemTable, ImgList, ComCtrls, ToolWin;

type
  THorarioParaleloForm = class(TCrossManyToManyEditor1Form)
    QuHorarioParalelo: TkbmMemTable;
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
    QuHorarioParaleloCodProfesor: TAutoIncField;
    QuHorarioParaleloNomMateria: TStringField;
    QuHorarioParaleloApeNomProfesor: TStringField;
    QuHorarioParaleloNombre: TStringField;
    DSParalelo: TDataSource;
    dlcParalelo: TDBLookupComboBox;
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
    procedure FillHorarioParalelo;
  public
    { Public declarations }
    property CodHorario: Integer read FCodHorario write FCodHorario;
    property CodDia: Integer read GetCodDia;
    property CodHora: Integer read GetCodHora;
  end;

implementation
uses
  HorColCm, FSelPeIn, DSource, DMaster;

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
    SourceDataModule.TbParaleloNomParalelo.AsString]);
  FNombre := MasterDataModule.StringsShowParalelo.Values[cbVerParalelo.Text];
  with SourceDataModule do
    ShowEditor(TbDia, TbHora, QuHorarioParalelo, TbPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
end;

procedure THorarioParaleloForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuHorarioParalelo.OnCalcFields := QuHorarioParaleloCalcFields;
  QuHorarioParalelo.AddIndex('QuHorarioParaleloIxParalelo', 'CodNivel;CodEspecializacion;CodParaleloId', []);
  SourceDataModule.TbParalelo.First;
  QuHorarioParalelo.Open;
  CodHorario := SourceDataModule.TbHorarioCodHorario.Value;
  cbVerParalelo.Items.Clear;
  FillHorarioParalelo;
  LoadNames(MasterDataModule.StringsShowParalelo, cbVerParalelo.Items);
  cbVerParalelo.Text := cbVerParalelo.Items[0];
  dlcParalelo.KeyValue := SourceDataModule.TbParaleloCodParalelo.AsInteger;
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
        TbParaleloCodNivel.AsInteger,
        TbParaleloCodEspecializacion.AsInteger,
        TbParaleloCodParaleloId.AsInteger,
        CodDia, CodHora, iCodDia, iCodHora);
    BtnMostrarClick(nil);
  end;
end;

procedure THorarioParaleloForm.BtnPriorClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbParalelo.Prior;
  dlcParalelo.KeyValue := SourceDataModule.TbParaleloCodParalelo.AsInteger;
end;

procedure THorarioParaleloForm.BtnNextClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbParalelo.Next;
  dlcParalelo.KeyValue := SourceDataModule.TbParaleloCodParalelo.AsInteger;
end;

procedure THorarioParaleloForm.FillHorarioParalelo;
var
  CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId: Integer;
  s: string;
begin
  with SourceDataModule do
  begin
    QuHorarioParalelo.EmptyTable;
    CodHorario := TbHorarioCodHorario.Value;
    TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
    begin
      TbDistributivo.DisableControls;
      s := TbDistributivo.IndexFieldNames;
      TbDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      TbDistributivo.First;
      QuHorarioParalelo.DisableControls;
      try
        while (TbHorarioDetalleCodHorario.Value = CodHorario) and not TbHorarioDetalle.Eof do
        begin
          CodMateria := TbHorarioDetalleCodMateria.Value;
          CodNivel := TbHorarioDetalleCodNivel.Value;
          CodEspecializacion := TbHorarioDetalleCodEspecializacion.Value;
          CodParaleloId := TbHorarioDetalleCodParaleloId.Value;
          while ((TbDistributivoCodMateria.Value <> CodMateria)
            or (TbDistributivoCodNivel.Value <> CodNivel)
            or (TbDistributivoCodEspecializacion.Value <> CodEspecializacion)
            or (TbDistributivoCodParaleloId.Value <> CodParaleloId))
            and not TbDistributivo.Eof do
            TbDistributivo.Next;
          QuHorarioParalelo.Append;
          QuHorarioParaleloCodProfesor.Value := TbDistributivoCodProfesor.Value;
          QuHorarioParaleloCodMateria.Value := CodMateria;
          QuHorarioParaleloCodNivel.Value := CodNivel;
          QuHorarioParaleloCodEspecializacion.Value := CodEspecializacion;
          QuHorarioParaleloCodParaleloId.Value := CodParaleloId;
          QuHorarioParaleloCodDia.Value := TbHorarioDetalleCodDia.Value;
          QuHorarioParaleloCodHora.Value := TbHorarioDetalleCodHora.Value;
          QuHorarioParalelo.Post;
          TbHorarioDetalle.Next;
        end;
      finally
        TbDistributivo.IndexFieldNames := s;
        TbDistributivo.EnableControls;
        QuHorarioParalelo.EnableControls;
      end;
    end;
  end;
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

