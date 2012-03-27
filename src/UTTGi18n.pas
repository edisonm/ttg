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
    constructor Create(APOFile: TPOFile); overload;
    destructor Destroy; override;
    procedure TranslateStringProperty(Sender: TObject; const Instance: TPersistent;
      PropInfo: PPropInfo; var Content: string); override;
    function TranslateResourceStrings: Boolean;
    function TranslateUnitResourceStrings(const ResUnitName: string): Boolean;
  end;

  function GetLResourceForLanguage(const ResName, Language: AnsiString): TLResource;
  function GetLResourceForDefaultLanguage(const ResName: AnsiString): TLResource;

  procedure DisposeTranslator;
  procedure EnableTranslator(const ResName, Language: AnsiString); overload;
  procedure EnableTranslator(const ResName: AnsiString); overload;

var
  ResourceTranslator: TResourceTranslator;

implementation

uses
  FileUtil, LCLProc;
{ TResourceTranslator }

function GetLResourceForLanguage(const ResName, Language: AnsiString): TLResource;
begin
  Result := LazarusResources.Find(ResName + '.' + Language, 'PO');
  if Result = nil then
  begin
    Result := LazarusResources.Find(ResName + '.' + Copy(Language, 1, 2), 'PO');
  end;
end;

function GetDefaultLanguage: string;
var
  LangShortID, T: string;
begin
  Result := GetEnvironmentVariableUTF8('LANG');
  T := '';
  if Result = '' then LCLGetLanguageIDs(Result, T);
end;

function GetLResourceForDefaultLanguage(const ResName: AnsiString): TLResource;
begin
  Result := GetLResourceForLanguage(ResName, GetDefaultLanguage);
end;

constructor TResourceTranslator.Create(APOFile: TPOFile);
begin
  FPOFile := APOFile;
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

function NewPOFile(const ResName, Language: AnsiString): TPOFile;
var
  LangFile: string;
  LResource: TLResource;
begin
  LResource := GetLResourceForLanguage(ResName, Language);
  if LResource <> nil then
  begin
    Result := TPOFile.Create;
    Result.ReadPOText(LResource.Value);
  end
  {$IFDEF UNIX}
  else
  begin
    LangFile := '/usr/share/locale/' + Language + '/LC_MESSAGES/' +
      ChangeFileExt(ExtractFileName(ParamStrUTF8(0)), '.po');
    if not FileExistsUTF8(LangFile) then
      LangFile := '/usr/share/locale/' + Copy(Language, 1, 2) + '/LC_MESSAGES/' +
        ChangeFileExt(ExtractFileName(ParamStrUTF8(0)), '.po');
    if FileExistsUTF8(LangFile) then
    begin
      Result := TPOFile.Create(LangFile);
    end
    else
      Result := nil;
  end;
  {$ENDIF}
end;

procedure EnableTranslator(const ResName, Language: AnsiString); overload;
var
  LResource: TLResource;
  LangFile: string;
  POFile: TPOFile;
begin
  POFile := NewPOFile(ResName, Language);
  if POFile <> nil then
  begin
    ResourceTranslator := TResourceTranslator.Create(POFile);
  end
  else
    ResourceTranslator := nil;
  LRSTranslator := ResourceTranslator;
end;

procedure EnableTranslator(const ResName: AnsiString); overload;
begin
  EnableTranslator(ResName, GetDefaultLanguage);
end;

initialization
  {$I ttg.lrs}
end.

