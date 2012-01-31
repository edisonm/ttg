{ -*- mode: Delphi -*- }
unit uttgi18n; 

{$I ttg.inc}

interface

uses
  Classes, SysUtils, Translations, LResources, typinfo;

type

  { TResourceTranslator }

  TResourceTranslator = class(TAbstractTranslator)
  private
    FPOFile: TPOFile;
  public
    constructor Create(LResource: TLResource);
    destructor Destroy; override;
    procedure TranslateStringProperty(Sender: TObject; const Instance: TPersistent;
      PropInfo: PPropInfo; var Content: string); override;
    function TranslateResourceStrings: Boolean;
    function TranslateUnitResourceStrings(const ResUnitName: string): Boolean;
  end;

  function GetLResourceForLanguage(const Name, Lang: AnsiString): TLResource;
  function GetLResourceForDefaultLanguage(const Name: AnsiString): TLResource;

  procedure DisposeTranslator;
  procedure EnableTranslator(LResource: TLResource); overload;
  procedure EnableTranslator; overload;

var
  ResourceTranslator: TResourceTranslator;

implementation

uses
  FileUtil, LCLProc;
{ TResourceTranslator }

function GetLResourceForLanguage(const Name, Lang: AnsiString): TLResource;
begin
  Result := LazarusResources.Find(Name + '.' + Lang, 'PO');
end;

function GetLResourceForDefaultLanguage(const Name: AnsiString): TLResource;
var
  Lang, LangShortID, T: string;
begin
  //Win32 user may decide to override locale with LANG variable.
  //if Lang = '' then
  Lang := GetEnvironmentVariableUTF8('LANG');
  if Lang = '' then
    LCLGetLanguageIDs(Lang, T);
  Result := GetLResourceForLanguage(Name, Lang);
  if Result = nil then
  begin
    LangShortID := copy(Lang, 1, 2);
    Result := GetLResourceForLanguage(Name, LangShortID);
  end
end;

constructor TResourceTranslator.Create(LResource: TLResource);
begin
  FPOFile:=TPOFile.Create;
  FPOFile.ReadPOText(LResource.Value);
end;

destructor TResourceTranslator.Destroy;
begin
  FPOFile.Free;
  inherited Destroy;
end;

procedure TResourceTranslator.TranslateStringProperty(Sender: TObject;
  const Instance: TPersistent; PropInfo: PPropInfo; var Content: string);
var
  s: string;
  Section: string;
begin
  if not Assigned(FPOFile) then exit;
  if not Assigned(PropInfo) then exit;
  if Instance is TComponent then
    if (csDesigning in TComponent(Instance).ComponentState) then
      exit;
  if (UpperCase(PropInfo^.PropType^.Name) <> 'TTRANSLATESTRING') then exit;
  Section := UpperCase(Section + '.' + Instance.GetNamePath + '.' + PropInfo^.Name);
  try
    s := FPOFile.Translate(Section, Content);
  except
    on E: Exception do
    begin
      WriteLn(E.ToString + ' ' + 'FPOFile.Translate(' + Section + ',' + Content + ')');
      s := '';
    end
  end;
  if s <> '' then
    Content := s;
end;

function TResourceTranslator.TranslateResourceStrings: Boolean;
begin
  Result:=Translations.TranslateResourceStrings(FPOFile);
end;

function TResourceTranslator.TranslateUnitResourceStrings(
  const ResUnitName: string): Boolean;
begin
  Result:=Translations.TranslateUnitResourceStrings(ResUnitName, FPOFile);
end;

procedure DisposeTranslator;
begin
  if Assigned(ResourceTranslator) then
  begin
    ResourceTranslator.Free;
    ResourceTranslator := nil;
    LRSTranslator := nil;
  end;
end;

procedure EnableTranslator(LResource: TLResource); overload;
begin
  ResourceTranslator := TResourceTranslator.Create(LResource);
  if ResourceTranslator <> nil then
    LRSTranslator := ResourceTranslator;
end;

procedure EnableTranslator; overload;
var
  LResource: TLResource;
begin
  LResource := GetLResourceForDefaultLanguage('ttg');
  if LResource <> nil then
  begin
    EnableTranslator(LResource);
  end
  else
    ResourceTranslator := nil;
end;

initialization
  {$I ttg.lrs}
  EnableTranslator;
finalization
  DisposeTranslator;
end.

