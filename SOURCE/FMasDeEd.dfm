inherited MasterDetailEditorForm: TMasterDetailEditorForm
  Left = 411
  Top = 234
  PixelsPerInch = 96
  TextHeight = 13
  inherited tb97Show: TToolBar
    inherited DBNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited Panel1: TPanel
    object Splitter1: TSplitter [0]
      Left = 1
      Top = 155
      Width = 500
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    inherited DBGrid: TDBGrid
      Height = 154
      TabOrder = 1
      OnEnter = DBGridEnter
    end
    object DBGridDetail: TDBGrid
      Left = 1
      Top = 158
      Width = 500
      Height = 96
      Align = alBottom
      DataSource = DataSourceDetail
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnEnter = DBGridEnter
      IniStorage = FormStorage
    end
  end
  inherited FormStorage: TFormStorage
    StoredProps.Strings = (
      'DBGridDetail.Height')
    Left = 92
    Top = 116
  end
  inherited DataSource: TDataSource
    Left = 120
  end
  object DataSourceDetail: TDataSource
    Left = 120
    Top = 116
  end
end
