unit FHorAulT;

{$I TTG.inc}

interface

uses
  LResources, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, FCrsMME0, Db, FCrsMME1, Sqlite3DS,
  ImgList, ComCtrls, ToolWin, DBCtrls, Variants;

type
  THorarioAulaTipoForm = class(TCrossManyToManyEditor1Form)
    QuHorarioAulaTipo: TSqlite3Dataset;
    dlcAulaTipo: TDBLookupComboBox;
    cbVerAulaTipo: TComboBox;
    BtnNext: TToolButton;
    BtnPrior: TToolButton;
    QuHorarioAulaTipoCodMateria: TLongIntField;
    QuHorarioAulaTipoCodNivel: TLongIntField;
    QuHorarioAulaTipoCodEspecializacion: TLongIntField;
    QuHorarioAulaTipoCodParaleloId: TLongIntField;
    QuHorarioAulaTipoCodHora: TLongIntField;
    QuHorarioAulaTipoCodDia: TLongIntField;
    QuHorarioAulaTipoNomMateria: TStringField;
    QuHorarioAulaTipoAbrNivel: TStringField;
    QuHorarioAulaTipoAbrEspecializacion: TStringField;
    QuHorarioAulaTipoNomParaleloId: TStringField;
    QuHorarioAulaTipoNombre: TStringField;
    QuHorarioAulaTipoCodAulaTipo: TAutoIncField;
    DSAulaTipo: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure BtnPriorClick(Sender: TObject);
    procedure BtnNextClick(Sender: TObject);
    procedure QuHorarioAulaTipoCalcFields(DataSet: TDataSet);
    procedure DSAulaTipoDataChange(Sender: TObject; Field: TField);
    procedure BtnMostrarClick(Sender: TObject);
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

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure THorarioAulaTipoForm.FillHorarioAulaTipo;
begin
  with SourceDataModule do
  begin
    TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    TbHorarioDetalle.First;
    if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
    begin
      TbDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      TbDistributivo.MasterFields := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      TbDistributivo.MasterSource := DSHorarioDetalle;
      try
        QuHorarioAulaTipo.EmptyTable;
        while (TbHorarioDetalleCodHorario.Value = CodHorario) and not TbHorarioDetalle.Eof do
        begin
          QuHorarioAulaTipo.Append;
          QuHorarioAulaTipoCodAulaTipo.Value := TbDistributivoCodAulaTipo.Value;
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
begin
  inherited;
  with SourceDataModule, MasterDataModule do
  begin
    Caption := Format('[%s %d] - %s', [SuperTitle, CodHorario,
      SourceDataModule.TbAulaTipoAbrAulaTipo.AsString]);
    FNombre := StringsShowAulaTipo.Values[cbVerAulaTipo.Text];
    ShowEditor(TbDia, TbHora, QuHorarioAulaTipo, TbPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
  end;
end;

procedure THorarioAulaTipoForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuHorarioAulaTipo.AddIndex('QuHorarioAulaTipoIxCodAulaTipo', 'CodAulaTipo', []);
  CodHorario := SourceDataModule.TbHorarioCodHorario.Value;
  cbVerAulaTipo.Items.Clear;
  FillHorarioAulaTipo;
  LoadNames(MasterDataModule.StringsShowAulaTipo, cbVerAulaTipo.Items);
  cbVerAulaTipo.Text := cbVerAulaTipo.Items[0];
  SourceDataModule.TbAulaTipo.First;
  dlcAulaTipo.KeyValue := SourceDataModule.TbAulaTipoCodAulaTipo.Value;
end;

procedure THorarioAulaTipoForm.BtnPriorClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbAulaTipo.Prior;
  dlcAulaTipo.KeyValue := SourceDataModule.TbAulaTipoCodAulaTipo.AsInteger;
end;

procedure THorarioAulaTipoForm.BtnNextClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbAulaTipo.Next;
  dlcAulaTipo.KeyValue := SourceDataModule.TbAulaTipoCodAulaTipo.Value;
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
