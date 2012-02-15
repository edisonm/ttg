{ -*- mode: Delphi -*- }
unit FTimetableTeacher;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, DBGrids, DbCtrls, ExtCtrls, Db, Variants,
  ZDataset, FConfig, FCrossManyToManyEditor0,
  FCrossManyToManyEditor1, FCrossManyToManyEditor, DMaster, DSource;

type

  { TTimetableTeacherForm }

  TTimetableTeacherForm = class(TCrossManyToManyEditor1Form)
    QuTimetableTeacher: TZQuery;
    CBShowTeacher: TComboBox;
    QuTimetableTeacherIdLevel: TLongintField;
    QuTimetableTeacherIdSpecialization: TLongintField;
    QuTimetableTeacherIdParallel: TLongintField;
    QuTimetableTeacherIdHour: TLongintField;
    QuTimetableTeacherIdDay: TLongintField;
    QuTimetableTeacherIdTheme: TLongintField;
    QuTimetableTeacherIsAssistance: TLongintField;
    QuTimetableTeacherNaTheme: TStringField;
    QuTimetableTeacherName: TStringField;
    QuTimetableTeacherAbLevel: TStringField;
    QuTimetableTeacherAbSpecialization: TStringField;
    QuTimetableTeacherNaParallel: TStringField;
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
    procedure TBShowClick(Sender: TObject);
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

Procedure TTimetableTeacherForm.TBShowClick(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    Caption := Format('[%s %d] - %s %s', [SuperTitle,
      Self.QuTeacher.FindField('IdTimetable').AsInteger,
      Self.QuTeacher.FindField('LnTeacher').AsString,
      Self.QuTeacher.FindField('NaTeacher').AsString]);
    FName := MasterDataModule.StringsShowTeacher.Values[CBShowTeacher.Text];
    ShowEditor(TbDay, TbHour, QuTimetableTeacher, TbTimeSlot, 'IdDay', 'NaDay',
      'IdDay', 'IdDay', 'IdHour', 'NaHour', 'IdHour', 'IdHour', 'Name');
  end;
end;

procedure TTimetableTeacherForm.FormCreate(Sender: TObject);
begin
  inherited;
  QuTeacher.Open;
  CBShowTeacher.Items.Clear;
  QuTimetableTeacher.Open;
  QuTimetableTeacherAbSpecialization.DisplayLabel := SFlTimetableDetail_IdSpecialization;
  QuTimetableTeacherNaParallel.DisplayLabel := SFlTimetableDetail_IdParallel;
  QuTimetableTeacherNaTheme.DisplayLabel := SFlTimetableDetail_IdTheme;
  QuTimetableTeacherName.DisplayLabel := SFlTeacher_NaTeacher;
  QuTeacherLnTeacher.DisplayLabel := SFlTeacher_LnTeacher;
  QuTeacherNaTeacher.DisplayLabel := SFlTeacher_NaTeacher;
  QuTimetableTeacherIdLevel.DisplayLabel := SFlTimetableDetail_IdLevel;
  QuTimetableTeacherIdSpecialization.DisplayLabel := SFlTimetableDetail_IdSpecialization;
  QuTimetableTeacherIdParallel.DisplayLabel := SFlTimetableDetail_IdParallel;
  QuTimetableTeacherIdHour.DisplayLabel := SFlTimetableDetail_IdHour;
  QuTimetableTeacherIdDay.DisplayLabel := SFlTimetableDetail_IdDay;
  QuTimetableTeacherIdTheme.DisplayLabel := SFlTimetableDetail_IdTheme;
  QuTimetableTeacherAbLevel.DisplayLabel := SFlTimetableDetail_IdLevel;
  LoadNames(MasterDataModule.StringsShowTeacher, CBShowTeacher.Items);
  CBShowTeacher.Text := CBShowTeacher.Items[0];
end;

procedure TTimetableTeacherForm.QuTimetableTeacherCalcFields(DataSet: TDataSet);
var
  IsAssistance: string;
begin
  inherited;
  if FName <> '' then
  begin
    if QuTimeTableTeacherIsAssistance.Value = 1 then
      IsAssistance := '*'
    else
      IsAssistance := '';
    DataSet['Name'] := VarArrToStr(DataSet[FName], ' ') + ' ' + IsAssistance;
  end
end;

procedure TTimetableTeacherForm.DSTeacherDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  TBShowClick(nil);
end;

initialization
{$IFDEF FPC}
  {$i ftimetableteacher.lrs}
{$ENDIF}

end.
