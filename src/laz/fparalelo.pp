unit FParalelo;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, FSingleEditor, ExtCtrls, DBCtrls, ZConnection, Grids,
  CheckLst, ComCtrls, ActnList, Variants;

type

  { TParaleloForm }

  TParaleloForm = class(TSingleEditorForm)
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
    FieldCodParaleloId, FieldNomParaleloId: TField;
    PostingData: Boolean;
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
  DMaster, FCrossManyToManyEditor1, DSource;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TParaleloForm.FormCreate(Sender: TObject);
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
      FieldCodParaleloId := FindField('CodParaleloId');
      FieldNomParaleloId := FindField('NomParaleloId');
      while not Eof do
      begin
        Items.Add(FindField('NomParaleloId').AsString);
        Next;
      end;
    end;
    DataSource.DataSet.Refresh;
  end;
end;

procedure TParaleloForm.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
end;

procedure TParaleloForm.ActFindExecute(Sender: TObject);
begin
  inherited;
end;

procedure TParaleloForm.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TParaleloForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
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
  CodNivel, CodEspecializacion: Integer;
begin
  inherited;
  with CheckListBox do if not PostingData and Assigned(DataSourceList.DataSet) then
  begin
    CodNivel := DataSource.DataSet.FindField('CodNivel').AsInteger;
    CodEspecializacion := DataSource.DataSet.FindField('CodEspecializacion').AsInteger;
    with DataSourceList.DataSet do
    begin
      First;
      while not Eof do
      begin
        Checked[Items.IndexOf(FieldNomParaleloId.AsString)] :=
          DataSourceDetail.DataSet.Locate('CodNivel;CodEspecializacion;CodParaleloId',
            VarArrayOf([CodNivel, CodEspecializacion, FieldCodParaleloId.AsInteger]), []);
        Next;
      end;
    end;
  end;
end;

procedure TParaleloForm.DataSourceStateChange(Sender: TObject);
begin
  inherited;
end;

procedure TParaleloForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TParaleloForm.CheckListBoxExit(Sender: TObject);
var
  CodNivel, CodEspecializacion, CodParaleloId: Integer;
begin
  inherited;
  with CheckListBox do if Assigned(DataSourceList.DataSet) then
  begin
    CodNivel := DataSource.DataSet.FindField('CodNivel').AsInteger;
    CodEspecializacion := DataSource.DataSet.FindField('CodEspecializacion').AsInteger;
    with DataSourceList.DataSet do
    try
      PostingData := True;
      First;
      while not Eof do
      begin
        CodParaleloId := FieldCodParaleloId.AsInteger;
        if DataSourceDetail.DataSet.Locate('CodNivel;CodEspecializacion;CodParaleloId',
          VarArrayOf([CodNivel, CodEspecializacion, CodParaleloId]), []) then
        begin
          if not Checked[Items.IndexOf(FieldNomParaleloId.AsString)] then
            DataSourceDetail.DataSet.Delete;
        end
        else
        begin
          if Checked[Items.IndexOf(FieldNomParaleloId.AsString)] then
          begin
            DataSourceDetail.DataSet.Append;
            DataSourceDetail.DataSet.FindField('CodNivel').Value := CodNivel;
            DataSourceDetail.DataSet.FindField('CodEspecializacion').Value := CodEspecializacion;
            DataSourceDetail.DataSet.FindField('CodParaleloId').Value := CodParaleloId;
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
  {$i fparalelo.lrs}
{$ENDIF}

end.
