unit FHorProf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Placemnt, StdCtrls, Buttons, ExtCtrls, Grids, RXGrids, RxLookup, FCrsMME0, Db,
  FCrsMME1, kbmMemTable, ImgList, ComCtrls, ToolWin;

type
  THorarioProfesorForm = class(TCrossManyToManyEditor1Form)
    QuHorarioProfesor: TkbmMemTable;
    dlcProfesor: TRxDBLookupCombo;
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
  DMaster, HorColCm, FConfig, DSource;
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
    s := Format('[%s %d] - %s', [Description[kbmHorario], CodHorario,
      dlcProfesor.Text]);
    Caption := s;
    FNombre := StrHolderShowProfesor.Strings.Values[cbVerProfesor.Text];
    ShowEditor(kbmDia, kbmHora, QuHorarioProfesor, kbmPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
  end;
end;

procedure THorarioProfesorForm.FormCreate(Sender: TObject);
begin
  inherited;
  CodHorario := SourceDataModule.kbmHorarioCodHorario.Value;
  SourceDataModule.kbmProfesor.First;
  cbVerProfesor.Items.Clear;
  FillHorarioProfesor;
  LoadNames(MasterDataModule.StrHolderShowProfesor.Strings, cbVerProfesor.Items);
  cbVerProfesor.Text := cbVerProfesor.Items[0];
  dlcProfesor.KeyValue := SourceDataModule.kbmProfesorCodProfesor.Value;
  btn97MostrarClick(nil);
end;

procedure THorarioProfesorForm.btn97PriorClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.kbmProfesor.Prior;
  dlcProfesor.KeyValue := SourceDataModule.kbmProfesorCodProfesor.Value;
  btn97MostrarClick(nil);
end;

procedure THorarioProfesorForm.btn97NextClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.kbmProfesor.Next;
  dlcProfesor.KeyValue := SourceDataModule.kbmProfesorCodProfesor.Value;
  btn97MostrarClick(nil);
end;

procedure THorarioProfesorForm.FillHorarioProfesor;
var
  CodMateria, CodNivel, CodEspecializacion, CodParaleloId: Integer;
begin
  with SourceDataModule do
  begin
    kbmHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    if kbmHorarioDetalle.Locate('CodHorario', CodHorario, []) then
    begin
      kbmDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      try
        QuHorarioProfesor.EmptyTable;
        kbmDistributivo.First;
        while (kbmHorarioDetalleCodHorario.Value = CodHorario) and not kbmHorarioDetalle.Eof do
        begin
          CodMateria := kbmHorarioDetalleCodMateria.Value;
          CodNivel := kbmHorarioDetalleCodNivel.Value;
          CodEspecializacion := kbmHorarioDetalleCodEspecializacion.Value;
          CodParaleloId := kbmHorarioDetalleCodParaleloId.Value;
          while ((kbmDistributivoCodMateria.Value <> CodMateria)
            or (kbmDistributivoCodNivel.Value <> CodNivel)
            or (kbmDistributivoCodEspecializacion.Value <> CodEspecializacion)
            or (kbmDistributivoCodParaleloId.Value <> CodParaleloId))
            and not kbmDistributivo.Eof do
            kbmDistributivo.Next;
          QuHorarioProfesor.Append;
          QuHorarioProfesorCodProfesor.Value := kbmDistributivoCodProfesor.Value;
          QuHorarioProfesorCodMateria.Value := kbmHorarioDetalleCodMateria.Value;
          QuHorarioProfesorCodNivel.Value := kbmHorarioDetalleCodNivel.Value;
          QuHorarioProfesorCodEspecializacion.Value := kbmHorarioDetalleCodEspecializacion.Value;
          QuHorarioProfesorCodParaleloId.Value := kbmHorarioDetalleCodParaleloId.Value;
          QuHorarioProfesorCodHora.Value := kbmHorarioDetalleCodHora.Value;
          QuHorarioProfesorCodDia.Value := kbmHorarioDetalleCodDia.Value;
          QuHorarioProfesor.Post;
          kbmHorarioDetalle.Next;
        end;
      finally
        kbmDistributivo.IndexFieldNames := '';
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

