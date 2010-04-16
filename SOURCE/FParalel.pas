unit FParalel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, RXDBCtrl, RXCtrls, ExtCtrls,
  StdCtrls, DBIndex, DBCtrls, RXSplit,
  CheckLst, DBChLsBx, Printers, kbmMemTable, ImgList, ComCtrls, ToolWin;

type
  TParaleloForm = class(TSingleEditorForm)
    DBCheckListBox: TDBCheckListBox;
    DataSourceList: TDataSource;
    DataSourceDetail: TDataSource;
    Splitter1: TSplitter;
    procedure BtnShowClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ParaleloForm: TParaleloForm;

implementation

uses
  DMaster, FCrsMME1, SGHCUtls, Consts, FMain, QSingRep, DSource;

{$R *.DFM}

procedure TParaleloForm.BtnShowClick(Sender: TObject);
begin
  PreviewSingleReport(SourceDataModule.TbParalelo, '', '', SuperTitle, Caption,
    poPortrait, MainForm.PrepareReport);
end;

procedure TParaleloForm.FormCreate(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbParalelo.MasterSource := DataSource;
  SourceDataModule.TbParalelo.MasterFields := 'CodNivel;CodEspecializacion';
  with DBCheckListBox do
  begin
    (DataSource.DataSet as TkbmMemTable).IndexFieldNames :=
      (DataSource.DataSet as TkbmMemTable).MasterFields + ';' + DataField;
    (ListSource.DataSet as TkbmMemTable).IndexFieldNames := KeyField;
  end;
end;

procedure TParaleloForm.FormDestroy(Sender: TObject);
begin
  inherited;
  with DBCheckListBox do
  begin
    (DataSource.DataSet as TkbmMemTable).IndexFieldNames := '';
    (ListSource.DataSet as TkbmMemTable).IndexFieldNames := '';
  end;
  SourceDataModule.TbParalelo.MasterSource := nil;
end;

end.

