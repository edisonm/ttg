unit DMaster;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, StrHlder, Placemnt, kbmMemTable;

type
  TMasterDataModule = class(TDataModule)
    TbTmpProfesorCarga: TkbmMemTable;
    TbTmpProfesorCargaCodProfesor: TIntegerField;
    TbTmpProfesorCargaNomProfesor: TStringField;
    TbTmpProfesorCargaApeProfesor: TStringField;
    TbTmpProfesorCargaCarga: TIntegerField;
    strHolderShowProfesor: TStrHolder;
    strHolderShowParalelo: TStrHolder;
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
    strHolderShowAulaTipo: TStrHolder;
  private
    { Private declarations }
    procedure FillProfesorProhibicionCant;
  public
    { Public declarations }
    procedure IntercambiarPeriodos(ACodHorario, ACodNivel, ACodEspecializacion,
      ACodParaleloId, ACodDia1, ACodHora1, ACodDia2, ACodHora2: Integer);
    function GetCargaActual: Integer;
    function PerformAllChecks(AMainStrings, ASubStrings: TStrings;
      AMaxCargaProfesor: Integer): Boolean;
  end;

var
  MasterDataModule: TMasterDataModule;

implementation

uses
  SGHCUtls, HorColCm, DSource;
{$R *.DFM}

procedure TMasterDataModule.FillProfesorProhibicionCant;
var
  CodProfesor, CodProfesor1: Integer;
begin
  with SourceDataModule, QuProfesorProhibicionCant do
  begin
    Close;
    Open;
    kbmProfesorProhibicion.IndexFieldNames := 'CodProfesor';
    kbmProfesorProhibicion.First;
    CodProfesor := -$7FFFFFFF;
    while not kbmProfesorProhibicion.Eof do
    begin
      CodProfesor1 := kbmProfesorProhibicionCodProfesor.Value;
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
      kbmProfesorProhibicion.Next;
    end;
  end;
end;

function TMasterDataModule.PerformAllChecks(AMainStrings, ASubStrings:
  TStrings; AMaxCargaProfesor: Integer): Boolean;
var
  HuboProblemas: Boolean;
  iPeriodoCant: Integer;
  procedure ObtenerPeriodoCant;
  begin
    with SourceDataModule do
    begin
      iPeriodoCant := kbmPeriodo.RecordCount;
    end;
  end;
  procedure ObtenerProfesorCarga;
  var
    CodProfesor, CodProfesor1: Integer;
  begin
    with SourceDataModule, kbmDistributivo do
    begin
      IndexFieldNames := 'CodProfesor';
      First;
      TbTmpProfesorCarga.Open;
      CodProfesor := -$7FFFFFFF;
      while not Eof do
      begin
        CodProfesor1 := kbmDistributivoCodProfesor.Value;
        if CodProfesor <> CodProfesor1 then
        begin
          TbTmpProfesorCarga.Append;
          TbTmpProfesorCargaCodProfesor.Value :=
            kbmDistributivoCodProfesor.Value;
          TbTmpProfesorCargaCarga.Value := ComposicionADuracion(kbmDistributivoComposicion.Value);
          CodProfesor := CodProfesor1;
        end
        else
        begin
          TbTmpProfesorCarga.Edit;
          with TbTmpProfesorCargaCarga do
            Value := Value + ComposicionADuracion(kbmDistributivoComposicion.Value);
        end;
        TbTmpProfesorCarga.Post;
        Next;
      end;
    end;
  end;
  procedure ObtenerAulaTipoCarga;
  var
    CodAulaTipo, CodAulaTipo1: Integer;
  begin
    with SourceDataModule, kbmDistributivo do
    begin
      TbTmpAulaTipoCarga.Open;
      IndexFieldNames := 'CodAulaTipo';
      First;
      CodAulaTipo := -$7FFFFFFF;
      while not Eof do
      begin
        CodAulaTipo1 := kbmDistributivoCodAulaTipo.Value;
        if CodAulaTipo <> CodAulaTipo1 then
        begin
          TbTmpAulaTipoCarga.Append;
          TbTmpAulaTipoCargaCodAulaTipo.Value := kbmDistributivoCodAulaTipo.Value;
          TbTmpAulaTipoCargaCarga.Value := ComposicionADuracion(kbmDistributivoComposicion.Value);
          CodAulaTipo := CodAulaTipo1;
        end
        else
        begin
          TbTmpAulaTipoCarga.Edit;
          with TbTmpAulaTipoCargaCarga do
            Value := Value + ComposicionADuracion(kbmDistributivoComposicion.Value);
        end;
        TbTmpAulaTipoCarga.Post;
        Next;
      end;
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
        bAulaTipoActive := kbmAulaTipo.Active;
        try
          kbmAulaTipo.First;
          First;
          s := '%s; %d; %d';
          ASubStrings.Add('Tipos de aulas sin problemas...');
          vSubMin := ASubStrings.Count;
          ASubStrings.Add('AulaTipo; Horas disponibles; Carga');
          while not Eof do
          begin
            if kbmAulaTipo.Locate('CodAulaTipo', TbTmpAulaTipoCargaCodAulaTipo.AsInteger, []) then
            begin
              c := iPeriodoCant * kbmAulaTipoCantidad.AsInteger;
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
          kbmAulaTipo.Active := bAulaTipoActive;
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
    with SourceDataModule, kbmParalelo do
    begin
      s := '%s %s %s; %d';
      HuboProblemasInterno := False;
      try
        Open;
        kbmDistributivo.First;
        kbmPeriodo.First;
        First;
        ASubStrings.Add('Carga Horaria de paralelos sin problemas...');
        vSubMin := ASubStrings.Count;
        ASubStrings.Add('Paralelo; Carga');
        while not Eof do
        begin
          kbmDistributivo.Filter :=
            Format('CodNivel=%d and CodEspecializacion=%d and CodParaleloId=%d', [
            kbmParaleloCodNivel.Value,
              kbmParaleloCodEspecializacion.Value,
              kbmParaleloCodParaleloId.Value]);
          kbmDistributivo.Filtered := true;
          kbmDistributivo.First;
          t := 0;
          try
            while not kbmDistributivo.Eof do
            begin
              Inc(t, ComposicionADuracion(kbmDistributivoComposicion.Value));
              kbmDistributivo.Next;
            end;
            if (t <= 0) or (t > kbmPeriodo.RecordCount) then
            begin
              if not HuboProblemasInterno then
              begin
                AMainStrings.Add('Carga Horaria de paralelos con problemas...');
                vMainMin := AMainStrings.Count;
                AMainStrings.Add('Paralelo; Carga');
              end;
              AMainStrings.Add(Format(s, [kbmParaleloAbrNivel.Value,
                kbmParaleloAbrEspecializacion.Value,
                kbmParaleloNomParaleloId.Value, t]));
              HuboProblemas := True;
              HuboProblemasInterno := True;
            end
            else
              ASubStrings.Add(Format(s, [kbmParaleloAbrNivel.Value,
                kbmParaleloAbrEspecializacion.Value,
                kbmParaleloNomParaleloId.Value, t]));
          except
            ASubStrings.Add(Format('Problemas: %s %s %s, Materia %s',
              [kbmParaleloAbrNivel.AsString, kbmParaleloAbrEspecializacion.AsString,
              kbmParaleloNomParaleloId.AsString, kbmDistributivoNomMateria.AsString]));
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
        kbmDistributivo.Filter := '';
        kbmDistributivo.Filtered := false;
        First;
        kbmDistributivo.First;
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
  with SourceDataModule, kbmDistributivo do
  begin
    VBookmark := GetBookmark;
    DisableControls;
    try
      First;
      c := 0;
      while not Eof do
      begin
        Inc(c, ComposicionADuracion(kbmDistributivoComposicion.Value));
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
    Locate1 := kbmHorarioDetalle.Locate(
      'CodHorario;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora',
      VarArrayOf([ACodHorario, ACodNivel, ACodEspecializacion, ACodParaleloId,
      ACodDia1, ACodHora1]), []);
    Bookmark1 := kbmHorarioDetalle.GetBookmark;
    try
      Locate2 := kbmHorarioDetalle.Locate(
        'CodHorario;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora',
        VarArrayOf([ACodHorario, ACodNivel, ACodEspecializacion, ACodParaleloId,
        ACodDia2, ACodHora2]), []);
      Bookmark2 := kbmHorarioDetalle.GetBookmark;
      try
        if Locate1 and Locate2 then
        begin
          kbmHorarioDetalle.GotoBookmark(Bookmark1);
          iCodMateria1 := kbmHorarioDetalleCodMateria.Value;
          iSesion1 := kbmHorarioDetalleSesion.Value;
          kbmHorarioDetalle.GotoBookmark(Bookmark2);
          iCodMateria2 := kbmHorarioDetalleCodMateria.Value;
          iSesion2 := kbmHorarioDetalleSesion.Value;
          kbmHorarioDetalle.Edit;
          kbmHorarioDetalleCodMateria.Value := iCodMateria1;
          kbmHorarioDetalleSesion.Value := iSesion1;
          kbmHorarioDetalle.Post;
          kbmHorarioDetalle.GotoBookmark(Bookmark1);
          kbmHorarioDetalle.Edit;
          kbmHorarioDetalleCodMateria.Value := iCodMateria2;
          kbmHorarioDetalleSesion.Value := iSesion2;
          kbmHorarioDetalle.Post;
        end
        else if Locate1 then
        begin
          kbmHorarioDetalle.GotoBookmark(Bookmark1);
          kbmHorarioDetalle.Edit;
          kbmHorarioDetalleCodDia.Value := ACodDia2;
          kbmHorarioDetalleCodHora.Value := ACodHora2;
          kbmHorarioDetalle.Post;
        end
        else if Locate2 then
        begin
          kbmHorarioDetalle.GotoBookmark(Bookmark1);
          kbmHorarioDetalle.Edit;
          kbmHorarioDetalleCodDia.Value := ACodDia1;
          kbmHorarioDetalleCodHora.Value := ACodHora1;
          kbmHorarioDetalle.Post;
        end;
      finally
        kbmHorarioDetalle.FreeBookmark(Bookmark2);
      end;
    finally
      kbmHorarioDetalle.FreeBookmark(Bookmark1);
    end;
  end;
end;

end.

