unit FHorProf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Placemnt, StdCtrls, Buttons, ExtCtrls, Grids, RXGrids, FCrsMME0, Db,
  FCrsMME1, kbmMemTable, ImgList, ComCtrls, ToolWin, DBCtrls;

type
  THorarioProfesorForm = class(TCrossManyToManyEditor1Form)
    QuHorarioProfesor: TkbmMemTable;
    dlcProfesor: TDBLookupComboBox;
    cbVerProfesor: TComboBox;
    btn97Mostrar: TToolButton;
    btn97Next: TToolButton;
    btn97Prior: TToolButton;
    QuHorarioProfesorCodNivel: TIntegerField;
    QuHorarioProfesorCodEspecializacion: TIntegerField;
    QuHorarioProfesorCodParaleloId: TIntegerField;
    QuHorarioProfesorCodHora: TIntegerField;
    QuHorarioProfesorCodDia: TIntegerField;
    QuHorarioProfesorCodMateria: TIntegerField;
    QuHorarioProfesorCodProfesor: TAutoIncField;
    QuHorarioProfesorNomMateria: TStringField;
    QuHorarioProfesorNombre: TStringField;
    QuHorarioProfesorAbrNivel: TStringField;
    QuHorarioProfesorAbrEspecializacion: TStringField;
    QuHorarioProfesorNomParaleloId: TStringField;
    procedure btn97MostrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn97PriorClick(Sender: TObject);
    procedure btn97NextClick(Sender: TObject);
    procedure QuHorarioProfesorCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FCodHorario: Integer;
    FNombre: string;
    procedure FillHorarioProfesor;
  protected
  public
    { Public declarations }
    property CodHorario: Integer read FCodHorario write FCodHorario;
  end;

implementation
uses
  HorColCm, FConfig, DMaster, DSource;
{$R *.DFM}

procedure THorarioProfesorForm.btn97MostrarClick(Sender: TObject);
var
  s: string;
begin
  inherited;
  with SourceDataModule, MasterDataModule do
  begin
    if varIsEmpty(dlcProfesor.KeyValue) then
      raise Exception.Create('Debe especificar un Profesor');
    s := Format('[%s %d] - %s', [Description[TbHorario], CodHorario,
      dlcProfesor.Text]);
    Caption := s;
    FNombre := StringsShowProfesor.Values[cbVerProfesor.Text];
    ShowEditor(TbDia, TbHora, QuHorarioProfesor, TbPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
  end;
end;

procedure THorarioProfesorForm.FormCreate(Sender: TObject);
begin
  inherited;
  CodHorario := SourceDataModule.TbHorarioCodHorario.Value;
  SourceDataModule.TbProfesor.First;
  cbVerProfesor.Items.Clear;
  FillHorarioProfesor;
  LoadNames(MasterDataModule.StringsShowProfesor, cbVerProfesor.Items);
  cbVerProfesor.Text := cbVerProfesor.Items[0];
  dlcProfesor.KeyValue := SourceDataModule.TbProfesorCodProfesor.Value;
  btn97MostrarClick(nil);
end;

procedure THorarioProfesorForm.btn97PriorClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbProfesor.Prior;
  dlcProfesor.KeyValue := SourceDataModule.TbProfesorCodProfesor.Value;
  btn97MostrarClick(nil);
end;

procedure THorarioProfesorForm.btn97NextClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbProfesor.Next;
  dlcProfesor.KeyValue := SourceDataModule.TbProfesorCodProfesor.Value;
  btn97MostrarClick(nil);
end;

procedure THorarioProfesorForm.FillHorarioProfesor;
var
  CodMateria, CodNivel, CodEspecializacion, CodParaleloId: Integer;
begin
  with SourceDataModule do
  begin
    TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
    begin
      TbDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      try
        QuHorarioProfesor.EmptyTable;
        TbDistributivo.First;
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
          QuHorarioProfesor.Append;
          QuHorarioProfesorCodProfesor.Value        := TbDistributivoCodProfesor.Value;
          QuHorarioProfesorCodMateria.Value         := TbHorarioDetalleCodMateria.Value;
          QuHorarioProfesorCodNivel.Value           := TbHorarioDetalleCodNivel.Value;
          QuHorarioProfesorCodEspecializacion.Value := TbHorarioDetalleCodEspecializacion.Value;
          QuHorarioProfesorCodParaleloId.Value      := TbHorarioDetalleCodParaleloId.Value;
          QuHorarioProfesorCodHora.Value            := TbHorarioDetalleCodHora.Value;
          QuHorarioProfesorCodDia.Value             := TbHorarioDetalleCodDia.Value;
          QuHorarioProfesor.Post;
          TbHorarioDetalle.Next;
        end;
      finally
        TbDistributivo.IndexFieldNames := '';
      end;
    end;
  end;
end;

procedure THorarioProfesorForm.QuHorarioProfesorCalcFields(
  DataSet: TDataSet);
begin
  inherited;
  if FNombre <> '' then
    DataSet['Nombre'] := VarArrToStr(DataSet[FNombre], ' ');
end;

end.

