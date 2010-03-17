inherited ParaleloForm: TParaleloForm
  Left = 286
  Top = 216
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited tb97Show: TToolBar
    inherited DBNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited Panel1: TPanel
    object Splitter1: TSplitter [0]
      Left = 350
      Top = 1
      Width = 3
      Height = 253
      Cursor = crHSplit
      Align = alRight
    end
    inherited DBGrid: TDBGrid
      Width = 349
      Hint = 'Cursos|Cursos disponibles'
      ParentShowHint = False
      ShowHint = True
    end
    object DBCheckListBox: TDBCheckListBox
      Left = 353
      Top = 1
      Width = 148
      Height = 253
      Hint = 'Paralelos|Lista de Paralelos'
      Align = alRight
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      DataSource = DataSourceDetail
      ReadOnly = False
      DataField = 'CodParaleloId'
      ListSource = DataSourceList
      ListField = 'NomParaleloId'
      KeyField = 'CodParaleloId'
    end
  end
  inherited ImageList: TImageList
    Left = 64
  end
  object DataSourceList: TDataSource
    DataSet = SourceDataModule.kbmParaleloId
    Left = 64
    Top = 116
  end
  object DataSourceDetail: TDataSource
    Left = 36
    Top = 116
  end
  object kbmParalelo: TkbmMemTable
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
      end
      item
        Name = 'AbrNivel'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'AbrEspecializacion'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'NomParaleloId'
        DataType = ftString
        Size = 5
      end>
    EnableIndexes = False
    AutoReposition = True
    IndexFieldNames = 'CodNivel;CodEspecializacion'
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
    VersioningMode = mtvmAllSinceCheckPoint
    FilterOptions = []
    MasterFields = 'CodNivel;CodEspecializacion'
    Version = '2.49'
    Left = 92
    Top = 88
    object kbmParaleloCodNivel: TIntegerField
      FieldName = 'CodNivel'
      Required = True
      Visible = False
    end
    object kbmParaleloCodEspecializacion: TIntegerField
      FieldName = 'CodEspecializacion'
      Required = True
      Visible = False
    end
    object kbmParaleloCodParaleloId: TIntegerField
      FieldName = 'CodParaleloId'
      Required = True
      Visible = False
    end
    object kbmParaleloAbrNivel: TStringField
      DisplayLabel = 'Nivel'
      FieldKind = fkLookup
      FieldName = 'AbrNivel'
      LookupDataSet = SourceDataModule.kbmNivel
      LookupKeyFields = 'CodNivel'
      LookupResultField = 'AbrNivel'
      KeyFields = 'CodNivel'
      Size = 5
      Lookup = True
    end
    object kbmParaleloAbrEspecializacion: TStringField
      DisplayLabel = 'Especializacion'
      FieldKind = fkLookup
      FieldName = 'AbrEspecializacion'
      LookupDataSet = SourceDataModule.kbmEspecializacion
      LookupKeyFields = 'CodEspecializacion'
      LookupResultField = 'AbrEspecializacion'
      KeyFields = 'CodEspecializacion'
      Size = 10
      Lookup = True
    end
    object kbmParaleloNomParaleloId: TStringField
      DisplayLabel = 'Paralelo'
      FieldKind = fkLookup
      FieldName = 'NomParaleloId'
      LookupDataSet = SourceDataModule.kbmParaleloId
      LookupKeyFields = 'CodParaleloId'
      LookupResultField = 'NomParaleloId'
      KeyFields = 'CodParaleloId'
      Size = 5
      Lookup = True
    end
  end
end
