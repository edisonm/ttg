{ -*- mode: Delphi -*- }
unit dsourcebase;

(*
  14/02/2012 2:13

  Warning:

    This module has been created automatically.
    Do not modify it manually or the changes will be lost the next update


*)

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF},
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  dsourcebaseconsts,
  DBase, ZConnection, ZDataset;

type
  TSourceBaseDataModule = class(TBaseDataModule)
    DbZConnection: TZConnection;
    TbLevel: TZTable;
    DSLevel: TDataSource;
    TbSpecialization: TZTable;
    DSSpecialization: TDataSource;
    TbParallel: TZTable;
    DSParallel: TDataSource;
    TbDay: TZTable;
    DSDay: TDataSource;
    TbCategory: TZTable;
    DSCategory: TDataSource;
    TbHour: TZTable;
    DSHour: TDataSource;
    TbRoomType: TZTable;
    DSRoomType: TDataSource;
    TbClass: TZTable;
    DSClass: TDataSource;
    TbTheme: TZTable;
    DSTheme: TDataSource;
    TbTeacher: TZTable;
    DSTeacher: TDataSource;
    TbDistribution: TZTable;
    DSDistribution: TDataSource;
    TbJoinedClass: TZTable;
    DSJoinedClass: TDataSource;
    TbThemeRestrictionType: TZTable;
    DSThemeRestrictionType: TDataSource;
    TbTimeSlot: TZTable;
    DSTimeSlot: TDataSource;
    TbAssistance: TZTable;
    DSAssistance: TDataSource;
    TbTeacherRestrictionType: TZTable;
    DSTeacherRestrictionType: TDataSource;
    TbTeacherRestriction: TZTable;
    DSTeacherRestriction: TDataSource;
    TbThemeRestriction: TZTable;
    DSThemeRestriction: TDataSource;
    TbTimetable: TZTable;
    DSTimetable: TDataSource;
    TbTimetableDetail: TZTable;
    DSTimetableDetail: TDataSource;

    procedure DataModuleCreate(Sender: TObject);
  private
  public
  end;
var
  SourceBaseDataModule: TSourceBaseDataModule;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}


procedure TSourceBaseDataModule.DataModuleCreate(Sender: TObject);
begin
  inherited;
  OnDestroy := DataModuleDestroy;
  SetLength(FTables, 20);
  Tables[0] := TbLevel;
  Tables[1] := TbSpecialization;
  Tables[2] := TbParallel;
  Tables[3] := TbDay;
  Tables[4] := TbCategory;
  Tables[5] := TbHour;
  Tables[6] := TbRoomType;
  Tables[7] := TbClass;
  Tables[8] := TbTheme;
  Tables[9] := TbTeacher;
  Tables[10] := TbDistribution;
  Tables[11] := TbJoinedClass;
  Tables[12] := TbThemeRestrictionType;
  Tables[13] := TbTimeSlot;
  Tables[14] := TbAssistance;
  Tables[15] := TbTeacherRestrictionType;
  Tables[16] := TbTeacherRestriction;
  Tables[17] := TbThemeRestriction;
  Tables[18] := TbTimetable;
  Tables[19] := TbTimetableDetail;
  with DataSetNameList do
  begin
    Add('TbLevel=Level');
    Add('TbSpecialization=Specialization');
    Add('TbParallel=Parallel');
    Add('TbDay=Day');
    Add('TbCategory=Category');
    Add('TbHour=Hour');
    Add('TbRoomType=RoomType');
    Add('TbClass=Class');
    Add('TbTheme=Theme');
    Add('TbTeacher=Teacher');
    Add('TbDistribution=Distribution');
    Add('TbJoinedClass=JoinedClass');
    Add('TbThemeRestrictionType=ThemeRestrictionType');
    Add('TbTimeSlot=TimeSlot');
    Add('TbAssistance=Assistance');
    Add('TbTeacherRestrictionType=TeacherRestrictionType');
    Add('TbTeacherRestriction=TeacherRestriction');
    Add('TbThemeRestriction=ThemeRestriction');
    Add('TbTimetable=Timetable');
    Add('TbTimetableDetail=TimetableDetail');
  end;
  with FieldCaptionList do
  begin
    Add('TbLevel.IdLevel=' + SFlLevel_IdLevel);
    Add('TbLevel.NaLevel=' + SFlLevel_NaLevel);
    Add('TbLevel.AbLevel=' + SFlLevel_AbLevel);
    Add('TbSpecialization.IdSpecialization=' + SFlSpecialization_IdSpecialization);
    Add('TbSpecialization.NaSpecialization=' + SFlSpecialization_NaSpecialization);
    Add('TbSpecialization.AbSpecialization=' + SFlSpecialization_AbSpecialization);
    Add('TbParallel.IdParallel=' + SFlParallel_IdParallel);
    Add('TbParallel.NaParallel=' + SFlParallel_NaParallel);
    Add('TbDay.IdDay=' + SFlDay_IdDay);
    Add('TbDay.NaDay=' + SFlDay_NaDay);
    Add('TbCategory.IdLevel=' + SFlCategory_IdLevel);
    Add('TbCategory.IdSpecialization=' + SFlCategory_IdSpecialization);
    Add('TbHour.IdHour=' + SFlHour_IdHour);
    Add('TbHour.NaHour=' + SFlHour_NaHour);
    Add('TbHour.Interval=' + SFlHour_Interval);
    Add('TbRoomType.IdRoomType=' + SFlRoomType_IdRoomType);
    Add('TbRoomType.NaRoomType=' + SFlRoomType_NaRoomType);
    Add('TbRoomType.AbRoomType=' + SFlRoomType_AbRoomType);
    Add('TbRoomType.Number=' + SFlRoomType_Number);
    Add('TbClass.IdLevel=' + SFlClass_IdLevel);
    Add('TbClass.IdSpecialization=' + SFlClass_IdSpecialization);
    Add('TbClass.IdParallel=' + SFlClass_IdParallel);
    Add('TbTheme.IdTheme=' + SFlTheme_IdTheme);
    Add('TbTheme.NaTheme=' + SFlTheme_NaTheme);
    Add('TbTeacher.IdTeacher=' + SFlTeacher_IdTeacher);
    Add('TbTeacher.TeacherNationalId=' + SFlTeacher_TeacherNationalId);
    Add('TbTeacher.LnTeacher=' + SFlTeacher_LnTeacher);
    Add('TbTeacher.NaTeacher=' + SFlTeacher_NaTeacher);
    Add('TbDistribution.IdTheme=' + SFlDistribution_IdTheme);
    Add('TbDistribution.IdLevel=' + SFlDistribution_IdLevel);
    Add('TbDistribution.IdSpecialization=' + SFlDistribution_IdSpecialization);
    Add('TbDistribution.IdParallel=' + SFlDistribution_IdParallel);
    Add('TbDistribution.IdTeacher=' + SFlDistribution_IdTeacher);
    Add('TbDistribution.IdRoomType=' + SFlDistribution_IdRoomType);
    Add('TbDistribution.RoomCount=' + SFlDistribution_RoomCount);
    Add('TbDistribution.Composition=' + SFlDistribution_Composition);
    Add('TbJoinedClass.IdTheme=' + SFlJoinedClass_IdTheme);
    Add('TbJoinedClass.IdLevel=' + SFlJoinedClass_IdLevel);
    Add('TbJoinedClass.IdSpecialization=' + SFlJoinedClass_IdSpecialization);
    Add('TbJoinedClass.IdParallel=' + SFlJoinedClass_IdParallel);
    Add('TbJoinedClass.IdLevel1=' + SFlJoinedClass_IdLevel1);
    Add('TbJoinedClass.IdSpecialization1=' + SFlJoinedClass_IdSpecialization1);
    Add('TbJoinedClass.IdParallel1=' + SFlJoinedClass_IdParallel1);
    Add('TbThemeRestrictionType.IdThemeRestrictionType=' + SFlThemeRestrictionType_IdThemeRestrictionType);
    Add('TbThemeRestrictionType.NaThemeRestrictionType=' + SFlThemeRestrictionType_NaThemeRestrictionType);
    Add('TbThemeRestrictionType.ColThemeRestrictionType=' + SFlThemeRestrictionType_ColThemeRestrictionType);
    Add('TbThemeRestrictionType.ValThemeRestrictionType=' + SFlThemeRestrictionType_ValThemeRestrictionType);
    Add('TbTimeSlot.IdDay=' + SFlTimeSlot_IdDay);
    Add('TbTimeSlot.IdHour=' + SFlTimeSlot_IdHour);
    Add('TbAssistance.IdTheme=' + SFlAssistance_IdTheme);
    Add('TbAssistance.IdLevel=' + SFlAssistance_IdLevel);
    Add('TbAssistance.IdSpecialization=' + SFlAssistance_IdSpecialization);
    Add('TbAssistance.IdParallel=' + SFlAssistance_IdParallel);
    Add('TbAssistance.IdTeacher=' + SFlAssistance_IdTeacher);
    Add('TbTeacherRestrictionType.IdTeacherRestrictionType=' + SFlTeacherRestrictionType_IdTeacherRestrictionType);
    Add('TbTeacherRestrictionType.NaTeacherRestrictionType=' + SFlTeacherRestrictionType_NaTeacherRestrictionType);
    Add('TbTeacherRestrictionType.ColTeacherRestrictionType=' + SFlTeacherRestrictionType_ColTeacherRestrictionType);
    Add('TbTeacherRestrictionType.ValTeacherRestrictionType=' + SFlTeacherRestrictionType_ValTeacherRestrictionType);
    Add('TbTeacherRestriction.IdTeacher=' + SFlTeacherRestriction_IdTeacher);
    Add('TbTeacherRestriction.IdDay=' + SFlTeacherRestriction_IdDay);
    Add('TbTeacherRestriction.IdHour=' + SFlTeacherRestriction_IdHour);
    Add('TbTeacherRestriction.IdTeacherRestrictionType=' + SFlTeacherRestriction_IdTeacherRestrictionType);
    Add('TbThemeRestriction.IdTheme=' + SFlThemeRestriction_IdTheme);
    Add('TbThemeRestriction.IdDay=' + SFlThemeRestriction_IdDay);
    Add('TbThemeRestriction.IdHour=' + SFlThemeRestriction_IdHour);
    Add('TbThemeRestriction.IdThemeRestrictionType=' + SFlThemeRestriction_IdThemeRestrictionType);
    Add('TbTimetable.IdTimetable=' + SFlTimetable_IdTimetable);
    Add('TbTimetable.TimeIni=' + SFlTimetable_TimeIni);
    Add('TbTimetable.TimeEnd=' + SFlTimetable_TimeEnd);
    Add('TbTimetable.Summary=' + SFlTimetable_Summary);
    Add('TbTimetableDetail.IdTimetable=' + SFlTimetableDetail_IdTimetable);
    Add('TbTimetableDetail.IdTheme=' + SFlTimetableDetail_IdTheme);
    Add('TbTimetableDetail.IdLevel=' + SFlTimetableDetail_IdLevel);
    Add('TbTimetableDetail.IdSpecialization=' + SFlTimetableDetail_IdSpecialization);
    Add('TbTimetableDetail.IdParallel=' + SFlTimetableDetail_IdParallel);
    Add('TbTimetableDetail.IdDay=' + SFlTimetableDetail_IdDay);
    Add('TbTimetableDetail.IdHour=' + SFlTimetableDetail_IdHour);
    Add('TbTimetableDetail.Session=' + SFlTimetableDetail_Session);
  end;
  with DataSetDescList do
  begin
    Add('TbLevel=' + STbLevel);
    Add('TbSpecialization=' + STbSpecialization);
    Add('TbParallel=' + STbParallel);
    Add('TbDay=' + STbDay);
    Add('TbCategory=' + STbCategory);
    Add('TbHour=' + STbHour);
    Add('TbRoomType=' + STbRoomType);
    Add('TbClass=' + STbClass);
    Add('TbTheme=' + STbTheme);
    Add('TbTeacher=' + STbTeacher);
    Add('TbDistribution=' + STbDistribution);
    Add('TbJoinedClass=' + STbJoinedClass);
    Add('TbThemeRestrictionType=' + STbThemeRestrictionType);
    Add('TbTimeSlot=' + STbTimeSlot);
    Add('TbAssistance=' + STbAssistance);
    Add('TbTeacherRestrictionType=' + STbTeacherRestrictionType);
    Add('TbTeacherRestriction=' + STbTeacherRestriction);
    Add('TbThemeRestriction=' + STbThemeRestriction);
    Add('TbTimetable=' + STbTimetable);
    Add('TbTimetableDetail=' + STbTimetableDetail);
  end;
end;

initialization
{$IFDEF FPC}
  {$i dsourcebase.lrs}
{$ENDIF}
end.

