program DBUTILS;
{$APPTYPE CONSOLE}
uses
  Forms,
  SysUtils,
  Acc2Pdx in 'Acc2Pdx.pas',
  DBPack in 'DBPack.pas',
  Ac2PxUtl in 'Ac2PxUtl.pas',
  PdxUtils in 'PdxUtils.pas',
  AccUtl in 'AccUtl.pas',
  Ac2DMUtl in 'Ac2DMUtl.pas',
  Acc2DM in 'Acc2DM.pas',
  ArDBUtls in '..\..\arctl\SOURCE\ArDBUtls.pas',
  DBPacker in '..\..\arctl\SOURCE\DBPacker.pas',
  BZIP2 in '..\..\arctl\SOURCE\BZIP2.PAS',
  ARCConst in '..\..\arctl\SOURCE\ARCConst.pas',
  DAO_TLB in 'C:\Documents and Settings\edison\Mis documentos\RAD Studio\7.0\Imports\DAO_TLB.pas';

begin
  if ParamCount = 0 then
  begin
    WriteLn(
      'DBUTILS.  Utiler¡as de base de datos versi¢n 1.0'#13#10 +
      #13#10 +
      'Edici¢n 09-13-1999 por Edison Mera.'#13#10 +
      'Usar:'#13#10 +
      '  DBUTILS [OPCION [PARAMETROS]]'#13#10 +
      #13#10 +
      '  OPCION:           Opcion seleccionada: /DBPACK, /DBUNPACK, /ACC2PDX, /ACC2DM.'#13#10 +
      '  PARAMETROS:       Par metros acordes con la opción.'#13#10 +
      '  Con la opci¢n sin par metros se muestra la ayuda.'#13#10 +
      #13#10 +
      'Ejemplo:'#13#10 +
      '  DBUTILS /DBPACK C:\BASE BASE.DBP');
  end
  else
  begin
    if UpperCase(ParamStr(1)) = '/DBPACK' then
      DBPack_
    else if UpperCase(ParamStr(1)) = '/DBUNPACK' then
      DBUnPack_
    else if UpperCase(ParamStr(1)) = '/ACC2PDX' then
      Acc2Pdx_
    else if UpperCase(PAramStr(1)) = '/ACC2DM' then
      Acc2DM_
    else
      raise Exception.Create('Opci¢n no v lida');
  end;
end.
