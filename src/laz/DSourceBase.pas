{ -*- mode: Delphi -*- }
unit DSourceBase;

(*
  01/03/2012 12:05

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
    TbResourceType: TZTable;
    DSResourceType: TDataSource;
    TbHour: TZTable;
    DSHour: TDataSource;
    TbResource: TZTable;
    DSResource: TDataSource;
    TbPeriod: TZTable;
    DSPeriod: TDataSource;
    TbActivity: TZTable;
    DSActivity: TDataSource;
    TbFillRequirement: TZTable;
    DSFillRequirement: TDataSource;
    TbResourceRestrictionType: TZTable;
    DSResourceRestrictionType: TDataSource;
    TbResourceRestriction: TZTable;
    DSResourceRestriction: TDataSource;
    TbRequirement: TZTable;
    DSRequirement: TDataSource;
    TbParticipant: TZTable;
    DSParticipant: TDataSource;
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
  SetLength(FTables, 15);
  SetLength(FMasterRels, 15);
  Tables[0] := TbTheme;
  TbTheme.AfterPost := DataSetAfterPost;
  TbTheme.AfterDelete := DataSetAfterDelete;
  Tables[1] := TbDay;
  Tables[2] := TbResourceType;
  TbResourceType.AfterPost := DataSetAfterPost;
  Tables[3] := TbHour;
  Tables[4] := TbResource;
  TbResource.AfterPost := DataSetAfterPost;
  Tables[5] := TbPeriod;
  Tables[6] := TbActivity;
  TbActivity.AfterPost := DataSetAfterPost;
  TbActivity.AfterDelete := DataSetAfterDelete;
  Tables[7] := TbFillRequirement;
  Tables[8] := TbResourceRestrictionType;
  Tables[9] := TbResourceRestriction;
  Tables[10] := TbRequirement;
  Tables[11] := TbParticipant;
  Tables[12] := TbTimetable;
  TbTimetable.AfterPost := DataSetAfterPost;
  TbTimetable.AfterDelete := DataSetAfterDelete;
  Tables[13] := TbTimetableDetail;
  Tables[14] := TbTimetableResource;
  SetLength(FMasterRels[0], 3);
  with FMasterRels[0, 0] do
  begin
    DetailDataSet := TbActivity;
    MasterFields := 'IdTheme';
    DetailFields := 'IdTheme';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  with FMasterRels[0, 1] do
  begin
    DetailDataSet := TbFillRequirement;
    MasterFields := 'IdTheme';
    DetailFields := 'IdTheme';
    UpdateCascade := True;
    DeleteCascade := True;
  end;
  with FMasterRels[0, 2] do
  begin
    DetailDataSet := TbRequirement;
    MasterFields := 'IdTheme';
    DetailFields := 'IdTheme';
    UpdateCascade := True;
    DeleteCascade := True;
  end;
  SetLength(FMasterRels[2], 1);
  with FMasterRels[2, 0] do
  begin
    DetailDataSet := TbRequirement;
    MasterFields := 'IdResourceType';
    DetailFields := 'IdResourceType';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  SetLength(FMasterRels[4], 4);
  with FMasterRels[4, 0] do
  begin
    DetailDataSet := TbFillRequirement;
    MasterFields := 'IdResource';
    DetailFields := 'IdResource';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  with FMasterRels[4, 1] do
  begin
    DetailDataSet := TbParticipant;
    MasterFields := 'IdResource';
    DetailFields := 'IdResource';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  with FMasterRels[4, 2] do
  begin
    DetailDataSet := TbResourceRestriction;
    MasterFields := 'IdResource';
    DetailFields := 'IdResource';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  with FMasterRels[4, 3] do
  begin
    DetailDataSet := TbTimetableResource;
    MasterFields := 'IdResource';
    DetailFields := 'IdResource';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  SetLength(FMasterRels[6], 3);
  with FMasterRels[6, 0] do
  begin
    DetailDataSet := TbParticipant;
    MasterFields := 'IdActivity';
    DetailFields := 'IdActivity';
    UpdateCascade := True;
    DeleteCascade := True;
  end;
  with FMasterRels[6, 1] do
  begin
    DetailDataSet := TbTimetableDetail;
    MasterFields := 'IdActivity';
    DetailFields := 'IdActivity';
    UpdateCascade := True;
    DeleteCascade := True;
  end;
  with FMasterRels[6, 2] do
  begin
    DetailDataSet := TbTimetableResource;
    MasterFields := 'IdActivity';
    DetailFields := 'IdActivity';
    UpdateCascade := True;
    DeleteCascade := False;
  end;
  SetLength(FMasterRels[12], 2);
  with FMasterRels[12, 0] do
  begin
    DetailDataSet := TbTimetableDetail;
    MasterFields := 'IdTimetable';
    DetailFields := 'IdTimetable';
    UpdateCascade := True;
    DeleteCascade := True;
  end;
  with FMasterRels[12, 1] do
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
    Add('TbResourceType=ResourceType');
    Add('TbHour=Hour');
    Add('TbResource=Resource');
    Add('TbPeriod=Period');
    Add('TbActivity=Activity');
    Add('TbFillRequirement=FillRequirement');
    Add('TbResourceRestrictionType=ResourceRestrictionType');
    Add('TbResourceRestriction=ResourceRestriction');
    Add('TbRequirement=Requirement');
    Add('TbParticipant=Participant');
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
    Add('TbResourceType.IdResourceType=' + SFlResourceType_IdResourceType);
    Add('TbResourceType.NaResourceType=' + SFlResourceType_NaResourceType);
    Add('TbResourceType.DefaultLimit=' + SFlResourceType_DefaultLimit);
    Add('TbResourceType.ValResourceType=' + SFlResourceType_ValResourceType);
    Add('TbHour.IdHour=' + SFlHour_IdHour);
    Add('TbHour.NaHour=' + SFlHour_NaHour);
    Add('TbHour.Interval=' + SFlHour_Interval);
    Add('TbResource.IdResourceType=' + SFlResource_IdResourceType);
    Add('TbResource.IdResource=' + SFlResource_IdResource);
    Add('TbResource.NaResource=' + SFlResource_NaResource);
    Add('TbResource.AbResource=' + SFlResource_AbResource);
    Add('TbResource.NumResource=' + SFlResource_NumResource);
    Add('TbPeriod.IdDay=' + SFlPeriod_IdDay);
    Add('TbPeriod.IdHour=' + SFlPeriod_IdHour);
    Add('TbActivity.IdActivity=' + SFlActivity_IdActivity);
    Add('TbActivity.IdTheme=' + SFlActivity_IdTheme);
    Add('TbActivity.NaActivity=' + SFlActivity_NaActivity);
    Add('TbFillRequirement.IdTheme=' + SFlFillRequirement_IdTheme);
    Add('TbFillRequirement.IdResource=' + SFlFillRequirement_IdResource);
    Add('TbFillRequirement.NumResource=' + SFlFillRequirement_NumResource);
    Add('TbResourceRestrictionType.IdResourceRestrictionType=' + SFlResourceRestrictionType_IdResourceRestrictionType);
    Add('TbResourceRestrictionType.NaResourceRestrictionType=' + SFlResourceRestrictionType_NaResourceRestrictionType);
    Add('TbResourceRestrictionType.ColResourceRestrictionType=' + SFlResourceRestrictionType_ColResourceRestrictionType);
    Add('TbResourceRestrictionType.ValResourceRestrictionType=' + SFlResourceRestrictionType_ValResourceRestrictionType);
    Add('TbResourceRestriction.IdResource=' + SFlResourceRestriction_IdResource);
    Add('TbResourceRestriction.IdDay=' + SFlResourceRestriction_IdDay);
    Add('TbResourceRestriction.IdHour=' + SFlResourceRestriction_IdHour);
    Add('TbResourceRestriction.IdResourceRestrictionType=' + SFlResourceRestriction_IdResourceRestrictionType);
    Add('TbRequirement.IdTheme=' + SFlRequirement_IdTheme);
    Add('TbRequirement.IdResourceType=' + SFlRequirement_IdResourceType);
    Add('TbRequirement.Limit=' + SFlRequirement_Limit);
    Add('TbParticipant.IdActivity=' + SFlParticipant_IdActivity);
    Add('TbParticipant.IdResource=' + SFlParticipant_IdResource);
    Add('TbParticipant.NumResource=' + SFlParticipant_NumResource);
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
    Add('TbTimetableResource.NumResource=' + SFlTimetableResource_NumResource);
  end;
  with DataSetDescList do
  begin
    Add('TbTheme=' + STbTheme);
    Add('TbDay=' + STbDay);
    Add('TbResourceType=' + STbResourceType);
    Add('TbHour=' + STbHour);
    Add('TbResource=' + STbResource);
    Add('TbPeriod=' + STbPeriod);
    Add('TbActivity=' + STbActivity);
    Add('TbFillRequirement=' + STbFillRequirement);
    Add('TbResourceRestrictionType=' + STbResourceRestrictionType);
    Add('TbResourceRestriction=' + STbResourceRestriction);
    Add('TbRequirement=' + STbRequirement);
    Add('TbParticipant=' + STbParticipant);
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

