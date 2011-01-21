inherited ParaleloForm: TParaleloForm
  Left = 595
  Top = 270
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited TlBShow: TToolBar
    inherited DBNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited Panel1: TPanel
    object Splitter1: TSplitter [0]
      Left = 349
      Top = 1
      Width = 3
      Height = 253
      Cursor = crHSplit
      Align = alRight
    end
    inherited DBGrid: TDBGrid
      Width = 348
      Hint = 'Cursos|Cursos disponibles'
      ParentShowHint = False
      ShowHint = True
    end
    object CheckListBox: TCheckListBox
      Left = 352
      Top = 1
      Width = 149
      Height = 253
      Align = alRight
      ItemHeight = 13
      TabOrder = 1
      OnExit = CheckListBoxExit
    end
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
    DataSet = SourceDataModule.TbParalelo
    Left = 36
    Top = 116
  end
end
