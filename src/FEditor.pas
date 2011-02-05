unit FEditor;

{$I TTG.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  StdCtrls, DBCtrls, Grids, DBGrids, Buttons, ExtCtrls, ComCtrls,
  ImgList, ToolWin, ActnList, UConfig;

type
  TEditorForm = class(TForm)
    pnlStatus: TPanel;
    TlBShow: TToolBar;
    BtnShow: TToolButton;
    Panel1: TPanel;
    ImageList: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FSuperTitle: string;
    FConfigStorage: TConfigStorage;
    FPreffix: string;
    FAction: TAction;
    function GetConfigValues(const Index: string): string;
    procedure SetConfigValues(const Index, Value: string);
    function GetConfigTexts(const Index: string): string;
    procedure SetConfigTexts(const Index, Value: string);
    function GetConfigIntegers(const Index: string): Integer;
    procedure SetConfigIntegers(const Index: string; Value: Integer);
    function GetConfigFloats(const Index: string): Extended;
    procedure SetConfigFloats(const Index: string; Value: Extended);
  protected
    procedure doLoadConfig; dynamic;
    procedure doSaveConfig; dynamic;
    property SuperTitle: string read FSuperTitle;
  public
    { Public declarations }
    property ConfigStorage: TConfigStorage read FConfigStorage;
    property ConfigValues[const Index: string]: string
                                                   read GetConfigValues
                                                   write SetConfigValues;
    property ConfigIntegers[const Index: string]: Integer
                                                     read GetConfigIntegers
                                                     write SetConfigIntegers;
    property ConfigTexts[const Index: string]: string
                                                  read GetConfigTexts
                                                  write SetConfigTexts;
    property ConfigFloats[const Index: string]: Extended
                                                   read GetConfigFloats
                                                   write SetConfigFloats;
    procedure InitEditor(AConfigStorage: TConfigStorage; const APreffix: string;
                         AAction: TAction);
    procedure LoadConfig;
    procedure SaveConfig;
    class function ToggleEditor(AOwner: TComponent;
                                var AForm;
                                AConfigStorage: TConfigStorage;
                                AAction: TAction): Boolean;
  end;
  
implementation

uses
  RelUtils;

{$R *.DFM}

class function TEditorForm.ToggleEditor(AOwner: TComponent; var AForm;
                                        AConfigStorage: TConfigStorage;
                                        AAction: TAction): Boolean;
var
  Instance: TComponent;
begin
  if not AAction.Checked then
  begin
    if TEditorForm(AForm).CloseQuery then
    begin
      TEditorForm(AForm).Close;
      TEditorForm(AForm) := nil;
    end
    else
      AAction.Checked := True;
    Result := False;
  end
  else
  begin
    Instance := TComponent(Self.NewInstance);
    TComponent(AForm) := Instance;
    Instance.Create(AOwner);
    TEditorForm(AForm).InitEditor(AConfigStorage, AAction.Name + 'Form', AAction);
    Result := True;
  end;
end;

procedure TEditorForm.InitEditor(AConfigStorage: TConfigStorage; const APreffix: string;
    AAction: TAction);
begin
  FConfigStorage := AConfigStorage;
  FPreffix := APreffix;
  FAction := AAction;
  if Assigned(FAction) then
  begin
    AAction.Checked := True;
    HelpContext := FAction.HelpContext;
    FSuperTitle := FAction.Caption;
    Caption := FAction.Caption;
  end;
  LoadConfig;
end;

procedure TEditorForm.LoadConfig;
begin
  Position := poDesigned;
  if FConfigStorage.Values[FPreffix] = '1' then
    doLoadConfig;
end;

procedure TEditorForm.SaveConfig;
begin
  doSaveConfig;
end;

procedure TEditorForm.doLoadConfig;
begin
  Top := ConfigIntegers['Top'];
  Left := ConfigIntegers['Left'];
  Width := ConfigIntegers['Width'];
  Height := ConfigIntegers['Height'];
end;

procedure TEditorForm.doSaveConfig;
begin
  ConfigStorage.Values[FPreffix] := '1';
  ConfigIntegers['Top'] := Top;
  ConfigIntegers['Left'] := Left;
  ConfigIntegers['Width'] := Width;
  ConfigIntegers['Height'] := Height;
end;

function TEditorForm.GetConfigValues(const Index: string): string;
begin
  Result := ConfigStorage.Values[FPreffix + '_' + Index];
end;

procedure TEditorForm.SetConfigValues(const Index: string; const Value: string);
begin
  ConfigStorage.Values[FPreffix + '_' + Index] := Value;
end;

function TEditorForm.GetConfigIntegers(const Index: string): Integer;
begin
   Result := ConfigStorage.Integers[FPreffix + '_' + Index];
end;

procedure TEditorForm.SetConfigIntegers(const Index: string; Value: Integer);
begin
   ConfigStorage.Integers[FPreffix + '_' + Index] := Value;
end;

function TEditorForm.GetConfigTexts(const Index: string): string;
begin
   Result := ConfigStorage.Texts[FPreffix + '_' + Index];
end;

procedure TEditorForm.SetConfigTexts(const Index: string; const Value: string);
begin
   ConfigStorage.Texts[FPreffix + '_' + Index] := Value;
end;

function TEditorForm.GetConfigFloats(const Index: string): Extended;
begin
   Result := ConfigStorage.Floats[FPreffix + '_' + Index];
end;

procedure TEditorForm.SetConfigFloats(const Index : string; Value: Extended);
begin
   ConfigStorage.Floats[FPreffix + '_' + Index] := Value;
end;

procedure TEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TEditorForm.FormDestroy(Sender: TObject);
begin
  if assigned(FAction) then
    FAction.Checked := False;
  SaveConfig;
end;

end.
