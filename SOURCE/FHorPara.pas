unit FHorPara;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FCrsMMER, Placemnt, StdCtrls, Buttons, ExtCtrls, Grids, RXGrids, RxLookup,
  Db, DBTables, RxQuery, FCrsMME1, TB97Ctls, DB97Btn, TB97,
  TB97Tlbr, kbmMemTable;

type
  THorarioParaleloForm = class(TCrossManyToManyEditor1Form)
    RxQuHorarioParalelo: TRxQuery;
    RxMemoryData1: TkbmMemTable;
    RxMemoryData1CodParaleloId: TIntegerField;
    RxMemoryData1CodNivel: TIntegerField;
    RxMemoryData1CodEspecializacion: TIntegerField;
    RxMemoryData1NomNivel: TStringField;
    RxMemoryData1NomEspecializacion: TStringField;
    RxMemoryData1NomParaleloId: TStringField;
    DataSource1: TDataSource;
    btn97IntercambiarPeriodos: TToolbarButton97;
    dlcNivel: TRxDBLookupCombo;
    dlcEspecializacion: TRxDBLookupCombo;
    dlcParaleloId: TRxDBLookupCombo;
    cbVerParalelo: TComboBox;
    btn97Mostrar: TToolbarButton97;
    procedure btn97MostrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IntercambiarPeriodosClick(Sender: TObject);
  private
    { Private declarations }
    FCodHorario: Integer;
    function GetCodNivel: Integer;
    function GetCodEspecializacion: Integer;
    function GetCodParaleloId: Integer;
    function GetCodDia: Integer;
    function GetCodHora: Integer;
    function GetNomNivel: string;
    function GetNomEspecializacion: string;
    function GetNomParaleloId: string;
  public
    { Public declarations }
    property CodHorario: Integer read FCodHorario write FCodHorario;
    property CodNivel: Integer read GetCodNivel;
    property CodEspecializacion: Integer read GetCodEspecializacion;
    property CodParaleloId: Integer read GetCodParaleloId;
    property CodDia: Integer read GetCodDia;
    property CodHora: Integer read GetCodHora;
    property NomNivel: string read GetNomNivel;
    property NomEspecializacion: string read GetNomEspecializacion;
    property NomParaleloId: string read GetNomParaleloId;
  end;

var
  HorarioParaleloForm: THorarioParaleloForm;

implementation
uses
  DMaster, HorColCm, FSelPeIn;
{$R *.DFM}

function THorarioParaleloForm.GetCodDia: Integer;
begin
  Result := ColKey[RxDrawGrid.Col - 1];
end;

function THorarioParaleloForm.GetCodHora: Integer;
begin
  Result := RowKey[RxDrawGrid.Row - 1];
end;

function THorarioParaleloForm.GetCodNivel: Integer;
begin
  if varIsEmpty(dlcNivel.KeyValue) then
    raise Exception.Create('Debe especificar un Nivel');
  Result := dlcNivel.KeyValue;
end;

function THorarioParaleloForm.GetCodEspecializacion: Integer;
begin
  if varIsEmpty(dlcEspecializacion.KeyValue) then
    raise Exception.Create('Debe especificar un Nivel');
  Result := dlcEspecializacion.KeyValue;
end;

function THorarioParaleloForm.GetCodParaleloId: Integer;
begin
  if varIsEmpty(dlcParaleloId.KeyValue) then
    raise Exception.Create('Debe especificar un Paralelo');
  Result := dlcParaleloId.KeyValue;
end;

function THorarioParaleloForm.GetNomNivel: string;
begin
  Result := dlcNivel.DisplayValue;
end;

function THorarioParaleloForm.GetNomEspecializacion: string;
begin
  Result := dlcEspecializacion.DisplayValue;
end;

function THorarioParaleloForm.GetNomParaleloId: string;
begin
  Result := dlcParaleloId.DisplayValue;
end;

procedure THorarioParaleloForm.btn97MostrarClick(Sender: TObject);
  procedure HorarioParalelo;
  var
    FParalelo: Variant;
    s: string;
  begin
    with MasterDataModule do
    begin
      TbParalelo.Open;
      FParalelo :=
        TbParalelo.Lookup('CodNivel;CodEspecializacion;CodParaleloId',
        VarArrayOf([CodNivel, CodEspecializacion, CodParaleloId]),
        'CodNivel;CodEspecializacion;CodParaleloId');
      if VarIsNull(FParalelo) then
        raise Exception.CreateFmt('%s %s %s no es un %s válido',
          [NomNivel, NomEspecializacion, NomParaleloId, TbParalelo.TableName]);
      with RxQuHorarioParalelo do
      begin
        Close;
        MacroByName('FieldKey').AsString :=
          StrHolderShowParalelo.Strings.Values[CBVerParalelo.Text];
        ParamByName('CodHorario').AsInteger := CodHorario;
        ParambyName('CodNivel').AsInteger := CodNivel;
        ParamByName('CodEspecializacion').AsInteger := CodEspecializacion;
        ParamByName('CodParaleloId').AsInteger := CodParaleloId;
        Prepare;
        Open;
        s := Format('[%s %d] - %s %s %s', [TbHorario.TableName, CodHorario,
          dlcNivel.Text, dlcEspecializacion.Text, dlcParaleloId.Text]);
        if IsEmpty then
          raise Exception.CreateFmt('%s %s no válido', [s,
            TbParalelo.TableName]);
      end;
      Caption := s;
    end;
  end;
  procedure Mostrar;
  begin
    with MasterDataModule do
    begin
      ShowEditor(TbDia, TbHora, RxQuHorarioParalelo, TbHorarioLaborable,
        'CodDia', 'NomDia', 'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora',
        'CodHora', 'Nombre');
      btn97IntercambiarPeriodos.Enabled := True;
    end;
  end;
begin
  inherited;
  HorarioParalelo;
  Mostrar;
end;

procedure THorarioParaleloForm.FormCreate(Sender: TObject);
begin
  inherited;
  cbVerParalelo.Items.Clear;
  RxMemoryData1.Open;
  MasterDataModule.TbHorarioDetalle.Open;
  LoadNames(MasterDataModule.StrHolderShowParalelo.Strings,
    cbVerParalelo.Items);
  cbVerParalelo.Text := cbVerParalelo.Items[0];
end;

procedure THorarioParaleloForm.IntercambiarPeriodosClick(Sender: TObject);
var
  iCodDia, iCodHora: Integer;
begin
  inherited;
  if SeleccionarPeriodo(iCodDia, iCodHora) then
  begin
    MasterDataModule.IntercambiarPeriodos(CodHorario, CodNivel,
      CodEspecializacion, CodParaleloId, CodDia, CodHora, iCodDia, iCodHora);
    btn97MostrarClick(nil);
  end;
end;

end.

