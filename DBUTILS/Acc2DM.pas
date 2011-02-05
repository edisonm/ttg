unit Acc2DM;

interface

uses
  Classes, ActiveX, Ac2DMUtl;

procedure AccessToDataModuleCommand;

implementation

uses
  SysUtils;

procedure AccessToDataModuleCommand;
var
  Msgs: TStrings;
  CreateDS: Boolean;
begin
  if (ParamCount = 4) or (ParamCount = 5) then
  begin
    CoInitialize(nil);
    Msgs := TStringList.Create;
    Msgs.BeginUpdate;
    CreateDS := (ParamCount = 5) and (UpperCase(ParamStr(5)) = '/DS');
    try
      AccessToDataModule(ParamStr(2), ParamStr(3), ParamStr(4), CreateDS, Msgs);
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
      'ACC2DM.  Convertidor de bases de datos de Access a m¢dulo de datos versi¢n 1.1'#13#10 +
      #13#10 +
      'Edici¢n 09-17-2000 por Edison Mera.'#13#10 +
      'Usar:'#13#10 +
      '  ACC2DM NombreArchivoAccess NombreDataModule NombreArchivo [/DS]'#13#10 +
      #13#10 +
      '  NombreArchivoAccess:    Nombre del archivo de Access.'#13#10 +
      '  NombreDataModule:       Nombre del M¢dulo de datos.'#13#10 +
      '  NombreArchivo:          Nombre del archivo del m¢dulo de datos sin extensi¢n.'#13#10 +
      '  /DS:                    Especifica que se genere los DataSource para cada DataSet.'#13#10 +
      #13#10 +
      'Ejemplo:'#13#10 +
      '  ACC2DM PRUEBA.MDB DatosPrueba C:\DATOS\DmPrueba /DS');
  end;
end;

end.
