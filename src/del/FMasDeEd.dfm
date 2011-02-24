inherited MasterDetailEditorForm: TMasterDetailEditorForm
  Left = 411
  Top = 234

  PixelsPerInch = 96

  inherited TlBShow: TToolBar
    inherited DBNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited pnlStatus: TPanel
    inherited SLState: TLabel
      Height = 17
    end
    inherited SLRecordNo: TLabel
      Height = 17
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
    end
  end
  inherited DataSource: TDataSource
    Left = 120
  end
  object DataSourceDetail: TDataSource
    Left = 120
    Top = 116
  end
end
