unit FHorPara;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  FCrsMMER, StdCtrls, Buttons, ExtCtrls, Grids, Variants, FCrsMME1, DBCtrls,
  SqlitePassDbo, ImgList, ComCtrls, ToolWin;

type
  THorarioParaleloForm = class(TCrossManyToManyEditor1Form)
    QuHorarioParalelo: TSqlitePassDataset;
    BtnIntercambiarPeriodos: TToolButton;
    cbVerParalelo: TComboBox;
    BtnPrior: TToolButton;
    BtnNext: TToolButton;
    QuHorarioParaleloCodMateria: TLargeintField;
    QuHorarioParaleloCodNivel: TLargeintField;
    QuHorarioParaleloCodEspecializacion: TLargeintField;
    QuHorarioParaleloCodParaleloId: TLargeintField;
    QuHorarioParaleloCodHora: TLargeintField;
    QuHorarioParaleloCodDia: TLargeintField;
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
  QuHorarioParalelo.OnCalcFields := QuHorarioParaleloCalcFields;
  PrepareQuery(QuHorarioParalelo, 'HorarioParalelo',
	       'CodNivel;CodEspecializacion;CodParaleloId');
  SourceDataModule.TbParalelo.First;
  CodHorario := SourceDataModule.TbHorario.FindField('CodHorario').AsInteger;
  cbVerParalelo.Items.Clear;
  FillHorarioParalelo;
  LoadNames(MasterDataModule.StringsShowParalelo, cbVerParalelo.Items);
  cbVerParalelo.Text := cbVerParalelo.Items[0];
  {$IFNDEF FPC}
  dlcParalelo.KeyValue := SourceDataModule.TbParalelo.FindField('CodParalelo').AsInteger;
  {$ENDIF}
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
  {$IFNDEF FPC}
  dlcParalelo.KeyValue := SourceDataModule.TbParalelo.FindField('CodParalelo').AsInteger;
  {$ENDIF}
end;

procedure THorarioParaleloForm.BtnNextClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbParalelo.Next;
  {$IFNDEF FPC}
  dlcParalelo.KeyValue := SourceDataModule.TbParalelo.FindField('CodParalelo').AsInteger;
  {$ENDIF}
end;

procedure THorarioParaleloForm.FillHorarioParalelo;
var
  CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId: Integer;
  s: string;
begin
  with SourceDataModule do
  begin
    CodHorario := TbHorario.FindField('CodHorario').AsInteger;
    TbHorarioDetalle.IndexedBy := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
    begin
      TbDistributivo.DisableControls;
      s := TbDistributivo.IndexedBy;
      TbDistributivo.IndexedBy := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      TbDistributivo.First;
      QuHorarioParalelo.DisableControls;
      try
        while (TbHorarioDetalle.FindField('CodHorario').AsInteger = CodHorario) and not TbHorarioDetalle.Eof do
        begin
          CodMateria := TbHorarioDetalle.FindField('CodMateria').AsInteger;
          CodNivel := TbHorarioDetalle.FindField('CodNivel').AsInteger;
          CodEspecializacion := TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
          CodParaleloId := TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
          while ((TbDistributivo.FindField('CodMateria').AsInteger <> CodMateria)
            or (TbDistributivo.FindField('CodNivel').AsInteger <> CodNivel)
            or (TbDistributivo.FindField('CodEspecializacion').AsInteger <> CodEspecializacion)
            or (TbDistributivo.FindField('CodParaleloId').AsInteger <> CodParaleloId))
            and not TbDistributivo.Eof do
            TbDistributivo.Next;
          QuHorarioParalelo.Append;
          QuHorarioParaleloCodProfesor.Value := TbDistributivo.FindField('CodProfesor').AsInteger;
          QuHorarioParaleloCodMateria.Value := CodMateria;
          QuHorarioParaleloCodNivel.Value := CodNivel;
          QuHorarioParaleloCodEspecializacion.Value := CodEspecializacion;
          QuHorarioParaleloCodParaleloId.Value := CodParaleloId;
          QuHorarioParaleloCodDia.Value := TbHorarioDetalle.FindField('CodDia').AsInteger;
          QuHorarioParaleloCodHora.Value := TbHorarioDetalle.FindField('CodHora').AsInteger;
          QuHorarioParalelo.Post;
          TbHorarioDetalle.Next;
        end;
      finally
        TbDistributivo.IndexedBy := s;
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

