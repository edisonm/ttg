{ -*- mode: Delphi -*- }
unit UTTGi18n; 

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
  function GetLResourceForDefaultLanguage(const ResName: AnsiString): TLResource;

  procedure DisposeTranslator;
  procedure EnableTranslator(LResource: TLResource); overload;
  procedure EnableTranslator(const ResName: AnsiString); overload;

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

function GetLResourceForDefaultLanguage(const ResName: AnsiString): TLResource;
var
  Lang, LangShortID, T: string;
begin
  Lang := GetEnvironmentVariableUTF8('LANG');
  T := '';
  if Lang = '' then
    LCLGetLanguageIDs(Lang, T);
  Result := GetLResourceForLanguage(ResName, Lang);
  if Result = nil then
  begin
    LangShortID := copy(Lang, 1, 2);
    Result := GetLResourceForLanguage(ResName, LangShortID);
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

type
  TPersistentAccess = class(TPersistent);

procedure TResourceTranslator.TranslateStringProperty(Sender: TObject;
  const Instance: TPersistent; PropInfo: PPropInfo; var Content: string);
var
  s: string;
  Section: string;
  Tmp: TPersistent;
  Component: TComponent;
begin
  if not Assigned(FPOFile) then
    exit;
  if not Assigned(PropInfo) then
    exit;
  if (UpperCase(PropInfo^.PropType^.Name) <> 'TTRANSLATESTRING') then
    exit;
  // do not translate at design time
  // get the component
  Tmp := Instance;
  while Assigned(Tmp) and not (Tmp is TComponent) do
    Tmp := TPersistentAccess(Tmp).GetOwner;
  if not Assigned(Tmp) then
    exit;
  Component := Tmp as TComponent;
  if (csDesigning in Component.ComponentState) then
    exit;

  if not (Sender is TReader) then
    exit;
  if Component = TReader(Sender).Root then
    Section := Component.ClassName
    else
      if Component.Owner = TReader(Sender).Root then
        Section := Component.Owner.ClassName
      else
        exit;
  Section := UpperCase(Section + '.' + Instance.GetNamePath + '.' + PropInfo^.Name);
  s := FPOFile.Translate(Section, Content);

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
  if LResource <> nil then
    ResourceTranslator := TResourceTranslator.Create(LResource);
  if ResourceTranslator <> nil then
    LRSTranslator := ResourceTranslator;
end;

procedure EnableTranslator(const ResName: AnsiString); overload;
var
  LResource: TLResource;
begin
  LResource := GetLResourceForDefaultLanguage(ResName);
  if LResource <> nil then
  begin
    EnableTranslator(LResource);
  end
  else
    ResourceTranslator := nil;
end;

initialization
  {$I ttg.lrs}
finalization
  DisposeTranslator;
end.

