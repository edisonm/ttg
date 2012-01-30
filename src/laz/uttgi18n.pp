{ -*- mode: Delphi -*- }
unit uttgi18n; 

{$I ttg.inc}

interface

uses
  Classes, SysUtils; 

function TranslateUnitResourceStrings: boolean;

implementation

uses LResources, Translations;
 
function TranslateUnitResourceStrings: boolean;
var
  r: TLResource;
  POFile: TPOFile;
begin
  r:=LazarusResources.Find('ttg.es','PO');
  POFile:=TPOFile.Create;
  try
    POFile.ReadPOText(r.Value);
    Result:=Translations.TranslateUnitResourceStrings('ttg.es',POFile);
  finally
    POFile.Free;
  end;
end;
 
initialization
  {$I ttg.lrs}
  TranslateUnitResourceStrings;
end.
