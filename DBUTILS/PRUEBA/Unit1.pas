unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, dbf;

type
  TForm1 = class(TForm)
    kbmDia: TDbf;
    dsDia: TDataSource;
    dsHora: TDataSource;
    kbmHora: TDbf;
    tbmHoraCodHora: TIntegerField;
    tbmHoraNomHora: TStringField;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    dsPeriodo: TDataSource;
    kbmPeriodo: TDbf;
    tbmPeriodoCodDia: TIntegerField;
    tbmPeriodoCodHora: TIntegerField;
    kbmDiaNomDia: TStringField;
    kbmDiaCodDia: TIntegerField;
    procedure kbmDiaBeforePost(DataSet: TDataSet);
    procedure kbmHoraBeforePost(DataSet: TDataSet);
    procedure kbmHoraBeforeDelete(DataSet: TDataSet);
    procedure kbmDiaBeforeDelete(DataSet: TDataSet);
    procedure kbmPeriodoBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
uses
  RelUtils;
  
procedure TForm1.kbmDiaBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmPeriodo, 'CodDia', 'CodDia', True);
end;

procedure TForm1.kbmHoraBeforePost(DataSet: TDataSet);
begin
  CheckMasterRelationUpdate(DataSet, kbmPeriodo, 'CodHora', 'CodHora', True);
end;

procedure TForm1.kbmHoraBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmPeriodo, 'CodHora', 'CodHora', True);
end;

procedure TForm1.kbmDiaBeforeDelete(DataSet: TDataSet);
begin
  CheckMasterRelationDelete(DataSet, kbmPeriodo, 'CodDia', 'CodDia', True);
end;

procedure TForm1.kbmPeriodoBeforePost(DataSet: TDataSet);
begin
  CheckDetailRelation(kbmDia, DataSet, 'CodDia', 'CodDia');
  CheckDetailRelation(kbmHora, DataSet, 'CodHora', 'CodHora');
end;

end.

