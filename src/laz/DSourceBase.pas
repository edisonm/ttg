{ -*- mode: Delphi -*- }
unit DSourceBase;

(*
  28/02/2012 16:43

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
  DSourceBaseConsts,
  DBase, ZConnection, ZDataset;

type
  TSourceBaseDataModule = class(TBaseDataModule)
    DbZConnection: TZConnection;
    TbTheme: TZTable;
    DSTheme: TDataSource;
    TbDay: TZTable;
    DSDay: TDataSource;
    TbHour: TZTable;
    DSHour: TDataSource;
    TbPeriod: TZTable;
    DSPeriod: TDataSource;
    TbResourceType: TZTable;
    DSResourceType: TDataSource;
    TbResource: TZTable;
    DSResource: TDataSource;
    TbResourceRestrictionType: TZTable;
    DSResourceRestrictionType: TDataSource;
    TbResourceRestriction: TZTable;
    DSResourceRestriction: TDataSource;
    TbActivity: TZTable;
    DSActivity: TDataSource;
    TbRequirement: TZTable;
    DSRequirement: TDataSource;
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
  SetLength(FTables, 13);
  SetLength(FMasterRels, 13);
  Tables[0] := TbTheme;
  TbTheme.AfterPost := DataSetAfterPost;
  Tables[1] := TbDay;
  Tables[2] := TbHour;
  Tables[3] := TbPeriod;
  Tables[4] := TbResourceType;
  Tables[5] := TbResource;
  TbResource.AfterPost := DataSetAfterPost;
  Tables[6] := TbResourceRestrictionType;
  Tables[7] := TbResourceRestriction;
  Tables[8] := TbActivity;
  TbActivity.AfterPost := DataSetAfterPost;
  TbActivity.AfterDelete := DataSetAfterDelete;
  Tables[9] := TbRequirement;
  Tables[10] := TbTimetable;
  TbTimetable.AfterPost := DataSetAfterPost;
  TbTimetable.AfterDelete := DataSetAfterDelete;
  Tables[11] := TbTimetableDetail;
  Tables[12] := TbTimetableResource;
  SetLength(FMasterRels[0], 1);
  with FMasterRels[0, 0] do
  begin
    DetailDataSet := TbActivity;
    MasterFields := 'IdTheme';
    DetailFields := 'IdTheme';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  SetLength(FMasterRels[5], 3);
  with FMasterRels[5, 0] do
  begin
    DetailDataSet := TbRequirement;
    MasterFields := 'IdResource';
    DetailFields := 'IdResource';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  with FMasterRels[5, 1] do
  begin
    DetailDataSet := TbResourceRestriction;
    MasterFields := 'IdResource';
    DetailFields := 'IdResource';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  with FMasterRels[5, 2] do
  begin
    DetailDataSet := TbTimetableResource;
    MasterFields := 'IdResource';
    DetailFields := 'IdResource';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  SetLength(FMasterRels[8], 3);
  with FMasterRels[8, 0] do
  begin
    DetailDataSet := TbRequirement;
    MasterFields := 'IdActivity';
    DetailFields := 'IdActivity';
    UpdateCascade := True;
    DeleteCascade := True;
  end;
  with FMasterRels[8, 1] do
  begin
    DetailDataSet := TbTimetableDetail;
    MasterFields := 'IdActivity';
    DetailFields := 'IdActivity';
    UpdateCascade := True;
    DeleteCascade := True;
  end;
  with FMasterRels[8, 2] do
  begin
    DetailDataSet := TbTimetableResource;
    MasterFields := 'IdActivity';
    DetailFields := 'IdActivity';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  SetLength(FMasterRels[10], 2);
  with FMasterRels[10, 0] do
  begin
    DetailDataSet := TbTimetableDetail;
    MasterFields := 'IdTimetable';
    DetailFields := 'IdTimetable';
    UpdateCascade := True;
    DeleteCascade := True;
  end;
  with FMasterRels[10, 1] do
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
    Add('TbDay=Day');
    Add('TbHour=Hour');
    Add('TbPeriod=Period');
    Add('TbResourceType=ResourceType');
    Add('TbResource=Resource');
    Add('TbResourceRestrictionType=ResourceRestrictionType');
    Add('TbResourceRestriction=ResourceRestriction');
    Add('TbActivity=Activity');
    Add('TbRequirement=Requirement');
    Add('TbTimetable=Timetable');
    Add('TbTimetableDetail=TimetableDetail');
    Add('TbTimetableResource=TimetableResource');
  end;
  with FieldCaptionList do
  begin
    Add('TbTheme.IdTheme=' + SFlTheme_IdTheme);
    Add('TbTheme.NaTheme=' + SFlTheme_NaTheme);
    Add('TbTheme.Composition=' + SFlTheme_Composition);
    Add('TbDay.IdDay=' + SFlDay_IdDay);
    Add('TbDay.NaDay=' + SFlDay_NaDay);
    Add('TbHour.IdHour=' + SFlHour_IdHour);
    Add('TbHour.NaHour=' + SFlHour_NaHour);
    Add('TbHour.Interval=' + SFlHour_Interval);
    Add('TbPeriod.IdDay=' + SFlPeriod_IdDay);
    Add('TbPeriod.IdHour=' + SFlPeriod_IdHour);
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
    Add('TbResourceRestriction.IdResource=' + SFlResourceRestriction_IdResource);
    Add('TbResourceRestriction.IdDay=' + SFlResourceRestriction_IdDay);
    Add('TbResourceRestriction.IdHour=' + SFlResourceRestriction_IdHour);
    Add('TbResourceRestriction.IdResourceRestrictionType=' + SFlResourceRestriction_IdResourceRestrictionType);
    Add('TbActivity.IdActivity=' + SFlActivity_IdActivity);
    Add('TbActivity.IdTheme=' + SFlActivity_IdTheme);
    Add('TbActivity.NaActivity=' + SFlActivity_NaActivity);
    Add('TbActivity.Composition=' + SFlActivity_Composition);
    Add('TbRequirement.IdActivity=' + SFlRequirement_IdActivity);
    Add('TbRequirement.IdResource=' + SFlRequirement_IdResource);
    Add('TbRequirement.NumRequirement=' + SFlRequirement_NumRequirement);
    Add('TbTimetable.IdTimetable=' + SFlTimetable_IdTimetable);
    Add('TbTimetable.TimeIni=' + SFlTimetable_TimeIni);
    Add('TbTimetable.TimeEnd=' + SFlTimetable_TimeEnd);
    Add('TbTimetable.Summary=' + SFlTimetable_Summary);
    Add('TbTimetableDetail.IdTimetable=' + SFlTimetableDetail_IdTimetable);
    Add('TbTimetableDetail.IdActivity=' + SFlTimetableDetail_IdActivity);
    Add('TbTimetableDetail.IdDay=' + SFlTimetableDetail_IdDay);
    Add('TbTimetableDetail.IdHour=' + SFlTimetableDetail_IdHour);
    Add('TbTimetableDetail.Session=' + SFlTimetableDetail_Session);
    Add('TbTimetableResource.IdTimetable=' + SFlTimetableResource_IdTimetable);
    Add('TbTimetableResource.IdActivity=' + SFlTimetableResource_IdActivity);
    Add('TbTimetableResource.IdResource=' + SFlTimetableResource_IdResource);
  end;
  with DataSetDescList do
  begin
    Add('TbTheme=' + STbTheme);
    Add('TbDay=' + STbDay);
    Add('TbHour=' + STbHour);
    Add('TbPeriod=' + STbPeriod);
    Add('TbResourceType=' + STbResourceType);
    Add('TbResource=' + STbResource);
    Add('TbResourceRestrictionType=' + STbResourceRestrictionType);
    Add('TbResourceRestriction=' + STbResourceRestriction);
    Add('TbActivity=' + STbActivity);
    Add('TbRequirement=' + STbRequirement);
    Add('TbTimetable=' + STbTimetable);
    Add('TbTimetableDetail=' + STbTimetableDetail);
    Add('TbTimetableResource=' + STbTimetableResource);
  end;
end;

initialization
{$IFDEF FPC}
  {$i DSourceBase.lrs}
{$ENDIF}
end.

