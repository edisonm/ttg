{ -*- mode: Delphi -*- }
unit FTimetableTeacher;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, DBGrids, DbCtrls, ExtCtrls, Db, Variants,
  ZConnection, ZDataset, FConfiguracion, FCrossManyToManyEditor0,
  FCrossManyToManyEditor1, FCrossManyToManyEditor, DMaster, DSource;

type

  { TTimetableTeacherForm }

  TTimetableTeacherForm = class(TCrossManyToManyEditor1Form)
    QuTimetableTeacher: TZQuery;
    cbVerTeacher: TComboBox;
    QuTimetableTeacherIdLevel: TLongintField;
    QuTimetableTeacherIdSpecialization: TLongintField;
    QuTimetableTeacherIdGroupId: TLongintField;
    QuTimetableTeacherIdHour: TLongintField;
    QuTimetableTeacherIdDay: TLongintField;
    QuTimetableTeacherIdSubject: TLongintField;
    QuTimetableTeacherNaSubject: TStringField;
    QuTimetableTeacherName: TStringField;
    QuTimetableTeacherAbLevel: TStringField;
    QuTimetableTeacherAbSpecialization: TStringField;
    QuTimetableTeacherNaGroupId: TStringField;
    DSTeacher: TDataSource;
    DBNavigator: TDBNavigator;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    QuTeacher: TZQuery;
    QuTeacherIdTimetable: TLongintField;
    QuTeacherIdTeacher: TLongintField;
    QuTeacherLnTeacher: TStringField;
    QuTeacherNaTeacher: TStringField;
    QuTimetableTeacherIdTimetable: TLongintField;
    QuTimetableTeacherIdTeacher: TLongintField;
    procedure BtnMostrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QuTimetableTeacherCalcFields(DataSet: TDataSet);
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

Procedure TTimetableTeacherForm.BtnMostrarClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    Caption := Format('[%s %d] - %s %s', [SuperTitle,
      QuTeacher.FindField('IdTimetable').AsInteger,
      QuTeacher.FindField('LnTeacher').AsString,
      QuTeacher.FindField('NaTeacher').AsString]);
    FName := MasterDataModule.StringsShowTeacher.Values[cbVerTeacher.Text];
    ShowEditor(TbDay, TbHour, QuTimetableTeacher, TbTimeSlot, 'IdDay', 'NaDay',
      'IdDay', 'IdDay', 'IdHour', 'NaHour', 'IdHour', 'IdHour', 'Name');
  end;
end;

procedure TTimetableTeacherForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuTeacher.Open;
  cbVerTeacher.Items.Clear;
  QuTimetableTeacher.Open;
  LoadNames(MasterDataModule.StringsShowTeacher, cbVerTeacher.Items);
  cbVerTeacher.Text := cbVerTeacher.Items[0];
end;

procedure TTimetableTeacherForm.QuTimetableTeacherCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FName <> '' then
    DataSet['Name'] := VarArrToStr(DataSet[FName], ' ');
end;

procedure TTimetableTeacherForm.DSTeacherDataChange(Sender: TObject;
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
