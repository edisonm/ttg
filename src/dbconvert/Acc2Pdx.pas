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
        Msgs.SaveToFile('errors.txt');
    finally
      Msgs.EndUpdate;
      Msgs.Free;
      //CoUninitialize;
    end;
  end
  else
  begin
    WriteLn(
      'DBCONVERT /ACC2PDX.  Converts Access to Paradox database.'#13#10 +
      'Usage:'#13#10 +
      '  DBCONVERT /ACC2PDX AccessFileName ParadoxDirectory'#13#10 +
      #13#10 +
      '  AccessFileName:        Name of Access File.'#13#10 +
      '  ParadoxDirectory:      Name of Paradox Directory.'#13#10 +
      #13#10 +
      'Example:'#13#10 +
      '  DBCONVERT /ACC2PDX Test.mdb ..\TestP\');
  end;
end;

end.
