{ -*- mode: Delphi -*- }
unit FTimeTableTeacher;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, DBGrids, DbCtrls, ExtCtrls, Db, Variants,
  ZConnection, ZDataset, FConfiguracion, FCrossManyToManyEditor0,
  FCrossManyToManyEditor1, FCrossManyToManyEditor, DMaster, DSource;

type

  { TTimeTableTeacherForm }

  TTimeTableTeacherForm = class(TCrossManyToManyEditor1Form)
    QuTimeTableTeacher: TZQuery;
    cbVerTeacher: TComboBox;
    QuTimeTableTeacherIdLevel: TLongintField;
    QuTimeTableTeacherIdSpecialization: TLongintField;
    QuTimeTableTeacherIdGroupId: TLongintField;
    QuTimeTableTeacherIdHour: TLongintField;
    QuTimeTableTeacherIdDay: TLongintField;
    QuTimeTableTeacherIdSubject: TLongintField;
    QuTimeTableTeacherNaSubject: TStringField;
    QuTimeTableTeacherName: TStringField;
    QuTimeTableTeacherAbLevel: TStringField;
    QuTimeTableTeacherAbSpecialization: TStringField;
    QuTimeTableTeacherNaGroupId: TStringField;
    DSTeacher: TDataSource;
    DBNavigator: TDBNavigator;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    QuTeacher: TZQuery;
    QuTeacherIdTimeTable: TLongintField;
    QuTeacherIdTeacher: TLongintField;
    QuTeacherLnTeacher: TStringField;
    QuTeacherNaTeacher: TStringField;
    QuTimeTableTeacherIdTimeTable: TLongintField;
    QuTimeTableTeacherIdTeacher: TLongintField;
    procedure BtnMostrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QuTimeTableTeacherCalcFields(DataSet: TDataSet);
    procedure DSTeacherDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    FName: string;
  protected
  public
    { Public declarations }
  end;

implementation
uses
  UTTGBasics;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

Procedure TTimeTableTeacherForm.BtnMostrarClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    Caption := Format('[%s %d] - %s %s', [SuperTitle,
      QuTeacher.FindField('IdTimeTable').AsInteger,
      QuTeacher.FindField('LnTeacher').AsString,
      QuTeacher.FindField('NaTeacher').AsString]);
    FName := MasterDataModule.StringsShowTeacher.Values[cbVerTeacher.Text];
    ShowEditor(TbDay, TbHour, QuTimeTableTeacher, TbTimeSlot, 'IdDay', 'NaDay',
      'IdDay', 'IdDay', 'IdHour', 'NaHour', 'IdHour', 'IdHour', 'Name');
  end;
end;

procedure TTimeTableTeacherForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuTeacher.Open;
  cbVerTeacher.Items.Clear;
  QuTimeTableTeacher.Open;
  LoadNames(MasterDataModule.StringsShowTeacher, cbVerTeacher.Items);
  cbVerTeacher.Text := cbVerTeacher.Items[0];
end;

procedure TTimeTableTeacherForm.QuTimeTableTeacherCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FName <> '' then
    DataSet['Name'] := VarArrToStr(DataSet[FName], ' ');
end;

procedure TTimeTableTeacherForm.DSTeacherDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  BtnMostrarClick(nil);
end;

initialization
{$IFDEF FPC}
  {$i ftimetableteacher.lrs}
{$ENDIF}

end.
