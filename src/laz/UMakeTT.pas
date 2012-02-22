{ -*- mode: Delphi -*- }
unit UMakeTT;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, MTProcs, UTTModel, DMaster, USolver, UModel, UTTGBasics,
    UDownHill;

type

  { TMakeTimetableThread }

  TMakeTimetableThread = class(TThread)
  private
    FTimetableModel: TTimetableModel;
    FValidIdes: TDynamicIntegerArray;
    procedure Parallel(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
    function ProcessTimetable(AIdTimetable, ATimetable: Integer): Boolean;
  public
  procedure Execute; override;
  constructor Create(const AValidIdes: TDynamicIntegerArray; CreateSuspended: Boolean);
  destructor Destroy; override;
  end;

  { TImproveTimetableThread }

  TImproveTimetableThread = class(TThread)
  private
    FTimetableModel: TTimetableModel;
    FIdTimetableFuente, FIdTimetable: Integer;
  public
  procedure Execute; override;
  constructor Create(AIdTimetableFuente, AIdTimetable: Integer; CreateSuspended: Boolean);
  destructor Destroy; override;
  end;

implementation

uses
  UEvolElitist, FProgress, UTTGConsts;

type

  { TSyncSaver }

  TSyncSaver = class
  private
    FSolver: TSolver;
    FIdTimetable: Integer;
    FExtraInfo: string;
    FTimeIni: TDateTime;
    FTimeEnd: TDateTime;
  public
    constructor Create(ASolver: TSolver; AIdTimetable: Integer;
      const AExtraInfo: string; ATimeIni, ATimeEnd: TDateTime);
    procedure Execute;
  end;

{ TSyncSaver }

constructor TSyncSaver.Create(ASolver: TSolver; AIdTimetable: Integer;
  const AExtraInfo: string; ATimeIni, ATimeEnd: TDateTime);
begin
  inherited Create;
  FSolver := ASolver;
  FIdTimetable := AIdTimetable;
  FExtraInfo := AExtraInfo;
  FTimeIni := ATimeIni;
  FTimeEnd := ATimeEnd;
end;

procedure TSyncSaver.Execute;
begin
  FSolver.SaveSolutionToDatabase(FIdTimetable, FExtraInfo, FTimeIni,
    FTimeEnd);
end;

procedure LoadBookmarks(s: string; Individual: TIndividual;
    ClusterCount: Integer; out Bookmarks: TBookmarkArray);
var
  Pos, d, i: Integer;
begin
  Pos := 1;
  SetLength(Bookmarks, Length(s));
  i := 0;
  while Pos <= Length(s) do
  begin
    d := StrToInt(ExtractString(s, Pos, ','));
    case d of
    1: Bookmarks[i] := TTTBookmark.Create(Individual, RandomIndexes(ClusterCount));
    2: Bookmarks[i] := TTTBookmark2.Create(Individual, RandomIndexes(ClusterCount));
    end;
    Inc(i);
  end;
  SetLength(Bookmarks, i);
end;

procedure ExecuteDownHill(DownHill: TDownHill; const Bookmarks: string;
    RefreshInterval: Integer);
var
  i: Integer;
  Individual: TIndividual;
  BookmarkArray: TBookmarkArray;
begin
  with TTimetableModel(DownHill.Model) do
  begin
    Individual := DownHill.Model.NewIndividual;
    try
      Individual.Assign(DownHill.BestIndividual);
      LoadBookmarks(Bookmarks, Individual, ClusterCount, BookmarkArray);
      try
        TDownHill.MultiDownHill(DownHill, Individual, BookmarkArray,
                                False, RefreshInterval);
      finally
        for i := 0 to High(BookmarkArray) do
          BookmarkArray[i].Free;
      end;
    finally
      Individual.Free;
    end;
  end;
end;

function TMakeTimetableThread.ProcessTimetable(AIdTimetable, ATimetable: Integer): Boolean;
var
  VEvolElitist: TEvolElitist;
  DownHill: TDownHill;
  FTimeIni: TDateTime;
  ProgressFormDrv: TProgressFormDrv;
  ExtraInfo: string;
  FBoolToStr: array [Boolean] of string;
begin
  Result := False;
  FTimeIni := Now;
  // We hav to initialize here due to SNo and SYes are location dependent
  FBoolToStr[False] := SNo;
  FBoolToStr[True] := SYes;
  with MasterDataModule.ConfigStorage do
  begin
    VEvolElitist := TEvolElitist.Create(FTimetableModel, SharedDirectory,
      PollinationProbability, PopulationSize, MaxIteration, CrossProbability,
      MutationProbability, ReparationProbability, InitialTimetables);
    try
      TThread.Synchronize(CurrentThread, VEvolElitist.Initialize);
      ProgressFormDrv := TProgressFormDrv.Create(ATimetable);
      try
        ProgressFormDrv.Caption := Format(SWorkInProgress, [AIdTimetable]);
        VEvolElitist.OnProgress := ProgressFormDrv.OnProgress;
        VEvolElitist.Execute(RefreshInterval);
        if ProgressFormDrv.CancelClick then
        begin
          Result := True;
          Exit;
        end;
        if ApplyDoubleDownHill then
        begin
          DownHill := TDownHill.Create(FTimetableModel,
            SharedDirectory, PollinationProbability);
          try
            DownHill.BestIndividual.Assign(VEvolElitist.BestIndividual);
            ProgressFormDrv.Caption := Format(SImprovingTimetable, [AIdTimetable]);
            DownHill.OnProgress := ProgressFormDrv.OnProgress;
            ExecuteDownHill(DownHill, Bookmarks, RefreshInterval);
            if ProgressFormDrv.CancelClick then
            begin
              Result := True;
              Exit;
            end;
            VEvolElitist.BestIndividual.Assign(DownHill.BestIndividual);
          finally
            DownHill.Free;
          end;
        end
        else
        begin
          VEvolElitist.DownHill;
        end;
      finally
        ProgressFormDrv.Free;
      end;
      VEvolElitist.BestIndividual.Update;
      ExtraInfo := Format('%0:-28s %12s',
        [SApplyDownhill + ':', FBoolToStr[ApplyDoubleDownHill]]);
      with TSyncSaver.Create(VEvolElitist, AIdTimetable, ExtraInfo,
        FTimeIni, Now) do
      try
        TThread.Synchronize(CurrentThread, Execute);
      finally
        Free;
      end;
    finally
      VEvolElitist.Free;
    end;
  end;
end;

{ TMakeTimetableThread }

procedure TMakeTimetableThread.Parallel(Index: PtrInt; Data: Pointer;
  Item: TMultiThreadProcItem);
begin
  MasterDataModule.ConfigStorage.InitRandom;
  if ProcessTimetable(FValidIdes[Index], Index) then
    Terminate;
end;

procedure TMakeTimetableThread.Execute;
begin
  ProcThreadPool.DoParallel(Parallel, 0, High(FValidIdes), nil);
end;

constructor TMakeTimetableThread.Create(const AValidIdes: TDynamicIntegerArray;
  CreateSuspended: Boolean);
var
  i: Integer;
begin
  FreeOnTerminate := True;
  with MasterDataModule.ConfigStorage do
    FTimetableModel := TTimetableModel.Create(
      ClashActivity, BreakTimetableResource, OutOfPositionEmptyHour,
      BrokenSession, NonScatteredActivity);
  SetLength(FValidIdes, Length(AValidIdes));
  // ProcThreadPool.MaxThreadCount := Length(AValidIdes);
  for i := 0 to High(AValidIdes) do
    FValidIdes[i] := AValidIdes[i];
  inherited Create(CreateSuspended);
end;

destructor TMakeTimetableThread.Destroy;
begin
  FTimetableModel.Free;
  inherited Destroy;
end;

type

  { TSyncLoader }

  TSyncLoader = class
  private
    FIndividual: TIndividual;
    FIndex: Integer;
  public
    constructor Create(AIndividual: TIndividual; AIndex: Integer);
    procedure Execute;
  end;

{ TSyncLoader }

constructor TSyncLoader.Create(AIndividual: TIndividual; AIndex: Integer);
begin
  inherited Create;
  FIndividual := AIndividual;
  FIndex := AIndex;
end;

procedure TSyncLoader.Execute;
begin
  FIndividual.LoadFromDataModule(FIndex);
end;

{ TImproveTimetableThread }

procedure TImproveTimetableThread.Execute;
var
  ProgressFormDrv: TProgressFormDrv;
  TimeIni: TDateTime;
  DownHill: TDownHill;
  ExtraInfo: string;
begin
  TimeIni := Now;
  with MasterDataModule.ConfigStorage do
  begin
    InitRandom;
    DownHill := TDownHill.Create(FTimetableModel,
      SharedDirectory, PollinationProbability);
    try
      {if s = '' then
        Timetable.MakeRandom
      else}
      with TSyncLoader.Create(TTimetable(DownHill.BestIndividual),
        FIdTimetableFuente) do
      try
        TThread.Synchronize(CurrentThread, Execute);
      finally
        Free;
      end;
      TDownHill.DownHill(DownHill.BestIndividual);
      ProgressFormDrv := TProgressFormDrv.Create(0);
      try
        DownHill.OnProgress := ProgressFormDrv.OnProgress;
        ProgressFormDrv.Caption := Format(SImprovingTimetableIn,
          [FIdTimetableFuente, FIdTimetable]);
        ExecuteDownHill(DownHill, Bookmarks, RefreshInterval);
        if ProgressFormDrv.CancelClick then
        begin
          Terminate;
          Exit;
        end
        else
          ExtraInfo := Format(SBaseTimetable, [FIdTimetableFuente]);
          with TSyncSaver.Create(DownHill, FIdTimetable, ExtraInfo,
            TimeIni, Now) do
          try
            TThread.Synchronize(CurrentThread, Execute);
          finally
            Free;
          end;
      finally
        ProgressFormDrv.Free;
      end;
    finally
      DownHill.Free;
    end;
  end;
end;

constructor TImproveTimetableThread.Create(AIdTimetableFuente, AIdTimetable: Integer;
  CreateSuspended: Boolean);
begin
  FreeOnTerminate := True;
  FIdTimetableFuente := AIdTimetableFuente;
  FIdTimetable := AIdTimetable;
  with MasterDataModule.ConfigStorage do
    FTimetableModel := TTimetableModel.Create(
      ClashActivity, BreakTimetableResource, OutOfPositionEmptyHour,
      BrokenSession, NonScatteredActivity);
  inherited Create(CreateSuspended);
end;

destructor TImproveTimetableThread.Destroy;
begin
  FTimetableModel.Free;
  inherited Destroy;
end;

end.

