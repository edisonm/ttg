unit FHorAulT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Placemnt, StdCtrls, Buttons, ExtCtrls, Grids, RXGrids, RxLookup,
  FCrsMME0, Db, DBTables, RxQuery, FCrsMME1, TB97Ctls, DB97Btn, TB97,
  TB97Tlbr, kbmMemTable;

type
  THorarioAulaTipoForm = class(TCrossManyToManyEditor1Form)
    QuHorarioAulaTipo: TRxQuery;
    DSAulaTipo: TDataSource;
    dlcAulaTipo: TRxDBLookupCombo;
    cbVerAulaTipo: TComboBox;
    btn97Mostrar: TToolbarButton97;
    btn97Next: TToolbarButton97;
    btn97Prior: TToolbarButton97;
    TbTmpAulaTipo: TkbmMemTable;
    TbTmpAulaTipoCodAulaTipo: TIntegerField;
    TbTmpAulaTipoNomAulaTipo: TStringField;
    TbTmpAulaTipoAbrAulaTipo: TStringField;
    TbTmpAulaTipoCantidad: TIntegerField;
    procedure btn97MostrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn97PriorClick(Sender: TObject);
    procedure btn97NextClick(Sender: TObject);
  private
    { Private declarations }
    FCodHorario: Integer;
  protected
  public
    { Public declarations }
    property CodHorario: Integer read FCodHorario write FCodHorario;
  end;

implementation
uses
  DMaster, HorColCm, FConfig;
{$R *.DFM}

procedure THorarioAulaTipoForm.btn97MostrarClick(Sender: TObject);
var
  s: string;
begin
  inherited;
  with MasterDataModule do
  begin
    if varIsEmpty(dlcAulaTipo.KeyValue) then
      raise Exception.Create('Debe especificar un tipo de aula');
    with QuHorarioAulaTipo do
    begin
      Close;
      MacroByName('FieldKey').AsString :=
        StrHolderShowAulaTipo.Strings.Values[CBVerAulaTipo.Text];
      ParamByName('CodAulaTipo').AsInteger := dlcAulaTipo.KeyValue;
      ParamByName('CodHorario').AsInteger := CodHorario;
      Prepare;
      Open;
      s := Format('[%s %d] - %s', [TbHorario.TableName, CodHorario,
        dlcAulaTipo.Text]);
    end;
    Caption := s;
    ShowEditor(TbDia, TbHora, QuHorarioAulaTipo, TbHorarioLaborable, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
  end;
end;

procedure THorarioAulaTipoForm.FormCreate(Sender: TObject);
begin
  inherited;
  CodHorario := MasterDataModule.TbHorarioCodHorario.Value;
  cbVerAulaTipo.Items.Clear;
  TbTmpAulaTipo.LoadFromDataSet(MasterDataModule.TbAulaTipo, []);
  TbTmpAulaTipo.Open;
  LoadNames(MasterDataModule.StrHolderShowAulaTipo.Strings, cbVerAulaTipo.Items);
  cbVerAulaTipo.Text := cbVerAulaTipo.Items[0];
  dlcAulaTipo.KeyValue := TbTmpAulaTipo.FindField('CodAulaTipo').AsInteger;
  btn97MostrarClick(nil);
end;

procedure THorarioAulaTipoForm.FormDestroy(Sender: TObject);
begin
  inherited;
  TbTmpAulaTipo.Close;
end;

procedure THorarioAulaTipoForm.btn97PriorClick(Sender: TObject);
begin
  inherited;
  TbTmpAulaTipo.Prior;
  dlcAulaTipo.KeyValue := TbTmpAulaTipo.FindField('CodAulaTipo').AsInteger;
  btn97MostrarClick(nil);
end;

procedure THorarioAulaTipoForm.btn97NextClick(Sender: TObject);
begin
  inherited;
  TbTmpAulaTipo.Next;
  dlcAulaTipo.KeyValue := TbTmpAulaTipo.FindField('CodAulaTipo').AsInteger;
  btn97MostrarClick(nil);
end;

end.
   