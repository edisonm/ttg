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
        'DBPACK.  Empacador de bases de datos de Paradox versi¢n 1.1'#13#10 +
        #13#10 +
        'Edici¢n 02-26-1999 por Edison Mera.'#13#10 +
        'Usar:'#13#10 +
        '  DBPACK Directorio NombreArchivo'#13#10 +
        #13#10 +
        '  Directorio:       Directorio en donde reside la base de datos.'#13#10 +
        '  NombreArchivo:    Archivo empacado.'#13#10 +
        #13#10 +
        'Ejemplo:'#13#10 +
        '  DBPACK C:\BASE BASE.DBP');
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
        'DBUNPACK.  Desempacador de bases de datos de Paradox versi¢n 1.1'#13#10 +
        #13#10 +
        'Edici¢n 11-15-2009 por Edison Mera.'#13#10 +
        'Usar:'#13#10 +
        '  DBUNPACK NombreArchivo Directorio'#13#10 +
        #13#10 +
        '  Directorio:       Directorio en donde reside la base de datos.'#13#10 +
        '  NombreArchivo:    Archivo empacado.'#13#10 +
        #13#10 +
        'Ejemplo:'#13#10 +
        '  DBUNPACK BASE.DBP C:\BASE');
    end;
  finally
    VDatabase.Free;
    VDBPacker.Free;
  end;
end;

end.

