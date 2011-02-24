unit Acc2Pdx;

//program Acc2Pdx;

interface

uses
  Classes, ActiveX, Ac2PxUtl, PdxUtils;

procedure AccessToParadoxCommand;

implementation

uses
  SysUtils;

procedure AccessToParadoxCommand;
var
  Msgs: TStrings;
begin
  if ParamCount = 3 then
  begin
    CoInitialize(nil);
    Msgs := TStringList.Create;
    Msgs.BeginUpdate;
    try
      if not DirectoryExists(ParamStr(3)) then
        CreateDir(ParamStr(3));
      AccessToParadox(ParamStr(2), ParamStr(3), Msgs);
      if Msgs.Count > 0 then
        Msgs.SaveToFile('ERRORS.TXT');
    finally
      Msgs.EndUpdate;
      Msgs.Free;
      //CoUninitialize;
    end;
  end
  else
  begin
    WriteLn(
      'ACC2PDX.  Convertidor de bases de datos de Access a paradox version 1.1'#13#10 +
      #13#10 +
      'Edici¢n 02-26-1999 por Edison Mera.'#13#10 +
      'Usar:'#13#10 +
      '  ACC2PDX NombreArchivoAccess DirectorioParadox'#13#10 +
      #13#10 +
      '  NombreArchivoAccess:    Nombre del archivo de Access.'#13#10 +
      '  DirectorioParadox:      Nombre del Directorio de Paradox.'#13#10 +
      #13#10 +
      'Ejemplo:'#13#10 +
      
      '  ACC2PDX PRUEBA.MDB ..\PRUEBAP\');
  end;
end;

end.
