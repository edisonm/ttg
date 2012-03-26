{ -*- mode: Delphi -*- }
unit FSplash;

{$I ttg.inc}

interface

uses
  LResources, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TSplashForm = class(TForm)
    LbProductName: TLabel;
    LbProductVersion: TLabel;
    LbCopyright: TLabel;
    LbTable: TLabel;
    LbYearLabel: TLabel;
    LbVersion: TLabel;
    LbExecutable: TLabel;
    LbEdition: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  UAbout, UTTGConsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TSplashForm.Image1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TSplashForm.FormCreate(Sender: TObject);
  procedure UpdBackground;
  var
    i, j, k, l, w, h: Integer;
  begin
    with Image1.Canvas do
    begin
      Pen.Color := clBlue;
      Brush.Color := clBlue;
      w := Image1.ClientWidth;
      h := Image1.ClientHeight;
      Rectangle(0, 0, w, h);
      for i := 1 to w - 2 do
      begin
        k := (i * 256) div w;
        for j := 1 to h - 2 do
        begin
          l := (j * 256) div h;
          Pixels[i, j] := 65535 * 256 - 256 * (abs(5 - i mod 11)) + 255
            - (k + l) div 2 - 256 * (abs(5 - j mod 11));
        end;
      end;
    end;
  end;
begin
  UpdBackground;
  Caption := SAppName;
  LbProductName.Caption := Caption;
  LbProductVersion.Caption := SAppVersion + '-' + SRevision;
  LbYearLabel.Caption := SBuildDateTime + ' - ' + SBuildMode;
  LbCopyright.Caption := SCopyright;
end;

initialization

{$IFDEF FPC}
  {$i FSplash.lrs}
{$ENDIF}

end.
