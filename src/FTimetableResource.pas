{ -*- mode: Delphi -*- }
unit FTimetableResource;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, DBGrids, DbCtrls, ExtCtrls, Db, Variants,
  ZDataset, FConfig, FCrossManyToManyEditor0,
  FCrossManyToManyEditor1, FCrossManyToManyEditor, DMaster, DSource;

type

  { TTimetableResourceForm }

  TTimetableResourceForm = class(TCrossManyToManyEditor1Form)
    QuTimetableResource: TZQuery;
    CBShowResource: TComboBox;
    DSResource: TDataSource;
    DBNavigator: TDBNavigator;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    QuResource: TZQuery;
    procedure TBShowClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QuTimetableResourceCalcFields(DataSet: TDataSet);
    procedure DSResourceDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    FName: string;
  protected
  public
    { Public declarations }
  end;

implementation
uses
  UTTGBasics, DSourceBaseConsts, URelUtils;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

Procedure TTimetableResourceForm.TBShowClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    Caption := Format('[%s %d] - %s', [SuperTitle,
      Self.QuResource.FindField('IdTimetable').AsInteger,
      Self.QuResource.FindField('NaResource').AsString]);
    FName := MasterDataModule.StringsShowResource.Values[CBShowResource.Text];
    ShowEditor(TbDay, TbHour, QuTimetableResource, TbPeriod, 'IdDay', 'NaDay',
      'IdDay', 'IdDay', 'IdHour', 'NaHour', 'IdHour', 'IdHour', 'Name');
  end;
end;

procedure TTimetableResourceForm.FormCreate(Sender: TObject);
var
  Field: TField;
begin
  inherited;
  QuResource.Open;
  with QuResource do
  begin
    FindField('IdTimetable').Visible := False;
    FindField('IdResource').Visible := False;
    FindField('NaResource').DisplayLabel := SFlResource_NaResource;
  end;
  CBShowResource.Items.Clear;
  with QuTimetableResource do
  begin
    PrepareDatasetFields(QuTimetableResource);
    Field := TStringField.Create(Owner);
    with Field do
    begin
      FieldKind := fkCalculated;
      Size := 40;
      DisplayLabel :=  SFlResource_NaResource;
      FieldName := 'Name';
      DataSet := QuTimetableResource;
    end;
    Open;
    FindField('NaTheme').DisplayLabel := SFlActivity_IdTheme;
    FindField('IdHour').DisplayLabel := SFlTimetableDetail_IdHour;
    FindField('IdDay').DisplayLabel := SFlTimetableDetail_IdDay;
    FindField('IdTheme').DisplayLabel := SFlActivity_IdTheme;
  end;
  LoadNames(MasterDataModule.StringsShowResource, CBShowResource.Items);
  CBShowResource.Text := CBShowResource.Items[0];
end;

procedure TTimetableResourceForm.QuTimetableResourceCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FName <> '' then
  begin
    DataSet['Name'] := VarArrToStr(DataSet[FName], ' ');
  end
end;

procedure TTimetableResourceForm.DSResourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  TBShowClick(nil);
end;

initialization
{$IFDEF FPC}
  {$i FTimetableResource.lrs}
{$ENDIF}

end.
