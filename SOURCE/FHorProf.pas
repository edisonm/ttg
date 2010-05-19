unit FHorProf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, FCrsMME0, Db, FCrsMME1, dbf,
  ImgList, ComCtrls, ToolWin, DBCtrls, Variants;

type
  THorarioProfesorForm = class(TCrossManyToManyEditor1Form)
    QuHorarioProfesor: TDbf;
    dlcProfesor: TDBLookupComboBox;
    cbVerProfesor: TComboBox;
    BtnNext: TToolButton;
    BtnPrior: TToolButton;
    QuHorarioProfesorCodNivel: TIntegerField;
    QuHorarioProfesorCodEspecializacion: TIntegerField;
    QuHorarioProfesorCodParaleloId: TIntegerField;
    QuHorarioProfesorCodHora: TIntegerField;
    QuHorarioProfesorCodDia: TIntegerField;
    QuHorarioProfesorCodMateria: TIntegerField;
    QuHorarioProfesorCodProfesor: TIntegerField;
    QuHorarioProfesorNomMateria: TStringField;
    QuHorarioProfesorNombre: TStringField;
    QuHorarioProfesorAbrNivel: TStringField;
    QuHorarioProfesorAbrEspecializacion: TStringField;
    QuHorarioProfesorNomParaleloId: TStringField;
    DSProfesor: TDataSource;
    procedure BtnMostrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnPriorClick(Sender: TObject);
    procedure BtnNextClick(Sender: TObject);
    procedure QuHorarioProfesorCalcFields(DataSet: TDataSet);
    procedure DSProfesorDataChange(Sender: TObject; Field: TField);
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

procedure THorarioProfesorForm.BtnMostrarClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    Caption := Format('[%s %d] - %s', [SuperTitle, CodHorario,
      SourceDataModule.TbProfesorApeNomProfesor.AsString]);
    FNombre := MasterDataModule.StringsShowProfesor.Values[cbVerProfesor.Text];
    ShowEditor(TbDia, TbHora, QuHorarioProfesor, TbPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
  end;
end;

procedure THorarioProfesorForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuHorarioProfesor.AddIndex('QuHorarioProfesorIndex1', 'CodProfesor', []);
  QuHorarioProfesor.Open;
  CodHorario := SourceDataModule.TbHorarioCodHorario.Value;
  SourceDataModule.TbProfesor.First;
  cbVerProfesor.Items.Clear;
  FillHorarioProfesor;
  LoadNames(MasterDataModule.StringsShowProfesor, cbVerProfesor.Items);
  cbVerProfesor.Text := cbVerProfesor.Items[0];
  dlcProfesor.KeyValue := SourceDataModule.TbProfesorCodProfesor.Value;
end;

procedure THorarioProfesorForm.BtnPriorClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbProfesor.Prior;
  dlcProfesor.KeyValue := SourceDataModule.TbProfesorCodProfesor.Value;
end;

procedure THorarioProfesorForm.BtnNextClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbProfesor.Next;
  dlcProfesor.KeyValue := SourceDataModule.TbProfesorCodProfesor.Value;
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
        while (TbHorarioDetalleCodHorario.Value = CodHorario)
	    and not TbHorarioDetalle.Eof do
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

end.

