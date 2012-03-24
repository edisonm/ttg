{ -*- mode: Delphi -*- }
unit DSourceBase;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF},
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  DSourceBaseConsts, DBase, ZDataset;

type
  TSourceBaseDataModule = class(TBaseDataModule)
    TbResourceType: TZTable;
    DSResourceType: TDataSource;
    TbDay: TZTable;
    DSDay: TDataSource;
    TbHour: TZTable;
    DSHour: TDataSource;
    TbResource: TZTable;
    DSResource: TDataSource;
    TbPeriod: TZTable;
    DSPeriod: TDataSource;
    TbActivity: TZTable;
    DSActivity: TDataSource;
    TbAvailability: TZTable;
    DSAvailability: TDataSource;
    TbResourceTypeLimit: TZTable;
    DSResourceTypeLimit: TDataSource;
    TbRestrictionType: TZTable;
    DSRestrictionType: TDataSource;
    TbRestriction: TZTable;
    DSRestriction: TDataSource;
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
  Tables[1] := TbResourceType;
  Tables[2] := TbDay;
  Tables[3] := TbHour;
  Tables[4] := TbResource;
  Tables[5] := TbPeriod;
  Tables[6] := TbActivity;
  Tables[7] := TbAvailability;
  Tables[8] := TbResourceTypeLimit;
  Tables[9] := TbRestrictionType;
  Tables[10] := TbRestriction;
  Tables[11] := TbParticipant;
  Tables[12] := TbTimetable;
  Tables[13] := TbTimetableDetail;
  Tables[14] := TbTimetableResource;
  with DataSetNameList do
  begin
    Add('TbTheme=Theme');
    Add('TbResourceType=ResourceType');
    Add('TbDay=Day');
    Add('TbHour=Hour');
    Add('TbResource=Resource');
    Add('TbPeriod=Period');
    Add('TbActivity=Activity');
    Add('TbAvailability=Availability');
    Add('TbResourceTypeLimit=ResourceTypeLimit');
    Add('TbRestrictionType=RestrictionType');
    Add('TbRestriction=Restriction');
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
    Add('TbResourceType.IdResourceType=' + SFlResourceType_IdResourceType);
    Add('TbResourceType.NaResourceType=' + SFlResourceType_NaResourceType);
    Add('TbResourceType.NumResourceLimit=' + SFlResourceType_NumResourceLimit);
    Add('TbResourceType.ValResourceType=' + SFlResourceType_ValResourceType);
    Add('TbResourceType.MaxWorkLoad=' + SFlResourceType_MaxWorkLoad);
    Add('TbDay.IdDay=' + SFlDay_IdDay);
    Add('TbDay.NaDay=' + SFlDay_NaDay);
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
    Add('TbAvailability.IdTheme=' + SFlAvailability_IdTheme);
    Add('TbAvailability.IdResource=' + SFlAvailability_IdResource);
    Add('TbAvailability.NumResource=' + SFlAvailability_NumResource);
    Add('TbResourceTypeLimit.IdTheme=' + SFlResourceTypeLimit_IdTheme);
    Add('TbResourceTypeLimit.IdResourceType=' + SFlResourceTypeLimit_IdResourceType);
    Add('TbResourceTypeLimit.NumResourceLimit=' + SFlResourceTypeLimit_NumResourceLimit);
    Add('TbRestrictionType.IdRestrictionType=' + SFlRestrictionType_IdRestrictionType);
    Add('TbRestrictionType.NaRestrictionType=' + SFlRestrictionType_NaRestrictionType);
    Add('TbRestrictionType.ColRestrictionType=' + SFlRestrictionType_ColRestrictionType);
    Add('TbRestrictionType.ValRestrictionType=' + SFlRestrictionType_ValRestrictionType);
    Add('TbRestriction.IdResource=' + SFlRestriction_IdResource);
    Add('TbRestriction.IdDay=' + SFlRestriction_IdDay);
    Add('TbRestriction.IdHour=' + SFlRestriction_IdHour);
    Add('TbRestriction.IdRestrictionType=' + SFlRestriction_IdRestrictionType);
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
    Add('TbResourceType=' + STbResourceType);
    Add('TbDay=' + STbDay);
    Add('TbHour=' + STbHour);
    Add('TbResource=' + STbResource);
    Add('TbPeriod=' + STbPeriod);
    Add('TbActivity=' + STbActivity);
    Add('TbAvailability=' + STbAvailability);
    Add('TbResourceTypeLimit=' + STbResourceTypeLimit);
    Add('TbRestrictionType=' + STbRestrictionType);
    Add('TbRestriction=' + STbRestriction);
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

