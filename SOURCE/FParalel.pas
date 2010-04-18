unit FParalel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  FSingEdt, DBGrids, ExtCtrls, DBIndex, kbmMemTable, DBCtrls,
  Grids, CheckLst, DBChLsBx, Printers, StdCtrls, ImgList, ComCtrls, ToolWin,
  ActnList;

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
  protected
    procedure doLoadConfig; override;
    procedure doSaveConfig; override;
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

procedure TParaleloForm.doLoadConfig;
begin
  inherited;
  DBCheckListBox.Width := ConfigIntegers['DBCheckListBox_Width'];
end;

procedure TParaleloForm.doSaveConfig;
begin
  inherited;
  ConfigIntegers['DBCheckListBox_Width'] := DBCheckListBox.Width;
end;

end.
