inherited ParaleloForm: TParaleloForm
  Left = 338
  Top = 206
  OnCreate = FormCreate
  OnDestroy = FormDestroy
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
    inherited DBGrid: TRxDBGrid
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
  inherited FormStorage: TFormStorage
    Active = True
    IniSection = '\Software\SGHC\SEParalelo'
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
    DataSet = SourceDataModule.TbParalelo
    Left = 36
    Top = 116
  end
end
