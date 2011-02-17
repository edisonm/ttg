object MasterDataModule: TMasterDataModule
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 404
  Width = 748
  object TbTmpProfesorCarga: TSqlitePassDataset
    CalcDisplayedRecordsOnly = False
    Database = SourceDataModule.Database
    MasterSourceAutoActivate = True
    FilterMode = fmSQLDirect
    FilterRecordLowerLimit = 0
    FilterRecordUpperLimit = 0
    Indexed = True
    LocateSmartRefresh = False
    LookUpCache = False
    LookUpDisplayedRecordsOnly = False
    LookUpSmartRefresh = False
    Sorted = False
    RecordsCacheCapacity = 100
    DatabaseAutoActivate = True
    VersionInfo.Component = '0.55'
    VersionInfo.Package = '0.55'
    ParamCheck = False
    WriteMode = wmDirect
    Left = 250
    Top = 11
    pParams = ()
    object TbTmpProfesorCargaCodProfesor: TLargeintField
      DisplayLabel = 'Profesor'
      FieldName = 'CodProfesor'
    end
    object TbTmpProfesorCargaApeProfesor: TStringField
      DisplayLabel = 'Apellido'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'ApeProfesor'
      LookupDataSet = SourceDataModule.TbProfesor
      LookupKeyFields = 'CodProfesor'
      LookupResultField = 'ApeProfesor'
      KeyFields = 'CodProfesor'
      Size = 31
      Lookup = True
    end
    object TbTmpProfesorCargaNomProfesor: TStringField
      DisplayLabel = 'Nombre'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'NomProfesor'
      LookupDataSet = SourceDataModule.TbProfesor
      LookupKeyFields = 'CodProfesor'
      LookupResultField = 'NomProfesor'
      KeyFields = 'CodProfesor'
      Size = 31
      Lookup = True
    end
    object TbTmpProfesorCargaCarga: TLargeintField
      FieldName = 'Carga'
    end
  end
  object QuDistributivoProfesor: TSqlitePassDataset
    CalcDisplayedRecordsOnly = False
    Database = SourceDataModule.Database
    MasterSourceAutoActivate = True
    FilterMode = fmSQLDirect
    FilterRecordLowerLimit = 0
    FilterRecordUpperLimit = 0
    Indexed = True
    LocateSmartRefresh = False
    LookUpCache = False
    LookUpDisplayedRecordsOnly = False
    LookUpSmartRefresh = False
    Sorted = False
    RecordsCacheCapacity = 100
    DatabaseAutoActivate = True
    VersionInfo.Component = '0.55'
    VersionInfo.Package = '0.55'
    ParamCheck = False
    WriteMode = wmDirect
    Left = 250
    Top = 115
    pParams = ()
    object QuDistributivoProfesorCodMateria: TLargeintField
      FieldName = 'CodMateria'
      Visible = False
    end
    object QuDistributivoProfesorCodNivel: TLargeintField
      FieldName = 'CodNivel'
      Visible = False
    end
    object QuDistributivoProfesorCodEspecializacion: TLargeintField
      FieldName = 'CodEspecializacion'
    end
    object QuDistributivoProfesorCodParaleloId: TLargeintField
      FieldName = 'CodParaleloId'
      Visible = False
    end
    object QuDistributivoProfesorCodProfesor: TLargeintField
      FieldName = 'CodProfesor'
      Visible = False
    end
    object QuDistributivoProfesorNomMateria: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Materia'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'NomMateria'
      LookupKeyFields = 'CodMateria'
      LookupResultField = 'NomMateria'
      KeyFields = 'CodMateria'
      Size = 15
      Lookup = True
    end
    object QuDistributivoProfesorAbrNivel: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Nivel'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'AbrNivel'
      LookupKeyFields = 'CodNivel'
      LookupResultField = 'AbrNivel'
      KeyFields = 'CodNivel'
      Size = 10
      Lookup = True
    end
    object QuDistributivoProfesorAbrEspecializacion: TStringField
      DisplayLabel = 'Espec.'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'AbrEspecializacion'
      LookupKeyFields = 'CodEspecializacion'
      LookupResultField = 'AbrEspecializacion'
      KeyFields = 'CodEspecializacion'
      Required = True
      Size = 10
      Lookup = True
    end
    object QuDistributivoProfesorNomParaleloId: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Par.'
      FieldKind = fkLookup
      FieldName = 'NomParaleloId'
      LookupKeyFields = 'CodParaleloId'
      LookupResultField = 'NomParaleloId'
      KeyFields = 'CodParaleloId'
      Size = 5
      Lookup = True
    end
    object QuDistributivoProfesorApeNomProfesor: TStringField
      DisplayLabel = 'Profesor'
      DisplayWidth = 31
      FieldKind = fkLookup
      FieldName = 'ApeNomProfesor'
      LookupKeyFields = 'CodProfesor'
      LookupResultField = 'ApeNomProfesor'
      KeyFields = 'CodProfesor'
      Size = 31
      Lookup = True
    end
  end
  object QuProfesorProhibicionCant: TSqlitePassDataset
    CalcDisplayedRecordsOnly = False
    Database = SourceDataModule.Database
    MasterSourceAutoActivate = True
    FilterMode = fmSQLDirect
    FilterRecordLowerLimit = 0
    FilterRecordUpperLimit = 0
    Indexed = True
    LocateSmartRefresh = False
    LookUpCache = False
    LookUpDisplayedRecordsOnly = False
    LookUpSmartRefresh = False
    Sorted = False
    RecordsCacheCapacity = 100
    DatabaseAutoActivate = True
    VersionInfo.Component = '0.55'
    VersionInfo.Package = '0.55'
    ParamCheck = False
    WriteMode = wmDirect
    Left = 58
    Top = 157
    pParams = ()
    object QuProfesorProhibicionCantCodProfesor: TLargeintField
      FieldName = 'CodProfesor'
    end
    object QuProfesorProhibicionCantCantidad: TLargeintField
      FieldName = 'Cantidad'
    end
  end
  object TbTmpAulaTipoCarga: TSqlitePassDataset
    CalcDisplayedRecordsOnly = False
    Database = SourceDataModule.Database
    MasterSourceAutoActivate = True
    FilterMode = fmSQLDirect
    FilterRecordLowerLimit = 0
    FilterRecordUpperLimit = 0
    Indexed = True
    LocateSmartRefresh = False
    LookUpCache = False
    LookUpDisplayedRecordsOnly = False
    LookUpSmartRefresh = False
    Sorted = False
    RecordsCacheCapacity = 100
    DatabaseAutoActivate = True
    VersionInfo.Component = '0.55'
    VersionInfo.Package = '0.55'
    ParamCheck = False
    WriteMode = wmDirect
    Left = 250
    Top = 62
    pParams = ()
    object TbTmpAulaTipoCargaCodAulaTipo: TLargeintField
      DisplayLabel = 'Tipo de aula'
      FieldName = 'CodAulaTipo'
    end
    object TbTmpAulaTipoCargaAbrAulaTipo: TStringField
      DisplayLabel = 'Nombre'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'AbrAulaTipo'
      LookupDataSet = SourceDataModule.TbAulaTipo
      LookupKeyFields = 'CodAulaTipo'
      LookupResultField = 'AbrAulaTipo'
      KeyFields = 'CodAulaTipo'
      Size = 31
      Lookup = True
    end
    object TbTmpAulaTipoCargaCarga: TLargeintField
      FieldName = 'Carga'
    end
  end
end
