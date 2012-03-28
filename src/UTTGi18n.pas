{ -*- mode: Delphi -*- }
unit UTTGi18n; 

{$I ttg.inc}

interface

uses
  Classes, SysUtils, Translations, LResources, typinfo, gettext;

type

  { TTrFile }

  TTrFile = class
  public
    function Translate(const Identifier, OriginalValue: String): String; virtual; abstract;
    function TranslateResourceStrings: Boolean; virtual; abstract;
    function TranslateUnitResourceStrings(const ResUnitName: string): Boolean; virtual; abstract;
    class function CreateTrFile(LResource: TLResource; const ValueType: string): TTrFile; overload;
    class function CreateTrFile(const FileName, ValueType: string): TTrFile; overload;
  end;

  TResourceTranslator = class(TAbstractTranslator)
  private
    FTrFile: TTrFile;
  public
    constructor Create(ATrFile: TTrFile);
    destructor Destroy; override;
    procedure TranslateStringProperty(Sender: TObject; const Instance: TPersistent;
      PropInfo: PPropInfo; var Content: string); override;
    function TranslateResourceStrings: Boolean;
    function TranslateUnitResourceStrings(const ResUnitName: string): Boolean;
  end;

  function GetLResourceForLanguage(const ResName, Language, ValueType: AnsiString): TLResource;
  function GetLResourceForDefaultLanguage(const ResName, ValueType: AnsiString): TLResource;

  procedure DisposeTranslator;
  procedure EnableTranslator(const ResName, Language: AnsiString); overload;
  procedure EnableTranslator(const ResName: AnsiString); overload;

var
  ResourceTranslator: TResourceTranslator;

implementation

uses
  FileUtil, LCLProc;
{ TResourceTranslator }

type
  { TMOTranslatorFile }

  { TMOTrFile }

  TMOTrFile = class(TTrFile)
    FMOFile: TMOFile;
  public
    constructor Create(ALResource: TLResource); overload;
    constructor Create(const FileName: string); overload;
    destructor Destroy; override;
    function Translate(const Identifier, OriginalValue: String): String; override;
    function TranslateResourceStrings: Boolean; override;
    function TranslateUnitResourceStrings(const ResUnitName: string): Boolean; override;
  end;

  { TPOTrFile }

  TPOTrFile = class(TTrFile)
    FPOFile: TPOFile;
  public
    constructor Create(ALResource: TLResource); overload;
    constructor Create(const FileName: TFileName); overload;
    destructor Destroy; override;
    function Translate(const Identifier, OriginalValue: String): String; override;
    function TranslateResourceStrings: Boolean; override;
    function TranslateUnitResourceStrings(const ResUnitName: string): Boolean; override;
  end;

{ TTrFile }

class function TTrFile.CreateTrFile(LResource: TLResource;
  const ValueType: string): TTrFile;
begin
  if ValueType = 'po' then
    Result := TPOTrFile.Create(LResource)
  else if ValueType = 'mo' then
    Result := TMOTrFile.Create(LResource)
  else
    Result := nil;
end;

class function TTrFile.CreateTrFile(const FileName, ValueType: string): TTrFile;
begin
  if ValueType = 'po' then
    Result := TPOTrFile.Create(FileName)
  else if ValueType = 'mo' then
    Result := TMOTrFile.Create(FileName)
  else
    Result := nil;
end;

{ TPOTrFile }

constructor TPOTrFile.Create(ALResource: TLResource);
begin
  FPOFile := TPOFile.Create;
  FPOFile.ReadPOText(ALResource.Value);
end;

constructor TPOTrFile.Create(const FileName: TFileName);
begin
  FPOFile := TPOFile.Create(FileName);
end;

destructor TPOTrFile.Destroy;
begin
  FPOFile.Free;
  inherited Destroy;
end;

function TPOTrFile.Translate(const Identifier, OriginalValue: String): String;
begin
  Result := FPOFile.Translate(Identifier, OriginalValue);
end;

function TPOTrFile.TranslateResourceStrings: Boolean;
begin
  Result := Translations.TranslateResourceStrings(FPOFile);
end;

function TPOTrFile.TranslateUnitResourceStrings(const ResUnitName: string): Boolean;
begin
  Result := Translations.TranslateUnitResourceStrings(ResUnitName, FPOFile);
end;

{ TMOTranslatorFile }

constructor TMOTrFile.Create(ALResource: TLResource);
var
  Stream: TStream;
begin
  Stream := TStringStream.Create(ALResource.Value);
  try
    FMOFile := TMOFile.Create(Stream);
  finally
    Stream.Free;
  end;
end;

constructor TMOTrFile.Create(const FileName: string);
begin
  FMOFile := TMOFile.Create(FileName);
end;

function TMOTrFile.Translate(const Identifier, OriginalValue: String): String;
begin
  Result := FMOFile.Translate(Identifier + #4 + OriginalValue);
  if Result = '' then
    Result := FMOFile.Translate(OriginalValue);
  WriteLn(Format('%s::%s --> %s', [Identifier, OriginalValue, Result]));
end;

function TMOTrFile.TranslateResourceStrings: Boolean;
begin
  gettext.TranslateResourceStrings(FMOFile);
  Result := True;
end;

function TMOTrFile.TranslateUnitResourceStrings(const ResUnitName: string): Boolean;
begin
  gettext.TranslateUnitResourceStrings(ResUnitName, FMOFile);
  Result := True;
end;

destructor TMOTrFile.Destroy;
begin
  FMOFile.Free;
  inherited Destroy;
end;

constructor TResourceTranslator.Create(ATrFile: TTrFile);
begin
  FTrFile := ATrFile;
end;

destructor TResourceTranslator.Destroy;
begin
  FTrFile.Free;
  inherited Destroy;
end;

function GetLResourceForLanguage(const ResName, Language, ValueType: AnsiString): TLResource;
begin
  Result := LazarusResources.Find(ResName + '.' + Language, ValueType);
  if Result = nil then
  begin
    Result := LazarusResources.Find(ResName + '.' + Copy(Language, 1, 2), ValueType);
  end;
end;

function GetDefaultLanguage: string;
var
  T: string;
begin
  Result := GetEnvironmentVariableUTF8('LANG');
  T := '';
  if Result = '' then LCLGetLanguageIDs(Result, T);
end;

function GetLResourceForDefaultLanguage(const ResName, ValueType: AnsiString): TLResource;
begin
  Result := GetLResourceForLanguage(ResName, GetDefaultLanguage, ValueType);
end;

type
  TPersistentAccess = class(TPersistent);

function GetIdentifierPath(Sender: TObject;
                           const Instance: TPersistent;
                           PropInfo: PPropInfo): string;
var
  Tmp: TPersistent;
  Component: TComponent;
  Reader: TReader;
begin
  Result := '';
  if (PropInfo = nil) or
     (SysUtils.CompareText(PropInfo^.PropType^.Name, 'TTRANSLATESTRING') <> 0) then
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
  Reader := TReader(Sender);
  if Reader.Driver is TLRSObjectReader then
    Result := TLRSObjectReader(Reader.Driver).GetStackPath
  else
    Result := Instance.ClassName + '.' + PropInfo^.Name;
  Result := UpperCase(Result);
end;

procedure TResourceTranslator.TranslateStringProperty(Sender: TObject;
  const Instance: TPersistent; PropInfo: PPropInfo; var Content: string);
var
  s: string;
begin
  if Assigned(FTrFile) then
  begin
    s := GetIdentifierPath(Sender, Instance, PropInfo);
    if s <> '' then
    begin
      s := FTrFile.Translate(s, Content);
      if s <> '' then
        Content := s;
    end;
  end;
end;

function TResourceTranslator.TranslateResourceStrings: Boolean;
begin
  Result := FTrFile.TranslateResourceStrings;
end;

function TResourceTranslator.TranslateUnitResourceStrings(
  const ResUnitName: string): Boolean;
begin
  Result := FTrFile.TranslateUnitResourceStrings(ResUnitName);
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

function GetLocaleFileName(const LangID, LCExt: string): string;
var
  LangShortID: string;
  function GetLanguageFileName(const Language, LCExt: string): string;
  begin
    //ParamStrUTF8(0) is said not to work properly in linux, but I've tested it
    Result := ExtractFilePath(ParamStrUTF8(0)) + Language +
      DirectorySeparator + ChangeFileExt(ExtractFileName(ParamStrUTF8(0)), LCExt);
    if FileExistsUTF8(Result) then
      exit;
    
    Result := ExtractFilePath(ParamStrUTF8(0)) + 'languages' + DirectorySeparator + Language +
      DirectorySeparator + ChangeFileExt(ExtractFileName(ParamStrUTF8(0)), LCExt);
    if FileExistsUTF8(Result) then
      exit;
    
    Result := ExtractFilePath(ParamStrUTF8(0)) + 'locale' + DirectorySeparator
      + Language + DirectorySeparator + ChangeFileExt(ExtractFileName(ParamStrUTF8(0)), LCExt);
    if FileExistsUTF8(Result) then
      exit;
    
    Result := ExtractFilePath(ParamStrUTF8(0)) + 'locale' + DirectorySeparator
      + Language + DirectorySeparator + 'LC_MESSAGES' + DirectorySeparator +
      ChangeFileExt(ExtractFileName(ParamStrUTF8(0)), LCExt);
    
    if FileExistsUTF8(Result) then
      exit;
    {$IFDEF UNIX}
    //In unix-like systems we can try to search for global locale
    Result := '/usr/share/locale/' + Language + '/LC_MESSAGES/' +
      ChangeFileExt(ExtractFileName(ParamStrUTF8(0)), LCExt);
    
    if FileExistsUTF8(Result) then
      exit;
    {$ENDIF}
    //Full language in file name - this will be default for the project
    //We need more careful handling, as it MAY result in incorrect filename
    try
      Result := ExtractFilePath(ParamStrUTF8(0)) + ChangeFileExt(ExtractFileName(ParamStrUTF8(0)), '.' + Language) + LCExt;
      if FileExistsUTF8(Result) then
        exit;
      
      //Common location (like in Lazarus)
      Result := ExtractFilePath(ParamStrUTF8(0)) + 'locale' + DirectorySeparator +
        ChangeFileExt(ExtractFileName(ParamStrUTF8(0)), '.' + Language) + LCExt;
      if FileExistsUTF8(Result) then
        exit;
      
      Result := 'locale' + DirectorySeparator +
        ChangeFileExt(ExtractFileName(ParamStrUTF8(0)), '.' + Language) + LCExt;
      WriteLn(Result);
      if FileExistsUTF8(Result) then
        exit;
      
      Result := ExtractFilePath(ParamStrUTF8(0)) + 'languages' +
        DirectorySeparator + ChangeFileExt(ExtractFileName(ParamStrUTF8(0)), '.' + Language) + LCExt;
      if FileExistsUTF8(Result) then
        exit;
    except
      Result := '';//Or do something else (useless)
    end;
    Result := '';
  end;
begin
  if LangID <> '' then
  begin
    //Let us search for reducted files
    Result := GetLanguageFileName(LangID, LCExt);
    if Result = '' then
    begin
      LangShortID := copy(LangID, 1, 2);
      Result := GetLanguageFileName(LangShortID, LCExt);
    end;
  end
  else
    Result := '';
end;

function FindLocaleFileName(LCExt: string): string;
var
  Lang, T: string;
  i: integer;
begin
  Result := '';
  Lang := '';

  for i := 1 to Paramcount - 1 do
    if (ParamStrUTF8(i) = '--LANG') or (ParamStrUTF8(i) = '-l') or
      (ParamStrUTF8(i) = '--lang') then
      Lang := ParamStrUTF8(i + 1);

  //Win32 user may decide to override locale with LANG variable.
  if Lang = '' then
    Lang := GetEnvironmentVariableUTF8('LANG');

  if Lang = '' then
    LCLGetLanguageIDs(Lang, T);

  Result := GetLocaleFileName(Lang, LCExt);
  if Result <> '' then
    exit;

  Result := ChangeFileExt(ParamStrUTF8(0), LCExt);
  if FileExistsUTF8(Result) then
    exit;

  Result := '';
end;

function NewTrFile(const ResName, Language, ValueType: AnsiString): TTrFile;
var
  LangFile: string;
  LResource: TLResource;
begin
  LResource := GetLResourceForLanguage(ResName, Language, UpperCase(ValueType));
  if LResource <> nil then
  begin
    Result := TTrFile.CreateTrFile(LResource, ValueType);
    WriteLn('LResource');
  end
  {$IFDEF UNIX}
  else
  begin
    LangFile := GetLocaleFileName(Language, '.' + LowerCase(ValueType));
    WriteLn('LangFile=' + LangFile);
    if FileExistsUTF8(LangFile) then
    begin
      Result := TTrFile.CreateTrFile(LangFile, ValueType);
    end
    else
      Result := nil;
  end;
  {$ENDIF}
end;

procedure EnableTranslator(const ResName, Language: AnsiString); overload;
var
  TrFile: TTrFile;
begin
  TrFile := NewTrFile(ResName, Language, 'mo');
  if TrFile = nil then
    TrFile := NewTrFile(ResName, Language, 'po');
  if TrFile <> nil then
  begin
    ResourceTranslator := TResourceTranslator.Create(TrFile);
  end
  else
  begin
    ResourceTranslator := nil;
  end;
  LRSTranslator := ResourceTranslator;
end;

procedure EnableTranslator(const ResName: AnsiString); overload;
begin
  EnableTranslator(ResName, GetDefaultLanguage);
end;

end.

