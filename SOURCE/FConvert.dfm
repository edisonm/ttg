object ConvertForm: TConvertForm
  Left = 317
  Top = 41
  Width = 445
  Height = 379
  Caption = 'Convertidor de formatos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
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
    Left = 357
    Top = 322
    Width = 75
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
    Width = 336
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
  object kbmAsignatura: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = 0
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
    IndexName = 'kbmAsignaturaPrimaryKey'
    IndexDefs = <
      item
        Name = 'kbmAsignaturaAulaTipo'
        Fields = 'CodAulaTipo'
      end
      item
        Name = 'kbmAsignaturaCargaAcademicaNivel'
        Fields = 'CodNivel'
      end
      item
        Name = 'kbmAsignaturaMateria'
        Fields = 'CodMateria'
      end
      item
        Name = 'kbmAsignaturaPrimaryKey'
        Fields = 'CodMateria;CodNivel;CodEspecializacion'
        Options = [ixPrimary, ixUnique]
      end>
    RecalcOnIndex = False
    RecalcOnFetch = True
    SortOptions = []
    Performance = mtpfFast
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    StoreDataOnForm = False
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentSaveFormat = mtsfBinary
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadLimit = -1
    EnableJournal = False
    EnableVersioning = False
    VersioningMode = mtvmAllSinceCheckPoint
    FilterOptions = []
    Version = '2.50e Beta'
    Left = 4
    Top = 6
    object kbmAsignaturaCodMateria: TIntegerField
      DisplayLabel = 'Materia'
      FieldName = 'CodMateria'
      Required = True
    end
    object kbmAsignaturaCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
    end
    object kbmAsignaturaCodEspecializacion: TIntegerField
      DisplayLabel = 'Especialización'
      FieldName = 'CodEspecializacion'
      Required = True
    end
    object kbmAsignaturaCodAulaTipo: TIntegerField
      DisplayLabel = 'Tipo de Aula'
      FieldName = 'CodAulaTipo'
      Required = True
    end
    object kbmAsignaturaComposicion: TStringField
      DisplayLabel = 'Composición'
      FieldName = 'Composicion'
      Required = True
      Size = 40
    end
  end
end
