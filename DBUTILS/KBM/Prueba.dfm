object DMPrueba: TDMPrueba
  OldCreateOrder = True
  Height = 0
  Width = 0
  object kbmAulaTipo: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
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
    object tbmAulaTipoCodAulaTipo: TIntegerField
      FieldName = 'CodAulaTipo'
      Required = True
    end
    object tbmAulaTipoNomAulaTipo: TStringField
      FieldName = 'NomAulaTipo'
      Required = True
      Size = 25
    end
    object tbmAulaTipoCantidad: TIntegerField
      FieldName = 'Cantidad'
      Required = True
    end
  end
  object dsAulaTipo: TDataSource
    DataSet = kbmAulaTipo
    Left = 56
    Top = 40
  end
  object kbmCurso: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmCursoNomCurso'
        Fields = 'NomCurso'
        Options = [ixUnique]
      end
      item
        Name = 'kbmCursoPrimaryKey'
        Fields = 'CodCurso'
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
    Left = 144
    Top = 60
    object tbmCursoCodCurso: TIntegerField
      FieldName = 'CodCurso'
      Required = True
    end
    object tbmCursoNomCurso: TStringField
      FieldName = 'NomCurso'
      Required = True
      Size = 25
    end
  end
  object dsCurso: TDataSource
    DataSet = kbmCurso
    Left = 152
    Top = 52
  end
  object kbmDia: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
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
    object tbmDiaCodDia: TIntegerField
      FieldName = 'CodDia'
      Required = True
    end
    object tbmDiaNomDia: TStringField
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
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
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
    object tbmMateriaCodMateria: TIntegerField
      FieldName = 'CodMateria'
      Required = True
    end
    object tbmMateriaNomMateria: TStringField
      FieldName = 'NomMateria'
      Required = True
    end
  end
  object dsMateria: TDataSource
    DataSet = kbmMateria
    Left = 344
    Top = 52
  end
  object kbmParaleloId: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
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
    Left = 432
    Top = 48
    object tbmParaleloIdCodParaleloId: TIntegerField
      FieldName = 'CodParaleloId'
      Required = True
    end
    object tbmParaleloIdNomParaleloId: TStringField
      FieldName = 'NomParaleloId'
      Required = True
      Size = 5
    end
  end
  object dsParaleloId: TDataSource
    DataSet = kbmParaleloId
    Left = 440
    Top = 40
  end
  object kbmParalelo: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmParaleloCursoParalelo'
        Fields = 'CodCurso'
      end
      item
        Name = 'kbmParaleloParaleloIdParalelo'
        Fields = 'CodParaleloId'
      end
      item
        Name = 'kbmParaleloPrimaryKey'
        Fields = 'CodCurso;CodParaleloId'
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
    Left = 48
    Top = 144
    object tbmParaleloCodCurso: TIntegerField
      FieldName = 'CodCurso'
      Required = True
    end
    object tbmParaleloCodParaleloId: TIntegerField
      FieldName = 'CodParaleloId'
      Required = True
    end
  end
  object dsParalelo: TDataSource
    DataSet = kbmParalelo
    Left = 56
    Top = 136
  end
  object kbmHora: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
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
    Left = 144
    Top = 156
    object tbmHoraCodHora: TIntegerField
      FieldName = 'CodHora'
      Required = True
    end
    object tbmHoraNomHora: TStringField
      FieldName = 'NomHora'
      Required = True
      Size = 10
    end
  end
  object dsHora: TDataSource
    DataSet = kbmHora
    Left = 152
    Top = 148
  end
  object kbmHorario: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
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
    Left = 240
    Top = 144
    object tbmHorarioCodHorario: TIntegerField
      FieldName = 'CodHorario'
      Required = True
    end
    object tbmHorarioMomentoInicial: TDateField
      FieldName = 'MomentoInicial'
      Required = True
    end
    object tbmHorarioMomentoFinal: TDateField
      FieldName = 'MomentoFinal'
      Required = True
    end
    object tbmHorarioInforme: TMemoField
      FieldName = 'Informe'
      BlobType = ftMemo
    end
  end
  object dsHorario: TDataSource
    DataSet = kbmHorario
    Left = 248
    Top = 136
  end
  object kbmPeriodo: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmPeriodoDiaHorarioLaborable'
        Fields = 'CodDia'
      end
      item
        Name = 'kbmPeriodoHoraHorarioLaborable'
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
    Left = 336
    Top = 156
    object tbmPeriodoCodDia: TIntegerField
      FieldName = 'CodDia'
      Required = True
    end
    object tbmPeriodoCodHora: TIntegerField
      FieldName = 'CodHora'
      Required = True
    end
  end
  object dsPeriodo: TDataSource
    DataSet = kbmPeriodo
    Left = 344
    Top = 148
  end
  object kbmDistributivo: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmDistributivoAulaTipoCargaAcademica'
        Fields = 'CodAulaTipo'
      end
      item
        Name = 'kbmDistributivoMateriaCargaAcademica'
        Fields = 'CodMateria'
      end
      item
        Name = 'kbmDistributivoParaleloCargaAcademica'
        Fields = 'CodCurso;CodParaleloId'
      end
      item
        Name = 'kbmDistributivoPrimaryKey'
        Fields = 'CodMateria;CodCurso;CodParaleloId'
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
    BeforePost = kbmDistributivoBeforePost
    BeforeDelete = kbmDistributivoBeforeDelete
    Left = 432
    Top = 144
    object tbmDistributivoCodMateria: TIntegerField
      FieldName = 'CodMateria'
      Required = True
    end
    object tbmDistributivoCodCurso: TIntegerField
      FieldName = 'CodCurso'
      Required = True
    end
    object tbmDistributivoCodParaleloId: TIntegerField
      FieldName = 'CodParaleloId'
      Required = True
    end
    object tbmDistributivoCodAulaTipo: TIntegerField
      DefaultExpression = '0'
      FieldName = 'CodAulaTipo'
    end
    object tbmDistributivoComposicion: TStringField
      FieldName = 'Composicion'
      Required = True
      Size = 50
    end
  end
  object dsDistributivo: TDataSource
    DataSet = kbmDistributivo
    Left = 440
    Top = 136
  end
  object kbmMateriaProhibicionTipo: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
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
    Left = 48
    Top = 240
    object tbmMateriaProhibicionTipoCodMateProhibicionTipo: TIntegerField
      FieldName = 'CodMateProhibicionTipo'
      Required = True
    end
    object tbmMateriaProhibicionTipoNomMateProhibicionTipo: TStringField
      FieldName = 'NomMateProhibicionTipo'
      Required = True
      Size = 10
    end
    object tbmMateriaProhibicionTipoColMateProhibicionTipo: TIntegerField
      FieldName = 'ColMateProhibicionTipo'
      Required = True
    end
    object tbmMateriaProhibicionTipoValMateProhibicionTipo: TFloatField
      FieldName = 'ValMateProhibicionTipo'
      Required = True
    end
  end
  object dsMateriaProhibicionTipo: TDataSource
    DataSet = kbmMateriaProhibicionTipo
    Left = 56
    Top = 232
  end
  object kbmMateriaProhibicion: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmMateriaProhibicionHorarioLaborableMateriaProhibicion'
        Fields = 'CodDia;CodHora'
      end
      item
        Name = 'kbmMateriaProhibicionMateriaMateriaProhibicion'
        Fields = 'CodMateria'
      end
      item
        Name = 'kbmMateriaProhibicionMateriaProhibicionTipoMateriaProhibicion'
        Fields = 'CodMateProhibicionTipo'
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
    Left = 144
    Top = 252
    object tbmMateriaProhibicionCodMateria: TIntegerField
      FieldName = 'CodMateria'
      Required = True
    end
    object tbmMateriaProhibicionCodDia: TIntegerField
      FieldName = 'CodDia'
      Required = True
    end
    object tbmMateriaProhibicionCodHora: TIntegerField
      FieldName = 'CodHora'
      Required = True
    end
    object tbmMateriaProhibicionCodMateProhibicionTipo: TIntegerField
      FieldName = 'CodMateProhibicionTipo'
      Required = True
    end
  end
  object dsMateriaProhibicion: TDataSource
    DataSet = kbmMateriaProhibicion
    Left = 152
    Top = 244
  end
  object kbmDistributivoVinculo: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmDistributivoVinculoCodCurso'
        Fields = 'CodCurso1'
      end
      item
        Name = 'kbmDistributivoVinculoCodCurso1'
        Fields = 'CodCurso2'
      end
      item
        Name = 'kbmDistributivoVinculoDistributivoVinculo'
        Fields = 'CodMateria1;CodCurso1;CodParaleloId1'
      end
      item
        Name = 'kbmDistributivoVinculoDistributivoVinculo1'
        Fields = 'CodMateria2;CodCurso2;CodParaleloId2'
      end
      item
        Name = 'kbmDistributivoVinculoPrimaryKey'
        Fields = 
          'CodMateria1;CodCurso1;CodParaleloId1;CodMateria2;CodCurso2;CodPa' +
          'raleloId2'
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
    BeforePost = kbmDistributivoVinculoBeforePost
    Left = 240
    Top = 240
    object tbmDistributivoVinculoCodMateria1: TIntegerField
      FieldName = 'CodMateria1'
      Required = True
    end
    object tbmDistributivoVinculoCodCurso1: TIntegerField
      FieldName = 'CodCurso1'
      Required = True
    end
    object tbmDistributivoVinculoCodParaleloId1: TIntegerField
      FieldName = 'CodParaleloId1'
      Required = True
    end
    object tbmDistributivoVinculoCodMateria2: TIntegerField
      FieldName = 'CodMateria2'
      Required = True
    end
    object tbmDistributivoVinculoCodCurso2: TIntegerField
      FieldName = 'CodCurso2'
      Required = True
    end
    object tbmDistributivoVinculoCodParaleloId2: TIntegerField
      FieldName = 'CodParaleloId2'
      Required = True
    end
  end
  object dsDistributivoVinculo: TDataSource
    DataSet = kbmDistributivoVinculo
    Left = 248
    Top = 232
  end
  object kbmProfesor: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
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
    Left = 336
    Top = 252
    object tbmProfesorCodProfesor: TIntegerField
      FieldName = 'CodProfesor'
      Required = True
    end
    object tbmProfesorApeProfesor: TStringField
      FieldName = 'ApeProfesor'
      Required = True
      Size = 15
    end
    object tbmProfesorNomProfesor: TStringField
      FieldName = 'NomProfesor'
      Required = True
      Size = 15
    end
  end
  object dsProfesor: TDataSource
    DataSet = kbmProfesor
    Left = 344
    Top = 244
  end
  object kbmParaleloProhibicionTipo: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmParaleloProhibicionTipoixNomMateProhibicionTipo'
        Fields = 'NomParaProhibicionTipo'
        Options = [ixUnique]
      end
      item
        Name = 'kbmParaleloProhibicionTipoPrimaryKey'
        Fields = 'CodParaProhibicionTipo'
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
    BeforePost = kbmParaleloProhibicionTipoBeforePost
    BeforeDelete = kbmParaleloProhibicionTipoBeforeDelete
    Left = 432
    Top = 240
    object tbmParaleloProhibicionTipoCodParaProhibicionTipo: TIntegerField
      FieldName = 'CodParaProhibicionTipo'
      Required = True
    end
    object tbmParaleloProhibicionTipoNomParaProhibicionTipo: TStringField
      FieldName = 'NomParaProhibicionTipo'
      Required = True
      Size = 10
    end
    object tbmParaleloProhibicionTipoColParaProhibicionTipo: TIntegerField
      FieldName = 'ColParaProhibicionTipo'
      Required = True
    end
    object tbmParaleloProhibicionTipoValParaProhibicionTipo: TFloatField
      FieldName = 'ValParaProhibicionTipo'
      Required = True
    end
  end
  object dsParaleloProhibicionTipo: TDataSource
    DataSet = kbmParaleloProhibicionTipo
    Left = 440
    Top = 232
  end
  object kbmParaleloProhibicion: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmParaleloProhibicionCodParaleloId'
        Fields = 'CodParaleloId'
      end
      item
        Name = 'kbmParaleloProhibicionHorarioLaborableParaleloProhibicion'
        Fields = 'CodDia;CodHora'
      end
      item
        Name = 'kbmParaleloProhibicionParaleloParaleloProhibicion'
        Fields = 'CodCurso;CodParaleloId'
      end
      item
        Name = 'kbmParaleloProhibicionParaleloProhibicionTipoParaleloProhibicion'
        Fields = 'CodParaProhibicionTipo'
      end
      item
        Name = 'kbmParaleloProhibicionPrimaryKey'
        Fields = 'CodCurso;CodParaleloId;CodDia;CodHora'
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
    BeforePost = kbmParaleloProhibicionBeforePost
    Left = 48
    Top = 336
    object tbmParaleloProhibicionCodCurso: TIntegerField
      FieldName = 'CodCurso'
      Required = True
    end
    object tbmParaleloProhibicionCodParaleloId: TIntegerField
      DefaultExpression = '0'
      FieldName = 'CodParaleloId'
    end
    object tbmParaleloProhibicionCodDia: TIntegerField
      FieldName = 'CodDia'
      Required = True
    end
    object tbmParaleloProhibicionCodHora: TIntegerField
      FieldName = 'CodHora'
      Required = True
    end
    object tbmParaleloProhibicionCodParaProhibicionTipo: TIntegerField
      FieldName = 'CodParaProhibicionTipo'
      Required = True
    end
  end
  object dsParaleloProhibicion: TDataSource
    DataSet = kbmParaleloProhibicion
    Left = 56
    Top = 328
  end
  object kbmHorarioDetalle: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmHorarioDetalleCargaAcademicaHorarioDetalle'
        Fields = 'CodMateria;CodCurso;CodParaleloId'
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
        Name = 'kbmHorarioDetalleHorarioLaborableHorarioDetalle'
        Fields = 'CodDia;CodHora'
      end
      item
        Name = 'kbmHorarioDetallePrimaryKey'
        Fields = 'CodHorario;CodCurso;CodParaleloId;CodDia;CodHora'
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
    Left = 144
    Top = 348
    object tbmHorarioDetalleCodHorario: TIntegerField
      FieldName = 'CodHorario'
      Required = True
    end
    object tbmHorarioDetalleCodCurso: TIntegerField
      FieldName = 'CodCurso'
      Required = True
    end
    object tbmHorarioDetalleCodParaleloId: TIntegerField
      FieldName = 'CodParaleloId'
      Required = True
    end
    object tbmHorarioDetalleCodDia: TIntegerField
      FieldName = 'CodDia'
      Required = True
    end
    object tbmHorarioDetalleCodHora: TIntegerField
      FieldName = 'CodHora'
      Required = True
    end
    object tbmHorarioDetalleCodMateria: TIntegerField
      FieldName = 'CodMateria'
      Required = True
    end
    object tbmHorarioDetalleSesion: TIntegerField
      FieldName = 'Sesion'
      Required = True
    end
  end
  object dsHorarioDetalle: TDataSource
    DataSet = kbmHorarioDetalle
    Left = 152
    Top = 340
  end
  object kbmDistributivoProfesor: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmDistributivoProfesorDistributivoDistributivoProfesor'
        Fields = 'CodMateria;CodCurso;CodParaleloId'
      end
      item
        Name = 'kbmDistributivoProfesorPrimaryKey'
        Fields = 'CodMateria;CodCurso;CodParaleloId;CodProfesor'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'kbmDistributivoProfesorProfesorDistributivoProfesor'
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
    BeforePost = kbmDistributivoProfesorBeforePost
    Left = 240
    Top = 336
    object tbmDistributivoProfesorCodMateria: TIntegerField
      FieldName = 'CodMateria'
      Required = True
    end
    object tbmDistributivoProfesorCodCurso: TIntegerField
      FieldName = 'CodCurso'
      Required = True
    end
    object tbmDistributivoProfesorCodParaleloId: TIntegerField
      FieldName = 'CodParaleloId'
      Required = True
    end
    object tbmDistributivoProfesorCodProfesor: TIntegerField
      FieldName = 'CodProfesor'
      Required = True
    end
  end
  object dsDistributivoProfesor: TDataSource
    DataSet = kbmDistributivoProfesor
    Left = 248
    Top = 328
  end
  object kbmProfesorProhibicionTipo: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
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
    Left = 336
    Top = 348
    object tbmProfesorProhibicionTipoCodProfProhibicionTipo: TIntegerField
      FieldName = 'CodProfProhibicionTipo'
      Required = True
    end
    object tbmProfesorProhibicionTipoNomProfProhibicionTipo: TStringField
      FieldName = 'NomProfProhibicionTipo'
      Required = True
      Size = 10
    end
    object tbmProfesorProhibicionTipoColProfProhibicionTipo: TIntegerField
      FieldName = 'ColProfProhibicionTipo'
      Required = True
    end
    object tbmProfesorProhibicionTipoValProfProhibicionTipo: TFloatField
      FieldName = 'ValProfProhibicionTipo'
      Required = True
    end
  end
  object dsProfesorProhibicionTipo: TDataSource
    DataSet = kbmProfesorProhibicionTipo
    Left = 344
    Top = 340
  end
  object kbmProfesorProhibicion: TkbmMemTable
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <>
    EnableIndexes = True
    AutoReposition = False
    IndexDefs = <
      item
        Name = 'kbmProfesorProhibicionHorarioLaborableProfesorProhibicion'
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
    Left = 432
    Top = 336
    object tbmProfesorProhibicionCodProfesor: TIntegerField
      FieldName = 'CodProfesor'
      Required = True
    end
    object tbmProfesorProhibicionCodDia: TIntegerField
      FieldName = 'CodDia'
      Required = True
    end
    object tbmProfesorProhibicionCodHora: TIntegerField
      FieldName = 'CodHora'
      Required = True
    end
    object tbmProfesorProhibicionCodProfProhibicionTipo: TIntegerField
      FieldName = 'CodProfProhibicionTipo'
      Required = True
    end
  end
  object dsProfesorProhibicion: TDataSource
    DataSet = kbmProfesorProhibicion
    Left = 440
    Top = 328
  end
end
