{ -*- mode: Delphi -*- }
{
  Headless build of ttg: solves .ttd files from the command line without
  ever touching a display. It deliberately does NOT use the LCL Interfaces
  unit (the widgetset would initialize GTK at unit-init time and exit when
  no display is available), only the data modules and solver units.
}
program ttgsolve;

{$I ttg.inc}

uses
  {$IFDEF UNIX}
  CThreads,
  CMem,
  {$ENDIF}
  Interfaces, { nogui widgetset: registers a display-free TWidgetSet }
  SysUtils,
  UConsole;

var
  Args: TCommandLine;

begin
  ParseCommandLine(Args);
  if Args.ShowHelp then
  begin
    PrintUsage;
    Halt(0);
  end;
  if not Args.Solving then
  begin
    WriteLn(StdErr, 'ttgsolve: this build only supports --solve');
    PrintUsage;
    Halt(2);
  end;
  if Args.InputFile = '' then
  begin
    WriteLn(StdErr, 'ttgsolve --solve: missing input .ttd file');
    PrintUsage;
    Halt(2);
  end;
  try
    Halt(SolveFile(Args.InputFile, Args.OutputFile, Args.Seed,
      Args.MaxIteration, Args.NoDownHill));
  except
    on E: Exception do
    begin
      WriteLn(StdErr, 'ttg: ', E.Message);
      Halt(1);
    end;
  end;
end.
