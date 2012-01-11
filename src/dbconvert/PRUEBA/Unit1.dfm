object Form1: TForm1
  Left = 271
  Top = 147
  Width = 512
  Height = 311
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 241
    Height = 121
    DataSource = dsDia
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 256
    Top = 8
    Width = 241
    Height = 121
    DataSource = dsHora
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBGrid3: TDBGrid
    Left = 7
    Top = 136
    Width = 241
    Height = 121
    DataSource = dsPeriodo
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object kbmDia: TkbmMemTable
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
    Left = 392
    Top = 144
    object kbmDiaCodDia: TIntegerField
      DisplayWidth = 10
      FieldName = 'CodDia'
      Required = True
    end
    object kbmDiaNomDia: TStringField
      DisplayWidth = 10
      FieldName = 'NomDia'
      Required = True
      Size = 10
    end
  end
  object dsDia: TDataSource
    DataSet = kbmDia
    Left = 424
    Top = 144
  end
  object dsHora: TDataSource
    DataSet = kbmHora
    Left = 352
    Top = 220
  end
  object kbmHora: TkbmMemTable
    Active = True
    AttachedAutoRefresh = True
    AutoIncMinValue = -1
    FieldDefs = <
      item
        Name = 'CodHora'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NomHora'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end>
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
    Left = 320
    Top = 220
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
  object dsPeriodo: TDataSource
    DataSet = kbmPeriodo
    Left = 424
    Top = 220
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
    Left = 392
    Top = 220
    object tbmPeriodoCodDia: TIntegerField
      FieldName = 'CodDia'
      Required = True
    end
    object tbmPeriodoCodHora: TIntegerField
      FieldName = 'CodHora'
      Required = True
    end
  end
end
