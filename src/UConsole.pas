{ -*- mode: Delphi -*- }
unit UConsole;

{$I ttg.inc}

{
  Headless command line support (`ttg --solve`).

  It drives the same TMakeTimetableThread the GUI uses: the solver runs in
  a worker thread while the main thread pumps TThread.Synchronize (via
  CheckSynchronize), so all database access stays on the main thread,
  exactly as in the threaded GUI build. Note that modern FPC RTL
  TThread.Synchronize only *enqueues* the method; it executes on the next
  CheckSynchronize, which is why the main thread must pump while solving.
}

interface

uses
  Classes, SysUtils, SyncObjs, UProgress, USolver, UMakeTT, UTTGConfig,
  UTTGBasics;

type

  { TConsoleProgressViewer }

  TConsoleProgressViewer = class(TProgressViewer)
  private
    FError: string;
    FLastPrinted: Integer;
  protected
    function GetCloseClick: Boolean; override;
    function GetCancelClick: Boolean; override;
  public
    constructor Create;
    procedure OnProgress(APosition, AMax: Integer; ASolver: TSolver;
      var Stop: Boolean); override;
    property ErrorText: string read FError write FError;
  end;

  { Parsed command line, shared by the GUI ttg.lpr and ttgsolve.lpr }

  TCommandLine = record
    Solving: Boolean;
    ShowHelp: Boolean;
    NoDownHill: Boolean;
    InputFile: string;
    OutputFile: string;
    Seed: string;
    MaxIteration: string;
  end;

procedure ParseCommandLine(out Args: TCommandLine);
procedure PrintUsage;
function SolveFile(const AInputFile, AOutputFile, ASeed, AMaxIteration: string;
  ANoDownHill: Boolean): Integer;

implementation

uses
  DSource, DMaster, ZDataset;

{ TConsoleProgressViewer }

constructor TConsoleProgressViewer.Create;
begin
  inherited Create;
  FLastPrinted := -1;
end;

function TConsoleProgressViewer.GetCloseClick: Boolean;
begin
  Result := False;
end;

function TConsoleProgressViewer.GetCancelClick: Boolean;
begin
  Result := False;
end;

procedure TConsoleProgressViewer.OnProgress(APosition, AMax: Integer;
  ASolver: TSolver; var Stop: Boolean);
begin
  { TSolver.DoProgress already throttles to about one call per second }
  if (APosition <> FLastPrinted) and (AMax > 0) then
  begin
    FLastPrinted := APosition;
    WriteLn(StdOut, Format('iteration %d/%d  best=%d',
      [APosition, AMax, ASolver.BestIndividual.Value]));
  end;
end;

{ TConsoleSolveThread }

type

  { Runs the make-timetable thread and signals the main thread when done,
    keeping the error message in the (longer lived) progress viewer since
    TMakeTimetableThread frees itself on terminate. }

  TConsoleSolveThread = class(TMakeTimetableThread)
  private
    FDone: TEvent;
    FViewer: TConsoleProgressViewer;
  protected
    procedure Execute; override;
  public
    constructor Create(const AValidIds: TDynamicIntegerArray;
      ATTGConfig: TTTGConfig; AProgressViewer: TConsoleProgressViewer;
      ADone: TEvent);
  end;

constructor TConsoleSolveThread.Create(const AValidIds: TDynamicIntegerArray;
  ATTGConfig: TTTGConfig; AProgressViewer: TConsoleProgressViewer;
  ADone: TEvent);
begin
  FDone := ADone;
  FViewer := AProgressViewer;
  inherited Create(AValidIds, ATTGConfig, AProgressViewer, False);
end;

procedure TConsoleSolveThread.Execute;
begin
  try
    inherited Execute;
  except
    on E: Exception do
      FViewer.ErrorText := E.Message;
  end;
  FDone.SetEvent;
end;

{ CLI support }

procedure ParseCommandLine(out Args: TCommandLine);
var
  i: Integer;
  Param: string;
begin
  Args.Solving := False;
  Args.ShowHelp := False;
  Args.NoDownHill := False;
  Args.InputFile := '';
  Args.OutputFile := '';
  Args.Seed := '';
  Args.MaxIteration := '';
  for i := 1 to ParamCount do
  begin
    Param := ParamStr(i);
    if (Param <> '') and (Param[1] = '-') then
    begin
      if (Length(Param) > 1) and (Param[2] = '-') then
        Delete(Param, 1, 2)
      else
        Delete(Param, 1, 1);
      if SameText(Param, 'solve') then
        Args.Solving := True
      else if SameText(Param, 'no-downhill') then
        Args.NoDownHill := True
      else if SameText(Param, 'help') or SameText(Param, '?') then
        Args.ShowHelp := True
      else if SameText(Copy(Param, 1, 5), 'seed=') then
        Args.Seed := Copy(Param, 6, MaxInt)
      else if SameText(Copy(Param, 1, 15), 'max-iterations=') then
        Args.MaxIteration := Copy(Param, 16, MaxInt)
      else
      begin
        WriteLn(StdErr, 'ttg: unknown option: -', Param);
        Args.ShowHelp := True;
      end;
    end
    else if Args.InputFile = '' then
      Args.InputFile := Param
    else
      Args.OutputFile := Param;
  end;
end;

procedure PrintUsage;
begin
  WriteLn('Usage: ttg [options] [<file.ttd>]');
  WriteLn('       ttg --solve [options] <input.ttd> [<output.ttd>]');
  WriteLn;
  WriteLn('  --solve             Solve without GUI; write the result,');
  WriteLn('                      including the new timetable, to <output.ttd>');
  WriteLn('                      (default: <input.ttd>.solved.ttd).');
  WriteLn('  --seed=N            Override Seed from the file config');
  WriteLn('                      (implies UseCustomSeed).');
  WriteLn('  --max-iterations=N  Override MaxIteration from the file config.');
  WriteLn('  --no-downhill       Skip the post-solve down-hill refinement');
  WriteLn('                      (bounds the run time; used by tests).');
  WriteLn('  --help              Show this help.');
  WriteLn;
  WriteLn('Without --solve a single .ttd argument opens the GUI with it.');
  WriteLn('ttgsolve is a display-free build supporting only --solve/--help.');
end;

function SolveFile(const AInputFile, AOutputFile, ASeed,
  AMaxIteration: string; ANoDownHill: Boolean): Integer;
var
  Config: TTTGConfig;
  Viewer: TConsoleProgressViewer;
  Done: TEvent;
  Query: TZQuery;
  ValidIds: TDynamicIntegerArray;
  IdTimetable: Integer;
  i: Integer;
  OutFile, Summary: string;

  function ParseInteger(const AValue, AName: string): Integer;
  begin
    try
      Result := StrToInt(AValue);
    except
      WriteLn(StdErr, 'ttg: invalid number for --', AName, ': ', AValue);
      Result := -1;
    end;
  end;

begin
  Result := 1;
  { Match the GUI runtime: .ttd configs store floats with a comma
    separator. }
  DefaultFormatSettings.DecimalSeparator := ',';
  { Several units (UTTModel...) contain debug WriteLn calls that would
    pollute the solve report: send the default Output to stderr and keep
    StdOut for the CLI's own messages. }
  Output := StdErr;
  if not FileExists(AInputFile) then
  begin
    WriteLn(StdErr, 'ttg: file not found: ', AInputFile);
    Exit;
  end;
  if AOutputFile <> '' then
    OutFile := AOutputFile
  else
    OutFile := AInputFile + '.solved.ttd';
  Viewer := TConsoleProgressViewer.Create;
  Done := TEvent.Create(nil, True, False, '');
  try
    SourceDataModule := TSourceDataModule.Create(nil);
    try
      MasterDataModule := TMasterDataModule.Create(nil);
      try
        SourceDataModule.EmptyTables;
        MasterDataModule.LoadFromTextFile(AInputFile);
        Config := MasterDataModule.ConfigStorage;
        Config.SkipDownHill := ANoDownHill;
        if AMaxIteration <> '' then
        begin
          IdTimetable := ParseInteger(AMaxIteration, 'max-iterations');
          if IdTimetable < 0 then
            Exit;
          Config.MaxIteration := IdTimetable;
        end;
        if ASeed <> '' then
        begin
          IdTimetable := ParseInteger(ASeed, 'seed');
          if IdTimetable < 0 then
            Exit;
          Config.UseCustomSeed := True;
          Config.Seed := IdTimetable;
        end;
        IdTimetable := MasterDataModule.NewIdTimetable;
        SetLength(ValidIds, 1);
        ValidIds[0] := IdTimetable;
        WriteLn(StdOut, Format('Solving %s (timetable id %d)...',
          [ExtractFileName(AInputFile), IdTimetable]));
        TConsoleSolveThread.Create(ValidIds, Config, Viewer, Done);
        { Pump the TThread.Synchronize queue while the solver runs }
        while Done.WaitFor(20) = wrTimeout do
          Classes.CheckSynchronize;
        Classes.CheckSynchronize;
        if Viewer.ErrorText <> '' then
        begin
          WriteLn(StdErr, 'ttg: ', Viewer.ErrorText);
          Exit;
        end;
        { Do not persist the test-only flag into the saved .ttd }
        i := Config.ConfigStrings.IndexOfName('SkipDownHill');
        if i >= 0 then
          Config.ConfigStrings.Delete(i);
        MasterDataModule.SaveToTextFile(OutFile);
        Query := TZQuery.Create(nil);
        try
          Query.Connection := SourceDataModule.DbZConnection;
          Query.SQL.Text := 'SELECT Summary FROM Timetable WHERE IdTimetable=' +
            IntToStr(IdTimetable);
          Query.Open;
          if not Query.IsEmpty then
            Summary := Query.Fields[0].AsString
          else
            Summary := '';
          Query.Close;
        finally
          Query.Free;
        end;
        if Summary <> '' then
          WriteLn(StdOut, Summary);
        WriteLn(StdOut, Format('Timetable %d saved to %s', [IdTimetable, OutFile]));
        Result := 0;
      finally
        MasterDataModule.Free;
      end;
    finally
      SourceDataModule.Free;
    end;
  finally
    Done.Free;
    Viewer.Free;
  end;
end;

end.
