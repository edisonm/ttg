unit DMaster;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics, DB,
  Controls, Forms, Dialogs, ZConnection, ZDataset, Variants, TTGCfg;

type

  { TMasterDataModule }

  TMasterDataModule = class(TDataModule)
    TbTmpProfesorCarga: TZTable;
    TbTmpProfesorCargaCodProfesor: TLongintField;
    TbTmpProfesorCargaNomProfesor: TStringField;
    TbTmpProfesorCargaApeProfesor: TStringField;
    TbTmpProfesorCargaCarga: TLongintField;
    QuDistributivoProfesor: TZTable;
    QuDistributivoProfesorCodMateria: TLongintField;
    QuDistributivoProfesorCodNivel: TLongintField;
    QuDistributivoProfesorCodParaleloId: TLongintField;
    QuDistributivoProfesorNomMateria: TStringField;
    QuDistributivoProfesorAbrNivel: TStringField;
    QuDistributivoProfesorNomParaleloId: TStringField;
    QuDistributivoProfesorCodProfesor: TLongintField;
    QuDistributivoProfesorApeNomProfesor: TStringField;
    QuDistributivoProfesorCodEspecializacion: TLongintField;
    QuDistributivoProfesorAbrEspecializacion: TStringField;
    QuProfesorProhibicionCant: TZTable;
    QuProfesorProhibicionCantCodProfesor: TLongintField;
    QuProfesorProhibicionCantCantidad: TLongintField;
    TbTmpAulaTipoCarga: TZTable;
    TbTmpAulaTipoCargaCodAulaTipo: TLongintField;
    TbTmpAulaTipoCargaAbrAulaTipo: TStringField;
    TbTmpAulaTipoCargaCarga: TLongintField;
    QuNewCodHorario: TZReadOnlyQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FStringsShowAulaTipo: TStrings;
    FStringsShowProfesor: TStrings;
    FStringsShowParalelo: TStrings;
    FConfigStorage: TTTGConfig;
    procedure FillProfesorProhibicionCant;
    procedure LoadIniStrings(AStrings: TStrings; var APosition: Integer);
  public
    { Public declarations }
    procedure IntercambiarPeriodos(ACodHorario, ACodNivel, ACodEspecializacion,
      ACodParaleloId, ACodDia1, ACodHora1, ACodDia2, ACodHora2: Integer);
    function PerformAllChecks(AMainStrings, ASubStrings: TStrings;
      AMaxCargaProfesor: Integer): Boolean;
    function NewCodHorario: Integer;
    procedure SaveToStrings(AStrings: TStrings);
    procedure SaveIniStrings(AStrings: TStrings);
    procedure SaveToTextDir(const ADirName: TFileName);
    procedure LoadFromStrings(AStrings: TStrings; var APosition: Integer);
    procedure LoadFromTextFile(const AFileName: TFileName);
    procedure SaveToTextFile(const AFileName: TFileName);
    property StringsShowAulaTipo: TStrings read FStringsShowAulaTipo;
    property StringsShowProfesor: TStrings read FStringsShowProfesor;
    property StringsShowParalelo: TStrings read FStringsShowParalelo;
    property ConfigStorage: TTTGConfig read FConfigStorage;
    procedure NewDatabase;
  end;

var
  MasterDataModule: TMasterDataModule;

implementation

uses
  HorColCm, DSource;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

const
  pfhVersionNumber = 292;

procedure TMasterDataModule.FillProfesorProhibicionCant;
var
  CodProfesor, CodProfesor1: Integer;
  s: string;
begin
  with SourceDataModule, QuProfesorProhibicionCant do
  begin
    Close;
    Open;
    s := TbProfesorProhibicion.IndexFieldNames;
    TbProfesorProhibicion.IndexFieldNames := 'CodProfesor';
    TbProfesorProhibicion.First;
    CodProfesor := -$7FFFFFFF;
    while not TbProfesorProhibicion.Eof do
    begin
      CodProfesor1 := TbProfesorProhibicion.FindField('CodProfesor').AsInteger;
      if CodProfesor <> CodProfesor1 then
      begin
        Append;
        with QuProfesorProhibicionCantCantidad do
          Value := 1;
        CodProfesor := CodProfesor1;
      end
      else
      begin
        Edit;
        with QuProfesorProhibicionCantCantidad do
          Value := Value + 1;
      end;
      Post;
      TbProfesorProhibicion.Next;
    end;
    TbProfesorProhibicion.IndexFieldNames := s;
  end;
end;

function TMasterDataModule.PerformAllChecks(AMainStrings, ASubStrings:
  TStrings; AMaxCargaProfesor: Integer): Boolean;
var
  HuboProblemas: Boolean;
  iPeriodoCant: Integer;
  procedure ObtenerPeriodoCant;
  begin
    iPeriodoCant := SourceDataModule.TbPeriodo.RecordCount;
  end;
  procedure ObtenerProfesorCarga;
  var
    CodProfesor, CodProfesor1: Integer;
    s: string;
  begin
    with SourceDataModule, TbDistributivo do
    begin
      s := IndexFieldNames;
      IndexFieldNames := 'CodProfesor';
      First;
      TbTmpProfesorCarga.Open;
      CodProfesor := -$7FFFFFFF;
      while not Eof do
      begin
        CodProfesor1 := TbDistributivo.FindField('CodProfesor').AsInteger;
        if CodProfesor <> CodProfesor1 then
        begin
          TbTmpProfesorCarga.Append;
          TbTmpProfesorCargaCodProfesor.Value :=
            TbDistributivo.FindField('CodProfesor').AsInteger;
          TbTmpProfesorCargaCarga.Value := ComposicionADuracion(TbDistributivo.FindField('Composicion').AsString);
          CodProfesor := CodProfesor1;
        end
        else
        begin
          TbTmpProfesorCarga.Edit;
          with TbTmpProfesorCargaCarga do
            Value := Value + ComposicionADuracion(TbDistributivo.FindField('Composicion').AsString);
        end;
        TbTmpProfesorCarga.Post;
        Next;
      end;
      IndexFieldNames := s;
    end;
  end;
  procedure ObtenerAulaTipoCarga;
  var
    CodAulaTipo, CodAulaTipo1: Integer;
    s: string;  
  begin
    with SourceDataModule, TbDistributivo do
    begin
      TbTmpAulaTipoCarga.Open;
      s := IndexFieldNames;
      IndexFieldNames := 'CodAulaTipo';
      First;
      CodAulaTipo := -$7FFFFFFF;
      while not Eof do
      begin
        CodAulaTipo1 := TbDistributivo.FindField('CodAulaTipo').AsInteger;
        if CodAulaTipo <> CodAulaTipo1 then
        begin
          TbTmpAulaTipoCarga.Append;
          TbTmpAulaTipoCargaCodAulaTipo.Value := TbDistributivo.FindField('CodAulaTipo').AsInteger;
          TbTmpAulaTipoCargaCarga.Value := ComposicionADuracion(TbDistributivo.FindField('Composicion').AsString);
          CodAulaTipo := CodAulaTipo1;
        end
        else
        begin
          TbTmpAulaTipoCarga.Edit;
          with TbTmpAulaTipoCargaCarga do
            Value := Value + ComposicionADuracion(TbDistributivo.FindField('Composicion').AsString);
        end;
        TbTmpAulaTipoCarga.Post;
        Next;
      end;
      IndexFieldNames := s;
    end;
  end;
  // Comprueba que no hayan asignadas mas horas de materias a profesores de las
  // permitidas
  procedure CheckProfesorProhibicionCant;
  var
    s: string;
    HuboProblemasInterno: Boolean;
    vMainMin, vMainMax, vSubMin, vSubMax: Integer;
  begin
    HuboProblemasInterno := False;
    s := '%s %s; %d';
    with QuProfesorProhibicionCant do
    begin
      FillProfesorProhibicionCant;
      if not IsEmpty then
      begin
        try
          ASubStrings.Add('Numero de prohibiciones de profesores sin problemas...');
          vSubMin := ASubStrings.Count;
          ASubStrings.Add('Profesor; Prohibiciones');
          while not Eof do
          begin
            if TbTmpProfesorCarga.Locate('CodProfesor',
              QuProfesorProhibicionCantCodProfesor.AsInteger, []) then
            begin
              if QuProfesorProhibicionCantCantidad.AsInteger +
                TbTmpProfesorCargaCarga.AsInteger > iPeriodoCant then
              begin
                if not HuboProblemasInterno then
                begin
                  AMainStrings.Add('Numero de prohibiciones de Profesores con problemas...');
                  vMainMin := AMainStrings.Count;
                  AMainStrings.Add('Profesor; Prohibiciones');
                end;
                AMainStrings.Add(Format(s, [TbTmpProfesorCargaApeProfesor.Value,
                  TbTmpProfesorCargaNomProfesor.Value,
                    QuProfesorProhibicionCantCantidad.AsInteger]));
                HuboProblemasInterno := True;
                HuboProblemas := True;
              end
              else
                ASubStrings.Add(Format(s, [TbTmpProfesorCargaApeProfesor.Value,
                  TbTmpProfesorCargaNomProfesor.Value,
                    QuProfesorProhibicionCantCantidad.AsInteger]));
            end;
            Next;
          end;
        finally
          Close;
        end;
        if HuboProblemasInterno then
        begin
          vMainMax := AMainStrings.Count - 1;
          EqualSpaced(AMainStrings, vMainMin, vMainMax, ';');
          AMainStrings.Add('');
        end;
        vSubMax := ASubStrings.Count - 1;
        EqualSpaced(ASubStrings, vSubMin, vSubMax, ';');
        ASubStrings.Add('');
      end;
    end;
  end;
  procedure CheckProfesorCarga;
  var
    s: string;
    vMainMin, vMainMax, vSubMin, vSubMax: Integer;
    HuboProblemasInterno: Boolean;
  begin
    with TbTmpProfesorCarga do
      if not IsEmpty then
      begin
        HuboProblemasInterno := False;
        First;
        s := '%s %s; %d';
        ASubStrings.Add('Carga horaria de los Profesores sin problemas...');
        vSubMin := ASubStrings.Count;
        ASubStrings.Add('Profesor; Carga');
        while not Eof do
        begin
          if TbTmpProfesorCargaCarga.Value > AMaxCargaProfesor then
          begin
            if not HuboProblemasInterno then
            begin
              AMainStrings.Add('Carga horaria de los Profesores con problemas...');
              vMainMin := AMainStrings.Count;
              AMainStrings.Add('Profesor; Carga');
            end;
            AMainStrings.Add(Format(s, [TbTmpProfesorCargaApeProfesor.Value,
              TbTmpProfesorCargaNomProfesor.Value,
                TbTmpProfesorCargaCarga.Value]));
            HuboProblemas := True;
            HuboProblemasInterno := True;
          end
          else
          begin
            ASubStrings.Add(Format(s, [TbTmpProfesorCargaApeProfesor.Value,
              TbTmpProfesorCargaNomProfesor.Value,
                TbTmpProfesorCargaCarga.Value]));
          end;
          Next;
        end;
        if HuboProblemas then
        begin
          vMainMax := AMainStrings.Count - 1;
          EqualSpaced(AMainStrings, vMainMin, vMainMax, ';');
          AMainStrings.Add('');
        end;
        vSubMax := ASubStrings.Count - 1;
        EqualSpaced(ASubStrings, vSubMin, vSubMax, ';');
        ASubStrings.Add('');
      end;
  end;

  // Chequea que existan las aulas suficientes para una materia dada
  procedure CheckAulaTipoCarga;
  var
    c: Integer;
    vMainMin, vMainMax, vSubMin, vSubMax: Integer;
    s: string;
    bAulaTipoActive, HuboProblemasInterno: Boolean;
  begin
    with SourceDataModule, TbTmpAulaTipoCarga do
      if not IsEmpty then
      begin
        HuboProblemasInterno := False;
        bAulaTipoActive := TbAulaTipo.Active;
        try
          TbAulaTipo.First;
          First;
          s := '%s; %d; %d';
          ASubStrings.Add('Tipos de aulas sin problemas...');
          vSubMin := ASubStrings.Count;
          ASubStrings.Add('AulaTipo; Horas disponibles; Carga');
          while not Eof do
          begin
            if TbAulaTipo.Locate('CodAulaTipo', TbTmpAulaTipoCargaCodAulaTipo.AsInteger, []) then
            begin
              c := iPeriodoCant * TbAulaTipo.FindField('Cantidad').AsInteger;
              if TbTmpAulaTipoCargaCarga.Value > c then
              begin
                if not HuboProblemasInterno then
                begin
                  AMainStrings.Add('Tipos de aulas con problemas...');
                  vMainMin := AMainStrings.Count;
                  AMainStrings.Add('AulaTipo; Horas disponibles; Carga');
                end;
                AMainStrings.Add(Format(s, [TbTmpAulaTipoCargaAbrAulaTipo.Value,
                  c, TbTmpAulaTipoCargaCarga.Value]));
                HuboProblemas := True;
                HuboProblemasInterno := True;
              end
              else
              begin
                ASubStrings.Add(Format(s, [TbTmpAulaTipoCargaAbrAulaTipo.Value,
                  c, TbTmpAulaTipoCargaCarga.Value]));
              end;
            end;
            Next;
          end;
        finally
          TbAulaTipo.Active := bAulaTipoActive;
        end;
        if HuboProblemas then
        begin
          vMainMax := AMainStrings.Count - 1;
          EqualSpaced(AMainStrings, vMainMin, vMainMax, ';');
          AMainStrings.Add('');
        end;
        vSubMax := ASubStrings.Count - 1;
        EqualSpaced(ASubStrings, vSubMin, vSubMax, ';');
        ASubStrings.Add('');
      end;
  end;
  // Comprueba que no hayan asignadas mas horas de materias a Cursos que periodos
  procedure CheckCursoCarga;
  var
    t, vMainMin, vMainMax, vSubMin, vSubMax: Integer;
    s: string;
    HuboProblemasInterno: Boolean;
  begin
    with SourceDataModule, TbParalelo do
    begin
      s := '%s %s %s; %d';
      HuboProblemasInterno := False;
      try
        Open;
        TbDistributivo.First;
        TbPeriodo.First;
        First;
        ASubStrings.Add('Carga Horaria de paralelos sin problemas...');
        vSubMin := ASubStrings.Count;
        ASubStrings.Add('Paralelo; Carga');
        while not Eof do
        begin
          TbDistributivo.Filter :=
            Format('CodNivel=%d and CodEspecializacion=%d and CodParaleloId=%d', [
            TbParalelo.FindField('CodNivel').AsInteger,
              TbParalelo.FindField('CodEspecializacion').AsInteger,
              TbParalelo.FindField('CodParaleloId').AsInteger]);
          TbDistributivo.Filtered := true;
          TbDistributivo.First;
          t := 0;
          try
            while not TbDistributivo.Eof do
            begin
              Inc(t, ComposicionADuracion(TbDistributivo.FindField('Composicion').AsString));
              TbDistributivo.Next;
            end;
            if (t <= 0) or (t > TbPeriodo.RecordCount) then
            begin
              if not HuboProblemasInterno then
              begin
                AMainStrings.Add('Carga Horaria de paralelos con problemas...');
                vMainMin := AMainStrings.Count;
                AMainStrings.Add('Paralelo; Carga');
              end;
              AMainStrings.Add(Format(s, [TbParalelo.FindField('AbrNivel').Value,
                TbParalelo.FindField('AbrEspecializacion').Value,
                TbParalelo.FindField('NomParaleloId').Value, t]));
              HuboProblemas := True;
              HuboProblemasInterno := True;
            end
            else
              ASubStrings.Add(Format(s, [TbParalelo.FindField('AbrNivel').Value,
                TbParalelo.FindField('AbrEspecializacion').Value,
                TbParalelo.FindField('NomParaleloId').Value, t]));
          except
            ASubStrings.Add(Format('Problemas: %s %s %s, Materia %s',
              [TbParalelo.FindField('AbrNivel').AsString, TbParalelo.FindField('AbrEspecializacion').AsString,
              TbParalelo.FindField('NomParaleloId').AsString, TbDistributivo.FindField('NomMateria').AsString]));
            HuboProblemas := True;
          end;
          Next;
        end;
        if HuboProblemasInterno then
        begin
          vMainMax := AMainStrings.Count - 1;
          EqualSpaced(AMainStrings, vMainMin, vMainMax, ';');
          AMainStrings.Add('');
        end;
        vSubMax := ASubStrings.Count - 1;
        EqualSpaced(ASubStrings, vSubMin, vSubMax, ';');
        ASubStrings.Add('');
      finally
        TbDistributivo.Filter := '';
        TbDistributivo.Filtered := false;
        First;
        TbDistributivo.First;
      end;
    end;
  end;
begin
  AMainStrings.Clear;
  ASubStrings.Clear;
  AMainStrings.BeginUpdate;
  ASubStrings.BeginUpdate;
  HuboProblemas := False;
  try
    ObtenerPeriodoCant;
    ObtenerProfesorCarga;
    ObtenerAulaTipoCarga;
    CheckProfesorCarga;
    CheckProfesorProhibicionCant;
    CheckAulaTipoCarga;
    CheckCursoCarga;
  finally
    AMainStrings.EndUpdate;
    ASubStrings.EndUpdate;
    TbTmpProfesorCarga.Close;
    TbTmpAulaTipoCarga.Close;
    Result := HuboProblemas;
  end;
end;

function TMasterDataModule.NewCodHorario: Integer;
begin
  with QuNewCodHorario do
  begin
    Open;
    try
      if Eof and Bof then
        Result := 1
      else
        Result := QuNewCodHorario.Fields[0].AsInteger;
    finally
      Close;
    end;
  end;
end;

procedure TMasterDataModule.SaveToStrings(AStrings: TStrings);
begin
  AStrings.Add('TTD ' + IntToStr(pfhVersionNumber));
  SourceDataModule.SaveToStrings(AStrings);
  SaveIniStrings(AStrings);
end;

procedure TMasterDataModule.SaveIniStrings(AStrings: TStrings);
begin
  AStrings.Add(IntToStr(FConfigStorage.ConfigStrings.Count));
  AStrings.AddStrings(FConfigStorage.ConfigStrings);
end;

procedure TMasterDataModule.SaveToTextDir(const ADirName: TFileName);
begin
  SourceDataModule.SaveToTextDir(ADirName);
  FConfigStorage.ConfigStrings.SaveToFile(ADirName + '/config.ini');
end;

procedure TMasterDataModule.LoadIniStrings(AStrings: TStrings; var APosition: Integer);
var
  Count, Limit: Integer;
begin
  Count := StrToInt(AStrings.Strings[APosition]);
  Inc(APosition);
  Limit := APosition + Count;
  FConfigStorage.ConfigStrings.Clear;
  FConfigStorage.ConfigStrings.Capacity := Count;
  while APosition < Limit do
  begin
    FConfigStorage.ConfigStrings.Add(AStrings[APosition]);
    Inc(APosition);
  end;
end;

procedure TMasterDataModule.LoadFromStrings(AStrings: TStrings; var APosition: Integer);
begin
  // version stored in AStrings.Strings[APosition];
  Inc(APosition);
  SourceDataModule.LoadFromStrings(AStrings, APosition);
  LoadIniStrings(AStrings, APosition);
end;

procedure TMasterDataModule.IntercambiarPeriodos(ACodHorario, ACodNivel,
  ACodEspecializacion, ACodParaleloId, ACodDia1, ACodHora1, ACodDia2,
  ACodHora2: Integer);
var
  Locate1, Locate2: Boolean;
  Bookmark1, Bookmark2: TBookmark;
  iCodMateria1, iSesion1, iCodMateria2, iSesion2: Integer;
begin
  with SourceDataModule do
  begin
    Locate1 := TbHorarioDetalle.Locate(
      'CodHorario;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora',
      VarArrayOf([ACodHorario, ACodNivel, ACodEspecializacion, ACodParaleloId,
      ACodDia1, ACodHora1]), []);
    Bookmark1 := TbHorarioDetalle.GetBookmark;
    try
      Locate2 := TbHorarioDetalle.Locate(
        'CodHorario;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora',
        VarArrayOf([ACodHorario, ACodNivel, ACodEspecializacion, ACodParaleloId,
        ACodDia2, ACodHora2]), []);
      Bookmark2 := TbHorarioDetalle.GetBookmark;
      try
        if Locate1 and Locate2 then
        begin
          TbHorarioDetalle.GotoBookmark(Bookmark1);
          iCodMateria1 := TbHorarioDetalle.FindField('CodMateria').AsInteger;
          iSesion1 := TbHorarioDetalle.FindField('Sesion').Value;
          TbHorarioDetalle.GotoBookmark(Bookmark2);
          iCodMateria2 := TbHorarioDetalle.FindField('CodMateria').AsInteger;
          iSesion2 := TbHorarioDetalle.FindField('Sesion').Value;
          TbHorarioDetalle.Edit;
          TbHorarioDetalle.FindField('CodMateria').AsInteger := iCodMateria1;
          TbHorarioDetalle.FindField('Sesion').AsInteger := iSesion1;
          TbHorarioDetalle.Post;
          TbHorarioDetalle.GotoBookmark(Bookmark1);
          TbHorarioDetalle.Edit;
          TbHorarioDetalle.FindField('CodMateria').AsInteger := iCodMateria2;
          TbHorarioDetalle.FindField('Sesion').AsInteger := iSesion2;
          TbHorarioDetalle.Post;
        end
        else if Locate1 then
        begin
          TbHorarioDetalle.GotoBookmark(Bookmark1);
          TbHorarioDetalle.Edit;
          TbHorarioDetalle.FindField('CodDia').AsInteger := ACodDia2;
          TbHorarioDetalle.FindField('CodHora').AsInteger := ACodHora2;
          TbHorarioDetalle.Post;
        end
        else if Locate2 then
        begin
          TbHorarioDetalle.GotoBookmark(Bookmark2);
          TbHorarioDetalle.Edit;
          TbHorarioDetalle.FindField('CodDia').AsInteger := ACodDia1;
          TbHorarioDetalle.FindField('CodHora').AsInteger := ACodHora1;
          TbHorarioDetalle.Post;
        end;
      finally
        TbHorarioDetalle.FreeBookmark(Bookmark2);
      end;
    finally
      TbHorarioDetalle.FreeBookmark(Bookmark1);
    end;
  end;
end;

procedure TMasterDataModule.DataModuleCreate(Sender: TObject);
var
  Strings: TStrings;
begin
  FStringsShowAulaTipo := TStringList.Create;
  FStringsShowProfesor := TStringList.Create;
  FStringsShowParalelo := TStringList.Create;
  FConfigStorage := TTTGConfig.Create(Self);
  with FStringsShowAulaTipo do
  begin
    add('Nivel_Paralelo=AbrNivel;NomParaleloId');
    add('Nivel_Paralelo_Materia=AbrNivel;NomParaleloId;NomMateria');
    add('Nivel_Paralelo_Especializacion=AbrNivel;NomParaleloId;AbrEspecializacion');
    add('Nivel_Paralelo_Especializacion_Materia=AbrNivel;NomParaleloId;AbrEspecializacion;NomMateria');
    add('Nivel_Especializacion_Paralelo=AbrNivel;AbrEspecializacion;NomParaleloId');
    add('Nivel_Especializacion_Paralelo_Materia=AbrNivel;AbrEspecializacion;NomParaleloId;NomMateria');
    add('Materia=NomMateria');
  end;
  with FStringsShowProfesor do
  begin
    add('Nivel_Paralelo=AbrNivel;NomParaleloId');
    add('Nivel_Paralelo_Materia=AbrNivel;NomParaleloId;NomMateria');
    add('Nivel_Paralelo_Especializacion=AbrNivel;NomParaleloId;AbrEspecializacion');
    add('Nivel_Paralelo_Especializacion_Materia=AbrNivel;NomParaleloId;AbrEspecializacion;NomMateria');
    add('Nivel_Especializacion_Paralelo=AbrNivel;AbrEspecializacion;NomParaleloId');
    add('Nivel_Especializacion_Paralelo_Materia=AbrNivel;AbrEspecializacion;NomParaleloId;NomMateria');
    add('Materia=NomMateria');
  end;
  with FStringsShowParalelo do
  begin
    add('Materia=NomMateria');
    add('Profesor=ApeProfesor;NomProfesor');
    add('Materia_Profesor=NomMateria;ApeProfesor;NomProfesor');
  end;
  with SourceDataModule do
  begin
    Database.Connect;
    Strings := TStringList.Create;
    if Database.Database = ':memory:' then
    try
      Strings.LoadFromFile('../dat/ttg.sql');
      Database.ExecuteDirect('pragma journal_mode=off');
      Database.ExecuteDirect(Strings.GetText);
      PrepareTables;
      OpenTables;
      NewDatabase;
    finally
      Strings.Free;
    end
    else
    begin
      Database.ExecuteDirect('pragma journal_mode=off');
      PrepareTables;
      OpenTables;
    end;
    TbDistributivo.BeforePost := TbDistributivoBeforePost;
  end;
end;

procedure TMasterDataModule.DataModuleDestroy(Sender: TObject);
begin
  FStringsShowAulaTipo.Free;
  FStringsShowProfesor.Free;
  FStringsShowParalelo.Free;
end;

procedure TMasterDataModule.NewDatabase;
begin
  SourceDataModule.EmptyTables;
  ConfigStorage.ConfigStrings.Clear;
  SourceDataModule.FillDefaultData;
end;

procedure TMasterDataModule.LoadFromTextFile(const AFileName: TFileName);
var
  AStrings: TStrings;
  APosition: Integer;
begin
  AStrings := TStringList.Create;
  try
    AStrings.LoadFromFile(AFileName);
    APosition := 0;
    LoadFromStrings(AStrings, APosition);
  finally
    AStrings.Free;
  end;
end;

procedure TMasterDataModule.SaveToTextFile(const AFileName: TFileName);
var
  AStrings: TStrings;
begin
  AStrings := TStringList.Create;
  try
    SaveToStrings(AStrings);
    AStrings.SaveToFile(AFileName);
  finally
    AStrings.Free;
  end;
end;

initialization
{$IFDEF FPC}
  {$i DMaster.lrs}
{$ENDIF}

end.

