{ -*- mode: Delphi -*- }
unit UDownHill;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, USolver, UModel, UTTModel;

type

  { TDownHill }

  TDownHill = class(TSolver)
  private
    class function MultiDownHill(Sender: TSolver; Individual: TIndividual;
      var ABookmarks: TBookmarkArray; ExitOnFirstDown: Boolean;
      Level, RefreshInterval, Threshold: Integer): Integer; overload;
    class function MultiDownHill(Sender: TSolver; Individual: TIndividual;
      MaxLevel, RefreshInterval: Integer): Integer; overload;
  protected
  public
    class function DownHill(Individual: TIndividual): Integer;
    function DoubleDownHill(RefreshInterval: Integer): Integer;
    function MultiDownHill(MaxLevel, RefreshInterval: Integer): Integer; overload;
    procedure Execute(RefreshInterval: Integer); override;
    procedure SaveSolutionToDatabase(ACodHorario: Integer;
      const AExtraInfo: string; AMomentoInicial, AMomentoFinal: TDateTime); override;
  end;

implementation

uses
  UTTGBasics;
{ TDownHill }

class function TDownHill.DownHill(Individual: TIndividual): Integer;
begin
  Result := MultiDownHill(nil, Individual, 1, 0);
end;

function TDownHill.DoubleDownHill(RefreshInterval: Integer): Integer;
{
begin
  Result := MultiDownHill(2, RefreshInterval);
end;
}
var
  Individual: TIndividual;
  Bookmarks: TBookmarkArray;
begin
  Individual := Model.NewIndividual;
  try
    Individual.Assign(BestIndividual);
    SetLength(Bookmarks, 2);
    Bookmarks[0] := TTTBookmark2.Create(Individual,
      RandomIndexes(TTimeTableModel(Model).ParaleloCant));
    Bookmarks[1] := TTTBookmark.Create(Individual,
      RandomIndexes(TTimeTableModel(Model).ParaleloCant));
    try
      Result := MultiDownHill(Self, Individual, Bookmarks, False, 0,
        RefreshInterval, 0);
    finally
      Bookmarks[0].Free;
      Bookmarks[1].Free;
    end;
  finally
    Individual.Free;
  end;
end;

function TDownHill.MultiDownHill(MaxLevel, RefreshInterval: Integer): Integer;
var
  Individual: TIndividual;
begin
  Individual := Model.NewIndividual;
  try
    Individual.Assign(BestIndividual);
    Result := MultiDownHill(Self, Individual, MaxLevel, RefreshInterval);
  finally
    Individual.Free;
  end;
end;

class function TDownHill.MultiDownHill(Sender: TSolver; Individual: TIndividual;
    MaxLevel, RefreshInterval: Integer): Integer;
var
  Bookmarks: TBookmarkArray;
  i: Integer;
begin
  SetLength(Bookmarks, MaxLevel);
  for i := 0 to MaxLevel - 1 do
    Bookmarks[i] := Individual.NewBookmark;
  try
    Result := MultiDownHill(Sender, Individual, Bookmarks, False, 0,
      RefreshInterval, 0);
  finally
    for i := 0 to MaxLevel - 1 do
      Bookmarks[i].Free;
  end;
end;

class function TDownHill.MultiDownHill(Sender: TSolver; Individual: TIndividual;
    var ABookmarks: TBookmarkArray; ExitOnFirstDown: Boolean;
    Level, RefreshInterval, Threshold: Integer): Integer;
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
      Bookmark := ABookmarks[Level];
      Bookmark.First;
      while not Bookmark.Eof do
      begin
        if Assigned(Sender) and (Level = High(ABookmarks) - 1) then
          Sender.DoProgress(Bookmark.Progress, Bookmark.Max, RefreshInterval,
                            Sender, Stop);
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
          if (Level = High(ABookmarks))
             or (MultiDownHill(Sender, Individual, ABookmarks, True, Level + 1,
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
          if Assigned(Sender) then
            Sender.BestIndividual.Assign(Individual);
        end;
      end;
    finally
      Result := Value - Result;
    end;
  end;
end;

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

