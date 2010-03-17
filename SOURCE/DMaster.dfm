object MasterDataModule: TMasterDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 35
  Top = 307
  Height = 320
  Width = 575
  object TbTmpProfesorCarga: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <>
    RecalcOnIndex = False
    RecalcOnFetch = True
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    StoreDataOnForm = False
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible]
    PersistentSaveFormat = mtsfBinary
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadLimit = -1
    EnableJournal = False
    EnableVersioning = False
    VersioningMode = mtvm1SinceCheckPoint
    FilterOptions = []
    Version = '2.49'
    Left = 250
    Top = 11
    object TbTmpProfesorCargaCodProfesor: TIntegerField
      DisplayLabel = 'Profesor'
      FieldName = 'CodProfesor'
    end
    object TbTmpProfesorCargaApeProfesor: TStringField
      DisplayLabel = 'Apellido'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'ApeProfesor'
      LookupDataSet = SourceDataModule.kbmProfesor
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
      LookupDataSet = SourceDataModule.kbmProfesor
      LookupKeyFields = 'CodProfesor'
      LookupResultField = 'NomProfesor'
      KeyFields = 'CodProfesor'
      Size = 31
      Lookup = True
    end
    object TbTmpProfesorCargaCarga: TIntegerField
      FieldName = 'Carga'
    end
  end
  object QuDistributivoProfesor: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <>
    RecalcOnIndex = False
    RecalcOnFetch = True
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    StoreDataOnForm = False
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentSaveFormat = mtsfBinary
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadLimit = -1
    EnableJournal = False
    EnableVersioning = False
    VersioningMode = mtvm1SinceCheckPoint
    FilterOptions = []
    Version = '2.49'
    Left = 250
    Top = 115
    object QuDistributivoProfesorCodMateria: TIntegerField
      FieldName = 'CodMateria'
      Visible = False
    end
    object QuDistributivoProfesorCodNivel: TIntegerField
      FieldName = 'CodNivel'
      Visible = False
    end
    object QuDistributivoProfesorCodEspecializacion: TIntegerField
      FieldName = 'CodEspecializacion'
    end
    object QuDistributivoProfesorCodParaleloId: TIntegerField
      FieldName = 'CodParaleloId'
      Visible = False
    end
    object QuDistributivoProfesorCodProfesor: TIntegerField
      FieldName = 'CodProfesor'
      Visible = False
    end
    object QuDistributivoProfesorNomMateria: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Materia'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'NomMateria'
      LookupDataSet = SourceDataModule.kbmMateria
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
      LookupDataSet = SourceDataModule.kbmNivel
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
      LookupDataSet = SourceDataModule.kbmEspecializacion
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
      LookupDataSet = SourceDataModule.kbmParaleloId
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
      LookupDataSet = SourceDataModule.kbmProfesor
      LookupKeyFields = 'CodProfesor'
      LookupResultField = 'ApeNomProfesor'
      KeyFields = 'CodProfesor'
      Size = 31
      Lookup = True
    end
  end
  object QuProfesorProhibicionCant: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <>
    RecalcOnIndex = False
    RecalcOnFetch = True
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    StoreDataOnForm = False
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentSaveFormat = mtsfBinary
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadLimit = -1
    EnableJournal = False
    EnableVersioning = False
    VersioningMode = mtvm1SinceCheckPoint
    FilterOptions = []
    Version = '2.49'
    Left = 58
    Top = 117
    object QuProfesorProhibicionCantCodProfesor: TIntegerField
      FieldName = 'CodProfesor'
    end
    object QuProfesorProhibicionCantCantidad: TIntegerField
      FieldName = 'Cantidad'
    end
  end
  object TbTmpAulaTipoCarga: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <>
    RecalcOnIndex = False
    RecalcOnFetch = True
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    StoreDataOnForm = False
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible]
    PersistentSaveFormat = mtsfBinary
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadLimit = -1
    EnableJournal = False
    EnableVersioning = False
    VersioningMode = mtvm1SinceCheckPoint
    FilterOptions = []
    Version = '2.49'
    Left = 250
    Top = 62
    object TbTmpAulaTipoCargaCodAulaTipo: TIntegerField
      DisplayLabel = 'Tipo de aula'
      FieldName = 'CodAulaTipo'
    end
    object TbTmpAulaTipoCargaAbrAulaTipo: TStringField
      DisplayLabel = 'Nombre'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'AbrAulaTipo'
      LookupDataSet = SourceDataModule.kbmAulaTipo
      LookupKeyFields = 'CodAulaTipo'
      LookupResultField = 'AbrAulaTipo'
      KeyFields = 'CodAulaTipo'
      Size = 31
      Lookup = True
    end
    object TbTmpAulaTipoCargaCarga: TIntegerField
      FieldName = 'Carga'
    end
  end
end
