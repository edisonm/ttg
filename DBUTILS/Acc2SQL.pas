unit Acc2SQL;

interface

uses
  Classes, ActiveX, Ac2SQUtl;

procedure AccessToSQLCommand;

implementation

uses
  SysUtils;

procedure AccessToSQLCommand;
var
  Msgs: TStrings;
begin
  if (ParamCount = 3) then
  begin
    CoInitialize(nil);
    Msgs := TStringList.Create;
    Msgs.BeginUpdate;
    try
      AccessToSQL(ParamStr(2), ParamStr(3), Msgs);
      if Msgs.Count > 0 then
        Msgs.SaveToFile('ERRORS.TXT');
    finally
      Msgs.EndUpdate;
      Msgs.Free;
    end;
  end
  else
  begin
    WriteLn(
      'ACC2DM.  Access to Ansi SQL Database converter version 1.1'#13#10 +
      #13#10 +
      'Edition 02-02-2011 by Edison Mera.'#13#10 +
      'Usage:'#13#10 +
      '  ACC2SQL AccessFileName SQLFileName'#13#10 +
      #13#10 +
      '  AccessFileName:    Name of the Access File.'#13#10 +
      '  SQLFileName:       Name of the SQL File to be generated.'#13#10 +
      #13#10 +
      'Example:'#13#10 +
      '  ACC2DM PRUEBA.MDB C:\DATOS\PRUEBA.SQL');
  end;
end;

end.

