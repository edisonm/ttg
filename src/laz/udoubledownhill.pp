{ -*- mode: Delphi -*- }
unit UDoubleDownHill;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, USolver, UTTGBasics, UTimeTableModel, Math, UModel;

type

  { TDoubleDownHill }

  TDoubleDownHill = class(TSolver)
  private
    function DoubleDownHill(RefreshInterval: Integer): Integer;
    function MultiDownHill(Individual: TIndividual; Movements: TMovements;
      ABookmark: TBookmark; ExitOnFirstDown: Boolean; Level, MaxLevel,
      RefreshInterval, Threshold: Integer): Integer;
    function MultiDownHill(MaxLevel, RefreshInterval: Integer): Integer;
  protected
  public
    procedure Execute(RefreshInterval: Integer); override;
    procedure SaveSolutionToDatabase(ACodHorario: Integer;
      const AExtraInfo: string; AMomentoInicial, AMomentoFinal: TDateTime); override;
  end;

implementation


type

  { TTTMovements }

  TTTMovements = class(TMovements)
  private
    FParalelos: TDynamicIntegerArray;
  public
    constructor Create(AParaleloCant: Integer);
    property Paralelos: TDynamicIntegerArray read FParalelos;
  end;

{ TTTMovements }

constructor TTTMovements.Create(AParaleloCant: Integer);
begin
  inherited Create;
  SetLength(FParalelos, AParaleloCant);
  Move(RandomIndexes(AParaleloCant)[0], FParalelos[0], AParaleloCant * SizeOf(Integer));
end;

type

  { TTTBookmark }

  TTTBookmark = class(TBookmark)
  private
    FPosition, FOffset, FPeriodo1, FPeriodo2: Integer;
    function GetParalelo: Integer;
  protected
    function GetProgress: Integer; override;
    function GetMax: Integer; override;
  public
    constructor Create(ABookmark: TBookmark); overload;
    procedure First; override;
    procedure Next; override;
    procedure Rewind; override;
    function Move: Integer; override;
    function Eof: Boolean; override;
    property Paralelo: Integer read GetParalelo;
    property Offset: Integer read FOffset write FOffset;
  end;

{ TDoubleDownHill }

function TDoubleDownHill.MultiDownHill(MaxLevel, RefreshInterval: Integer): Integer;
var
  Max: Integer;
  Movements: TTTMovements;
  Individual: TIndividual;
  Bookmark: TTTBookmark;
begin
  with TTimeTableModel(Model) do
  begin
    // Max := ParaleloCant * PeriodoCant * (PeriodoCant - 1) div 2;
    Movements := TTTMovements.Create(ParaleloCant);
    Individual := NewIndividual;
    Bookmark := TTTBookmark.Create(Individual, Movements);
    try
      Individual.Assign(BestIndividual);
      Result := MultiDownHill(Individual, Movements, Bookmark, False, 0, MaxLevel, RefreshInterval, 0);
    finally
      Bookmark.Free;
      Individual.Free;
      Movements.Free;
    end;
  end;
end;

{ TTTMovements }

function TTTBookmark.GetParalelo: Integer;
var
  Index: Integer;
begin
  Index := (FPosition + FOffset) mod TTimeTableModel(Individual.Model).ParaleloCant;
  Result := TTTMovements(Movements).Paralelos[Index];
end;

procedure TTTBookmark.First;
begin
  FPosition := 0;
  FOffset := 0;
  FPeriodo1 := 0;
  with TTimeTableModel(Individual.Model), TTimeTable(Individual) do
  begin
    FPeriodo2 := SesionADuracion[ParaleloPeriodoASesion[Paralelo, FPeriodo1]];
    //FPeriodo2 := FSesionADuracion[ParaleloPeriodoASesion[FParalelo, FPeriodo2]] - 1;
  end;
end;

procedure TTTBookmark.Next;
var
  Sesion: Integer;
  PeriodoASesion: TDynamicIntegerArray;
begin
  with TTimeTableModel(Individual.Model), TTimeTable(Individual) do
  begin
    PeriodoASesion := ParaleloPeriodoASesion[Paralelo];
    if FPeriodo1 > 0 then
    begin
      Dec(FPeriodo1);
      Sesion := PeriodoASesion[FPeriodo1];
      if Sesion < 0 then
        Inc(FPeriodo1)
      else
        repeat
          Inc(FPeriodo1);
        until (FPeriodo1 >= PeriodoCant)
          or (PeriodoASesion[FPeriodo1] <> Sesion);
    end;
    if FPeriodo1 >= PeriodoCant - SesionADuracion[PeriodoASesion[PeriodoCant - 1]] then
    begin
      Inc(FPosition);
      FPeriodo1 := 0;
      FPeriodo2 := SesionADuracion[ParaleloPeriodoASesion[Paralelo, 0]];
    end
    else
    begin
    if (FPeriodo2 <= FPeriodo1) then
      FPeriodo2 := FPeriodo1 + SesionADuracion[PeriodoASesion[FPeriodo1]]
    else
    begin
      Sesion := PeriodoASesion[FPeriodo2];
      if Sesion < 0 then
        Inc(FPeriodo2)
      else
        repeat
          Inc(FPeriodo2);
        until (FPeriodo2 >= PeriodoCant)
          or (PeriodoASesion[FPeriodo2] <> Sesion);
    end;
    if FPeriodo2 = PeriodoCant then
    begin
      Inc(FPeriodo1, SesionADuracion[PeriodoASesion[FPeriodo1]]);
      if FPeriodo1 = PeriodoCant - SesionADuracion[PeriodoASesion[PeriodoCant - 1]] then
      begin
        Inc(FPosition);
        FPeriodo1 := 0;
        FPeriodo2 := SesionADuracion[ParaleloPeriodoASesion[Paralelo, 0]];
      end
      else
        FPeriodo2 := FPeriodo1 + SesionADuracion[PeriodoASesion[FPeriodo1]];
    end;
    end;
  end;
end;

procedure TTTBookmark.Rewind;
begin
  Inc(FOffset, FPosition);
  FPosition := 0;
end;

function TTTBookmark.GetProgress: Integer;
begin
  with TTimeTableModel(Individual.Model) do
    Result := (FOffset + FPosition) * PeriodoCant * (PeriodoCant - 1) div 2 +
    (FPeriodo1 * PeriodoCant - FPeriodo1 * (FPeriodo1 + 1) div 2 + FPeriodo2 - 1);
end;

function TTTBookmark.GetMax: Integer;
begin
  with TTimeTableModel(Individual.Model) do
    Result := (FOffset + ParaleloCant) * PeriodoCant * (PeriodoCant - 1) div 2;
end;

constructor TTTBookmark.Create(ABookmark: TBookmark);
begin
  inherited Create(ABookmark.Individual, ABookmark.Movements);
  FPosition := TTTBookmark(ABookmark).FPosition;
  FOffset := TTTBookmark(ABookmark).FOffset;
end;

function TTTBookmark.Move: Integer;
var
  Duracion1, Duracion2: Integer;
begin
  with TTimeTableModel(Individual.Model), TTimeTable(Individual) do
  begin
    Duracion1 := SesionADuracion[ParaleloPeriodoASesion[Paralelo, FPeriodo1]];
    Duracion2 := SesionADuracion[ParaleloPeriodoASesion[Paralelo, FPeriodo2]];
    Result := InternalSwap(Paralelo, FPeriodo1, FPeriodo2);
    FPeriodo2 := FPeriodo2 + Duracion2 - Duracion1;
  end;
end;

function TTTBookmark.Eof: Boolean;
begin
  Result := FPosition = TTimeTableModel(Individual.Model).ParaleloCant;
end;

function TDoubleDownHill.MultiDownHill(Individual: TIndividual;
    Movements: TMovements; ABookmark: TBookmark; ExitOnFirstDown: Boolean;
    Level, MaxLevel, RefreshInterval, Threshold: Integer): Integer;
var
  Position, MaxProgress, Index, Delta: Integer;
  Stop, Down: Boolean;
  Bookmark: TBookmark;
begin
  with Individual do
  begin
    Result := Value;
    try
      Stop := False;
      Position := 0;
      Bookmark := TTTBookmark.Create(ABookmark);
      try
      Bookmark.First;
      while not Bookmark.Eof do
      begin
        //if Level = MaxLevel - 1 then
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
             or (MultiDownHill(Individual, Movements, Bookmark, True, Level + 1,
                               MaxLevel, RefreshInterval, Threshold - Delta) >= 0) then
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
      end
    finally
      Result := Value - Result;
    end;
  end;
end;

function TDoubleDownHill.DoubleDownHill(RefreshInterval: Integer): Integer;
begin
{  Result := MultiDownHill(0, RefreshInterval)
    + MultiDownHill(1, RefreshInterval) + MultiDownHill(2, RefreshInterval);
}
  Result := MultiDownHill(0, RefreshInterval);
end;

(*
function TDoubleDownHill.DoubleDownHill(RefreshInterval: Integer): Integer;
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

procedure TDoubleDownHill.Execute(RefreshInterval: Integer);
begin
  inherited;
  try
    DoubleDownHill(RefreshInterval);
  finally
    if (SharedDirectory <> '') and FileExists(FileName) then
      DeleteFile(FileName);
  end;
end;

procedure TDoubleDownHill.SaveSolutionToDatabase(ACodHorario: Integer;
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

