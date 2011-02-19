unit FHorProf;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, FCrsMME0, Db, FCrsMME1, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset,
  ImgList, ComCtrls, ToolWin, DBCtrls, Variants;

type
  THorarioProfesorForm = class(TCrossManyToManyEditor1Form)
    QuHorarioProfesor: TZQuery;
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
  SourceDataModule.TbProfesor.First;
  CodHorario := SourceDataModule.TbHorario.FindField('CodHorario').AsInteger;
  cbVerProfesor.Items.Clear;
  QuHorarioProfesor.ParamByName('CodHorario').AsInteger := CodHorario;
  QuHorarioProfesor.Open;
  LoadNames(MasterDataModule.StringsShowProfesor, cbVerProfesor.Items);
  cbVerProfesor.Text := cbVerProfesor.Items[0];
end;

procedure THorarioProfesorForm.BtnPriorClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbProfesor.Prior;
end;

procedure THorarioProfesorForm.BtnNextClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbProfesor.Next;
  {$IFNDEF FPC}
  dlcProfesor.KeyValue := SourceDataModule.TbProfesor.FindField('CodProfesor').AsInteger;
  {$ENDIF}
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
