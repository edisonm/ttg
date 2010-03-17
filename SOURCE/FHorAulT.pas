unit FHorAulT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Placemnt, StdCtrls, Buttons, ExtCtrls, Grids, FCrsMME0, Db, FCrsMME1,
  kbmMemTable, ImgList, ComCtrls, ToolWin, DBCtrls;

type
  THorarioAulaTipoForm = class(TCrossManyToManyEditor1Form)
    QuHorarioAulaTipo: TkbmMemTable;
    dlcAulaTipo: TDBLookupComboBox;
    cbVerAulaTipo: TComboBox;
    btn97Mostrar: TToolButton;
    btn97Next: TToolButton;
    btn97Prior: TToolButton;
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
    procedure btn97MostrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn97PriorClick(Sender: TObject);
    procedure btn97NextClick(Sender: TObject);
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
    kbmHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    if kbmHorarioDetalle.Locate('CodHorario', CodHorario, []) then
    begin
      kbmDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      kbmDistributivo.MasterFields := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      kbmDistributivo.MasterSource := dsHorarioDetalle;
      try
        QuHorarioAulaTipo.EmptyTable;
        while (kbmHorarioDetalleCodHorario.Value = CodHorario) and not kbmHorarioDetalle.Eof do
        begin
          QuHorarioAulaTipo.Append;
          QuHorarioAulaTipoCodAulaTipo.Value := kbmAulaTipoCodAulaTipo.Value;
          QuHorarioAulaTipoCodMateria.Value := kbmHorarioDetalleCodMateria.Value;
          QuHorarioAulaTipoCodNivel.Value := kbmHorarioDetalleCodNivel.Value;
          QuHorarioAulaTipoCodEspecializacion.Value := kbmHorarioDetalleCodEspecializacion.Value;
          QuHorarioAulaTipoCodParaleloId.Value := kbmHorarioDetalleCodParaleloId.Value;
          QuHorarioAulaTipoCodHora.Value := kbmHorarioDetalleCodHora.Value;
          QuHorarioAulaTipoCodDia.Value := kbmHorarioDetalleCodDia.Value;
          QuHorarioAulaTipo.Post;
          kbmHorarioDetalle.Next;
        end;
      finally
        kbmDistributivo.IndexFieldNames := '';
        kbmDistributivo.MasterFields := '';
        kbmDistributivo.MasterSource := nil;
      end;
    end;
  end;
end;

procedure THorarioAulaTipoForm.btn97MostrarClick(Sender: TObject);
var
  s: string;
begin
  inherited;
  with SourceDataModule, MasterDataModule do
  begin
    if varIsEmpty(dlcAulaTipo.KeyValue) then
      raise Exception.Create('Debe especificar un tipo de aula');
    s := Format('[%s %d] - %s', [kbmHorario.Name, CodHorario, dlcAulaTipo.Text]);
    Caption := s;
    FNombre := StringsShowAulaTipo.Values[cbVerAulaTipo.Text];
    ShowEditor(kbmDia, kbmHora, QuHorarioAulaTipo, kbmPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
  end;
end;

procedure THorarioAulaTipoForm.FormCreate(Sender: TObject);
begin
  inherited;
  CodHorario := SourceDataModule.kbmHorarioCodHorario.Value;
  cbVerAulaTipo.Items.Clear;
  FillHorarioAulaTipo;
  LoadNames(MasterDataModule.StringsShowAulaTipo, cbVerAulaTipo.Items);
  cbVerAulaTipo.Text := cbVerAulaTipo.Items[0];
  SourceDataModule.kbmAulaTipo.First;
  dlcAulaTipo.KeyValue := SourceDataModule.kbmAulaTipoCodAulaTipo.Value;
  btn97MostrarClick(nil);
end;

procedure THorarioAulaTipoForm.btn97PriorClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.kbmAulaTipo.Prior;
  dlcAulaTipo.KeyValue := SourceDataModule.kbmAulaTipoCodAulaTipo.AsInteger;
  btn97MostrarClick(nil);
end;

procedure THorarioAulaTipoForm.btn97NextClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.kbmAulaTipo.Next;
  dlcAulaTipo.KeyValue := SourceDataModule.kbmAulaTipoCodAulaTipo.Value;
  btn97MostrarClick(nil);
end;

procedure THorarioAulaTipoForm.QuHorarioAulaTipoCalcFields(
  DataSet: TDataSet);
begin
  inherited;
  if FNombre <> '' then
    DataSet['Nombre'] := VarArrToStr(DataSet[FNombre], ' ');
end;

end.

