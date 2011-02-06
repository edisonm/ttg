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
  Option, Options: string;
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
    CreateFieldDefs := False;
    CreateSrcRels := False;
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
        else if Option = 'csr' then CreateSrcRels := True
        else if Option = 'lfm' then LazarusFrm := True;
        // else invalid option
      end;
    end;
    try
      AccessToDataModule(ParamStr(2), ParamStr(3), ParamStr(4),
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
