{ -*- mode: Delphi -*- }
unit FTheme;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, FSingleEditor, Grids, Buttons, DBCtrls, ExtCtrls,
  Printers, ComCtrls, ActnList, FCrossManytoManyEditorR, ZDataset, db;

type

  { TThemeForm }

  TThemeForm = class(TSingleEditorForm)
    procedure ActFindExecute(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure FormActivate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ThemeForm: TThemeForm;

implementation
uses
  DMaster, FCrossManyToManyEditor, FConfig, DSource, UTTGConsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TThemeForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
end;

procedure TThemeForm.DataSourceStateChange(Sender: TObject);
begin
  inherited;
end;

procedure TThemeForm.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TThemeForm.ActFindExecute(Sender: TObject);
begin
  inherited;
end;

procedure TThemeForm.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  inherited;
end;

procedure TThemeForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
end;

procedure TThemeForm.FormActivate(Sender: TObject);
begin
  with SourceDataModule do
  begin
    TbTheme.Locate('IdTheme', (Sender as TCustomForm).Tag, []);
  end;
end;

procedure TThemeForm.FormCreate(Sender: TObject);
begin
  inherited;
end;

procedure TThemeForm.FormDestroy(Sender: TObject);
begin
  inherited;
end;

initialization

{$IFDEF FPC}
{$i FTheme.lrs}
{$ENDIF}

end.
