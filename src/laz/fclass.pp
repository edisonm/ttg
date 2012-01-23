{ -*- mode: Delphi -*- }
unit FClass;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, FSingleEditor, ExtCtrls, DBCtrls, ZConnection, Grids,
  CheckLst, ComCtrls, ActnList, Variants;

type

  { TClassForm }

  TClassForm = class(TSingleEditorForm)
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
    FieldIdGroupId, FieldNaGroupId: TField;
    PostingData: Boolean;
  protected
    procedure doLoadConfig; override;
    procedure doSaveConfig; override;
  public
    { Public declarations }
  end;

var
  ClassForm: TClassForm;

implementation

uses
  DMaster, FCrossManyToManyEditor1, DSource;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TClassForm.FormCreate(Sender: TObject);
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
      FieldIdGroupId := FindField('IdGroupId');
      FieldNaGroupId := FindField('NaGroupId');
      while not Eof do
      begin
        Items.Add(FindField('NaGroupId').AsString);
        Next;
      end;
    end;
    DataSource.DataSet.Refresh;
  end;
end;

procedure TClassForm.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
end;

procedure TClassForm.ActFindExecute(Sender: TObject);
begin
  inherited;
end;

procedure TClassForm.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TClassForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
end;

procedure TClassForm.doLoadConfig;
begin
  inherited;
  CheckListBox.Width := ConfigIntegers['CheckListBox_Width'];
end;

procedure TClassForm.doSaveConfig;
begin
  inherited;
  ConfigIntegers['CheckListBox_Width'] := CheckListBox.Width;
end;

procedure TClassForm.DataSourceDataChange(Sender: TObject;
  Field: TField);
var
  IdLevel, IdSpecialization: Integer;
begin
  inherited;
  with CheckListBox do if not PostingData and Assigned(DataSourceList.DataSet) then
  begin
    IdLevel := DataSource.DataSet.FindField('IdLevel').AsInteger;
    IdSpecialization := DataSource.DataSet.FindField('IdSpecialization').AsInteger;
    with DataSourceList.DataSet do
    begin
      First;
      while not Eof do
      begin
        Checked[Items.IndexOf(FieldNaGroupId.AsString)] :=
          DataSourceDetail.DataSet.Locate('IdLevel;IdSpecialization;IdGroupId',
            VarArrayOf([IdLevel, IdSpecialization, FieldIdGroupId.AsInteger]), []);
        Next;
      end;
    end;
  end;
end;

procedure TClassForm.DataSourceStateChange(Sender: TObject);
begin
  inherited;
end;

procedure TClassForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TClassForm.CheckListBoxExit(Sender: TObject);
var
  IdLevel, IdSpecialization, IdGroupId: Integer;
begin
  inherited;
  with CheckListBox do if Assigned(DataSourceList.DataSet) then
  begin
    IdLevel := DataSource.DataSet.FindField('IdLevel').AsInteger;
    IdSpecialization := DataSource.DataSet.FindField('IdSpecialization').AsInteger;
    with DataSourceList.DataSet do
    try
      PostingData := True;
      First;
      while not Eof do
      begin
        IdGroupId := FieldIdGroupId.AsInteger;
        if DataSourceDetail.DataSet.Locate('IdLevel;IdSpecialization;IdGroupId',
          VarArrayOf([IdLevel, IdSpecialization, IdGroupId]), []) then
        begin
          if not Checked[Items.IndexOf(FieldNaGroupId.AsString)] then
            DataSourceDetail.DataSet.Delete;
        end
        else
        begin
          if Checked[Items.IndexOf(FieldNaGroupId.AsString)] then
          begin
            DataSourceDetail.DataSet.Append;
            DataSourceDetail.DataSet.FindField('IdLevel').Value := IdLevel;
            DataSourceDetail.DataSet.FindField('IdSpecialization').Value := IdSpecialization;
            DataSourceDetail.DataSet.FindField('IdGroupId').Value := IdGroupId;
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
  {$i fclass.lrs}
{$ENDIF}

end.
