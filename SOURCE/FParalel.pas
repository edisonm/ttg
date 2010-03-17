unit FParalel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, ExtCtrls, StdCtrls, DBIndex, DBCtrls,
  CheckLst, DBChLsBx, Printers, kbmMemTable, ImgList, ComCtrls, ToolWin;
(*
  FormStorage:
    DBCheckListBox.Width
*)

type
  TParaleloForm = class(TSingleEditorForm)
    DBCheckListBox: TDBCheckListBox;
    DataSourceList: TDataSource;
    DataSourceDetail: TDataSource;
    kbmParalelo: TkbmMemTable;
    kbmParaleloCodNivel: TIntegerField;
    kbmParaleloCodEspecializacion: TIntegerField;
    kbmParaleloCodParaleloId: TIntegerField;
    kbmParaleloAbrNivel: TStringField;
    kbmParaleloAbrEspecializacion: TStringField;
    kbmParaleloNomParaleloId: TStringField;
    Splitter1: TSplitter;
    procedure btn97ShowClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  DMaster, FCrsMME1, SGHCUtls, Consts, FMain, QSingRep, DSource;

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

