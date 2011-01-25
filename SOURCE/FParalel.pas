unit FParalel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  FSingEdt, DBGrids, ExtCtrls, kbmMemTable, DBCtrls, Grids, CheckLst,
  StdCtrls, ImgList, ComCtrls, ToolWin, ActnList;

type
  TParaleloForm = class(TSingleEditorForm)
    DataSourceList: TDataSource;
    DataSourceDetail: TDataSource;
    Splitter1: TSplitter;
    CheckListBox: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure CheckListBoxExit(Sender: TObject);
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
  DMaster, FCrsMME1, SGHCUtls, Consts, FMain, DSource;

{$R *.DFM}

procedure TParaleloForm.FormCreate(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbParalelo.MasterSource := DataSource;
  SourceDataModule.TbParalelo.MasterFields := 'CodNivel;CodEspecializacion';
  SourceDataModule.TbParalelo.IndexFieldNames :=
      SourceDataModule.TbParalelo.MasterFields + ';' + 'CodParaleloId';
  SourceDataModule.TbParaleloId.IndexFieldNames := 'CodParaleloId';
  with CheckListBox do
  begin
    Items.Clear;
    if Assigned(DataSourceList.DataSet) then
    with DataSourceList.DataSet do
    begin
      First;
      while not Eof do
      begin
        Items.Add(FindField('NomParaleloId').AsString);
        Next;
      end;
    end;
  end;
end;

procedure TParaleloForm.FormDestroy(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbParaleloId.IndexFieldNames := '';
  SourceDataModule.TbParalelo.IndexFieldNames := '';
  SourceDataModule.TbParalelo.MasterSource := nil;
end;

procedure TParaleloForm.doLoadConfig;
begin
  inherited;
  CheckListBox.Width := ConfigIntegers['CheckListBox_Width'];
end;

procedure TParaleloForm.doSaveConfig;
begin
  inherited;
  ConfigIntegers['CheckListBox_Width'] := CheckListBox.Width;
end;

procedure TParaleloForm.DataSourceDataChange(Sender: TObject;
  Field: TField);
var
  i: Integer;
begin
  inherited;
  with CheckListBox do
  begin
    for i := 0 to Items.Count - 1 do
      Checked[i] := False;
    if Assigned(DataSourceList.DataSet) then
    begin
    with DataSourceDetail.DataSet do
    begin
      First;
      while not Eof do
      begin
        Checked[Items.IndexOf(DataSourceList.DataSet.Lookup('CodParaleloId',
          FindField('CodParaleloId').AsInteger, 'NomParaleloId'))] := True;
        Next;
      end;
    end;
    end;
  end;
end;

procedure TParaleloForm.CheckListBoxExit(Sender: TObject);
var
  i, CodParaleloId: Integer;
begin
  inherited;
  with CheckListBox do
  begin
    if Assigned(DataSourceList.DataSet) then
    for i := 0 to Items.Count - 1 do
    begin
      CodParaleloId := DataSourceList.DataSet.Lookup('NomParaleloId', Items[i], 'CodParaleloId');
      if DataSourceDetail.DataSet.Locate('CodParaleloId', CodParaleloId, []) then
      begin
        if not Checked[i] then
          DataSourceDetail.DataSet.Delete;
      end
      else
      begin
        if Checked[i] then
        begin
          DataSource.DataSet.CheckBrowseMode;
          DataSourceDetail.DataSet.Append;
          DataSourceDetail.DataSet.FindField('CodNivel').Value := DataSource.DataSet.FindField('CodNivel').Value;
          DataSourceDetail.DataSet.FindField('CodEspecializacion').Value := DataSource.DataSet.FindField('CodEspecializacion').Value;
          DataSourceDetail.DataSet.FindField('CodParaleloId').Value := CodParaleloId;
          DataSourceDetail.DataSet.Post;
        end;
      end;
    end;
  end;
end;

end.
