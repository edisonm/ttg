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
    TbCategory: TZTable;
    DSCategory: TDataSource;
    TbParallel: TZTable;
    DSParallel: TDataSource;
    TbDay: TZTable;
    DSDay: TDataSource;
    TbHour: TZTable;
    DSHour: TDataSource;
    TbRoomType: TZTable;
    DSRoomType: TDataSource;
    TbCluster: TZTable;
    DSCluster: TDataSource;
    TbTheme: TZTable;
    DSTheme: TDataSource;
    TbResource: TZTable;
    DSResource: TDataSource;
    TbDistribution: TZTable;
    DSDistribution: TDataSource;
    TbJoinedCluster: TZTable;
    DSJoinedCluster: TDataSource;
    TbThemeRestrictionType: TZTable;
    DSThemeRestrictionType: TDataSource;
    TbTimeSlot: TZTable;
    DSTimeSlot: TDataSource;
    TbAssistance: TZTable;
    DSAssistance: TDataSource;
    TbResourceRestrictionType: TZTable;
    DSResourceRestrictionType: TDataSource;
    TbResourceRestriction: TZTable;
    DSResourceRestriction: TDataSource;
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
  SetLength(FTables, 18);
  Tables[0] := TbCategory;
  Tables[1] := TbParallel;
  Tables[2] := TbDay;
  Tables[3] := TbHour;
  Tables[4] := TbRoomType;
  Tables[5] := TbCluster;
  Tables[6] := TbTheme;
  Tables[7] := TbResource;
  Tables[8] := TbDistribution;
  Tables[9] := TbJoinedCluster;
  Tables[10] := TbThemeRestrictionType;
  Tables[11] := TbTimeSlot;
  Tables[12] := TbAssistance;
  Tables[13] := TbResourceRestrictionType;
  Tables[14] := TbResourceRestriction;
  Tables[15] := TbThemeRestriction;
  Tables[16] := TbTimetable;
  Tables[17] := TbTimetableDetail;
  with DataSetNameList do
  begin
    Add('TbCategory=Category');
    Add('TbParallel=Parallel');
    Add('TbDay=Day');
    Add('TbHour=Hour');
    Add('TbRoomType=RoomType');
    Add('TbCluster=Cluster');
    Add('TbTheme=Theme');
    Add('TbResource=Resource');
    Add('TbDistribution=Distribution');
    Add('TbJoinedCluster=JoinedCluster');
    Add('TbThemeRestrictionType=ThemeRestrictionType');
    Add('TbTimeSlot=TimeSlot');
    Add('TbAssistance=Assistance');
    Add('TbResourceRestrictionType=ResourceRestrictionType');
    Add('TbResourceRestriction=ResourceRestriction');
    Add('TbThemeRestriction=ThemeRestriction');
    Add('TbTimetable=Timetable');
    Add('TbTimetableDetail=TimetableDetail');
  end;
  with FieldCaptionList do
  begin
    Add('TbCategory.IdCategory=' + SFlCategory_IdCategory);
    Add('TbCategory.NaCategory=' + SFlCategory_NaCategory);
    Add('TbCategory.AbCategory=' + SFlCategory_AbCategory);
    Add('TbParallel.IdParallel=' + SFlParallel_IdParallel);
    Add('TbParallel.NaParallel=' + SFlParallel_NaParallel);
    Add('TbDay.IdDay=' + SFlDay_IdDay);
    Add('TbDay.NaDay=' + SFlDay_NaDay);
    Add('TbHour.IdHour=' + SFlHour_IdHour);
    Add('TbHour.NaHour=' + SFlHour_NaHour);
    Add('TbHour.Interval=' + SFlHour_Interval);
    Add('TbRoomType.IdRoomType=' + SFlRoomType_IdRoomType);
    Add('TbRoomType.NaRoomType=' + SFlRoomType_NaRoomType);
    Add('TbRoomType.AbRoomType=' + SFlRoomType_AbRoomType);
    Add('TbRoomType.Number=' + SFlRoomType_Number);
    Add('TbCluster.IdCategory=' + SFlCluster_IdCategory);
    Add('TbCluster.IdParallel=' + SFlCluster_IdParallel);
    Add('TbTheme.IdTheme=' + SFlTheme_IdTheme);
    Add('TbTheme.NaTheme=' + SFlTheme_NaTheme);
    Add('TbResource.IdResource=' + SFlResource_IdResource);
    Add('TbResource.AbResource=' + SFlResource_AbResource);
    Add('TbResource.NaResource=' + SFlResource_NaResource);
    Add('TbResource.NumResource=' + SFlResource_NumResource);
    Add('TbDistribution.IdTheme=' + SFlDistribution_IdTheme);
    Add('TbDistribution.IdCategory=' + SFlDistribution_IdCategory);
    Add('TbDistribution.IdParallel=' + SFlDistribution_IdParallel);
    Add('TbDistribution.IdResource=' + SFlDistribution_IdResource);
    Add('TbDistribution.IdRoomType=' + SFlDistribution_IdRoomType);
    Add('TbDistribution.RoomCount=' + SFlDistribution_RoomCount);
    Add('TbDistribution.Composition=' + SFlDistribution_Composition);
    Add('TbJoinedCluster.IdTheme=' + SFlJoinedCluster_IdTheme);
    Add('TbJoinedCluster.IdCategory=' + SFlJoinedCluster_IdCategory);
    Add('TbJoinedCluster.IdParallel=' + SFlJoinedCluster_IdParallel);
    Add('TbJoinedCluster.IdCategory1=' + SFlJoinedCluster_IdCategory1);
    Add('TbJoinedCluster.IdParallel1=' + SFlJoinedCluster_IdParallel1);
    Add('TbThemeRestrictionType.IdThemeRestrictionType=' + SFlThemeRestrictionType_IdThemeRestrictionType);
    Add('TbThemeRestrictionType.NaThemeRestrictionType=' + SFlThemeRestrictionType_NaThemeRestrictionType);
    Add('TbThemeRestrictionType.ColThemeRestrictionType=' + SFlThemeRestrictionType_ColThemeRestrictionType);
    Add('TbThemeRestrictionType.ValThemeRestrictionType=' + SFlThemeRestrictionType_ValThemeRestrictionType);
    Add('TbTimeSlot.IdDay=' + SFlTimeSlot_IdDay);
    Add('TbTimeSlot.IdHour=' + SFlTimeSlot_IdHour);
    Add('TbAssistance.IdTheme=' + SFlAssistance_IdTheme);
    Add('TbAssistance.IdCategory=' + SFlAssistance_IdCategory);
    Add('TbAssistance.IdParallel=' + SFlAssistance_IdParallel);
    Add('TbAssistance.IdResource=' + SFlAssistance_IdResource);
    Add('TbResourceRestrictionType.IdResourceRestrictionType=' + SFlResourceRestrictionType_IdResourceRestrictionType);
    Add('TbResourceRestrictionType.NaResourceRestrictionType=' + SFlResourceRestrictionType_NaResourceRestrictionType);
    Add('TbResourceRestrictionType.ColResourceRestrictionType=' + SFlResourceRestrictionType_ColResourceRestrictionType);
    Add('TbResourceRestrictionType.ValResourceRestrictionType=' + SFlResourceRestrictionType_ValResourceRestrictionType);
    Add('TbResourceRestriction.IdResource=' + SFlResourceRestriction_IdResource);
    Add('TbResourceRestriction.IdDay=' + SFlResourceRestriction_IdDay);
    Add('TbResourceRestriction.IdHour=' + SFlResourceRestriction_IdHour);
    Add('TbResourceRestriction.IdResourceRestrictionType=' + SFlResourceRestriction_IdResourceRestrictionType);
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
    Add('TbTimetableDetail.IdCategory=' + SFlTimetableDetail_IdCategory);
    Add('TbTimetableDetail.IdParallel=' + SFlTimetableDetail_IdParallel);
    Add('TbTimetableDetail.IdDay=' + SFlTimetableDetail_IdDay);
    Add('TbTimetableDetail.IdHour=' + SFlTimetableDetail_IdHour);
    Add('TbTimetableDetail.Session=' + SFlTimetableDetail_Session);
  end;
  with DataSetDescList do
  begin
    Add('TbCategory=' + STbCategory);
    Add('TbParallel=' + STbParallel);
    Add('TbDay=' + STbDay);
    Add('TbHour=' + STbHour);
    Add('TbRoomType=' + STbRoomType);
    Add('TbCluster=' + STbCluster);
    Add('TbTheme=' + STbTheme);
    Add('TbResource=' + STbResource);
    Add('TbDistribution=' + STbDistribution);
    Add('TbJoinedCluster=' + STbJoinedCluster);
    Add('TbThemeRestrictionType=' + STbThemeRestrictionType);
    Add('TbTimeSlot=' + STbTimeSlot);
    Add('TbAssistance=' + STbAssistance);
    Add('TbResourceRestrictionType=' + STbResourceRestrictionType);
    Add('TbResourceRestriction=' + STbResourceRestriction);
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

