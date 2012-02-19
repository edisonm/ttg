{ -*- mode: Delphi -*- }
unit dsourcebase;

(*
  19/02/2012 19:58

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
    TbCluster: TZTable;
    DSCluster: TDataSource;
    TbDay: TZTable;
    DSDay: TDataSource;
    TbHour: TZTable;
    DSHour: TDataSource;
    TbTheme: TZTable;
    DSTheme: TDataSource;
    TbActivity: TZTable;
    DSActivity: TDataSource;
    TbResourceType: TZTable;
    DSResourceType: TDataSource;
    TbResource: TZTable;
    DSResource: TDataSource;
    TbResourceRestrictionType: TZTable;
    DSResourceRestrictionType: TDataSource;
    TbTimeSlot: TZTable;
    DSTimeSlot: TDataSource;
    TbRequirement: TZTable;
    DSRequirement: TDataSource;
    TbJoinedCluster: TZTable;
    DSJoinedCluster: TDataSource;
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
  Tables[0] := TbCategory;
  Tables[1] := TbParallel;
  TbParallel.AfterPost := DataSetAfterPost;
  TbParallel.AfterDelete := DataSetAfterDelete;
  Tables[2] := TbCluster;
  TbCluster.AfterPost := DataSetAfterPost;
  TbCluster.AfterDelete := DataSetAfterDelete;
  Tables[3] := TbDay;
  Tables[4] := TbHour;
  Tables[5] := TbTheme;
  Tables[6] := TbActivity;
  TbActivity.AfterPost := DataSetAfterPost;
  TbActivity.AfterDelete := DataSetAfterDelete;
  Tables[7] := TbResourceType;
  Tables[8] := TbResource;
  TbResource.AfterPost := DataSetAfterPost;
  TbResource.AfterDelete := DataSetAfterDelete;
  Tables[9] := TbResourceRestrictionType;
  Tables[10] := TbTimeSlot;
  Tables[11] := TbRequirement;
  Tables[12] := TbJoinedCluster;
  Tables[13] := TbThemeRestrictionType;
  Tables[14] := TbThemeRestriction;
  Tables[15] := TbResourceRestriction;
  Tables[16] := TbTimetable;
  TbTimetable.AfterPost := DataSetAfterPost;
  TbTimetable.AfterDelete := DataSetAfterDelete;
  Tables[17] := TbTimetableDetail;
  Tables[18] := TbTimetableResource;
  SetLength(FMasterRels[1], 1);
  with FMasterRels[1, 0] do
  begin
    DetailDataSet := TbCluster;
    MasterFields := 'IdParallel';
    DetailFields := 'IdParallel';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  SetLength(FMasterRels[2], 1);
  with FMasterRels[2, 0] do
  begin
    DetailDataSet := TbActivity;
    MasterFields := 'IdCategory;IdParallel';
    DetailFields := 'IdCategory;IdParallel';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  SetLength(FMasterRels[6], 3);
  with FMasterRels[6, 0] do
  begin
    DetailDataSet := TbJoinedCluster;
    MasterFields := 'IdTheme;IdCategory;IdParallel';
    DetailFields := 'IdTheme;IdCategory;IdParallel';
    UpdateCascade := True;
    DeleteCascade := True;
  end;
  with FMasterRels[6, 1] do
  begin
    DetailDataSet := TbRequirement;
    MasterFields := 'IdTheme;IdCategory;IdParallel';
    DetailFields := 'IdTheme;IdCategory;IdParallel';
    UpdateCascade := True;
    DeleteCascade := True;
  end;
  with FMasterRels[6, 2] do
  begin
    DetailDataSet := TbTimetableDetail;
    MasterFields := 'IdTheme;IdCategory;IdParallel';
    DetailFields := 'IdTheme;IdCategory;IdParallel';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  SetLength(FMasterRels[8], 3);
  with FMasterRels[8, 0] do
  begin
    DetailDataSet := TbRequirement;
    MasterFields := 'IdResource';
    DetailFields := 'IdResource';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  with FMasterRels[8, 1] do
  begin
    DetailDataSet := TbResourceRestriction;
    MasterFields := 'IdResource';
    DetailFields := 'IdResource';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  with FMasterRels[8, 2] do
  begin
    DetailDataSet := TbTimetableResource;
    MasterFields := 'IdResource';
    DetailFields := 'IdResource';
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
    Add('TbCategory=Category');
    Add('TbParallel=Parallel');
    Add('TbCluster=Cluster');
    Add('TbDay=Day');
    Add('TbHour=Hour');
    Add('TbTheme=Theme');
    Add('TbActivity=Activity');
    Add('TbResourceType=ResourceType');
    Add('TbResource=Resource');
    Add('TbResourceRestrictionType=ResourceRestrictionType');
    Add('TbTimeSlot=TimeSlot');
    Add('TbRequirement=Requirement');
    Add('TbJoinedCluster=JoinedCluster');
    Add('TbThemeRestrictionType=ThemeRestrictionType');
    Add('TbThemeRestriction=ThemeRestriction');
    Add('TbResourceRestriction=ResourceRestriction');
    Add('TbTimetable=Timetable');
    Add('TbTimetableDetail=TimetableDetail');
    Add('TbTimetableResource=TimetableResource');
  end;
  with FieldCaptionList do
  begin
    Add('TbCategory.IdCategory=' + SFlCategory_IdCategory);
    Add('TbCategory.NaCategory=' + SFlCategory_NaCategory);
    Add('TbCategory.AbCategory=' + SFlCategory_AbCategory);
    Add('TbParallel.IdParallel=' + SFlParallel_IdParallel);
    Add('TbParallel.NaParallel=' + SFlParallel_NaParallel);
    Add('TbCluster.IdCategory=' + SFlCluster_IdCategory);
    Add('TbCluster.IdParallel=' + SFlCluster_IdParallel);
    Add('TbDay.IdDay=' + SFlDay_IdDay);
    Add('TbDay.NaDay=' + SFlDay_NaDay);
    Add('TbHour.IdHour=' + SFlHour_IdHour);
    Add('TbHour.NaHour=' + SFlHour_NaHour);
    Add('TbHour.Interval=' + SFlHour_Interval);
    Add('TbTheme.IdTheme=' + SFlTheme_IdTheme);
    Add('TbTheme.NaTheme=' + SFlTheme_NaTheme);
    Add('TbActivity.IdTheme=' + SFlActivity_IdTheme);
    Add('TbActivity.IdCategory=' + SFlActivity_IdCategory);
    Add('TbActivity.IdParallel=' + SFlActivity_IdParallel);
    Add('TbActivity.Composition=' + SFlActivity_Composition);
    Add('TbResourceType.IdResourceType=' + SFlResourceType_IdResourceType);
    Add('TbResourceType.NaResourceType=' + SFlResourceType_NaResourceType);
    Add('TbResourceType.DefaultLimit=' + SFlResourceType_DefaultLimit);
    Add('TbResourceType.ValResourceType=' + SFlResourceType_ValResourceType);
    Add('TbResource.IdResource=' + SFlResource_IdResource);
    Add('TbResource.IdResourceType=' + SFlResource_IdResourceType);
    Add('TbResource.NaResource=' + SFlResource_NaResource);
    Add('TbResource.AbResource=' + SFlResource_AbResource);
    Add('TbResource.NumResource=' + SFlResource_NumResource);
    Add('TbResourceRestrictionType.IdResourceRestrictionType=' + SFlResourceRestrictionType_IdResourceRestrictionType);
    Add('TbResourceRestrictionType.NaResourceRestrictionType=' + SFlResourceRestrictionType_NaResourceRestrictionType);
    Add('TbResourceRestrictionType.ColResourceRestrictionType=' + SFlResourceRestrictionType_ColResourceRestrictionType);
    Add('TbResourceRestrictionType.ValResourceRestrictionType=' + SFlResourceRestrictionType_ValResourceRestrictionType);
    Add('TbTimeSlot.IdDay=' + SFlTimeSlot_IdDay);
    Add('TbTimeSlot.IdHour=' + SFlTimeSlot_IdHour);
    Add('TbRequirement.IdTheme=' + SFlRequirement_IdTheme);
    Add('TbRequirement.IdCategory=' + SFlRequirement_IdCategory);
    Add('TbRequirement.IdParallel=' + SFlRequirement_IdParallel);
    Add('TbRequirement.IdResource=' + SFlRequirement_IdResource);
    Add('TbRequirement.NumRequirement=' + SFlRequirement_NumRequirement);
    Add('TbJoinedCluster.IdTheme=' + SFlJoinedCluster_IdTheme);
    Add('TbJoinedCluster.IdCategory=' + SFlJoinedCluster_IdCategory);
    Add('TbJoinedCluster.IdParallel=' + SFlJoinedCluster_IdParallel);
    Add('TbJoinedCluster.IdCategory1=' + SFlJoinedCluster_IdCategory1);
    Add('TbJoinedCluster.IdParallel1=' + SFlJoinedCluster_IdParallel1);
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
    Add('TbCategory=' + STbCategory);
    Add('TbParallel=' + STbParallel);
    Add('TbCluster=' + STbCluster);
    Add('TbDay=' + STbDay);
    Add('TbHour=' + STbHour);
    Add('TbTheme=' + STbTheme);
    Add('TbActivity=' + STbActivity);
    Add('TbResourceType=' + STbResourceType);
    Add('TbResource=' + STbResource);
    Add('TbResourceRestrictionType=' + STbResourceRestrictionType);
    Add('TbTimeSlot=' + STbTimeSlot);
    Add('TbRequirement=' + STbRequirement);
    Add('TbJoinedCluster=' + STbJoinedCluster);
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

