unit DMaster;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, StrHlder, Placemnt, RxQuery, kbmMemTable;

type
  TMasterDataModule = class(TDataModule)
    TbEspecializacion: TTable;
    DSEspecializacion: TDataSource;
    TbNivel: TTable;
    DSNivel: TDataSource;
    TbAulaTipo: TTable;
    DSAulaTipo: TDataSource;
    TbDia: TTable;
    DSDia: TDataSource;
    TbProfesorProhibicionTipo: TTable;
    DSProfesorProhibicionTipo: TDataSource;
    TbCurso: TTable;
    DSCurso: TDataSource;
    TbParaleloId: TTable;
    DSParaleloId: TDataSource;
    TbParalelo: TTable;
    DSParalelo: TDataSource;
    TbHora: TTable;
    DSHora: TDataSource;
    TbMateria: TTable;
    DSMateria: TDataSource;
    TbProfesor: TTable;
    DSProfesor: TDataSource;
    TbHorarioLaborable: TTable;
    DSHorarioLaborable: TDataSource;
    TbAsignatura: TTable;
    DSAsignatura: TDataSource;
    TbMateriaProhibicionTipo: TTable;
    DSMateriaProhibicionTipo: TDataSource;
    TbHorario: TTable;
    DSHorario: TDataSource;
    DSCargaAcademica: TDataSource;
    TbHorarioDetalle: TTable;
    DSHorarioDetalle: TDataSource;
    TbProfesorProhibicion: TTable;
    DSProfesorProhibicion: TDataSource;
    TbMateriaProhibicion: TTable;
    DSMateriaProhibicion: TDataSource;
    TbHoraCodHora: TIntegerField;
    TbHoraIntervalo: TStringField;
    TbHoraNomHora: TStringField;
    TbHorarioCodHorario: TIntegerField;
    TbHorarioMomentoInicial: TDateTimeField;
    TbHorarioMomentoFinal: TDateTimeField;
    TbHorarioDetalleCodHorario: TIntegerField;
    TbHorarioDetalleCodNivel: TIntegerField;
    TbHorarioDetalleCodParaleloId: TIntegerField;
    TbHorarioDetalleCodDia: TIntegerField;
    TbHorarioDetalleCodHora: TIntegerField;
    TbHorarioDetalleSesion: TIntegerField;
    TbProfesorCodProfesor: TIntegerField;
    TbProfesorCedProfesor: TStringField;
    TbProfesorNomProfesor: TStringField;
    TbProfesorApeProfesor: TStringField;
    TbProfesorProhibicionCodProfesor: TIntegerField;
    TbProfesorProhibicionCodDia: TIntegerField;
    TbProfesorProhibicionCodHora: TIntegerField;
    TbProfesorProhibicionCodProfProhibicionTipo: TIntegerField;
    TbCursoCodNivel: TIntegerField;
    TbCursoCodEspecializacion: TIntegerField;
    TbHorarioLaborableCodDia: TIntegerField;
    TbHorarioLaborableCodHora: TIntegerField;
    TbMateriaProhibicionDia: TIntegerField;
    TbMateriaProhibicionHora: TIntegerField;
    TbMateriaProhibicionCodMateProhibicionTipo: TIntegerField;
    TbCursoAbrNivel: TStringField;
    TbCursoAbrEspecializacion: TStringField;
    TbMateriaCodMateria: TIntegerField;
    TbMateriaNomMateria: TStringField;
    TbAsignaturaCodMateria: TIntegerField;
    TbAsignaturaComposicion: TStringField;
    TbProfesorApeNomProfesor: TStringField;
    TbCargaAcademica: TTable;
    TbCargaAcademicaCodMateria: TIntegerField;
    TbCargaAcademicaCodNivel: TIntegerField;
    TbCargaAcademicaCodParaleloId: TIntegerField;
    TbCargaAcademicaCodProfesor: TIntegerField;
    QuProfesorCarga: TQuery;
    QuProfesorCargaCodProfesor: TIntegerField;
    QuProfesorCargaCantidad: TIntegerField;
    QuProfesorCargaComposicion: TStringField;
    TbTmpProfesorCarga: TkbmMemTable;
    TbTmpProfesorCargaCodProfesor: TIntegerField;
    TbTmpProfesorCargaNomProfesor: TStringField;
    TbTmpProfesorCargaApeProfesor: TStringField;
    TbTmpProfesorCargaCarga: TIntegerField;
    FormStorage: TFormStorage;
    TbCargaAcademicaComposicion: TStringField;
    TbHorarioDetalleCodMateria: TIntegerField;
    TbCargaAcademicaDuracion: TIntegerField;
    TbProfesorProhibicionNomProfProhibicionTipo: TStringField;
    TbMateriaProhibicionNomMateProhibicionTipo: TStringField;
    TbHorarioDetalleNomMateria: TStringField;
    StrHolderShowProfesor: TStrHolder;
    TbHorarioInforme: TMemoField;
    QuCargaAcademica: TQuery;
    QuCargaAcademicaCodMateria: TIntegerField;
    QuCargaAcademicaCodNivel: TIntegerField;
    QuCargaAcademicaCodParaleloId: TIntegerField;
    QuCargaAcademicaNomMateria: TStringField;
    QuCargaAcademicaAbrNivel: TStringField;
    QuCargaAcademicaNomParaleloId: TStringField;
    StrHolderShowParalelo: TStrHolder;
    TbCursoAbrCurso: TStringField;
    TbCargaAcademicaNomMateria: TStringField;
    TbCargaAcademicaAbrNivel: TStringField;
    TbCargaAcademicaNomParaleloId: TStringField;
    TbCargaAcademicaApeNomProfesor: TStringField;
    TbProfesor1: TTable;
    IntegerField6: TIntegerField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    SQLScrDelHorario: TSQLScript;
    TbMateria1: TTable;
    TbMateria1CodMateria: TIntegerField;
    TbMateria1NomMateria: TStringField;
    TbAsignaturaNomMateria: TStringField;
    TbAsignaturaAbrNivel: TStringField;
    QuCargaAcademicaParalelo: TQuery;
    QuCargaAcademicaParaleloCodMateria: TIntegerField;
    QuCargaAcademicaParaleloCodNivel: TIntegerField;
    QuCargaAcademicaParaleloCodParaleloId: TIntegerField;
    QuCargaAcademicaParaleloNomMateria: TStringField;
    QuCargaAcademicaParaleloAbrNivel: TStringField;
    QuCargaAcademicaParaleloNomParaleloId: TStringField;
    QuCargaAcademicaParaleloCodProfesor: TIntegerField;
    QuCargaAcademicaParaleloApeNomProfesor: TStringField;
    TbAsignaturaCodNivel: TIntegerField;
    TbAsignaturaCodEspecializacion: TIntegerField;
    TbHorarioTiempo: TTimeField;
    TbAsignaturaCodAulaTipo: TIntegerField;
    TbCargaAcademicaCodEspecializacion: TIntegerField;
    TbCargaAcademicaAbrEspecializacion: TStringField;
    QuCargaAcademicaParaleloCodEspecializacion: TIntegerField;
    TbHorarioDetalleCodEspecializacion: TIntegerField;
    TbAsignaturaAbrEspecializacion: TStringField;
    TbAsignaturaAbrAulaTipo: TStringField;
    QuCargaAcademicaCodEspecializacion: TIntegerField;
    QuCargaAcademicaAbrEspecializacion: TStringField;
    QuCargaAcademicaParaleloAbrEspecializacion: TStringField;
    TbEspecializacionCodEspecializacion: TIntegerField;
    TbEspecializacionNomEspecializacion: TStringField;
    TbEspecializacionAbrEspecializacion: TStringField;
    TbAulaTipoCodAulaTipo: TIntegerField;
    TbAulaTipoNomAulaTipo: TStringField;
    TbAulaTipoAbrAulaTipo: TStringField;
    TbAulaTipoCantidad: TIntegerField;
    TbNivelCodNivel: TIntegerField;
    TbNivelNomNivel: TStringField;
    TbNivelAbrNivel: TStringField;
    TbDiaCodDia: TIntegerField;
    TbDiaNomDia: TStringField;
    TbProfesorProhibicionTipoCodProfProhibicionTipo: TIntegerField;
    TbProfesorProhibicionTipoNomProfProhibicionTipo: TStringField;
    TbProfesorProhibicionTipoColProfProhibicionTipo: TIntegerField;
    TbProfesorProhibicionTipoValProfProhibicionTipo: TFloatField;
    TbParaleloIdCodParaleloId: TIntegerField;
    TbParaleloIdNomParaleloId: TStringField;
    TbParaleloCodNivel: TIntegerField;
    TbParaleloCodEspecializacion: TIntegerField;
    TbParaleloCodParaleloId: TIntegerField;
    TbMateriaProhibicionTipoCodMateProhibicionTipo: TIntegerField;
    TbMateriaProhibicionTipoNomMateProhibicionTipo: TStringField;
    TbMateriaProhibicionTipoColMateProhibicionTipo: TIntegerField;
    TbMateriaProhibicionTipoValMateProhibicionTipo: TFloatField;
    TbMateriaProhibicionCodMateria: TIntegerField;
    TbParalelo1: TTable;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    procedure TbProfesorCalcFields(DataSet: TDataSet);
    procedure TbCargaAcademicaCalcFields(DataSet: TDataSet);
    procedure MasterDataModuleCreate(Sender: TObject);
    procedure MasterDataModuleDestroy(Sender: TObject);
    procedure TbHorarioBeforeDelete(DataSet: TDataSet);
    procedure DataSetBeforePost(DataSet: TDataSet);
    procedure TbCursoCalcFields(DataSet: TDataSet);
    procedure TbCargaAcademicaBeforeOpen(DataSet: TDataSet);
    procedure TbAsignaturaBeforePost(DataSet: TDataSet);
    procedure TbHorarioCalcFields(DataSet: TDataSet);
    procedure TbCargaAcademicaBeforePost(DataSet: TDataSet);
    procedure DataSetBeforeClose(DataSet: TDataSet);
    procedure TbCargaAcademicaAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
    FOnProgress: TDataSetNotifyEvent;
  public
    { Public declarations }
    procedure IntercambiarPeriodos(ACodHorario, ACodNivel, ACodEspecializacion,
      ACodParaleloId, ACodDia1, ACodHora1, ACodDia2, ACodHora2: Integer);
    procedure ProcessTable(ATable: TTable);
    property OnProgress: TDataSetNotifyEvent read FOnProgress write FOnProgress;
    function GetDescription(ATable: TTable): string;
    function GetCargaActual: Integer;
    function PerformAllChecks(AMainStrings, ASubStrings: TStrings;
      AMaxCargaProfesor: Integer): Boolean;
  end;

var
  MasterDataModule: TMasterDataModule;

implementation

uses
  DMain, SGHCUtls, HorColCm;
{$R *.DFM}

procedure TMasterDataModule.ProcessTable(ATable: TTable);
begin
  try
    ATable.Open
  except
  end;
  if Assigned(FOnProgress) then
    FOnProgress(ATable)
end;

procedure TMasterDataModule.TbProfesorCalcFields(DataSet: TDataSet);
begin
  with DataSet do
    FieldValues['ApeNomProfesor'] := FieldValues['ApeProfesor'] + ' ' +
      FieldValues['NomProfesor'];
end;

function TMasterDataModule.GetDescription(ATable: TTable): string;
begin
  Result :=
    MainDataModule.sthProperty.Strings.Values[Format('Table[%s].Description',
    [ATable.TableName])];
end;

function TMasterDataModule.PerformAllChecks(AMainStrings, ASubStrings:
  TStrings; AMaxCargaProfesor: Integer): Boolean;
  // Chequea que no hayan asignadas más horas de materias a profesores de las
  // permitidas
var
  HuboProblemas: Boolean;
  procedure CheckProfesorCarga;
  var
    s: string;
    vMainMin, vMainMax, vSubMin, vSubMax: Integer;
  begin
    with QuProfesorCarga do
    begin
      Close;
      Open;
      TbTmpProfesorCarga.Open;
      try
        while not Eof do
        begin
          if not TbTmpProfesorCarga.Locate('CodProfesor',
            QuProfesorCargaCodProfesor.Value, []) then
          begin
            TbTmpProfesorCarga.Append;
            TbTmpProfesorCargaCodProfesor.Value :=
              QuProfesorCargaCodProfesor.Value;
            if not QuProfesorCargaCantidad.isNull then
              TbTmpProfesorCargaCarga.Value := QuProfesorCargaCantidad.Value *
                ComposicionADuracion(QuProfesorCargaComposicion.Value);
          end
          else
          begin
            TbTmpProfesorCarga.Edit;
            if not QuProfesorCargaCantidad.isNull then
              with TbTmpProfesorCargaCarga do
                Value := Value + QuProfesorCargaCantidad.Value *
                  ComposicionADuracion(QuProfesorCargaComposicion.Value);
          end;
          TbTmpProfesorCarga.Post;
          Next;
        end;
        with TbTmpProfesorCarga do
          if not IsEmpty then
          begin
            First;
            s := '%s %s; %d';
            AMainStrings.Add('Carga horaria de los Profesores con problemas...');
            vMainMin := AMainStrings.Count;
            AMainStrings.Add('Profesor; Carga');
            ASubStrings.Add('Carga horaria de los Profesores sin problemas...');
            vSubMin := ASubStrings.Count;
            ASubStrings.Add('Profesor; Carga');
            while not Eof do
            begin
              if TbTmpProfesorCargaCarga.Value > AMaxCargaProfesor then
              begin
                AMainStrings.Add(Format(s, [TbTmpProfesorCargaApeProfesor.Value,
                  TbTmpProfesorCargaNomProfesor.Value,
                    TbTmpProfesorCargaCarga.Value]));
                HuboProblemas := True;
              end
              else
              begin
                ASubStrings.Add(Format(s, [TbTmpProfesorCargaApeProfesor.Value,
                  TbTmpProfesorCargaNomProfesor.Value,
                    TbTmpProfesorCargaCarga.Value]));
              end;
              Next;
            end;
            vMainMax := AMainStrings.Count - 1;
            vSubMax := ASubStrings.Count - 1;
            EqualSpaced(AMainStrings, vMainMin, vMainMax, ';');
            EqualSpaced(ASubStrings, vSubMin, vSubMax, ';');
          end;
      finally
        Close;
        TbTmpProfesorCarga.Close;
      end;
    end;
  end;
  // Chequea que no hayan asignadas más horas de materias a Cursos que períodos
  procedure CheckCursoCarga;
  var
    t, vMainMin, vMainMax, vSubMin, vSubMax: Integer;
    s: string;
    bActive, bAsignaturaActive, bHorarioLaborableActive: Boolean;
  begin
    with TbCurso do
    begin
      s := '%s %s; %d';
      bActive := Active;
      bAsignaturaActive := TbAsignatura.Active;
      bHorarioLaborableActive := TbHorarioLaborable.Active;
      try
        Open;
        TbAsignatura.Open;
        TbHorarioLaborable.Open;
        First;
        AMainStrings.Add('Carga Horaria de paralelos con problemas...');
        vMainMin := AMainStrings.Count;
        AMainStrings.Add('Curso; Carga');
        ASubStrings.Add('Carga Horaria de paralelos sin problemas...');
        vSubMin := ASubStrings.Count;
        ASubStrings.Add('Curso; Carga');
        while not Eof do
        begin
          TbAsignatura.Filter := Format('CodNivel=%d and CodEspecializacion=%d',
            [TbCursoCodNivel.Value, TbCursoCodEspecializacion.Value]);
          TbAsignatura.Filtered := true;
          TbAsignatura.First;
          t := 0;
          try
            while not TbAsignatura.Eof do
            begin
              Inc(t, ComposicionADuracion(TbAsignaturaComposicion.Value));
              TbAsignatura.Next;
            end;
            if (t <= 0) or (t > TbHorarioLaborable.RecordCount) then
            begin
              AMainStrings.Add(Format(s, [TbCursoAbrNivel.Value,
                TbCursoAbrEspecializacion.Value, t]));
              HuboProblemas := True;
            end
            else
              ASubStrings.Add(Format(s, [TbCursoAbrNivel.Value,
                TbCursoAbrEspecializacion.Value, t]));
          except
            ASubStrings.Add(Format('Problemas: Curso %s; Materia %s',
              [TbCursoAbrCurso.AsString, TbAsignaturaNomMateria.AsString]));
            HuboProblemas := True;
          end;
          Next;
        end;
        vMainMax := AMainStrings.Count - 1;
        vSubMax := ASubStrings.Count - 1;
        EqualSpaced(AMainStrings, vMainMin, vMainMax, ';');
        EqualSpaced(ASubStrings, vSubMin, vSubMax, ';');
      finally
        TbAsignatura.Filter := '';
        TbAsignatura.Filtered := false;
        First;
        TbAsignatura.First;
        TbHorarioLaborable.Active := bHorarioLaborableActive;
        TbAsignatura.Active := bAsignaturaActive;
        Active := bActive;
      end;
    end;
  end;
  procedure CheckCargaAcademica;
  begin
    with QuCargaAcademica do
    begin
      Close;
      Open;
      try
        if not IsEmpty then
        begin
          AMainStrings.Add('CargaAcademica de Materias no asignadas...');
          LoadStringsFromDataSet(AMainStrings, QuCargaAcademica,
            'NomMateria;AbrNivel;AbrEspecializacion;NomParaleloId', true, true);
          HuboProblemas := True;
        end;
      finally
        Close;
      end;
    end;
  end;
  procedure CheckCargaAcademicaParalelo;
  begin
    with QuCargaAcademicaParalelo do
    begin
      Close;
      Open;
      try
        if not IsEmpty then
        begin
          AMainStrings.Add('CargaAcademica de Materias no relacionadas con Paralelos...');
          LoadStringsFromDataSet(AMainStrings, QuCargaAcademicaParalelo,
            'NomMateria;NomCurso;NomParaleloId;ApeNomProfesor', true,
            true);
          HuboProblemas := True;
        end;
      finally
        Close;
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
    CheckProfesorCarga;
    CheckCursoCarga;
    CheckCargaAcademica;
    CheckCargaAcademicaParalelo;
  finally
    AMainStrings.EndUpdate;
    ASubStrings.EndUpdate;
    Result := HuboProblemas;
  end;
end;

procedure TMasterDataModule.TbCargaAcademicaBeforePost(DataSet: TDataSet);
begin
  if VarIsNull(DataSet['Composicion']) then
    raise Exception.Create('Materia no asignada a este Paralelo');
  TbCargaAcademicaCodMateria.DefaultExpression :=
    TbCargaAcademicaCodMateria.AsString;
  TbCargaAcademicaCodNivel.DefaultExpression :=
    TbCargaAcademicaCodNivel.AsString;
  TbCargaAcademicaCodEspecializacion.DefaultExpression :=
    TbCargaAcademicaCodEspecializacion.AsString;
end;

procedure TMasterDataModule.TbCargaAcademicaCalcFields(DataSet: TDataSet);
var
  v: Variant;
begin
  try
    v := TbAsignatura.Lookup('CodMateria;CodNivel;CodEspecializacion',
      VarArrayOf([TbCargaAcademicaCodMateria.AsInteger,
      TbCargaAcademicaCodNivel.AsInteger,
        TbCargaAcademicaCodEspecializacion.AsInteger]),
        'Composicion');
    DataSet['Composicion'] := v;
    DataSet['Duracion'] := ComposicionADuracion(VarToStr(v));
  except
  end;
end;

procedure TMasterDataModule.MasterDataModuleCreate(Sender: TObject);
begin
  FormStorage.RestoreFormPlacement;
end;

procedure TMasterDataModule.MasterDataModuleDestroy(Sender: TObject);
begin
  FormStorage.SaveFormPlacement;
end;

function TMasterDataModule.GetCargaActual: Integer;
var
  VBookmark: TBookmark;
  c: Integer;
begin
  with TbCargaAcademica do
  begin
    VBookmark := GetBookmark;
    DisableControls;
    try
      First;
      c := 0;
      while not Eof do
      begin
        Inc(c, ComposicionADuracion(TbCargaAcademicaComposicion.Value));
        Next;
      end;
      Result := c;
    finally
      EnableControls;
      GotoBookmark(VBookmark);
    end;
  end;
end;

procedure TMasterDataModule.TbHorarioBeforeDelete(DataSet: TDataSet);
begin
  SQLScrDelHorario.ParamByName('CodHorario').AsInteger :=
    TbHorarioCodHorario.AsInteger;
  SQLScrDelHorario.ExecSQL;
end;

procedure TMasterDataModule.DataSetBeforePost(DataSet: TDataSet);
begin
  if (DataSet.State in dsEditModes) and DataSet.Fields[0].IsNull
    then DataSet.Fields[0].Value := GetFreeCode(DataSet as TTable,
      DataSet.Fields[0].FieldName);
end;

procedure TMasterDataModule.TbCursoCalcFields(DataSet: TDataSet);
begin
  DataSet['AbrCurso'] := DataSet['AbrNivel'] + ' ' +
    DataSet['AbrEspecializacion'];
end;

procedure TMasterDataModule.TbCargaAcademicaBeforeOpen(DataSet: TDataSet);
begin
  TbParalelo.Open;
  TbAsignatura.Open;
end;

procedure TMasterDataModule.TbAsignaturaBeforePost(DataSet: TDataSet);
var
  s: string;
begin
  s := TbAsignaturaComposicion.Value;
  if ComposicionADuracion(s) <= 0 then
    raise Exception.CreateFmt('Composición no válida: "%s"', [s]);
end;

procedure TMasterDataModule.TbHorarioCalcFields(DataSet: TDataSet);
begin
  TbHorarioTiempo.Value := TbHorarioMomentoFinal.Value -
    TbHorarioMomentoInicial.Value;
end;

procedure TMasterDataModule.DataSetBeforeClose(DataSet: TDataSet);
begin
  (DataSet as TBDEDataSet).FlushBuffers;
end;

procedure TMasterDataModule.IntercambiarPeriodos(ACodHorario, ACodNivel,
  ACodEspecializacion, ACodParaleloId, ACodDia1, ACodHora1, ACodDia2,
  ACodHora2: Integer);
var
  Locate1, Locate2: Boolean;
  Bookmark1, Bookmark2: TBookmark;
  iCodMateria1, iSesion1, iCodMateria2, iSesion2: Integer;
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

procedure TMasterDataModule.TbCargaAcademicaAfterInsert(DataSet: TDataSet);
begin
  TbCargaAcademicaCodMateria.AsString :=
    TbCargaAcademicaCodMateria.DefaultExpression;
  TbCargaAcademicaCodNivel.AsString :=
    TbCargaAcademicaCodNivel.DefaultExpression;
  TbCargaAcademicaCodEspecializacion.AsString :=
    TbCargaAcademicaCodEspecializacion.DefaultExpression;
end;

end.

