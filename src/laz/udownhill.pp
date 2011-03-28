{ -*- mode: Delphi -*- }
unit UDownHill;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, USolver, UModel;

type

  { TDownHill }

  TDownHill = class(TSolver)
  private
    function MultiDownHill(Individual: TIndividual;
      ABookmark: TBookmark; ExitOnFirstDown: Boolean;
      Level, MaxLevel, RefreshInterval, Threshold: Integer): Integer;
  protected
  public
    function DownHill: Integer;
    function DoubleDownHill(RefreshInterval: Integer): Integer;
    function MultiDownHill(MaxLevel, RefreshInterval: Integer): Integer;
    procedure Execute(RefreshInterval: Integer); override;
    procedure SaveSolutionToDatabase(ACodHorario: Integer;
      const AExtraInfo: string; AMomentoInicial, AMomentoFinal: TDateTime); override;
  end;

implementation

{ TDownHill }

function TDownHill.MultiDownHill(MaxLevel, RefreshInterval: Integer): Integer;
var
  Individual: TIndividual;
  Bookmark: TBookmark;
begin
  Individual := Model.NewIndividual;
  Bookmark := Individual.NewBookmark;
  try
    Individual.Assign(BestIndividual);
    Result := MultiDownHill(Individual, Bookmark, False, 0, MaxLevel, RefreshInterval, 0);
  finally
    Bookmark.Free;
    Individual.Free;
  end;
end;

function TDownHill.MultiDownHill(Individual: TIndividual;
    ABookmark: TBookmark; ExitOnFirstDown: Boolean;
    Level, MaxLevel, RefreshInterval, Threshold: Integer): Integer;
var
  Delta: Integer;
  Stop, Down: Boolean;
  Bookmark: TBookmark;
begin
  with Individual do
  begin
    Result := Value;
    try
      Stop := False;
      Bookmark := ABookmark.Clone;
      try
        while not Bookmark.Eof do
        begin
          if Level = MaxLevel - 1 then
            DoProgress(Bookmark.Progress, Bookmark.Max, RefreshInterval, Self, Stop);
          if Stop then
            Exit;
          Delta := Bookmark.Move;
          if Delta < Threshold then
          begin
            if ExitOnFirstDown then
              Exit;
            Threshold := 0;
            Down := True;
          end
          else
          begin
            if (Level = MaxLevel)
                or (MultiDownHill(Individual, Bookmark, True, Level + 1, MaxLevel,
                RefreshInterval, Threshold - Delta) >= 0) then
            begin
              Down := False;
              Bookmark.Undo;
            end
            else
            begin
              if ExitOnFirstDown then
                Exit;
              Threshold := 0;
              Down := True;
            end;
          end;
          Bookmark.Next;
          if Down then
          begin
            Bookmark.Rewind;
            BestIndividual.Assign(Individual);
          end;
        end;
      finally
        Bookmark.Free;
      end;
    finally
      Result := Value - Result;
    end;
  end;
end;

function TDownHill.DownHill: Integer;
begin
  Result := MultiDownHill(0, 0);
end;

function TDownHill.DoubleDownHill(RefreshInterval: Integer): Integer;
begin
  Result := MultiDownHill(1, RefreshInterval);
end;

(*
function TDownHill.DoubleDownHill(RefreshInterval: Integer): Integer;
var
  Paralelo, Periodo1, Periodo2, Sesion, Duracion1, Duracion2, Counter,
    Delta1: Integer;
  Position, Offset, Max: Integer;
  PeriodoASesion: TDynamicIntegerArray;
  Stop, Down: Boolean;
  { Continuar: Boolean; }
  procedure SafeIncPeriodo;
  begin
    with TTimeTable(BestIndividual), TTimeTableModel(Model) do
    begin
      if Periodo1 > 0 then
      begin
        Dec(Periodo1);
        Sesion := PeriodoASesion[Periodo1];
        if Sesion < 0 then
          Inc(Periodo1)
        else
          repeat
            Inc(Periodo1);
          until (Periodo1 >= PeriodoCant)
            or (PeriodoASesion[Periodo1] <> Sesion);
      end;
      Down := True;
      if Periodo2 <= Periodo1 then
        Periodo2 := Periodo1 + SesionADuracion[PeriodoASesion[Periodo1]]
      else
      begin
        Sesion := PeriodoASesion[Periodo2];
        if Sesion < 0 then
          Inc(Periodo1)
        else
          repeat
            Inc(Periodo2);
          until (Periodo2 >= PeriodoCant)
            or (PeriodoASesion[Periodo2] <> Sesion);
      end;
    end;
  end;
var
  Paralelos: TDynamicIntegerArray;
  Index: Integer;
begin
  with TTimeTable(BestIndividual), TTimeTableModel(Model) do
  begin
    Paralelos := RandomIndexes(ParaleloCant);
    Counter := 0;
    Offset := 0;
    Index := 0;
    Position := 0;
    Max := SesionCantidadDoble;
    Result := Value;
    while Counter < ParaleloCant do
    begin
      Index := (Offset + Counter) mod ParaleloCant;
      Paralelo := Paralelos[Index];
      Periodo1 := 0;
      PeriodoASesion := ParaleloPeriodoASesion[Paralelo];
      Down := False;
      while Periodo1 < PeriodoCant do
      begin
        Periodo2 := Periodo1 + SesionADuracion[PeriodoASesion[Periodo1]];
        while Periodo2 < PeriodoCant do
        begin
          Stop := False;
          DoProgress(Position, Max, RefreshInterval, Self, Stop);
          if Stop then
          begin
            Result := Value - Result;
            Exit;
          end;
          Inc(Position);
          if Pollinate then
            SafeIncPeriodo
          else
          begin
          Duracion1 := SesionADuracion[PeriodoASesion[Periodo1]];
          Duracion2 := SesionADuracion[PeriodoASesion[Periodo2]];
          Delta1 := InternalSwap(Paralelo, Periodo1, Periodo2);
          if Delta1 < 0 then
          begin
            Down := True;
            Inc(Periodo2, Duracion2);
          end
          else
          begin
            if (DownHill(Paralelos, Index, True, False, -Delta1) < 0) then
              SafeIncPeriodo
            else
            begin
              InternalSwap(Paralelo, Periodo1, Periodo2 + Duracion2 - Duracion1);
              Inc(Periodo2, Duracion2);
            end;
          end;
          end;
        end;
        Sesion := PeriodoASesion[Periodo1];
        if Sesion < 0 then
          Inc(Periodo1)
        else
          repeat
            Inc(Periodo1);
          until (Periodo1 >= PeriodoCant)
            or (PeriodoASesion[Periodo1] <> Sesion);
      end;
      Inc(Counter);
      if Down then
      begin
        Max := Position + SesionCantidadDoble;
        Offset := (Offset + Counter) mod ParaleloCant;
        Counter := 0;
      end;
    end;
    Result := Value - Result;
  end;
end;
*)

procedure TDownHill.Execute(RefreshInterval: Integer);
begin
  inherited;
  try
    DoubleDownHill(RefreshInterval);
  finally
    if (SharedDirectory <> '') and FileExists(FileName) then
      DeleteFile(FileName);
  end;
end;

procedure TDownHill.SaveSolutionToDatabase(ACodHorario: Integer;
  const AExtraInfo: string; AMomentoInicial, AMomentoFinal: TDateTime);
var
  Report: TStrings;
begin
  Report := TStringList.Create;
  try
    Report.Add('Algoritmo de Descenso Rapido Doble');
    Report.Add('==================================');
    if AExtraInfo <> '' then
      Report.Add(AExtraInfo);
    BestIndividual.ReportValues(Report);
    BestIndividual.SaveToDataModule(ACodHorario, AMomentoInicial, AMomentoFinal, Report);
  finally
    Report.Free;
  end;
end;

end.

