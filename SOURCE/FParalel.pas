unit FParalel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, RXDBCtrl, RXCtrls, ExtCtrls,
  StdCtrls, DBIndex, DBCtrls, TB97Ctls, DB97Btn, TB97, TB97Tlbr, RXSplit,
  CheckLst, DBChLsBx, Printers, kbmMemTable;

type
  TParaleloForm = class(TSingleEditorForm)
    DBCheckListBox: TDBCheckListBox;
    RxSplitter: TRxSplitter;
    DataSourceList: TDataSource;
    DataSourceDetail: TDataSource;
    kbmParalelo: TkbmMemTable;
    kbmParaleloCodNivel: TIntegerField;
    kbmParaleloCodEspecializacion: TIntegerField;
    kbmParaleloCodParaleloId: TIntegerField;
    kbmParaleloAbrNivel: TStringField;
    kbmParaleloAbrEspecializacion: TStringField;
    kbmParaleloNomParaleloId: TStringField;
    procedure btn97ShowClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  DMaster, FCrsMME1, SGHCUtls, Consts, FMain, QMaDeRep, QSingRep, DSource;

{$R *.DFM}

procedure TParaleloForm.btn97ShowClick(Sender: TObject);
begin
  PreviewSingleReport(kbmParalelo, '', '', SuperTitle, Caption,
    poPortrait, MainForm.PrepareReport);
end;

procedure TParaleloForm.FormCreate(Sender: TObject);
begin
  inherited;
  kbmParalelo.AttachedTo := SourceDataModule.kbmParalelo;
  kbmParalelo.Open;
  kbmParalelo.MasterSource := DataSource;
end;

end.

