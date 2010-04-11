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
  inherited pnlStatus: TPanel
    inherited SLRecordNo: TDBStatusLabel
      Left = 481
      Width = 20
    end
  end
  inherited Panel1: TPanel
    inherited DBGrid: TRxDBGrid
      Width = 346
      Hint = 'Cursos|Cursos disponibles'
      ParentShowHint = False
      ShowHint = True
    end
    inherited Splitter1: TRxSplitter
      Left = 350
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
    object Splitter: TRxSplitter
      Left = 347
      Top = 1
      Width = 3
      Height = 253
      ControlFirst = DBCheckListBox
      Align = alRight
    end
  end
  inherited FormStorage: TFormStorage
    Active = True
    IniSection = '\Software\SGHC1\SEParalelo'
    StoredProps.Strings = (
      'tb97Show.DockedTo'
      'tb97Show.DockPos'
      'tb97Show.DockRow'
      'DBCheckListBox.Width')
  end
  inherited DataSource: TDataSource
    DataSet = SourceDataModule.TbCurso
  end
  object DataSourceList: TDataSource
    DataSet = SourceDataModule.TbParaleloId
    Left = 64
    Top = 116
  end
  object DataSourceDetail: TDataSource
    Left = 36
    Top = 116
  end
  object TbParalelo: TkbmMemTable
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
        Name = 'TbParaleloCursoParalelo'
        Fields = 'CodNivel;CodEspecializacion'
      end
      item
        Name = 'TbParaleloParaleloIdParalelo'
        Fields = 'CodParaleloId'
      end
      item
        Name = 'TbParaleloPrimaryKey'
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
    object TbParaleloCodNivel: TIntegerField
      FieldName = 'CodNivel'
      Required = True
      Visible = False
    end
    object TbParaleloCodEspecializacion: TIntegerField
      FieldName = 'CodEspecializacion'
      Required = True
      Visible = False
    end
    object TbParaleloCodParaleloId: TIntegerField
      FieldName = 'CodParaleloId'
      Required = True
      Visible = False
    end
    object TbParaleloAbrNivel: TStringField
      DisplayLabel = 'Nivel'
      FieldKind = fkLookup
      FieldName = 'AbrNivel'
      LookupDataSet = SourceDataModule.TbNivel
      LookupKeyFields = 'CodNivel'
      LookupResultField = 'AbrNivel'
      KeyFields = 'CodNivel'
      Size = 5
      Lookup = True
    end
    object TbParaleloAbrEspecializacion: TStringField
      DisplayLabel = 'Especializacion'
      FieldKind = fkLookup
      FieldName = 'AbrEspecializacion'
      LookupDataSet = SourceDataModule.TbEspecializacion
      LookupKeyFields = 'CodEspecializacion'
      LookupResultField = 'AbrEspecializacion'
      KeyFields = 'CodEspecializacion'
      Size = 10
      Lookup = True
    end
    object TbParaleloNomParaleloId: TStringField
      DisplayLabel = 'Paralelo'
      FieldKind = fkLookup
      FieldName = 'NomParaleloId'
      LookupDataSet = SourceDataModule.TbParaleloId
      LookupKeyFields = 'CodParaleloId'
      LookupResultField = 'NomParaleloId'
      KeyFields = 'CodParaleloId'
      Size = 5
      Lookup = True
    end
  end
end
