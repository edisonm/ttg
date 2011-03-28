{ -*- mode: Delphi -*- }
unit USolver;

{$I ttg.inc}

interface

uses
  {$IFDEF UNIX}cthreads, cmem, {$ENDIF}Classes, SysUtils, UModel;

type

  TSolver = class;

  TProgressEvent = procedure(Position, Max: Integer; Solver: TSolver;
    var Stop: Boolean) of object;

  { TSolver }

  TSolver = class
  private
    FModel: TModel;
    FBestIndividual: TIndividual;
    FOnProgress: TProgressEvent;
    FSharedDirectory: string;
    FPollinationProb: Double;
    FNumImports, FNumExports, FColision: Integer;
    function GetFileName: string;
  protected
    procedure DoProgress(Position, Max, RefreshInterval: Integer; Solver: TSolver;
      var Stop: Boolean);
  public
    constructor Create(AModel: TModel; const ASharedDirectory: string;
      APollinationProb: Double);
    destructor Destroy; override;
    procedure Update; virtual;
    procedure UpdateValue; virtual;
    procedure Execute(RefreshInterval: Integer); virtual;
    procedure SaveSolutionToDatabase(ACodHorario: Integer;
      const AExtraInfo: string; AMomentoInicial, AMomentoFinal: TDateTime); virtual; abstract;
    function Pollinate: Boolean;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
    property BestIndividual: TIndividual read FBestIndividual;
    property SharedDirectory: string read FSharedDirectory write FSharedDirectory;
    property FileName: string read GetFileName;
    property PollinationProb: Double read FPollinationProb write FPollinationProb;
    property NumImports: Integer read FNumImports;
    property NumExports: Integer read FNumExports;
    property NumColision: Integer read FColision;
    property Model: TModel read FModel;
  end;

implementation

{ TSolver }

function TSolver.GetFileName: string;
begin
  Result := FSharedDirectory + 'ttable.dat';
end;

procedure TSolver.DoProgress(Position, Max, RefreshInterval: Integer;
  Solver: TSolver; var Stop: Boolean);
begin
  if (RefreshInterval <> 0)
      and Assigned(FOnProgress)
      and (Position mod RefreshInterval = 0) then
    FOnProgress(Position, Max, Solver, Stop);
end;

constructor TSolver.Create(AModel: TModel; const ASharedDirectory: string;
  APollinationProb: Double);
begin
  inherited Create;
  FModel := AModel;
  FBestIndividual := FModel.NewIndividual;
  FSharedDirectory := ASharedDirectory;
  FPollinationProb := APollinationProb;
end;

destructor TSolver.Destroy;
begin
  FBestIndividual.Free;
  inherited Destroy;
end;

procedure TSolver.Update;
begin
  BestIndividual.Update;
end;

procedure TSolver.UpdateValue;
begin
  BestIndividual.UpdateValue;
end;

procedure TSolver.Execute(RefreshInterval: Integer);
begin
  FNumImports := 0;
  FNumExports := 0;
  FColision := 0;
end;

function TSolver.Pollinate: Boolean;
  procedure Exportar;
  var
    Stream: TStream;
    Value: Integer;
  begin
    Stream := TFileStream.Create(FileName, fmCreate or fmShareExclusive);
    try
      Value := BestIndividual.Value;
      Stream.write(Value, SizeOf(Value));
      BestIndividual.SaveToStream(Stream);
      Inc(FNumExports);
    finally
      Stream.Free;
    end;
  end;
var
  Stream: TStream;
  Value: Integer;
begin
  Result := False;
  if (FSharedDirectory <> '') and (Random < FPollinationProb) then
  try
    if FileExists(FileName) then
    begin
      Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
      try
        Stream.read(Value, SizeOf(Value));
        if Value < BestIndividual.Value then
        begin
          BestIndividual.LoadFromStream(Stream);
          Inc(FNumImports);
          Result := True;
        end;
      finally
        Stream.Free;
      end;
      if Value > BestIndividual.Value then
        Exportar;
    end
    else
    begin
      Exportar;
    end;
  except
    Inc(FColision);
  end;
end;

end.

