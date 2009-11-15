inherited HorarioParaleloForm: THorarioParaleloForm
  Left = 387
  Top = 106
  Width = 704
  Height = 428
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited do97Top: TDock97
    Width = 696
    inherited tb97Show: TToolbar97
      Left = 688
      DockPos = 696
    end
    inherited tb97Navigation: TToolbar97
      Left = 0
      Visible = True
      object btn97Mostrar: TToolbarButton97
        Left = 570
        Top = 0
        Width = 23
        Height = 22
        Hint = 'Mostrar|Mostrar el horario'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
          0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
          00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
          00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
          F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
          F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
          FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
          0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
          00337777FFFF77FF7733EEEE0000000003337777777777777333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = btn97MostrarClick
      end
      object btn97Prior: TToolbarButton97
        Left = 524
        Top = 0
        Width = 23
        Height = 22
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333FF3333333333333003333333333333F77F33333333333009033
          333333333F7737F333333333009990333333333F773337FFFFFF330099999000
          00003F773333377777770099999999999990773FF33333FFFFF7330099999000
          000033773FF33777777733330099903333333333773FF7F33333333333009033
          33333333337737F3333333333333003333333333333377333333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        OnClick = btn97PriorClick
      end
      object btn97Next: TToolbarButton97
        Left = 547
        Top = 0
        Width = 23
        Height = 22
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333FF3333333333333003333
          3333333333773FF3333333333309003333333333337F773FF333333333099900
          33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
          99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
          33333333337F3F77333333333309003333333333337F77333333333333003333
          3333333333773333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        OnClick = btn97NextClick
      end
      object dlcNivel: TRxDBLookupCombo
        Left = 0
        Top = 0
        Width = 113
        Height = 21
        Hint = 'Nivel|Seleccione el nivel'
        DropDownCount = 8
        DisplayEmpty = '(Nivel)'
        LookupField = 'CodNivel'
        LookupDisplay = 'AbrNivel'
        LookupSource = SourceDataModule.dsNivel
        TabOrder = 0
      end
      object dlcEspecializacion: TRxDBLookupCombo
        Left = 113
        Top = 0
        Width = 113
        Height = 21
        Hint = 'Especialización|Seleccione la especialización'
        DropDownCount = 8
        DisplayEmpty = '(Especialización)'
        LookupField = 'CodEspecializacion'
        LookupDisplay = 'NomEspecializacion'
        LookupSource = SourceDataModule.dsEspecializacion
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object dlcParaleloId: TRxDBLookupCombo
        Left = 226
        Top = 0
        Width = 113
        Height = 21
        Hint = 'Seleccione el tipo de paralelo'
        DropDownCount = 8
        DisplayEmpty = '(Paralelo)'
        LookupField = 'CodParaleloId'
        LookupDisplay = 'NomParaleloId'
        LookupSource = SourceDataModule.dsParaleloId
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object cbVerParalelo: TComboBox
        Left = 339
        Top = 0
        Width = 185
        Height = 21
        Hint = 'Ver|Seleccione el parámetro a ver en el horario'
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = 'cbVerParalelo'
      end
    end
    inherited tb97Edit: TToolbar97
      Left = 606
      DockPos = 614
      inherited btn97Ok: TToolbarButton97
        Enabled = False
        Visible = False
      end
      inherited btn97Cancel: TToolbarButton97
        Enabled = False
        Visible = False
      end
      object btn97IntercambiarPeriodos: TToolbarButton97
        Left = 46
        Top = 0
        Width = 23
        Height = 22
        Hint = 'Intercambiar períodos|Intercambiar períodos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
          333333333333337FF3333333333333903333333333333377FF33333333333399
          03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
          99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
          99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
          03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
          33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
          33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
          3333777777333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = IntercambiarPeriodosClick
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 382
    Width = 696
  end
  inherited Panel1: TPanel
    Width = 678
    Height = 347
  end
  inherited do97Right: TDock97
    Left = 687
    Height = 347
  end
  inherited do97Bottom: TDock97
    Top = 373
    Width = 696
  end
  inherited do97Left: TDock97
    Height = 347
  end
  inherited RxDrawGrid: TRxDrawGrid
    Width = 678
    Height = 347
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
    OnDblClick = IntercambiarPeriodosClick
  end
  inherited FormStorage: TFormStorage
    Active = True
    IniSection = '\Software\SGHC1\MMEd1HorarioParalelo'
    Top = 104
  end
  object QuHorarioParalelo: TkbmMemTable
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
      end
      item
        Name = 'CodHora'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodDia'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodMateria'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodProfesor'
        DataType = ftAutoInc
      end
      item
        Name = 'NomMateria'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'ApeNomProfesor'
        DataType = ftString
        Size = 31
      end
      item
        Name = 'Nombre'
        DataType = ftString
        Size = 40
      end>
    EnableIndexes = True
    AutoReposition = False
    IndexFieldNames = 'CodNivel;CodEspecializacion;CodParaleloId'
    IndexName = 'QuHorarioParaleloIxParalelo'
    IndexDefs = <
      item
        Name = 'QuHorarioParaleloIxParalelo'
        Fields = 'CodNivel;CodEspecializacion;CodParaleloId'
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
    MasterFields = 'CodNivel;CodEspecializacion;CodParaleloId'
    MasterSource = dsParalelo
    Version = '2.49'
    OnCalcFields = QuHorarioParaleloCalcFields
    Left = 60
    Top = 104
    object QuHorarioParaleloCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
      Visible = False
    end
    object QuHorarioParaleloCodEspecializacion: TIntegerField
      DisplayLabel = 'Especialización'
      FieldName = 'CodEspecializacion'
      Required = True
      Visible = False
    end
    object QuHorarioParaleloCodParaleloId: TIntegerField
      DisplayLabel = 'Paralelo'
      FieldName = 'CodParaleloId'
      Required = True
      Visible = False
    end
    object QuHorarioParaleloCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
      Visible = False
    end
    object QuHorarioParaleloCodDia: TIntegerField
      DisplayLabel = 'Día'
      FieldName = 'CodDia'
      Required = True
      Visible = False
    end
    object QuHorarioParaleloCodMateria: TIntegerField
      DisplayLabel = 'Materia'
      FieldName = 'CodMateria'
      Required = True
      Visible = False
    end
    object QuHorarioParaleloCodProfesor: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Código'
      FieldName = 'CodProfesor'
      Visible = False
    end
    object QuHorarioParaleloNomMateria: TStringField
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
    object QuHorarioParaleloApeNomProfesor: TStringField
      DisplayLabel = 'Profesor'
      DisplayWidth = 31
      FieldKind = fkLookup
      FieldName = 'ApeNomProfesor'
      LookupDataSet = SourceDataModule.kbmProfesor
      LookupKeyFields = 'CodProfesor'
      LookupResultField = 'ApeNomProfesor'
      KeyFields = 'CodProfesor'
      Visible = False
      Size = 31
      Lookup = True
    end
    object QuHorarioParaleloNombre: TStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 40
      Calculated = True
    end
  end
  object kbmParalelo: TkbmMemTable
    Active = True
    AttachedTo = SourceDataModule.kbmParalelo
    AttachedAutoRefresh = True
    AutoIncMinValue = 0
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
    VersioningMode = mtvmAllSinceCheckPoint
    FilterOptions = []
    Version = '2.49'
    Left = 88
    Top = 104
    object kbmParaleloCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      DisplayWidth = 10
      FieldName = 'CodNivel'
      Required = True
      Visible = False
    end
    object kbmParaleloCodEspecializacion: TIntegerField
      DisplayLabel = 'Especialización'
      DisplayWidth = 10
      FieldName = 'CodEspecializacion'
      Required = True
      Visible = False
    end
    object kbmParaleloCodParaleloId: TIntegerField
      DisplayLabel = 'Paralelo'
      DisplayWidth = 10
      FieldName = 'CodParaleloId'
      Required = True
      Visible = False
    end
    object kbmParaleloAbrNivel: TStringField
      DisplayLabel = 'Nivel'
      DisplayWidth = 5
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
      DisplayWidth = 10
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
      DisplayWidth = 5
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
  object dsParalelo: TDataSource
    DataSet = kbmParalelo
    Left = 88
    Top = 132
  end
end
