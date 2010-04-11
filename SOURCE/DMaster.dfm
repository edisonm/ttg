object MasterDataModule: TMasterDataModule
  OldCreateOrder = False
  Left = 222
  Top = 122
  Height = 404
  Width = 748
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
    Top = 157
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
  object strHolderShowAulaTipo: TStrHolder
    Capacity = 8
    Macros = <>
    Left = 58
    Top = 11
    InternalVer = 1
    StrData = (
      ''
      
        '4e6976656c5f506172616c656c6f3d4162724e6976656c3b4e6f6d506172616c' +
        '656c6f4964'
      
        '4e6976656c5f506172616c656c6f5f4d6174657269613d4162724e6976656c3b' +
        '4e6f6d506172616c656c6f49643b4e6f6d4d617465726961'
      
        '4e6976656c5f506172616c656c6f5f457370656369616c697a6163696f6e3d41' +
        '62724e6976656c3b4e6f6d506172616c656c6f49643b41627245737065636961' +
        '6c697a6163696f6e'
      
        '4e6976656c5f506172616c656c6f5f457370656369616c697a6163696f6e5f4d' +
        '6174657269613d4162724e6976656c3b4e6f6d506172616c656c6f49643b4162' +
        '72457370656369616c697a6163696f6e3b4e6f6d4d617465726961'
      
        '4e6976656c5f457370656369616c697a6163696f6e5f506172616c656c6f3d41' +
        '62724e6976656c3b416272457370656369616c697a6163696f6e3b4e6f6d5061' +
        '72616c656c6f4964'
      
        '4e6976656c5f457370656369616c697a6163696f6e5f506172616c656c6f5f4d' +
        '6174657269613d4162724e6976656c3b416272457370656369616c697a616369' +
        '6f6e3b4e6f6d506172616c656c6f49643b4e6f6d4d617465726961'
      '4d6174657269613d4e6f6d4d617465726961')
  end
  object strHolderShowProfesor: TStrHolder
    Capacity = 8
    Macros = <>
    Left = 58
    Top = 59
    InternalVer = 1
    StrData = (
      ''
      
        '4e6976656c5f506172616c656c6f3d4162724e6976656c3b4e6f6d506172616c' +
        '656c6f4964'
      
        '4e6976656c5f506172616c656c6f5f4d6174657269613d4162724e6976656c3b' +
        '4e6f6d506172616c656c6f49643b4e6f6d4d617465726961'
      
        '4e6976656c5f506172616c656c6f5f457370656369616c697a6163696f6e3d41' +
        '62724e6976656c3b4e6f6d506172616c656c6f49643b41627245737065636961' +
        '6c697a6163696f6e'
      
        '4e6976656c5f506172616c656c6f5f457370656369616c697a6163696f6e5f4d' +
        '6174657269613d4162724e6976656c3b4e6f6d506172616c656c6f49643b4162' +
        '72457370656369616c697a6163696f6e3b4e6f6d4d617465726961'
      
        '4e6976656c5f457370656369616c697a6163696f6e5f506172616c656c6f3d41' +
        '62724e6976656c3b416272457370656369616c697a6163696f6e3b4e6f6d5061' +
        '72616c656c6f4964'
      
        '4e6976656c5f457370656369616c697a6163696f6e5f506172616c656c6f5f4d' +
        '6174657269613d4162724e6976656c3b416272457370656369616c697a616369' +
        '6f6e3b4e6f6d506172616c656c6f49643b4e6f6d4d617465726961'
      '4d6174657269613d4e6f6d4d617465726961')
  end
  object strHolderShowParalelo: TStrHolder
    Capacity = 4
    Macros = <>
    Left = 58
    Top = 107
    InternalVer = 1
    StrData = (
      ''
      '4d6174657269613d4e6f6d4d617465726961'
      '50726f6665736f723d4170654e6f6d50726f6665736f72'
      
        '4d6174657269615f50726f6665736f723d4e6f6d4d6174657269613b4170654e' +
        '6f6d50726f6665736f72'
      '20')
  end
end
