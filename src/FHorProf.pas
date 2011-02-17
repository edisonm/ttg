unit FHorProf;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, FCrsMME0, Db, FCrsMME1, SqlitePassDbo,
  ImgList, ComCtrls, ToolWin, DBCtrls, Variants;

type
  THorarioProfesorForm = class(TCrossManyToManyEditor1Form)
    QuHorarioProfesor: TSqlitePassDataset;
    dlcProfesor: TDBLookupComboBox;
    cbVerProfesor: TComboBox;
    BtnNext: TToolButton;
    BtnPrior: TToolButton;
    QuHorarioProfesorCodNivel: TLargeintField;
    QuHorarioProfesorCodEspecializacion: TLargeintField;
    QuHorarioProfesorCodParaleloId: TLargeintField;
    QuHorarioProfesorCodHora: TLargeintField;
    QuHorarioProfesorCodDia: TLargeintField;
    QuHorarioProfesorCodMateria: TLargeintField;
    QuHorarioProfesorCodProfesor: TAutoIncField;
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
  HorColCm, FConfig, DMaster, DSource, RelUtils;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure THorarioProfesorForm.BtnMostrarClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    Caption := Format('[%s %d] - %s', [SuperTitle, CodHorario,
      SourceDataModule.TbProfesor.FindField('ApeNomProfesor').AsString]);
    FNombre := MasterDataModule.StringsShowProfesor.Values[cbVerProfesor.Text];
    ShowEditor(TbDia, TbHora, QuHorarioProfesor, TbPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
  end;
end;

procedure THorarioProfesorForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuHorarioProfesor.OnCalcFields := QuHorarioProfesorCalcFields;
  PrepareQuery(QuHorarioProfesor, 'HorarioProfesor', 'CodProfesor');
  CodHorario := SourceDataModule.TbHorario.FindField('CodHorario').AsInteger;
  SourceDataModule.TbProfesor.First;
  cbVerProfesor.Items.Clear;
  FillHorarioProfesor;
  LoadNames(MasterDataModule.StringsShowProfesor, cbVerProfesor.Items);
  cbVerProfesor.Text := cbVerProfesor.Items[0];
  {$IFNDEF FPC}
  dlcProfesor.KeyValue := SourceDataModule.TbProfesor.FindField('CodProfesor').AsInteger;
  {$ENDIF}
end;

procedure THorarioProfesorForm.BtnPriorClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbProfesor.Prior;
  {$IFNDEF FPC}
  dlcProfesor.KeyValue := SourceDataModule.TbProfesor.FindField('CodProfesor').AsInteger;
  {$ENDIF}
end;

procedure THorarioProfesorForm.BtnNextClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbProfesor.Next;
  {$IFNDEF FPC}
  dlcProfesor.KeyValue := SourceDataModule.TbProfesor.FindField('CodProfesor').AsInteger;
  {$ENDIF}
end;

procedure THorarioProfesorForm.FillHorarioProfesor;
var
  CodMateria, CodNivel, CodEspecializacion, CodParaleloId: Integer;
begin
  with SourceDataModule do
  begin
    TbHorarioDetalle.IndexedBy := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
    begin
      TbDistributivo.IndexedBy := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      try
        TbDistributivo.First;
        while (TbHorarioDetalle.FindField('CodHorario').AsInteger = CodHorario)
	    and not TbHorarioDetalle.Eof do
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
          QuHorarioProfesor.Append;
          QuHorarioProfesorCodProfesor.Value        := TbDistributivo.FindField('CodProfesor').AsInteger;
          QuHorarioProfesorCodMateria.Value         := TbHorarioDetalle.FindField('CodMateria').AsInteger;
          QuHorarioProfesorCodNivel.Value           := TbHorarioDetalle.FindField('CodNivel').AsInteger;
          QuHorarioProfesorCodEspecializacion.Value := TbHorarioDetalle.FindField('CodEspecializacion').AsInteger;
          QuHorarioProfesorCodParaleloId.Value      := TbHorarioDetalle.FindField('CodParaleloId').AsInteger;
          QuHorarioProfesorCodHora.Value            := TbHorarioDetalle.FindField('CodHora').AsInteger;
          QuHorarioProfesorCodDia.Value             := TbHorarioDetalle.FindField('CodDia').AsInteger;
          QuHorarioProfesor.Post;
          TbHorarioDetalle.Next;
        end;
      finally
        TbDistributivo.IndexedBy := '';
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

initialization
{$IFDEF FPC}
  {$i FHorProf.lrs}
{$ENDIF}

end.
