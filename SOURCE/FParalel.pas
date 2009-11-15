unit FParalel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, RXDBCtrl, RXCtrls, ExtCtrls,
  StdCtrls, DBIndex, DBCtrls, TB97Ctls, DB97Btn, TB97, TB97Tlbr, RXSplit,
  CheckLst, DBChLsBx, Printers, DBTables;

type
  TParaleloForm = class(TSingleEditorForm)
    DBCheckListBox: TDBCheckListBox;
    RxSplitter: TRxSplitter;
    DataSourceList: TDataSource;
    DataSourceDetail: TDataSource;
    btn97Asignatura: TDBToolbarButton97;
    procedure btn97AsignaturaClick(Sender: TObject);
    procedure btn97ShowClick(Sender: TObject);
  private
    { Private declarations }
    FHorarioLaborableRecordCount: Integer;
    procedure EdAsignaturaGetColName(Sender: TObject; ACol: Integer; var
      AColName: string);
    procedure EdAsignaturaDestroy(Sender: TObject);
  public
    { Public declarations }
  end;

implementation

uses
  DMaster, FCrsMME1, SGHCUtls, Consts, FMain, QMaDeRep, QSingRep;

{$R *.DFM}

procedure TParaleloForm.btn97AsignaturaClick(Sender: TObject);
var
  AsignaturaForm: TCrossManyToManyEditor1Form;
begin
  AsignaturaForm := TCrossManyToManyEditor1Form.Create(Application);
  with MasterDataModule, AsignaturaForm do
  begin
    LoadCaption(AsignaturaForm, TbAsignatura);
    Caption := Format('%s - Especialización: [%s]', [Caption,
      TbEspecializacionNomEspecializacion.AsString]);
    LoadHints(AsignaturaForm, TbCurso, TbMateria, TbAsignatura);
    OnDestroy := EdAsignaturaDestroy;
      //OnGetRowName := EdAsignaturaGetRowName;
    OnGetColName := EdAsignaturaGetColName;
    TbHorarioLaborable.Open;
    FHorarioLaborableRecordCount := TbHorarioLaborable.RecordCount;
    with FormStorage do
    begin
      IniSection := IniSection + '\CubEd2' + TbParalelo.TableName;
      Active := True;
    end;
    TbAsignatura.Filter := Format('(CodNivel=%d)and(CodEspecializacion=%d)',
      [TbCursoCodNivel.AsInteger, TbCursoCodEspecializacion.AsInteger]);
    TbAsignatura.Filtered := True;
    TbAsignaturaCodEspecializacion.DefaultExpression :=
      TbEspecializacionCodEspecializacion.AsString;
    ShowEditor(TbAulaTipo, TbMateria, TbAsignatura, nil, 'CodAulaTipo',
      'AbrAulaTipo', 'CodAulaTipo', '', 'CodMateria', 'NomMateria',
      'CodMateria', '', 'Composicion');
  end;
end;

procedure TParaleloForm.EdAsignaturaGetColName(Sender: TObject; ACol: Integer;
  var AColName: string);
var
  i, j, d: Integer;
  t: Integer;
begin
  with Sender as TCrossManyToManyEditor1Form do
  begin
    try
      t := 0;
      i := ACol - 1;
      for j := 0 to RxDrawGrid.RowCount - 2 do
      begin
        if Rel[i, j] <> '' then
        begin
          d := ComposicionADuracion(Rel[i, j]);
          if d <= 0 then raise Exception.Create(SInvalidNumber);
          Inc(t, d);
        end;
      end;
      if (t <= 0) or (t > FHorarioLaborableRecordCount) then
      begin
        AColName := Format('* %s  %.2d', [AColName, t]);
        RxDrawGrid.Canvas.Font.Color := clRed;
      end
      else
        AColName := Format('  %s  %.2d', [AColName, t]);
    except
      AColName := Format('* %s  ##', [AColName]);
      RxDrawGrid.Canvas.Font.Color := clRed;
    end;
  end;
end;

procedure TParaleloForm.EdAsignaturaDestroy(Sender: TObject);
begin
  MasterDataModule.TbAsignatura.Filtered := False;
end;

procedure TParaleloForm.btn97ShowClick(Sender: TObject);
begin
  with MasterDataModule do
  begin
    TbParalelo1.Open;
    try
      PreviewSingleReport(TbParalelo1, '', '', SuperTitle, Caption,
        poPortrait, MainForm.PrepareReport);
    finally
      MasterDataModule.TbParalelo1.Close;
    end;
  end;
end;

end.

 