{ -*- mode: Delphi -*- }
unit DBPack;

interface

procedure DBPackCommand;

procedure DBUnPackCommand;

implementation

uses
  SysUtils, dbTables, DBPacker;

procedure DBPackCommand;
var
  VDBPacker: TDBPacker;
  VDatabase: TDatabase;
begin
  VDBPacker := TDBPacker.Create(nil);
  VDatabase := TDatabase.Create(nil);
  try
    if ParamCount = 3 then
    begin
      with VDatabase.Params do
      begin
        Add('PATH=' + ParamStr(2));
        Add('DEFAULT DRIVER=PARADOX');
        Add('ENABLE BCD=FALSE');
      end;
      VDBPacker.Database := VDatabase;
      VDatabase.DatabaseName := 'PACKING';
      VDatabase.DriverName := 'STANDARD';
      VDatabase.LoginPrompt := False;
      VDBPacker.Options := [poStructure, poCompress];
      VDBPacker.SaveToFile(ParamStr(3));
    end
    else
    begin
      WriteLn(
        'DBCONVERT /DBPACK.  Packs Paradox database'#13#10 +
        'Usage:'#13#10 +
        '  DBCONVERT /DBPACK Directory FileName'#13#10 +
        #13#10 +
        '  Directory:   Directory where the database resides.'#13#10 +
        '  FileName:    Packed File Name.'#13#10 +
        #13#10 +
        'Example:'#13#10 +
        '  DBCONVERT /DBPACK c:\base base.dbp');
    end;
  finally
    VDatabase.Free;
    VDBPacker.Free;
  end;
end;

procedure DBUnPackCommand;
var
  VDBPacker: TDBPacker;
  VDatabase: TDatabase;
begin
  VDBPacker := TDBPacker.Create(nil);
  VDatabase := TDatabase.Create(nil);
  try
    if ParamCount = 3 then
    begin
      with VDatabase.Params do
      begin
        Add('PATH=' + ParamStr(3));
        Add('DEFAULT DRIVER=PARADOX');
        Add('ENABLE BCD=FALSE');
      end;
      VDBPacker.Database := VDatabase;
      VDatabase.DatabaseName := 'PACKING';
      VDatabase.DriverName := 'STANDARD';
      VDatabase.LoginPrompt := False;
      VDBPacker.Options := [poStructure, poCompress];
      VDBPacker.LoadFromFile(ParamStr(2));
    end
    else
    begin
      WriteLn(
        'DBCONVERT /DBUNPACK.  Unpacks Paradox database.'#13#10 +
        'Usage:'#13#10 +
        '  DBUNPACK NombreArchivo Directorio'#13#10 +
        #13#10 +
        '  FileName:    Packed File Name.'#13#10 +
        '  Directory:   Directory where the database resides.'#13#10 +
        #13#10 +
        'Example:'#13#10 +
        '  DBCONVERT /DBUNPACK base.dbp c:\base');
    end;
  finally
    VDatabase.Free;
    VDBPacker.Free;
  end;
end;

end.

