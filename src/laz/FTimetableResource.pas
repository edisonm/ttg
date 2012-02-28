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
    QuTimetableResourceIdCategory: TLongintField;
    QuTimetableResourceIdParallel: TLongintField;
    QuTimetableResourceIdHour: TLongintField;
    QuTimetableResourceIdDay: TLongintField;
    QuTimetableResourceIdTheme: TLongintField;
    QuTimetableResourceNaTheme: TStringField;
    QuTimetableResourceName: TStringField;
    QuTimetableResourceAbCategory: TStringField;
    QuTimetableResourceNaParallel: TStringField;
    DSResource: TDataSource;
    DBNavigator: TDBNavigator;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    QuResource: TZQuery;
    QuResourceIdTimetable: TLongintField;
    QuResourceIdResource: TLongintField;
    QuResourceNaResource: TStringField;
    QuTimetableResourceIdTimetable: TLongintField;
    QuTimetableResourceIdResource: TLongintField;
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
  UTTGBasics, dsourcebaseconsts;

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
begin
  inherited;
  QuResource.Open;
  CBShowResource.Items.Clear;
  QuTimetableResource.Open;
  QuTimetableResourceNaTheme.DisplayLabel := SFlActivity_IdTheme;
  QuTimetableResourceName.DisplayLabel := SFlResource_NaResource;
  QuResourceNaResource.DisplayLabel := SFlResource_NaResource;
  QuTimetableResourceIdHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuTimetableResourceIdDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuTimetableResourceIdTheme.DisplayLabel := SFlActivity_IdTheme;
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
