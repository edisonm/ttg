unit Acc2DM;

interface

uses
  Classes, ActiveX, Ac2DMUtl;

procedure AccessToDataModuleCommand;

implementation

uses
  SysUtils, DB;

procedure AccessToDataModuleCommand;
var
  Msgs: TStrings;
  CreateDataSource,
  CreateSrcIndexes, // Code in .pas
  CreateIndexDefs,  // Code in .dfm
  CreateSrcFields,  // Code in .pas
  CreateFieldDefs,  // Code in .dfm
  CreateDfmFields,   // Code in .dfm
  CreateSrcRels,
  LazarusFrm: Boolean;
  iPos: Integer;
  Option, Options, DataSetClass, Units: string;
begin
  if (ParamCount = 4) or (ParamCount = 5) then
  begin
    CoInitialize(nil);
    Msgs := TStringList.Create;
    Msgs.BeginUpdate;
    CreateDataSource := False;
    CreateSrcIndexes := False;
    CreateIndexDefs := False;
    CreateSrcFields := False;
    CreateDfmFields := False;
    CreateFieldDefs := False;
    CreateSrcRels := False;
    LazarusFrm := False;
    DataSetClass := 'Table';
    Units := '';
    if ParamCount = 5 then
    begin
      iPos := 1;
      Options := ParamStr(5);
      while iPos <= Length(Options) do
      begin
        Option := ExtractFieldName(Options, iPos);
        if Option = 'cds' then CreateDataSource := True
        else if Option = 'csi' then CreateSrcIndexes := True
        else if Option = 'cid' then CreateIndexDefs := True
        else if Option = 'csf' then CreateSrcFields := True
        else if Option = 'cfd' then CreateFieldDefs := True
        else if Option = 'cdf' then CreateDfmFields := True
        else if Option = 'csr' then CreateSrcRels := True
        else if Option = 'lfm' then LazarusFrm := True
        else if StrPos(PChar(Option), 'DS=') <> nil then
          DataSetClass := Copy(Option, 4, Length(Option) - 3)
        else if StrPos(PChar(Option), 'U=') <> nil then
          Units := Copy(Option, 3, Length(Option) - 2);
        // else invalid option
      end;
    end;
    try
      AccessToDataModule(ParamStr(2), ParamStr(3), ParamStr(4), DataSetClass, Units,
        CreateDataSource, CreateSrcIndexes, CreateIndexDefs, CreateSrcFields,
        CreateFieldDefs, CreateDfmFields, CreateSrcRels, LazarusFrm, Msgs);
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
      'ACC2DM.  Access to Data Module Converter version 1.1'#13#10 +
      #13#10 +
      'Edition 09-17-2011 by Edison Mera.'#13#10 +
      'Usage:'#13#10 +
      '  ACC2DM AccessFileName NombreDataModule NombreArchivo [Option1;Option2;...]'#13#10 +
      #13#10 +
      '  AccessFileName:        Name of the Access File.'#13#10 +
      '  DataModuleName:        Name of the Data Module.'#13#10 +
      '  FileName:              Name of the Data Module File without extension.'#13#10 +
      '  [Option1;Option2;...]: Optional Options separated with semi colon.'#13#10 +
      '  Valid options are cds;csi;cid;csf;cfd;cdf;csr;lfm;DS=DataSetClassName;U=Units'#13#10 +
      #13#10 +
      'Ejemplo:'#13#10 +
      '  ACC2DM Test.mdb TestData c:\data\DmTest cds;csi');
  end;
end;

end.
