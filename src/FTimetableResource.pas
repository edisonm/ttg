{ -*- mode: Delphi -*- }
unit FTimetableResource;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, DBGrids, DbCtrls, ExtCtrls, Grids, ComCtrls, Db, Variants,
  ZDataset, FConfig, FCrossManyToManyEditor0, FCrossManyToManyEditor1, DMaster,
  DSource, FCrossManyToManyEditor, FTimetable, UConfigStorage, ActnList;

type

  { TTimetableResourceForm }

  TTimetableResourceForm = class(TCrossManyToManyEditor1Form)
    DSTimetable: TDatasource;
    QuTimetableResource: TZQuery;
    CBShowResource: TComboBox;
    DSResource: TDataSource;
    DBNavigator: TDBNavigator;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    QuResource: TZQuery;
    TbDay: TZTable;
    TbHour: TZTable;
    TbPeriod: TZTable;
    procedure CBShowResourceChange(Sender: TObject);
    procedure DSTimetableDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure QuTimetableResourceCalcFields(DataSet: TDataSet);
    procedure DSResourceDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    FName: string;
  protected
  public
    { Public declarations }
    class function ToggleEditor(AOwner: TComponent;
                                var AForm;
                                AConfigStorage: TConfigStorage;
                                AAction: TAction;
                                ADataSet: TDataSet): Boolean; overload;
  end;

implementation
uses
  UTTGBasics, DSourceConsts, UTTGDBUtils;

class function TTimetableResourceForm.ToggleEditor(AOwner: TComponent;
                                                   var AForm;
                                                   AConfigStorage: TConfigStorage;
                                                   AAction: TAction;
                                                   ADataSet: TDataSet): Boolean;
begin
  Result := ToggleEditor(AOwner, AForm, AConfigStorage, AAction);
  if Result then with TTimetableResourceForm(AForm) do
  begin
    DSTimetable.DataSet := ADataSet;
    DSResource.OnDataChange := DSResourceDataChange;
    CBShowResource.OnChange := CBShowResourceChange;
    DSTimetableDataChange(nil, nil);
    CBShowResourceChange(nil);
  end;
end;

procedure TTimetableResourceForm.FormCreate(Sender: TObject);
var
  Field: TField;
begin
  inherited;
  TbDay.Open;
  TbHour.Open;
  TbPeriod.Open;
  QuResource.Open;
  with QuResource do
  begin
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

procedure TTimetableResourceForm.CBShowResourceChange(Sender: TObject);
begin
  Caption := Format('[%s %d] - %s', [SuperTitle,
    DSTimetable.DataSet.FindField('IdTimetable').AsInteger,
    QuResource.FindField('NaResource').AsString]);
  FName := MasterDataModule.StringsShowResource.Values[CBShowResource.Text];
  ShowEditor(TbDay, TbHour, QuTimetableResource, TbPeriod, 'IdDay', 'NaDay',
    'IdDay', 'IdDay', 'IdHour', 'NaHour', 'IdHour', 'IdHour', 'Name');
end;

procedure TTimetableResourceForm.DSTimetableDataChange(Sender: TObject;
  Field: TField);
begin
  QuTimetableResource.ParamByName('IdTimetable').AsInteger
    := DSTimetable.DataSet.FindField('IdTimetable').AsInteger;
  QuTimetableResource.Refresh;
  CBShowResourceChange(Sender);
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
  CBShowResourceChange(Sender);
end;

initialization

{$i FTimetableResource.lrs}

end.
