{ -*- mode: Delphi -*- }
unit dsourcebase;

(*
  19/02/2012 18:09

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
    TbTheme: TZTable;
    DSTheme: TDataSource;
    TbCategory: TZTable;
    DSCategory: TDataSource;
    TbParallel: TZTable;
    DSParallel: TDataSource;
    TbDay: TZTable;
    DSDay: TDataSource;
    TbHour: TZTable;
    DSHour: TDataSource;
    TbCluster: TZTable;
    DSCluster: TDataSource;
    TbJoinedCluster: TZTable;
    DSJoinedCluster: TDataSource;
    TbResourceType: TZTable;
    DSResourceType: TDataSource;
    TbResource: TZTable;
    DSResource: TDataSource;
    TbResourceRestrictionType: TZTable;
    DSResourceRestrictionType: TDataSource;
    TbTimeSlot: TZTable;
    DSTimeSlot: TDataSource;
    TbActivity: TZTable;
    DSActivity: TDataSource;
    TbRequirement: TZTable;
    DSRequirement: TDataSource;
    TbThemeRestrictionType: TZTable;
    DSThemeRestrictionType: TDataSource;
    TbThemeRestriction: TZTable;
    DSThemeRestriction: TDataSource;
    TbResourceRestriction: TZTable;
    DSResourceRestriction: TDataSource;
    TbTimetable: TZTable;
    DSTimetable: TDataSource;
    TbTimetableDetail: TZTable;
    DSTimetableDetail: TDataSource;
    TbTimetableResource: TZTable;
    DSTimetableResource: TDataSource;

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
  SetLength(FTables, 19);
  SetLength(FMasterRels, 19);
  Tables[0] := TbTheme;
  Tables[1] := TbCategory;
  Tables[2] := TbParallel;
  Tables[3] := TbDay;
  Tables[4] := TbHour;
  Tables[5] := TbCluster;
  Tables[6] := TbJoinedCluster;
  Tables[7] := TbResourceType;
  Tables[8] := TbResource;
  Tables[9] := TbResourceRestrictionType;
  Tables[10] := TbTimeSlot;
  Tables[11] := TbActivity;
  TbActivity.AfterPost := DataSetAfterPost;
  TbActivity.AfterDelete := DataSetAfterDelete;
  Tables[12] := TbRequirement;
  Tables[13] := TbThemeRestrictionType;
  Tables[14] := TbThemeRestriction;
  Tables[15] := TbResourceRestriction;
  Tables[16] := TbTimetable;
  TbTimetable.AfterPost := DataSetAfterPost;
  TbTimetable.AfterDelete := DataSetAfterDelete;
  Tables[17] := TbTimetableDetail;
  Tables[18] := TbTimetableResource;
  SetLength(FMasterRels[11], 2);
  with FMasterRels[11, 0] do
  begin
    DetailDataSet := TbRequirement;
    MasterFields := 'IdTheme;IdCategory;IdParallel';
    DetailFields := 'IdTheme;IdCategory;IdParallel';
    UpdateCascade := True;
    DeleteCascade := True;
  end;
  with FMasterRels[11, 1] do
  begin
    DetailDataSet := TbTimetableDetail;
    MasterFields := 'IdTheme;IdCategory;IdParallel';
    DetailFields := 'IdTheme;IdCategory;IdParallel';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  SetLength(FMasterRels[16], 2);
  with FMasterRels[16, 0] do
  begin
    DetailDataSet := TbTimetableDetail;
    MasterFields := 'IdTimetable';
    DetailFields := 'IdTimetable';
    UpdateCascade := True;
    DeleteCascade := True;
  end;
  with FMasterRels[16, 1] do
  begin
    DetailDataSet := TbTimetableResource;
    MasterFields := 'IdTimetable';
    DetailFields := 'IdTimetable';
    UpdateCascade := True;
    DeleteCascade := True;
  end;
  with DataSetNameList do
  begin
    Add('TbTheme=Theme');
    Add('TbCategory=Category');
    Add('TbParallel=Parallel');
    Add('TbDay=Day');
    Add('TbHour=Hour');
    Add('TbCluster=Cluster');
    Add('TbJoinedCluster=JoinedCluster');
    Add('TbResourceType=ResourceType');
    Add('TbResource=Resource');
    Add('TbResourceRestrictionType=ResourceRestrictionType');
    Add('TbTimeSlot=TimeSlot');
    Add('TbActivity=Activity');
    Add('TbRequirement=Requirement');
    Add('TbThemeRestrictionType=ThemeRestrictionType');
    Add('TbThemeRestriction=ThemeRestriction');
    Add('TbResourceRestriction=ResourceRestriction');
    Add('TbTimetable=Timetable');
    Add('TbTimetableDetail=TimetableDetail');
    Add('TbTimetableResource=TimetableResource');
  end;
  with FieldCaptionList do
  begin
    Add('TbTheme.IdTheme=' + SFlTheme_IdTheme);
    Add('TbTheme.NaTheme=' + SFlTheme_NaTheme);
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
    Add('TbCluster.IdCategory=' + SFlCluster_IdCategory);
    Add('TbCluster.IdParallel=' + SFlCluster_IdParallel);
    Add('TbJoinedCluster.IdTheme=' + SFlJoinedCluster_IdTheme);
    Add('TbJoinedCluster.IdCategory=' + SFlJoinedCluster_IdCategory);
    Add('TbJoinedCluster.IdParallel=' + SFlJoinedCluster_IdParallel);
    Add('TbJoinedCluster.IdCategory1=' + SFlJoinedCluster_IdCategory1);
    Add('TbJoinedCluster.IdParallel1=' + SFlJoinedCluster_IdParallel1);
    Add('TbResourceType.IdResourceType=' + SFlResourceType_IdResourceType);
    Add('TbResourceType.NaResourceType=' + SFlResourceType_NaResourceType);
    Add('TbResourceType.DefaultLimit=' + SFlResourceType_DefaultLimit);
    Add('TbResource.IdResource=' + SFlResource_IdResource);
    Add('TbResource.IdResourceType=' + SFlResource_IdResourceType);
    Add('TbResource.NaResource=' + SFlResource_NaResource);
    Add('TbResource.AbResource=' + SFlResource_AbResource);
    Add('TbResource.NumResource=' + SFlResource_NumResource);
    Add('TbResourceRestrictionType.IdResourceRestrictionType=' + SFlResourceRestrictionType_IdResourceRestrictionType);
    Add('TbResourceRestrictionType.IdResourceType=' + SFlResourceRestrictionType_IdResourceType);
    Add('TbResourceRestrictionType.NaResourceRestrictionType=' + SFlResourceRestrictionType_NaResourceRestrictionType);
    Add('TbResourceRestrictionType.ColResourceRestrictionType=' + SFlResourceRestrictionType_ColResourceRestrictionType);
    Add('TbResourceRestrictionType.ValResourceRestrictionType=' + SFlResourceRestrictionType_ValResourceRestrictionType);
    Add('TbTimeSlot.IdDay=' + SFlTimeSlot_IdDay);
    Add('TbTimeSlot.IdHour=' + SFlTimeSlot_IdHour);
    Add('TbActivity.IdTheme=' + SFlActivity_IdTheme);
    Add('TbActivity.IdCategory=' + SFlActivity_IdCategory);
    Add('TbActivity.IdParallel=' + SFlActivity_IdParallel);
    Add('TbActivity.Composition=' + SFlActivity_Composition);
    Add('TbRequirement.IdTheme=' + SFlRequirement_IdTheme);
    Add('TbRequirement.IdCategory=' + SFlRequirement_IdCategory);
    Add('TbRequirement.IdParallel=' + SFlRequirement_IdParallel);
    Add('TbRequirement.IdResource=' + SFlRequirement_IdResource);
    Add('TbRequirement.NumRequirement=' + SFlRequirement_NumRequirement);
    Add('TbThemeRestrictionType.IdThemeRestrictionType=' + SFlThemeRestrictionType_IdThemeRestrictionType);
    Add('TbThemeRestrictionType.NaThemeRestrictionType=' + SFlThemeRestrictionType_NaThemeRestrictionType);
    Add('TbThemeRestrictionType.ColThemeRestrictionType=' + SFlThemeRestrictionType_ColThemeRestrictionType);
    Add('TbThemeRestrictionType.ValThemeRestrictionType=' + SFlThemeRestrictionType_ValThemeRestrictionType);
    Add('TbThemeRestriction.IdTheme=' + SFlThemeRestriction_IdTheme);
    Add('TbThemeRestriction.IdDay=' + SFlThemeRestriction_IdDay);
    Add('TbThemeRestriction.IdHour=' + SFlThemeRestriction_IdHour);
    Add('TbThemeRestriction.IdThemeRestrictionType=' + SFlThemeRestriction_IdThemeRestrictionType);
    Add('TbResourceRestriction.IdResource=' + SFlResourceRestriction_IdResource);
    Add('TbResourceRestriction.IdDay=' + SFlResourceRestriction_IdDay);
    Add('TbResourceRestriction.IdHour=' + SFlResourceRestriction_IdHour);
    Add('TbResourceRestriction.IdResourceRestrictionType=' + SFlResourceRestriction_IdResourceRestrictionType);
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
    Add('TbTimetableResource.IdTimetable=' + SFlTimetableResource_IdTimetable);
    Add('TbTimetableResource.IdTheme=' + SFlTimetableResource_IdTheme);
    Add('TbTimetableResource.IdCategory=' + SFlTimetableResource_IdCategory);
    Add('TbTimetableResource.IdParallel=' + SFlTimetableResource_IdParallel);
    Add('TbTimetableResource.IdResource=' + SFlTimetableResource_IdResource);
  end;
  with DataSetDescList do
  begin
    Add('TbTheme=' + STbTheme);
    Add('TbCategory=' + STbCategory);
    Add('TbParallel=' + STbParallel);
    Add('TbDay=' + STbDay);
    Add('TbHour=' + STbHour);
    Add('TbCluster=' + STbCluster);
    Add('TbJoinedCluster=' + STbJoinedCluster);
    Add('TbResourceType=' + STbResourceType);
    Add('TbResource=' + STbResource);
    Add('TbResourceRestrictionType=' + STbResourceRestrictionType);
    Add('TbTimeSlot=' + STbTimeSlot);
    Add('TbActivity=' + STbActivity);
    Add('TbRequirement=' + STbRequirement);
    Add('TbThemeRestrictionType=' + STbThemeRestrictionType);
    Add('TbThemeRestriction=' + STbThemeRestriction);
    Add('TbResourceRestriction=' + STbResourceRestriction);
    Add('TbTimetable=' + STbTimetable);
    Add('TbTimetableDetail=' + STbTimetableDetail);
    Add('TbTimetableResource=' + STbTimetableResource);
  end;
end;

initialization
{$IFDEF FPC}
  {$i dsourcebase.lrs}
{$ENDIF}
end.

