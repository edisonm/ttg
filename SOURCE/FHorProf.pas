unit FHorProf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Placemnt, StdCtrls, Buttons, ExtCtrls, Grids, RXGrids, RxLookup,
  FCrsMME0, Db, DBTables, RxQuery, FCrsMME1, TB97Ctls, DB97Btn, TB97,
  TB97Tlbr;

type
  THorarioProfesorForm = class(TCrossManyToManyEditor1Form)
    QuHorarioProfesor: TRxQuery;
    QuProfesor: TQuery;
    DSProfesor: TDataSource;
    dlcProfesor: TRxDBLookupCombo;
    cbVerProfesor: TComboBox;
    btn97Mostrar: TToolbarButton97;
    btn97Next: TToolbarButton97;
    btn97Prior: TToolbarButton97;
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

procedure THorarioProfesorForm.btn97MostrarClick(Sender: TObject);
var
  s: string;
begin
  inherited;
  with MasterDataModule do
  begin
    if varIsEmpty(dlcProfesor.KeyValue) then
      raise Exception.Create('Debe especificar un Profesor');
    with QuHorarioProfesor do
    begin
      Close;
      MacroByName('FieldKey').AsString :=
        StrHolderShowProfesor.Strings.Values[CBVerProfesor.Text];
      MacroByName('Excluir').AsString
        := ConfiguracionForm.edtProfesorHorarioExcluirProfProhibicion.Text;
      ParamByName('CodProfesor').AsInteger := dlcProfesor.KeyValue;
      ParamByName('CodHorario').AsInteger := CodHorario;
      Prepare;
      Open;
      s := Format('[%s %d] - %s', [TbHorario.TableName, CodHorario,
        dlcProfesor.Text]);
    end;
    Caption := s;
    ShowEditor(TbDia, TbHora, QuHorarioProfesor, TbHorarioLaborable, 'CodDia', 'NomDia',
      'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora', 'CodHora', 'Nombre');
  end;
end;

procedure THorarioProfesorForm.FormCreate(Sender: TObject);
begin
  inherited;
  CodHorario := MasterDataModule.TbHorarioCodHorario.Value;
  QuProfesor.Prepare;
  QuProfesor.Open;
  cbVerProfesor.Items.Clear;
  LoadNames(MasterDataModule.StrHolderShowProfesor.Strings, cbVerProfesor.Items);
  cbVerProfesor.Text := cbVerProfesor.Items[0];
  dlcProfesor.KeyValue := QuProfesor.FindField('CodProfesor').AsInteger;
  btn97MostrarClick(nil);
end;

procedure THorarioProfesorForm.FormDestroy(Sender: TObject);
begin
  inherited;
  QuProfesor.Close;
end;

procedure THorarioProfesorForm.btn97PriorClick(Sender: TObject);
begin
  inherited;
  QuProfesor.Prior;
  dlcProfesor.KeyValue := QuProfesor.FindField('CodProfesor').AsInteger;
  btn97MostrarClick(nil);
end;

procedure THorarioProfesorForm.btn97NextClick(Sender: TObject);
begin
  inherited;
  QuProfesor.Next;
  dlcProfesor.KeyValue := QuProfesor.FindField('CodProfesor').AsInteger;
  btn97MostrarClick(nil);
end;

end.
   