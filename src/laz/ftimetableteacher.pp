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
    cbxShowTeacher: TComboBox;
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
    procedure btnShowClick(Sender: TObject);
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
  UTTGBasics, dsourcebaseconsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

Procedure TTimetableTeacherForm.btnShowClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    Caption := Format('[%s %d] - %s %s', [SuperTitle,
      QuTeacher.FindField('IdTimetable').AsInteger,
      QuTeacher.FindField('LnTeacher').AsString,
      QuTeacher.FindField('NaTeacher').AsString]);
    FName := MasterDataModule.StringsShowTeacher.Values[cbxShowTeacher.Text];
    ShowEditor(TbDay, TbHour, QuTimetableTeacher, TbTimeSlot, 'IdDay', 'NaDay',
      'IdDay', 'IdDay', 'IdHour', 'NaHour', 'IdHour', 'IdHour', 'Name');
  end;
end;

procedure TTimetableTeacherForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuTeacher.Open;
  cbxShowTeacher.Items.Clear;
  QuTimetableTeacher.Open;
  QuTimetableTeacherAbSpecialization.DisplayLabel := SFlTimetableDetail_IdSpecialization;
  QuTimetableTeacherNaGroupId.DisplayLabel := SFlTimetableDetail_IdGroupId;
  QuTimetableTeacherNaSubject.DisplayLabel := SFlTimetableDetail_IdSubject;
  QuTimetableTeacherName.DisplayLabel := SFlTeacher_NaTeacher;
  QuTeacherLnTeacher.DisplayLabel := SFlTeacher_LnTeacher;
  QuTeacherNaTeacher.DisplayLabel := SFlTeacher_NaTeacher;
  QuTimetableTeacherIdLevel.DisplayLabel := SFlTimetableDetail_IdLevel;
  QuTimetableTeacherIdSpecialization.DisplayLabel := SFlTimetableDetail_IdSpecialization;
  QuTimetableTeacherIdGroupId.DisplayLabel := SFlTimetableDetail_IdGroupId;
  QuTimetableTeacherIdHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuTimetableTeacherIdDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuTimetableTeacherIdSubject.DisplayLabel := SFlTimetableDetail_IdSubject;
  QuTimetableTeacherAbLevel.DisplayLabel := SFlTimetableDetail_IdLevel;
  LoadNames(MasterDataModule.StringsShowTeacher, cbxShowTeacher.Items);
  cbxShowTeacher.Text := cbxShowTeacher.Items[0];
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
  btnShowClick(nil);
end;

initialization
{$IFDEF FPC}
  {$i ftimetableteacher.lrs}
{$ENDIF}

end.
