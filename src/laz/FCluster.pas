{ -*- mode: Delphi -*- }
unit FCluster;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, FSingleEditor, ExtCtrls, DBCtrls, Grids,
  CheckLst, ActnList, Variants;

type

  { TClusterForm }

  TClusterForm = class(TSingleEditorForm)
    DataSourceList: TDataSource;
    DataSourceDetail: TDataSource;
    Splitter1: TSplitter;
    CheckListBox: TCheckListBox;
    procedure ActFindExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure CheckListBoxExit(Sender: TObject);
    procedure DataSourceStateChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FieldIdParallel, FieldNaParallel: TField;
    PostingData: Boolean;
  protected
    procedure doLoadConfig; override;
    procedure doSaveConfig; override;
  public
    { Public declarations }
  end;

var
  ClusterForm: TClusterForm;

implementation

uses
  DMaster, FCrossManyToManyEditor1, DSource;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TClusterForm.FormCreate(Sender: TObject);
begin
  inherited;
  PostingData := False;
  with CheckListBox do
  begin
    Items.Clear;
    if Assigned(DataSourceList.DataSet) then
    with DataSourceList.DataSet do
    begin
      First;
      FieldIdParallel := FindField('IdParallel');
      FieldNaParallel := FindField('NaParallel');
      while not Eof do
      begin
        Items.Add(FindField('NaParallel').AsString);
        Next;
      end;
    end;
    DataSource.DataSet.Refresh;
  end;
end;

procedure TClusterForm.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
end;

procedure TClusterForm.ActFindExecute(Sender: TObject);
begin
  inherited;
end;

procedure TClusterForm.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TClusterForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
end;

procedure TClusterForm.doLoadConfig;
begin
  inherited;
  CheckListBox.Width := ConfigIntegers['CheckListBox_Width'];
end;

procedure TClusterForm.doSaveConfig;
begin
  inherited;
  ConfigIntegers['CheckListBox_Width'] := CheckListBox.Width;
end;

procedure TClusterForm.DataSourceDataChange(Sender: TObject;
  Field: TField);
var
  IdCategory: Integer;
begin
  inherited;
  with CheckListBox do if not PostingData and Assigned(DataSourceList.DataSet) then
  begin
    IdCategory := DataSource.DataSet.FindField('IdCategory').AsInteger;
    with DataSourceList.DataSet do
    begin
      First;
      while not Eof do
      begin
        Checked[Items.IndexOf(FieldNaParallel.AsString)] :=
          DataSourceDetail.DataSet.Locate('IdCategory;IdParallel',
            VarArrayOf([IdCategory, FieldIdParallel.AsInteger]), []);
        Next;
      end;
    end;
  end;
end;

procedure TClusterForm.DataSourceStateChange(Sender: TObject);
begin
  inherited;
end;

procedure TClusterForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TClusterForm.CheckListBoxExit(Sender: TObject);
var
  IdCategory, IdParallel: Integer;
begin
  inherited;
  with CheckListBox do if Assigned(DataSourceList.DataSet) then
  begin
    IdCategory := DataSource.DataSet.FindField('IdCategory').AsInteger;
    with DataSourceList.DataSet do
    try
      PostingData := True;
      First;
      while not Eof do
      begin
        IdParallel := FieldIdParallel.AsInteger;
        if DataSourceDetail.DataSet.Locate('IdCategory;IdParallel',
          VarArrayOf([IdCategory, IdParallel]), []) then
        begin
          if not Checked[Items.IndexOf(FieldNaParallel.AsString)] then
            DataSourceDetail.DataSet.Delete;
        end
        else
        begin
          if Checked[Items.IndexOf(FieldNaParallel.AsString)] then
          begin
            DataSourceDetail.DataSet.Append;
            DataSourceDetail.DataSet.FindField('IdCategory').Value := IdCategory;
            DataSourceDetail.DataSet.FindField('IdParallel').Value := IdParallel;
            DataSourceDetail.DataSet.Post;
          end;
        end;
        Next;
      end;
    finally
      PostingData := False;
    end;
  end;
end;

initialization
{$IFDEF FPC}
  {$i FCluster.lrs}
{$ENDIF}

end.
