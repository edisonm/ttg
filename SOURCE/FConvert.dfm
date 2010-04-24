object ConvertForm: TConvertForm
  Left = 382
  Top = 120
  Width = 445
  Height = 379
  Caption = 'Convertidor de formatos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 33
    Height = 13
    Caption = 'Fuente'
  end
  object Label2: TLabel
    Left = 32
    Top = 40
    Width = 36
    Height = 13
    Caption = 'Destino'
  end
  object feSource: TFilenameEdit
    Left = 80
    Top = 8
    Width = 351
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    NumGlyphs = 1
    TabOrder = 0
  end
  object feDestination: TFilenameEdit
    Left = 80
    Top = 32
    Width = 351
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    NumGlyphs = 1
    TabOrder = 1
  end
  object btnConvertir: TButton
    Left = 352
    Top = 322
    Width = 80
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Convertir'
    TabOrder = 2
    OnClick = btnConvertirClick
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 64
    Width = 423
    Height = 252
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object cbxDataSet: TComboBox
    Left = 8
    Top = 323
    Width = 337
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 4
    OnChange = cbxDataSetChange
  end
  object FormStorage1: TFormStorage
    StoredProps.Strings = (
      'feSource.FileName'
      'feDestination.FileName')
    StoredValues = <>
    Left = 96
    Top = 56
  end
  object TbAsignatura: TkbmMemTable
    Active = True
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
    IndexFieldNames = 'CodMateria;CodNivel;CodEspecializacion'
    IndexName = 'TbAsignaturaPrimaryKey'
    IndexDefs = <
      item
        Name = 'TbAsignaturaAulaTipo'
        Fields = 'CodAulaTipo'
      end
      item
        Name = 'TbAsignaturaCargaAcademicaNivel'
        Fields = 'CodNivel'
      end
      item
        Name = 'TbAsignaturaMateria'
        Fields = 'CodMateria'
      end
      item
        Name = 'TbAsignaturaPrimaryKey'
        Fields = 'CodMateria;CodNivel;CodEspecializacion'
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
    EnableVersioning = False
    VersioningMode = mtvmAllSinceCheckPoint
    FilterOptions = []
    Version = '2.49'
    Left = 4
    Top = 6
    object TbAsignaturaCodMateria: TIntegerField
      DisplayLabel = 'Materia'
      FieldName = 'CodMateria'
      Required = True
    end
    object TbAsignaturaCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
    end
    object TbAsignaturaCodEspecializacion: TIntegerField
      DisplayLabel = 'Especialización'
      FieldName = 'CodEspecializacion'
      Required = True
    end
    object TbAsignaturaCodAulaTipo: TIntegerField
      DisplayLabel = 'Tipo de Aula'
      FieldName = 'CodAulaTipo'
      Required = True
    end
    object TbAsignaturaComposicion: TStringField
      DisplayLabel = 'Composición'
      FieldName = 'Composicion'
      Required = True
      Size = 40
    end
  end
end
