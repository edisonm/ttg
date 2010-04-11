object SelPeriodoForm: TSelPeriodoForm
  Left = 316
  Top = 244
  BorderStyle = bsDialog
  Caption = 'Seleccionar período'
  ClientHeight = 105
  ClientWidth = 282
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 173
    Height = 13
    Caption = 'Seleccione el período a intercambiar'
  end
  object Label2: TLabel
    Left = 16
    Top = 24
    Width = 18
    Height = 13
    Caption = 'Día'
    FocusControl = DBLookupComboBox1
  end
  object Label3: TLabel
    Left = 144
    Top = 24
    Width = 23
    Height = 13
    Caption = 'Hora'
    FocusControl = DBLookupComboBox2
  end
  object BBAceptar: TBitBtn
    Left = 107
    Top = 72
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BBCancelar: TBitBtn
    Left = 195
    Top = 72
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkCancel
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 16
    Top = 40
    Width = 121
    Height = 21
    DataField = 'NomDia'
    DataSource = DSDiaHora
    TabOrder = 2
  end
  object DBLookupComboBox2: TDBLookupComboBox
    Left = 144
    Top = 40
    Width = 121
    Height = 21
    DataField = 'NomHora'
    DataSource = DSDiaHora
    TabOrder = 3
  end
  object TbDiaHora: TkbmMemTable
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
    Left = 24
    Top = 64
    object TbDiaHoraCodDia: TIntegerField
      DisplayLabel = 'Día'
      FieldName = 'CodDia'
      Required = True
      Visible = False
    end
    object TbDiaHoraCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
      Visible = False
      AttributeSet = 'CodHora'
    end
    object TbDiaHoraNomDia: TStringField
      DisplayLabel = 'Día'
      FieldKind = fkLookup
      FieldName = 'NomDia'
      LookupDataSet = SourceDataModule.kbmDia
      LookupKeyFields = 'CodDia'
      LookupResultField = 'NomDia'
      KeyFields = 'CodDia'
      Required = True
      Size = 10
      Lookup = True
    end
    object TbDiaHoraNomHora: TStringField
      DisplayLabel = 'Hora'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'NomHora'
      LookupDataSet = SourceDataModule.kbmHora
      LookupKeyFields = 'CodHora'
      LookupResultField = 'NomHora'
      KeyFields = 'CodHora'
      Required = True
      Size = 10
      Lookup = True
    end
  end
  object DSDiaHora: TDataSource
    DataSet = TbDiaHora
    Left = 52
    Top = 64
  end
end
