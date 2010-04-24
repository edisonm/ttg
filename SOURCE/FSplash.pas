unit FSplash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, DB, About, ExtCtrls, RxVerInf, AppEvent;

type
  TSplashForm = class(TForm)
    lblProductName: TLabel;
    lblProductVersion: TLabel;
    lblCopyright: TLabel;
    PBLoad: TProgressBar;
    Label4: TLabel;
    lblTable: TLabel;
    lblYearLabel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FVerInfo: TVersionInfo;
  public
    { Public declarations }
    procedure OnDataSetProgress(DataSet: TDataSet);
    procedure IncPosition;
    property VerInfo: TVersionInfo read FVerInfo;
  end;

var
  SplashForm: TSplashForm;

implementation

{$R *.DFM}

procedure TSplashForm.IncPosition;
begin
  PBLoad.Position := PBLoad.Position + 1;
end;

procedure TSplashForm.OnDataSetProgress(DataSet: TDataSet);
begin
  lblTable.Caption := DataSet.Name;
  lblTable.Repaint;
  IncPosition;
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
  FVerInfo := TVersionInfo.Create(Application.ExeName);
  if VerInfo.Valid then
  begin
    lblYearLabel.Caption := VerInfo.LegalCopyright;
    lblProductVersion.Caption := VerInfo.FileVersion;
  end;
  Caption := VerInfo.FileDescription;
  lblProductName.Caption := VerInfo.FileDescription;
  lblCopyright.Caption := FormatDateTime('c', VerInfo.VerFileDate);
end;

procedure TSplashForm.FormDestroy(Sender: TObject);
begin
  VerInfo.Free;
end;

end.
