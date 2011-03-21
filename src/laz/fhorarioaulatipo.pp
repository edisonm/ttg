{ -*- mode: Delphi -*- }
unit FHorarioAulaTipo;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Db,
  FCrossManyToManyEditor0, FCrossManyToManyEditor1, FCrossManyToManyEditor, DBGrids, ComCtrls, DBCtrls, Variants,
  ZConnection, ZDataset;

type

  { THorarioAulaTipoForm }

  THorarioAulaTipoForm = class(TCrossManyToManyEditor1Form)
    QuHorarioAulaTipo: TZQuery;
    cbVerAulaTipo: TComboBox;
    QuHorarioAulaTipoCodMateria: TLongintField;
    QuHorarioAulaTipoCodNivel: TLongintField;
    QuHorarioAulaTipoCodEspecializacion: TLongintField;
    QuHorarioAulaTipoCodParaleloId: TLongintField;
    QuHorarioAulaTipoCodHora: TLongintField;
    QuHorarioAulaTipoCodDia: TLongintField;
    QuHorarioAulaTipoNomMateria: TStringField;
    QuHorarioAulaTipoAbrNivel: TStringField;
    QuHorarioAulaTipoAbrEspecializacion: TStringField;
    QuHorarioAulaTipoNomParaleloId: TStringField;
    QuHorarioAulaTipoNombre: TStringField;
    DSAulaTipo: TDataSource;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    QuAulaTipo: TZQuery;
    QuAulaTipoCodHorario: TLongintField;
    QuAulaTipoCodAulaTipo: TLongintField;
    QuAulaTipoAbrAulaTipo: TStringField;
    QuHorarioAulaTipoCodHorario: TLongintField;
    QuHorarioAulaTipoCodAulaTipo: TLongintField;
    DBNavigator: TDBNavigator;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure DrawGridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure DrawGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure DrawGridSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QuHorarioAulaTipoCalcFields(DataSet: TDataSet);
    procedure DSAulaTipoDataChange(Sender: TObject; Field: TField);
    procedure BtnMostrarClick(Sender: TObject);
  private
    { Private declarations }
    FNombre: string;
  protected
  public
    { Public declarations }
  end;

implementation
uses
  DMaster, UTTGBasics, FConfiguracion, DSource;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure THorarioAulaTipoForm.BtnMostrarClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule, MasterDataModule do
  begin
    Caption := Format('[%s %d] - %s', [SuperTitle,
      QuAulaTipo.FindField('CodHorario').AsInteger,
      QuAulaTipo.FindField('AbrAulaTipo').AsString]);
    FNombre := StringsShowAulaTipo.Values[cbVerAulaTipo.Text];
    ShowEditor(TbDia, TbHora, QuHorarioAulaTipo, TbPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
  end;
end;

procedure THorarioAulaTipoForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuAulaTipo.Open;
  cbVerAulaTipo.Items.Clear;
  QuHorarioAulaTipo.Open;
  LoadNames(MasterDataModule.StringsShowAulaTipo, cbVerAulaTipo.Items);
  cbVerAulaTipo.Text := cbVerAulaTipo.Items[0];
end;

procedure THorarioAulaTipoForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure THorarioAulaTipoForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  inherited;
end;

procedure THorarioAulaTipoForm.BtnOkClick(Sender: TObject);
begin
  inherited;
end;

procedure THorarioAulaTipoForm.DrawGridDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  inherited;
end;

procedure THorarioAulaTipoForm.DrawGridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  inherited;
end;

procedure THorarioAulaTipoForm.DrawGridSetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  inherited;
end;

procedure THorarioAulaTipoForm.DrawGridSelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  inherited;
end;

procedure THorarioAulaTipoForm.BtnCancelClick(Sender: TObject);
begin
  inherited;
end;

procedure THorarioAulaTipoForm.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
  inherited;
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
  {$i fhorarioaulatipo.lrs}
{$ENDIF}

end.
