unit UDoubleDownHill;
{$I ttg.inc}

interface

uses
  Classes, SysUtils, USolver, UTTGBasics, KerModel;

type

  { TDoubleDownHill }

  TDoubleDownHill = class(TSolver)
  private
    function DoubleDownHill(RefreshInterval: Integer): Double;
  protected
  public
    procedure Execute(RefreshInterval: Integer); override;
    procedure SaveSolutionToDatabase(ACodHorario: Integer;
      const AExtraInfo: string; AMomentoInicial, AMomentoFinal: TDateTime); override;
  end;

implementation

{ TDoubleDownHill }

function TDoubleDownHill.DoubleDownHill(RefreshInterval: Integer): Double;
var
  Paralelo, Periodo1, Periodo2, Sesion, Duracion1, Duracion2, Counter,
    Delta1, Delta2, Value1{$IFDEF DEBUG}, Value2{$ENDIF}: Integer;
  Position, Offset, Max: Integer;
  RandomOrders: array [0 .. 4095] of Integer;
  RandomValues: array [0 .. 4095] of Integer;
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
begin
  with TTimeTable(BestIndividual), TTimeTableModel(Model) do
  begin
    Update;
    for Counter := 0 to ParaleloCant - 1 do
    begin
      RandomOrders[Counter] := Counter;
      RandomValues[Counter] := Random($7FFFFFFF);
    end;
    SortInteger(RandomValues, RandomOrders, 0, ParaleloCant - 1);
    Counter := 0;
    Offset := 0;
    Position := 0;
    Max := SesionCantidadDoble;
    Result := Value;
    while Counter < ParaleloCant do
    begin
      { Continuar := True; }
      Paralelo := RandomOrders[(Offset + Counter) mod ParaleloCant];
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
            if (DownHill(True, False, -Delta1) < 0) then
              SafeIncPeriodo
            else
            begin
              InternalSwap(Paralelo, Periodo1, Periodo2 + Duracion2 - Duracion1);
              Inc(Periodo2, Duracion2);
            end;
          end;
          end;
        end;
        Value1 := Value;
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

