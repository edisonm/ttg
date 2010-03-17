object SourceBaseDataModule: TSourceBaseDataModule
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 0
  Width = 0
  object kbmAulaTipo: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodAulaTipo'
        DataType = ftAutoInc
      end
      item
        Name = 'NomAulaTipo'
        Attributes = [faRequired]
        DataType = ftString
        Size = 25
      end
      item
        Name = 'AbrAulaTipo'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Cantidad'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmAulaTipoixAbrAulaTipo'
        Fields = 'AbrAulaTipo'
        Options = [ixUnique]
      end
      item
        Name = 'kbmAulaTipoixNomAulaTipo'
        Fields = 'NomAulaTipo'
        Options = [ixUnique]
      end
      item
        Name = 'kbmAulaTipoPrimaryKey'
        Fields = 'CodAulaTipo'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmAulaTipoBeforePost
    BeforeDelete = kbmAulaTipoBeforeDelete
    Left = 48
    Top = 48
    object kbmAulaTipoCodAulaTipo: TAutoIncField
      DisplayLabel = 'Código'
      FieldName = 'CodAulaTipo'
    end
    object kbmAulaTipoNomAulaTipo: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomAulaTipo'
      Required = True
      Size = 25
    end
    object kbmAulaTipoAbrAulaTipo: TStringField
      DisplayLabel = 'Abreviatura'
      FieldName = 'AbrAulaTipo'
      Required = True
      Size = 10
    end
    object kbmAulaTipoCantidad: TIntegerField
      FieldName = 'Cantidad'
      Required = True
    end
  end
  object dsAulaTipo: TDataSource
    DataSet = kbmAulaTipo
    Left = 56
    Top = 40
  end
  object kbmEspecializacion: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodEspecializacion'
        DataType = ftAutoInc
      end
      item
        Name = 'NomEspecializacion'
        Attributes = [faRequired]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AbrEspecializacion'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmEspecializacionixAbrEspecializacion'
        Fields = 'AbrEspecializacion'
        Options = [ixUnique]
      end
      item
        Name = 'kbmEspecializacionixNomEspecializacion'
        Fields = 'NomEspecializacion'
        Options = [ixUnique]
      end
      item
        Name = 'kbmEspecializacionPrimaryKey'
        Fields = 'CodEspecializacion'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmEspecializacionBeforePost
    BeforeDelete = kbmEspecializacionBeforeDelete
    Left = 144
    Top = 60
    object kbmEspecializacionCodEspecializacion: TAutoIncField
      DisplayLabel = 'Código'
      FieldName = 'CodEspecializacion'
    end
    object kbmEspecializacionNomEspecializacion: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomEspecializacion'
      Required = True
    end
    object kbmEspecializacionAbrEspecializacion: TStringField
      DisplayLabel = 'Abreviatura'
      FieldName = 'AbrEspecializacion'
      Required = True
      Size = 10
    end
  end
  object dsEspecializacion: TDataSource
    DataSet = kbmEspecializacion
    Left = 152
    Top = 52
  end
  object kbmDia: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodDia'
        DataType = ftAutoInc
      end
      item
        Name = 'NomDia'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmDiaixNomDia'
        Fields = 'NomDia'
        Options = [ixUnique]
      end
      item
        Name = 'kbmDiaPrimaryKey'
        Fields = 'CodDia'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmDiaBeforePost
    BeforeDelete = kbmDiaBeforeDelete
    Left = 240
    Top = 48
    object kbmDiaCodDia: TAutoIncField
      DisplayLabel = 'Código'
      FieldName = 'CodDia'
    end
    object kbmDiaNomDia: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomDia'
      Required = True
      Size = 10
    end
  end
  object dsDia: TDataSource
    DataSet = kbmDia
    Left = 248
    Top = 40
  end
  object kbmMateria: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodMateria'
        DataType = ftAutoInc
      end
      item
        Name = 'NomMateria'
        Attributes = [faRequired]
        DataType = ftString
        Size = 20
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmMateriaixNomMateria'
        Fields = 'NomMateria'
        Options = [ixUnique]
      end
      item
        Name = 'kbmMateriaPrimaryKey'
        Fields = 'CodMateria'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmMateriaBeforePost
    BeforeDelete = kbmMateriaBeforeDelete
    Left = 336
    Top = 60
    object kbmMateriaCodMateria: TAutoIncField
      DisplayLabel = 'Código'
      FieldName = 'CodMateria'
    end
    object kbmMateriaNomMateria: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomMateria'
      Required = True
    end
  end
  object dsMateria: TDataSource
    DataSet = kbmMateria
    Left = 344
    Top = 52
  end
  object kbmNivel: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodNivel'
        DataType = ftAutoInc
      end
      item
        Name = 'NomNivel'
        Attributes = [faRequired]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'AbrNivel'
        DataType = ftString
        Size = 5
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmNivelixAbrNivel'
        Fields = 'AbrNivel'
        Options = [ixUnique]
      end
      item
        Name = 'kbmNivelixNomNivel'
        Fields = 'NomNivel'
        Options = [ixUnique]
      end
      item
        Name = 'kbmNivelPrimaryKey'
        Fields = 'CodNivel'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmNivelBeforePost
    BeforeDelete = kbmNivelBeforeDelete
    Left = 432
    Top = 48
    object kbmNivelCodNivel: TAutoIncField
      DisplayLabel = 'Código'
      FieldName = 'CodNivel'
    end
    object kbmNivelNomNivel: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomNivel'
      Required = True
      Size = 15
    end
    object kbmNivelAbrNivel: TStringField
      DisplayLabel = 'Abreviatura'
      FieldName = 'AbrNivel'
      Size = 5
    end
  end
  object dsNivel: TDataSource
    DataSet = kbmNivel
    Left = 440
    Top = 40
  end
  object kbmHora: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodHora'
        DataType = ftAutoInc
      end
      item
        Name = 'NomHora'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Intervalo'
        Attributes = [faRequired]
        DataType = ftString
        Size = 21
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmHoraixIntervalo'
        Fields = 'Intervalo'
        Options = [ixUnique]
      end
      item
        Name = 'kbmHoraixNomHora'
        Fields = 'NomHora'
        Options = [ixUnique]
      end
      item
        Name = 'kbmHoraPrimaryKey'
        Fields = 'CodHora'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmHoraBeforePost
    BeforeDelete = kbmHoraBeforeDelete
    Left = 48
    Top = 144
    object kbmHoraCodHora: TAutoIncField
      DisplayLabel = 'Código'
      FieldName = 'CodHora'
    end
    object kbmHoraNomHora: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomHora'
      Required = True
      Size = 10
    end
    object kbmHoraIntervalo: TStringField
      FieldName = 'Intervalo'
      Required = True
      Size = 21
    end
  end
  object dsHora: TDataSource
    DataSet = kbmHora
    Left = 56
    Top = 136
  end
  object kbmHorario: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodHorario'
        DataType = ftAutoInc
      end
      item
        Name = 'MomentoInicial'
        Attributes = [faRequired]
        DataType = ftDateTime
      end
      item
        Name = 'MomentoFinal'
        Attributes = [faRequired]
        DataType = ftDateTime
      end
      item
        Name = 'Informe'
        DataType = ftMemo
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmHorarioixMomentoFinal'
        Fields = 'MomentoFinal'
      end
      item
        Name = 'kbmHorarioixMomentoInicial'
        Fields = 'MomentoInicial'
      end
      item
        Name = 'kbmHorarioPrimaryKey'
        Fields = 'CodHorario'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmHorarioBeforePost
    BeforeDelete = kbmHorarioBeforeDelete
    Left = 144
    Top = 156
    object kbmHorarioCodHorario: TAutoIncField
      DisplayLabel = 'Código'
      FieldName = 'CodHorario'
    end
    object kbmHorarioMomentoInicial: TDateTimeField
      DisplayLabel = 'Momento Inicial'
      FieldName = 'MomentoInicial'
      Required = True
    end
    object kbmHorarioMomentoFinal: TDateTimeField
      DisplayLabel = 'Momento Final'
      FieldName = 'MomentoFinal'
      Required = True
    end
    object kbmHorarioInforme: TMemoField
      FieldName = 'Informe'
      BlobType = ftMemo
    end
  end
  object dsHorario: TDataSource
    DataSet = kbmHorario
    Left = 152
    Top = 148
  end
  object kbmCurso: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodNivel'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodEspecializacion'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmCursoEspecializacionCurso'
        Fields = 'CodEspecializacion'
      end
      item
        Name = 'kbmCursoNivelCurso'
        Fields = 'CodNivel'
      end
      item
        Name = 'kbmCursoPrimaryKey'
        Fields = 'CodNivel;CodEspecializacion'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmCursoBeforePost
    BeforeDelete = kbmCursoBeforeDelete
    Left = 240
    Top = 144
    object kbmCursoCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
    end
    object kbmCursoCodEspecializacion: TIntegerField
      DisplayLabel = 'Especialización'
      FieldName = 'CodEspecializacion'
      Required = True
    end
  end
  object dsCurso: TDataSource
    DataSet = kbmCurso
    Left = 248
    Top = 136
  end
  object kbmParaleloId: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodParaleloId'
        DataType = ftAutoInc
      end
      item
        Name = 'NomParaleloId'
        Attributes = [faRequired]
        DataType = ftString
        Size = 5
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmParaleloIdixNomParaleloId'
        Fields = 'NomParaleloId'
        Options = [ixUnique]
      end
      item
        Name = 'kbmParaleloIdPrimaryKey'
        Fields = 'CodParaleloId'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmParaleloIdBeforePost
    BeforeDelete = kbmParaleloIdBeforeDelete
    Left = 336
    Top = 156
    object kbmParaleloIdCodParaleloId: TAutoIncField
      DisplayLabel = 'Código'
      FieldName = 'CodParaleloId'
    end
    object kbmParaleloIdNomParaleloId: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomParaleloId'
      Required = True
      Size = 5
    end
  end
  object dsParaleloId: TDataSource
    DataSet = kbmParaleloId
    Left = 344
    Top = 148
  end
  object kbmMateriaProhibicionTipo: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodMateProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NomMateProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ColMateProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ValMateProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftFloat
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmMateriaProhibicionTipoixNomMateProhibicionTipo'
        Fields = 'NomMateProhibicionTipo'
        Options = [ixUnique]
      end
      item
        Name = 'kbmMateriaProhibicionTipoPrimaryKey'
        Fields = 'CodMateProhibicionTipo'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmMateriaProhibicionTipoBeforePost
    BeforeDelete = kbmMateriaProhibicionTipoBeforeDelete
    Left = 432
    Top = 144
    object kbmMateriaProhibicionTipoCodMateProhibicionTipo: TIntegerField
      DisplayLabel = 'Código'
      FieldName = 'CodMateProhibicionTipo'
      Required = True
    end
    object kbmMateriaProhibicionTipoNomMateProhibicionTipo: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomMateProhibicionTipo'
      Required = True
      Size = 10
    end
    object kbmMateriaProhibicionTipoColMateProhibicionTipo: TIntegerField
      DisplayLabel = 'Color'
      FieldName = 'ColMateProhibicionTipo'
      Required = True
    end
    object kbmMateriaProhibicionTipoValMateProhibicionTipo: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'ValMateProhibicionTipo'
      Required = True
    end
  end
  object dsMateriaProhibicionTipo: TDataSource
    DataSet = kbmMateriaProhibicionTipo
    Left = 440
    Top = 136
  end
  object kbmPeriodo: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodDia'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodHora'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmPeriodoDiaPeriodo'
        Fields = 'CodDia'
      end
      item
        Name = 'kbmPeriodoHoraPeriodo'
        Fields = 'CodHora'
      end
      item
        Name = 'kbmPeriodoPrimaryKey'
        Fields = 'CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmPeriodoBeforePost
    BeforeDelete = kbmPeriodoBeforeDelete
    Left = 48
    Top = 240
    object kbmPeriodoCodDia: TIntegerField
      DisplayLabel = 'Día'
      FieldName = 'CodDia'
      Required = True
    end
    object kbmPeriodoCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
    end
  end
  object dsPeriodo: TDataSource
    DataSet = kbmPeriodo
    Left = 56
    Top = 232
  end
  object kbmParalelo: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodNivel'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodEspecializacion'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodParaleloId'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmParaleloCursoParalelo'
        Fields = 'CodNivel;CodEspecializacion'
      end
      item
        Name = 'kbmParaleloParaleloIdParalelo'
        Fields = 'CodParaleloId'
      end
      item
        Name = 'kbmParaleloPrimaryKey'
        Fields = 'CodNivel;CodEspecializacion;CodParaleloId'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmParaleloBeforePost
    BeforeDelete = kbmParaleloBeforeDelete
    Left = 144
    Top = 252
    object kbmParaleloCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
    end
    object kbmParaleloCodEspecializacion: TIntegerField
      DisplayLabel = 'Especialización'
      FieldName = 'CodEspecializacion'
      Required = True
    end
    object kbmParaleloCodParaleloId: TIntegerField
      DisplayLabel = 'Paralelo'
      FieldName = 'CodParaleloId'
      Required = True
    end
  end
  object dsParalelo: TDataSource
    DataSet = kbmParalelo
    Left = 152
    Top = 244
  end
  object kbmProfesor: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodProfesor'
        DataType = ftAutoInc
      end
      item
        Name = 'CedProfesor'
        Attributes = [faRequired]
        DataType = ftString
        Size = 11
      end
      item
        Name = 'ApeProfesor'
        Attributes = [faRequired]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'NomProfesor'
        Attributes = [faRequired]
        DataType = ftString
        Size = 15
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmProfesorixApeNomProfesor'
        Fields = 'ApeProfesor;NomProfesor'
        Options = [ixUnique]
      end
      item
        Name = 'kbmProfesorixNomApeProfesor'
        Fields = 'NomProfesor;ApeProfesor'
        Options = [ixUnique]
      end
      item
        Name = 'kbmProfesorPrimaryKey'
        Fields = 'CodProfesor'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmProfesorBeforePost
    BeforeDelete = kbmProfesorBeforeDelete
    Left = 240
    Top = 240
    object kbmProfesorCodProfesor: TAutoIncField
      DisplayLabel = 'Código'
      FieldName = 'CodProfesor'
    end
    object kbmProfesorCedProfesor: TStringField
      DisplayLabel = 'Cédula'
      FieldName = 'CedProfesor'
      Required = True
      Size = 11
    end
    object kbmProfesorApeProfesor: TStringField
      DisplayLabel = 'Apellido'
      FieldName = 'ApeProfesor'
      Required = True
      Size = 15
    end
    object kbmProfesorNomProfesor: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomProfesor'
      Required = True
      Size = 15
    end
  end
  object dsProfesor: TDataSource
    DataSet = kbmProfesor
    Left = 248
    Top = 232
  end
  object kbmMateriaProhibicion: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodMateria'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodDia'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodHora'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodMateProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmMateriaProhibicionMateriaMateriaProhibicion'
        Fields = 'CodMateria'
      end
      item
        Name = 'kbmMateriaProhibicionMateriaProhibicionTipoMateriaProhibicion'
        Fields = 'CodMateProhibicionTipo'
      end
      item
        Name = 'kbmMateriaProhibicionPeriodoMateriaProhibicion'
        Fields = 'CodDia;CodHora'
      end
      item
        Name = 'kbmMateriaProhibicionPrimaryKey'
        Fields = 'CodMateria;CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmMateriaProhibicionBeforePost
    Left = 336
    Top = 252
    object kbmMateriaProhibicionCodMateria: TIntegerField
      DisplayLabel = 'Materia'
      FieldName = 'CodMateria'
      Required = True
    end
    object kbmMateriaProhibicionCodDia: TIntegerField
      DisplayLabel = 'Día'
      FieldName = 'CodDia'
      Required = True
    end
    object kbmMateriaProhibicionCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
    end
    object kbmMateriaProhibicionCodMateProhibicionTipo: TIntegerField
      DisplayLabel = 'Tipo de Prohibición'
      FieldName = 'CodMateProhibicionTipo'
      Required = True
    end
  end
  object dsMateriaProhibicion: TDataSource
    DataSet = kbmMateriaProhibicion
    Left = 344
    Top = 244
  end
  object kbmDistributivo: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodMateria'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodNivel'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodEspecializacion'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodParaleloId'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodProfesor'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodAulaTipo'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Composicion'
        Attributes = [faRequired]
        DataType = ftString
        Size = 40
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmDistributivoAulaTipoDistributivo'
        Fields = 'CodAulaTipo'
      end
      item
        Name = 'kbmDistributivoMateriaDistributivo'
        Fields = 'CodMateria'
      end
      item
        Name = 'kbmDistributivoParaleloDistributivo'
        Fields = 'CodNivel;CodEspecializacion;CodParaleloId'
      end
      item
        Name = 'kbmDistributivoPrimaryKey'
        Fields = 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'kbmDistributivoProfesorDistributivo'
        Fields = 'CodProfesor'
      end>
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
    BeforePost = kbmDistributivoBeforePost
    BeforeDelete = kbmDistributivoBeforeDelete
    Left = 432
    Top = 240
    object kbmDistributivoCodMateria: TIntegerField
      DisplayLabel = 'Materia'
      FieldName = 'CodMateria'
      Required = True
    end
    object kbmDistributivoCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
    end
    object kbmDistributivoCodEspecializacion: TIntegerField
      DisplayLabel = 'Especialización'
      FieldName = 'CodEspecializacion'
      Required = True
    end
    object kbmDistributivoCodParaleloId: TIntegerField
      DisplayLabel = 'Paralelo'
      FieldName = 'CodParaleloId'
      Required = True
    end
    object kbmDistributivoCodProfesor: TIntegerField
      DisplayLabel = 'Profesor'
      FieldName = 'CodProfesor'
      Required = True
    end
    object kbmDistributivoCodAulaTipo: TIntegerField
      DisplayLabel = 'Tipo de Aula'
      FieldName = 'CodAulaTipo'
      Required = True
    end
    object kbmDistributivoComposicion: TStringField
      DisplayLabel = 'Composición'
      FieldName = 'Composicion'
      Required = True
      Size = 40
    end
  end
  object dsDistributivo: TDataSource
    DataSet = kbmDistributivo
    Left = 440
    Top = 232
  end
  object kbmHorarioDetalle: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodHorario'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodMateria'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodNivel'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodEspecializacion'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodParaleloId'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodDia'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodHora'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Sesion'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmHorarioDetalleDistributivoHorarioDetalle'
        Fields = 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId'
      end
      item
        Name = 'kbmHorarioDetalleHorarioDetalleCodMateria'
        Fields = 'CodMateria'
      end
      item
        Name = 'kbmHorarioDetalleHorarioHorarioDetalle'
        Fields = 'CodHorario'
      end
      item
        Name = 'kbmHorarioDetalleixRestriccionMateria'
        Fields = 
          'CodHorario;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodH' +
          'ora'
        Options = [ixUnique]
      end
      item
        Name = 'kbmHorarioDetallePeriodoHorarioDetalle'
        Fields = 'CodDia;CodHora'
      end
      item
        Name = 'kbmHorarioDetallePrimaryKey'
        Fields = 
          'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;' +
          'CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmHorarioDetalleBeforePost
    Left = 48
    Top = 336
    object kbmHorarioDetalleCodHorario: TIntegerField
      DisplayLabel = 'Horario'
      FieldName = 'CodHorario'
      Required = True
    end
    object kbmHorarioDetalleCodMateria: TIntegerField
      DisplayLabel = 'Materia'
      FieldName = 'CodMateria'
      Required = True
    end
    object kbmHorarioDetalleCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
    end
    object kbmHorarioDetalleCodEspecializacion: TIntegerField
      DisplayLabel = 'Especialización'
      FieldName = 'CodEspecializacion'
      Required = True
    end
    object kbmHorarioDetalleCodParaleloId: TIntegerField
      DisplayLabel = 'Paralelo'
      FieldName = 'CodParaleloId'
      Required = True
    end
    object kbmHorarioDetalleCodDia: TIntegerField
      DisplayLabel = 'Día'
      FieldName = 'CodDia'
      Required = True
    end
    object kbmHorarioDetalleCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
    end
    object kbmHorarioDetalleSesion: TIntegerField
      DisplayLabel = 'Sesión'
      FieldName = 'Sesion'
      Required = True
    end
  end
  object dsHorarioDetalle: TDataSource
    DataSet = kbmHorarioDetalle
    Left = 56
    Top = 328
  end
  object kbmProfesorProhibicionTipo: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodProfProhibicionTipo'
        DataType = ftAutoInc
      end
      item
        Name = 'NomProfProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ColProfProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ValProfProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftFloat
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmProfesorProhibicionTipoixNomProfProhibicionTipo'
        Fields = 'NomProfProhibicionTipo'
        Options = [ixUnique]
      end
      item
        Name = 'kbmProfesorProhibicionTipoPrimaryKey'
        Fields = 'CodProfProhibicionTipo'
        Options = [ixPrimary, ixUnique]
      end>
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
    BeforePost = kbmProfesorProhibicionTipoBeforePost
    BeforeDelete = kbmProfesorProhibicionTipoBeforeDelete
    Left = 144
    Top = 348
    object kbmProfesorProhibicionTipoCodProfProhibicionTipo: TAutoIncField
      DisplayLabel = 'Código'
      FieldName = 'CodProfProhibicionTipo'
    end
    object kbmProfesorProhibicionTipoNomProfProhibicionTipo: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomProfProhibicionTipo'
      Required = True
      Size = 10
    end
    object kbmProfesorProhibicionTipoColProfProhibicionTipo: TIntegerField
      DisplayLabel = 'Color'
      FieldName = 'ColProfProhibicionTipo'
      Required = True
    end
    object kbmProfesorProhibicionTipoValProfProhibicionTipo: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'ValProfProhibicionTipo'
      Required = True
    end
  end
  object dsProfesorProhibicionTipo: TDataSource
    DataSet = kbmProfesorProhibicionTipo
    Left = 152
    Top = 340
  end
  object kbmProfesorProhibicion: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodProfesor'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodDia'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodHora'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodProfProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmProfesorProhibicionPeriodoProfesorProhibicion'
        Fields = 'CodDia;CodHora'
      end
      item
        Name = 'kbmProfesorProhibicionPrimaryKey'
        Fields = 'CodProfesor;CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'kbmProfesorProhibicionProfesorProfesorProhibicion'
        Fields = 'CodProfesor'
      end
      item
        Name = 'kbmProfesorProhibicionProfesorProhibicionTipoProfesorProhibicion'
        Fields = 'CodProfProhibicionTipo'
      end>
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
    BeforePost = kbmProfesorProhibicionBeforePost
    Left = 240
    Top = 336
    object kbmProfesorProhibicionCodProfesor: TIntegerField
      DisplayLabel = 'Profesor'
      FieldName = 'CodProfesor'
      Required = True
    end
    object kbmProfesorProhibicionCodDia: TIntegerField
      DisplayLabel = 'Día'
      FieldName = 'CodDia'
      Required = True
    end
    object kbmProfesorProhibicionCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
    end
    object kbmProfesorProhibicionCodProfProhibicionTipo: TIntegerField
      DisplayLabel = 'Tipo de prohibición'
      FieldName = 'CodProfProhibicionTipo'
      Required = True
    end
  end
  object dsProfesorProhibicion: TDataSource
    DataSet = kbmProfesorProhibicion
    Left = 248
    Top = 328
  end
end
