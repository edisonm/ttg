unit FHorAulT;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, FCrsMME0, Db, FCrsMME1, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset,
  ImgList, ComCtrls, ToolWin, DBCtrls, Variants;

type
  THorarioAulaTipoForm = class(TCrossManyToManyEditor1Form)
    QuHorarioAulaTipo: TZQuery;
    dlcAulaTipo: TDBLookupComboBox;
    cbVerAulaTipo: TComboBox;
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
  DMaster, HorColCm, FConfig, DSource, RelUtils;

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
        while (TbHorarioDetalle.FindField('CodHorario').AsInteger = CodHorario) and not TbHorarioDetalle.Eof do
        begin
          QuHorarioAulaTipo.Append;
          QuHorarioAulaTipoCodAulaTipo.Value := TbDistributivo.FindField('CodAulaTipo').AsInteger;
          QuHorarioAulaTipoCodMateria.Value := TbHorarioDetalle.FindField('CodMateria').AsInteger;
          QuHorarioAulaTipoCodNivel.Value := TbHorarioDetalle.FindField('CodNivel').AsInteger;
          QuHorarioAulaTipoCodEspecializacion.Value := TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
          QuHorarioAulaTipoCodParaleloId.Value := TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
          QuHorarioAulaTipoCodHora.Value := TbHorarioDetalle.FindField('CodHora').AsInteger;
          QuHorarioAulaTipoCodDia.Value := TbHorarioDetalle.FindField('CodDia').AsInteger;
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
      SourceDataModule.TbAulaTipo.FindField('AbrAulaTipo').AsString]);
    FNombre := StringsShowAulaTipo.Values[cbVerAulaTipo.Text];
    ShowEditor(TbDia, TbHora, QuHorarioAulaTipo, TbPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
  end;
end;

procedure THorarioAulaTipoForm.FormCreate(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbAulaTipo.First;
  CodHorario := SourceDataModule.TbHorario.FindField('CodHorario').AsInteger;
  cbVerAulaTipo.Items.Clear;
  FillHorarioAulaTipo;
  QuHorarioAulaTipo.ParamByName('CodHorario').AsInteger := CodHorario;
  QuHorarioAulaTipo.Open;
  LoadNames(MasterDataModule.StringsShowAulaTipo, cbVerAulaTipo.Items);
  cbVerAulaTipo.Text := cbVerAulaTipo.Items[0];
end;

procedure THorarioAulaTipoForm.BtnPriorClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbAulaTipo.Prior;
  {$IFNDEF FPC}
  dlcAulaTipo.KeyValue := SourceDataModule.TbAulaTipo.FindField('CodAulaTipo').AsInteger;
  {$ENDIF}
end;

procedure THorarioAulaTipoForm.BtnNextClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbAulaTipo.Next;
  {$IFNDEF FPC}
  dlcAulaTipo.KeyValue := SourceDataModule.TbAulaTipo.FindField('CodAulaTipo').AsInteger;
  {$ENDIF}
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
