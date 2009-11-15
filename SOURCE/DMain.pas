unit DMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, DBPacker, Db, RxLogin, DBSecur, StrHlder, Placemnt, BDEUtils;

type
  TMainDataModule = class(TDataModule)
    dbMain: TDatabase;
    dbpkMain: TDBPacker;
    sthProperty: TStrHolder;
    secMain: TDBSecurity;
    seMain: TSession;
    FormStorage: TFormStorage;
    procedure MainDataModuleCreate(Sender: TObject);
    procedure MainDataModuleDestroy(Sender: TObject);
    function secMainChangePassword(UsersTable: TTable; const OldPassword,
      NewPassword: string): Boolean;
    procedure sesMainPassword(Sender: TObject; var Continue: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SaveToFile(FileName: TFileName);
    procedure LoadFromFile(FileName: TFileName);
    procedure NewDatabase(OnDataSetProgress: TDataSetNotifyEvent);
    procedure FillDefaultData;
    procedure CompactarTablas(OnCompactar: TNotifyEvent);
  end;

var
  MainDataModule: TMainDataModule;
implementation
uses
  BDE, FileUtil, ArDBUtls, DMaster;
{$R *.DFM}

procedure TMainDataModule.MainDataModuleCreate(Sender: TObject);
begin
  FormStorage.RestoreFormPlacement;
  if dbMain.Connected then
  begin
    MessageDlg('La base de datos estaba conectada', mtWarning, [mbOk], 0);
    dbMain.Close;
  end;
  with dbMain.Params do
    Values['PATH'] := ExpandFileName(Values['PATH']);
  try
    dbMain.Open;
  except
    DbiAddAlias(nil, PChar(dbMain.AliasName), szPARADOX, PChar('PATH:' +
      ExpandFileName('..\DAT\')), LongBool(True));
    dbMain.Open;
  end;
  if not DirExists(dbMain.Directory) then
    NewDatabase(nil);
  sthProperty.Strings.LoadFromFile(dbMain.Directory + 'PROPERTY.TXT');
end;

procedure TMainDataModule.SaveToFile(FileName: TFileName);
begin
  dbMain.Close; // Se asegura que se vacíen los Buffers
  dbMain.Open;
  dbpkMain.Options := [poData, poCompress];
  dbpkMain.SaveToFile(FileName);
end;

procedure TMainDataModule.NewDatabase(OnDataSetProgress: TDataSetNotifyEvent);
begin
  dbMain.Close;
  try
    dbMain.Open;
    if not DirExists(dbMain.Directory) then
    begin
      CreateDir(dbMain.Directory);
      dbpkMain.LoadFromFile('..\BIN\HORCOLEG.DB0');
    end
    else
      EmptyDataBase(dbMain, OnDataSetProgress);
    if not Assigned(MasterDataModule.OnDataSetProgress) then
      MasterDataModule.OnDataSetProgress := OnDataSetProgress;
  finally
    FillDefaultData;
  end;
end;

procedure TMainDataModule.LoadFromFile(FileName: TFileName);
begin
  dbMain.Close;
  dbMain.Open;
  dbpkMain.LoadFromFile(FileName);
end;

procedure TMainDataModule.FillDefaultData;
const
  SNomHora: array[1..9] of string = (
    'Primera',
    'Segunda',
    'Tercera',
    'Cuarta',
    'Recreo',
    'Quinta',
    'Sexta',
    'Séptima',
    'Octava'
    );
  SNomMateProhibicionTipo: array[0..1] of string = (
    'Inadecuado',
    'Imposible'
    );
  SNomProfProhibicionTipo: array[0..1] of string = (
    'No gusta',
    'No puede'
    );
  EColMateProhibicionTipo: array[0..1] of TColor = (
    clLime,
    clRed
    );
  EColProfProhibicionTipo: array[0..1] of TColor = (
    clLime,
    clRed
    );
  EValMateProhibicionTipo: array[0..1] of Double = (
    50,
    500
    );
  EValProfProhibicionTipo: array[0..1] of Double = (
    50,
    500
    );
var
  t: TDateTime;
  i, j: Integer;
  s: string;
begin
  with MasterDataModule do
  begin
    // Días laborables por defecto, excepto sábados y domingos:
    with TbDia do
    begin
      Open;
      try
        for i := Low(LongDayNames) + 1 to High(LongDayNames) - 1 do
        begin
          Append;
          Fields[0].AsInteger := i;
          Fields[1].AsString := LongDayNames[i];
          Post;
        end;
      finally
        Close;
      end;
    end;
    // Horas por defecto:
    with TbHora do
    begin
      Open;
      try
        t := 7 / 24;
        for i := Low(SNomHora) to High(SNomHora) do
        begin
          Append;
          Fields[0].AsInteger := i;
          s := FormatDateTime(ShortTimeFormat, t);
          if i = 5 then
            t := t + 1 / 48
          else
            t := t + 1 / 32;
          Fields[1].AsString := SNomHora[i];
          Fields[2].AsString := s + '-' + FormatDateTime(ShortTimeFormat, t);
          Post;
        end;
      finally
        Close;
      end;
    end;
    // Generar todos los períodos, exceptuando el sábado, domingo y el recreo:
    with TbHorarioLaborable do
    begin
      Open;
      try
        for i := Low(LongDayNames) + 1 to High(LongDayNames) - 1 do
        begin
          for j := Low(SNomHora) to High(SNomHora) do
          begin
            if j <> 5 then
            begin
              Append;
              Fields[0].AsInteger := i;
              Fields[1].AsInteger := j;
              Post;
            end;
          end;
        end;
      finally
        Close;
      end;
    end;
    with TbMateriaProhibicionTipo do
    begin
      Open;
      try
        for i := Low(SNomMateProhibicionTipo) to High(SNomMateProhibicionTipo) do
        begin
          Append;
          Fields[0].AsInteger := i;
          Fields[1].AsString := SNomMateProhibicionTipo[i];
          Fields[2].AsInteger := EColMateProhibicionTipo[i];
          Fields[3].AsFloat := EValMateProhibicionTipo[i];
          Post;
        end;
      finally
        Close;
      end;
    end;
    with TbProfesorProhibicionTipo do
    begin
      Open;
      try
        for i := Low(SNomProfProhibicionTipo) to High(SNomProfProhibicionTipo) do
        begin
          Append;
          Fields[0].AsInteger := i;
          Fields[1].AsString := SNomProfProhibicionTipo[i];
          Fields[2].AsInteger := EColProfProhibicionTipo[i];
          Fields[3].AsFloat := EValProfProhibicionTipo[i];
          Post;
        end;
      finally
        Close;
      end;
    end;
  end;
end;

procedure TMainDataModule.MainDataModuleDestroy(Sender: TObject);
begin
  dbMain.Connected := False;
  FormStorage.SaveFormPlacement;
end;

function TMainDataModule.secMainChangePassword(UsersTable: TTable;
  const OldPassword, NewPassword: string): Boolean;
begin
  with dbMain, Session do
  begin
    OnPassword := sesMainPassword;
    try
      RemoveAllPasswords;
      CloseDataSets;
      AddPassword(OldPassword);
      AddPassword(NewPassword);
      AddAllMasterPassword(dbMain, NewPassword);
      RemovePassword(OldPassword);
      Result := True;
    except
      RemovePassword(NewPassword);
      Result := False;
      OnPassword := nil;
    end;
  end;
end;

procedure TMainDataModule.sesMainPassword(Sender: TObject;
  var Continue: Boolean);
begin
  Continue := False;
end;

procedure TMainDataModule.CompactarTablas(OnCompactar: TNotifyEvent);
var
  s: string;
  i: Integer;
  List: TStrings;
  TbSource: TTable;
begin
  List := TStringList.Create;
  try
    TbSource := TTable.Create(nil);
    //TbSource.TableLevel := 7;
    //TbSource.TableType := ttParadox;
    //TbSource.Exclusive := True;
    try
      TbSource.DisableControls;
      TbSource.Exclusive := True;
      TbSource.DatabaseName := dbMain.DatabaseName;
      TbSource.SessionName := dbMain.SessionName;
      dbMain.Connected := False;
      dbMain.Exclusive := True;
      dbMain.KeepConnection := False;
      try
        dbMain.Session.GetTableNames(dbMain.DatabaseName, '', False, False, List);
        s := '';
        for i := 0 to List.Count - 1 do
        begin
          TbSource.TableName := List.Strings[i];
          TbSource.Active := True;
          if Assigned(OnCompactar) then
            OnCompactar(TbSource);
          try
            try
              PackTable(TbSource);
            except
              //Application.HandleException(Self);
            end;
          finally
            TbSource.Active := False;
          end;
        end;
      finally
        dbMain.KeepConnection := True;
        dbMain.Exclusive := False;
        dbMain.Connected := True;
      end;
    finally
      TbSource.Free;
    end;
  finally
    List.Free;
  end;
end;

end.

