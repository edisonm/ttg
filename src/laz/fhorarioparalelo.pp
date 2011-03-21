{ -*- mode: Delphi -*- }
unit FHorarioParalelo;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, Db, FCrossManytoManyEditorR, StdCtrls, Buttons, ExtCtrls,
  Grids, Variants, FCrossManyToManyEditor1, DBCtrls, ZConnection, DBGrids, ZDataset, ComCtrls,
  FSelPeriodo, DSource, DMaster;

type

  { THorarioParaleloForm }

  THorarioParaleloForm = class(TCrossManyToManyEditor1Form)
    QuHorarioParalelo: TZQuery;
    BtnIntercambiarPeriodos: TToolButton;
    cbVerParalelo: TComboBox;
    QuHorarioParaleloCodMateria: TLongintField;
    QuHorarioParaleloCodNivel: TLongintField;
    QuHorarioParaleloCodEspecializacion: TLongintField;
    QuHorarioParaleloCodParaleloId: TLongintField;
    QuHorarioParaleloCodHora: TLongintField;
    QuHorarioParaleloCodDia: TLongintField;
    QuHorarioParaleloCodProfesor: TLongintField;
    QuHorarioParaleloNombre: TStringField;
    DSParalelo: TDataSource;
    QuHorarioParaleloNomMateria: TStringField;
    QuParalelo: TZQuery;
    QuParaleloCodHorario: TLongintField;
    QuParaleloCodNivel: TLongintField;
    QuParaleloCodEspecializacion: TLongintField;
    QuParaleloCodParaleloId: TLongintField;
    QuParaleloAbrNivel: TStringField;
    QuParaleloAbrEspecializacion: TStringField;
    QuParaleloNomParaleloId: TStringField;
    QuHorarioParaleloCodHorario: TLongintField;
    QuHorarioParaleloApeProfesor: TStringField;
    QuHorarioParaleloNomProfesor: TStringField;
    DBGrid1: TDBGrid;
    QuParaleloNomParalelo: TStringField;
    Splitter1: TSplitter;
    DBNavigator: TDBNavigator;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnMostrarClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure DrawGridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure DrawGridSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure DrawGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IntercambiarPeriodosClick(Sender: TObject);
    procedure QuHorarioParaleloCalcFields(DataSet: TDataSet);
    procedure DSParaleloDataChange(Sender: TObject; Field: TField);
    procedure QuParaleloCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FNombre: string;
    function GetCodDia: Integer;
    function GetCodHora: Integer;
  public
    { Public declarations }
    property CodDia: Integer read GetCodDia;
    property CodHora: Integer read GetCodHora;
  end;

implementation

uses
  UTTGDBUtils, UTTGBasics;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

function THorarioParaleloForm.GetCodDia: Integer;
begin
  Result := ColKey[DrawGrid.Col - 1];
end;

function THorarioParaleloForm.GetCodHora: Integer;
begin
  Result := RowKey[DrawGrid.Row - 1];
end;

procedure THorarioParaleloForm.BtnMostrarClick(Sender: TObject);
begin
  inherited;
  Caption := Format('[%s %d] - %s %s %s', [SuperTitle,
    QuParalelo.FindField('CodHorario').AsInteger,
    QuParalelo.FindField('AbrNivel').AsString,
    QuParalelo.FindField('AbrEspecializacion').AsString,
    QuParalelo.FindField('NomParaleloId').AsString]);
  FNombre := MasterDataModule.StringsShowParalelo.Values[cbVerParalelo.Text];
  with SourceDataModule do
    ShowEditor(TbDia, TbHora, QuHorarioParalelo, TbPeriodo, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
end;

procedure THorarioParaleloForm.BtnCancelClick(Sender: TObject);
begin
  inherited;
end;

procedure THorarioParaleloForm.BtnOkClick(Sender: TObject);
begin
  inherited;
end;

procedure THorarioParaleloForm.DrawGridDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  inherited;
end;

procedure THorarioParaleloForm.DrawGridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  inherited;
end;

procedure THorarioParaleloForm.DrawGridSelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  inherited;
end;

procedure THorarioParaleloForm.DrawGridSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  inherited;
end;

procedure THorarioParaleloForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  inherited;
end;

procedure THorarioParaleloForm.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
  inherited;
end;

procedure THorarioParaleloForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuParalelo.Open;
  cbVerParalelo.Items.Clear;
  QuHorarioParalelo.Open;
  LoadNames(MasterDataModule.StringsShowParalelo, cbVerParalelo.Items);
  cbVerParalelo.Text := cbVerParalelo.Items[0];
end;

procedure THorarioParaleloForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure THorarioParaleloForm.IntercambiarPeriodosClick(Sender: TObject);
var
  iCodDia, iCodHora: Integer;
begin
  inherited;
  if TSelPeriodoForm.SeleccionarPeriodo(iCodDia, iCodHora) then
  begin
    with SourceDataModule do
      MasterDataModule.IntercambiarPeriodos(
        TbHorario.FindField('CodHorario').AsInteger,
        QuParalelo.FindField('CodNivel').AsInteger,
        QuParalelo.FindField('CodEspecializacion').AsInteger,
        QuParalelo.FindField('CodParaleloId').AsInteger,
        CodDia, CodHora, iCodDia, iCodHora);
    QuHorarioParalelo.Refresh;
    BtnMostrarClick(nil);
  end;
end;

procedure THorarioParaleloForm.QuHorarioParaleloCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FNombre <> '' then
    DataSet['Nombre'] := VarArrToStr(DataSet[FNombre], ' ');
end;

procedure THorarioParaleloForm.QuParaleloCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet['NomParalelo'] := VarArrToStr(DataSet['AbrNivel;AbrEspecializacion;NomParaleloId'], ' ');
end;

procedure THorarioParaleloForm.DSParaleloDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  BtnMostrarClick(nil);
end;

initialization

{$IFDEF FPC}
  {$i fhorarioparalelo.lrs}
{$ENDIF}

end.

