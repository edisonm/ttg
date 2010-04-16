unit FHorAulT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Placemnt, StdCtrls, Buttons, ExtCtrls, Grids, RXGrids, FCrsMME0, Db,
  FCrsMME1, kbmMemTable, ImgList, ComCtrls, ToolWin, DBCtrls, Variants;

type
  THorarioAulaTipoForm = class(TCrossManyToManyEditor1Form)
    QuHorarioAulaTipo: TkbmMemTable;
    dlcAulaTipo: TDBLookupComboBox;
    cbVerAulaTipo: TComboBox;
    BtnMostrar: TToolButton;
    BtnNext: TToolButton;
    BtnPrior: TToolButton;
    QuHorarioAulaTipoCodMateria: TIntegerField;
    QuHorarioAulaTipoCodNivel: TIntegerField;
    QuHorarioAulaTipoCodEspecializacion: TIntegerField;
    QuHorarioAulaTipoCodParaleloId: TIntegerField;
    QuHorarioAulaTipoCodHora: TIntegerField;
    QuHorarioAulaTipoCodDia: TIntegerField;
    QuHorarioAulaTipoNomMateria: TStringField;
    QuHorarioAulaTipoAbrNivel: TStringField;
    QuHorarioAulaTipoAbrEspecializacion: TStringField;
    QuHorarioAulaTipoNomParaleloId: TStringField;
    QuHorarioAulaTipoNombre: TStringField;
    QuHorarioAulaTipoCodAulaTipo: TAutoIncField;
    procedure BtnMostrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnPriorClick(Sender: TObject);
    procedure BtnNextClick(Sender: TObject);
    procedure QuHorarioAulaTipoCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FCodHorario: Integer;
    FNombre: string;
    procedure FillHorarioAulaTipo;
  protected
  public
    { Public declarations }
    property CodHorario: Integer read FCodHorario write FCodHorario;
  end;

implementation
uses
  DMaster, HorColCm, FConfig, DSource;
{$R *.DFM}

procedure THorarioAulaTipoForm.FillHorarioAulaTipo;
begin
  with SourceDataModule do
  begin
    TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
    begin
      TbDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      TbDistributivo.MasterFields := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      TbDistributivo.MasterSource := dsHorarioDetalle;
      try
        QuHorarioAulaTipo.EmptyTable;
        while (TbHorarioDetalleCodHorario.Value = CodHorario) and not TbHorarioDetalle.Eof do
        begin
          QuHorarioAulaTipo.Append;
          QuHorarioAulaTipoCodAulaTipo.Value := TbAulaTipoCodAulaTipo.Value;
          QuHorarioAulaTipoCodMateria.Value := TbHorarioDetalleCodMateria.Value;
          QuHorarioAulaTipoCodNivel.Value := TbHorarioDetalleCodNivel.Value;
          QuHorarioAulaTipoCodEspecializacion.Value := TbHorarioDetalleCodEspecializacion.Value;
          QuHorarioAulaTipoCodParaleloId.Value := TbHorarioDetalleCodParaleloId.Value;
          QuHorarioAulaTipoCodHora.Value := TbHorarioDetalleCodHora.Value;
          QuHorarioAulaTipoCodDia.Value := TbHorarioDetalleCodDia.Value;
          QuHorarioAulaTipo.Post;
          TbHorarioDetalle.Next;
        end;
      finally
        TbDistributivo.IndexFieldNames := '';
        TbDistributivo.MasterFields := '';
        TbDistributivo.MasterSource := nil;
      end;
    end;
  end;
end;

procedure THorarioAulaTipoForm.BtnMostrarClick(Sender: TObject);
var
  s: string;
begin
  inherited;
  with SourceDataModule, MasterDataModule do
  begin
    if varIsEmpty(dlcAulaTipo.KeyValue) then
      raise Exception.Create('Debe especificar un tipo de aula');
    s := Format('[%s %d] - %s', [TbHorario.Name, CodHorario, dlcAulaTipo.Text]);
    Caption := s;
    FNombre := StringsShowAulaTipo.Values[cbVerAulaTipo.Text];
    ShowEditor(TbDia, TbHora, QuHorarioAulaTipo, TbPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
  end;
end;

procedure THorarioAulaTipoForm.FormCreate(Sender: TObject);
begin
  inherited;
  CodHorario := SourceDataModule.TbHorarioCodHorario.Value;
  cbVerAulaTipo.Items.Clear;
  FillHorarioAulaTipo;
  LoadNames(MasterDataModule.StringsShowAulaTipo, cbVerAulaTipo.Items);
  cbVerAulaTipo.Text := cbVerAulaTipo.Items[0];
  SourceDataModule.TbAulaTipo.First;
  dlcAulaTipo.KeyValue := SourceDataModule.TbAulaTipoCodAulaTipo.Value;
  BtnMostrarClick(nil);
end;

procedure THorarioAulaTipoForm.BtnPriorClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbAulaTipo.Prior;
  dlcAulaTipo.KeyValue := SourceDataModule.TbAulaTipoCodAulaTipo.AsInteger;
  BtnMostrarClick(nil);
end;

procedure THorarioAulaTipoForm.BtnNextClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbAulaTipo.Next;
  dlcAulaTipo.KeyValue := SourceDataModule.TbAulaTipoCodAulaTipo.Value;
  BtnMostrarClick(nil);
end;

procedure THorarioAulaTipoForm.QuHorarioAulaTipoCalcFields(
  DataSet: TDataSet);
begin
  inherited;
  if FNombre <> '' then
    DataSet['Nombre'] := VarArrToStr(DataSet[FNombre], ' ');
end;

end.

