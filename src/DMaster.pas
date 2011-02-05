unit DMaster;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, kbmMemTable, TTGUtls, Variants;

type
  TMasterDataModule = class(TDataModule)
    TbTmpProfesorCarga: TkbmMemTable;
    TbTmpProfesorCargaCodProfesor: TIntegerField;
    TbTmpProfesorCargaNomProfesor: TStringField;
    TbTmpProfesorCargaApeProfesor: TStringField;
    TbTmpProfesorCargaCarga: TIntegerField;
    QuDistributivoProfesor: TkbmMemTable;
    QuDistributivoProfesorCodMateria: TIntegerField;
    QuDistributivoProfesorCodNivel: TIntegerField;
    QuDistributivoProfesorCodParaleloId: TIntegerField;
    QuDistributivoProfesorNomMateria: TStringField;
    QuDistributivoProfesorAbrNivel: TStringField;
    QuDistributivoProfesorNomParaleloId: TStringField;
    QuDistributivoProfesorCodProfesor: TIntegerField;
    QuDistributivoProfesorApeNomProfesor: TStringField;
    QuDistributivoProfesorCodEspecializacion: TIntegerField;
    QuDistributivoProfesorAbrEspecializacion: TStringField;
    QuProfesorProhibicionCant: TkbmMemTable;
    QuProfesorProhibicionCantCodProfesor: TIntegerField;
    QuProfesorProhibicionCantCantidad: TIntegerField;
    TbTmpAulaTipoCarga: TkbmMemTable;
    TbTmpAulaTipoCargaCodAulaTipo: TIntegerField;
    TbTmpAulaTipoCargaAbrAulaTipo: TStringField;
    TbTmpAulaTipoCargaCarga: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FStringsShowAulaTipo: TStrings;
    FStringsShowProfesor: TStrings;
    FStringsShowParalelo: TStrings;
    procedure FillProfesorProhibicionCant;
  public
    { Public declarations }
    procedure IntercambiarPeriodos(ACodHorario, ACodNivel, ACodEspecializacion,
      ACodParaleloId, ACodDia1, ACodHora1, ACodDia2, ACodHora2: Integer);
    function GetCargaActual: Integer;
    function PerformAllChecks(AMainStrings, ASubStrings: TStrings;
      AMaxCargaProfesor: Integer): Boolean;
    property StringsShowAulaTipo: TStrings read FStringsShowAulaTipo;
    property StringsShowProfesor: TStrings read FStringsShowProfesor;
    property StringsShowParalelo: TStrings read FStringsShowParalelo;
  end;

var
  MasterDataModule: TMasterDataModule;

implementation

uses
  HorColCm, DSource, BaseUtls;
{$R *.DFM}

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
      CodProfesor1 := TbProfesorProhibicionCodProfesor.Value;
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
        CodProfesor1 := TbDistributivoCodProfesor.Value;
        if CodProfesor <> CodProfesor1 then
        begin
          TbTmpProfesorCarga.Append;
          TbTmpProfesorCargaCodProfesor.Value :=
            TbDistributivoCodProfesor.Value;
          TbTmpProfesorCargaCarga.Value := ComposicionADuracion(TbDistributivoComposicion.AsString);
          CodProfesor := CodProfesor1;
        end
        else
        begin
          TbTmpProfesorCarga.Edit;
          with TbTmpProfesorCargaCarga do
            Value := Value + ComposicionADuracion(TbDistributivoComposicion.AsString);
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
        CodAulaTipo1 := TbDistributivoCodAulaTipo.Value;
        if CodAulaTipo <> CodAulaTipo1 then
        begin
          TbTmpAulaTipoCarga.Append;
          TbTmpAulaTipoCargaCodAulaTipo.Value := TbDistributivoCodAulaTipo.Value;
          TbTmpAulaTipoCargaCarga.Value := ComposicionADuracion(TbDistributivoComposicion.AsString);
          CodAulaTipo := CodAulaTipo1;
        end
        else
        begin
          TbTmpAulaTipoCarga.Edit;
          with TbTmpAulaTipoCargaCarga do
            Value := Value + ComposicionADuracion(TbDistributivoComposicion.AsString);
        end;
        TbTmpAulaTipoCarga.Post;
        Next;
      end;
      IndexFieldNames := s;
    end;
  end;
  // Chequea que no hayan asignadas más horas de materias a profesores de las
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
          ASubStrings.Add('Número de prohibiciones de profesores sin problemas...');
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
                  AMainStrings.Add('Número de prohibiciones de Profesores con problemas...');
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
              c := iPeriodoCant * TbAulaTipoCantidad.AsInteger;
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
  // Chequea que no hayan asignadas más horas de materias a Cursos que períodos
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
            TbParaleloCodNivel.Value,
              TbParaleloCodEspecializacion.Value,
              TbParaleloCodParaleloId.Value]);
          TbDistributivo.Filtered := true;
          TbDistributivo.First;
          t := 0;
          try
            while not TbDistributivo.Eof do
            begin
              Inc(t, ComposicionADuracion(TbDistributivoComposicion.AsString));
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
              AMainStrings.Add(Format(s, [TbParaleloAbrNivel.Value,
                TbParaleloAbrEspecializacion.Value,
                TbParaleloNomParaleloId.Value, t]));
              HuboProblemas := True;
              HuboProblemasInterno := True;
            end
            else
              ASubStrings.Add(Format(s, [TbParaleloAbrNivel.Value,
                TbParaleloAbrEspecializacion.Value,
                TbParaleloNomParaleloId.Value, t]));
          except
            ASubStrings.Add(Format('Problemas: %s %s %s, Materia %s',
              [TbParaleloAbrNivel.AsString, TbParaleloAbrEspecializacion.AsString,
              TbParaleloNomParaleloId.AsString, TbDistributivoNomMateria.AsString]));
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

function TMasterDataModule.GetCargaActual: Integer;
var
  VBookmark: TBookmark;
  c: Integer;
begin
  with SourceDataModule, TbDistributivo do
  begin
    VBookmark := GetBookmark;
    DisableControls;
    try
      First;
      c := 0;
      while not Eof do
      begin
        Inc(c, ComposicionADuracion(TbDistributivoComposicion.AsString));
        Next;
      end;
      Result := c;
    finally
      EnableControls;
      GotoBookmark(VBookmark);
    end;
  end;
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
          iCodMateria1 := TbHorarioDetalleCodMateria.Value;
          iSesion1 := TbHorarioDetalleSesion.Value;
          TbHorarioDetalle.GotoBookmark(Bookmark2);
          iCodMateria2 := TbHorarioDetalleCodMateria.Value;
          iSesion2 := TbHorarioDetalleSesion.Value;
          TbHorarioDetalle.Edit;
          TbHorarioDetalleCodMateria.Value := iCodMateria1;
          TbHorarioDetalleSesion.Value := iSesion1;
          TbHorarioDetalle.Post;
          TbHorarioDetalle.GotoBookmark(Bookmark1);
          TbHorarioDetalle.Edit;
          TbHorarioDetalleCodMateria.Value := iCodMateria2;
          TbHorarioDetalleSesion.Value := iSesion2;
          TbHorarioDetalle.Post;
        end
        else if Locate1 then
        begin
          TbHorarioDetalle.GotoBookmark(Bookmark1);
          TbHorarioDetalle.Edit;
          TbHorarioDetalleCodDia.Value := ACodDia2;
          TbHorarioDetalleCodHora.Value := ACodHora2;
          TbHorarioDetalle.Post;
        end
        else if Locate2 then
        begin
          TbHorarioDetalle.GotoBookmark(Bookmark1);
          TbHorarioDetalle.Edit;
          TbHorarioDetalleCodDia.Value := ACodDia1;
          TbHorarioDetalleCodHora.Value := ACodHora1;
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
begin
  FStringsShowAulaTipo := TStringList.Create;
  FStringsShowProfesor := TStringList.Create;
  FStringsShowParalelo := TStringList.Create;
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
    add('Profesor=ApeNomProfesor');
    add('Materia_Profesor=NomMateria;ApeNomProfesor');
  end;
end;

procedure TMasterDataModule.DataModuleDestroy(Sender: TObject);
begin
  FStringsShowAulaTipo.Free;
  FStringsShowProfesor.Free;
  FStringsShowParalelo.Free;
end;

end.

