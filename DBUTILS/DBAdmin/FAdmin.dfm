object AdminForm: TAdminForm
  Left = 237
  Top = 173
  Width = 544
  Height = 375
  Caption = 'Administración'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 27
    Width = 536
    Height = 321
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Fuentes de datos'
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 33
        Height = 13
        Caption = 'Fuente'
      end
      object DBGrid1: TDBGrid
        Left = 4
        Top = 32
        Width = 521
        Height = 257
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object DBNavigator1: TDBNavigator
        Left = 264
        Top = 2
        Width = 260
        Height = 25
        DataSource = DataSource1
        Flat = True
        TabOrder = 1
      end
      object ComboBox1: TComboBox
        Left = 88
        Top = 4
        Width = 169
        Height = 21
        ItemHeight = 13
        TabOrder = 2
        OnChange = ComboBox1Change
      end
    end
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 536
    Height = 27
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 1
    object MenuBar1: TMenuBar
      Left = 11
      Top = 2
      Width = 47
      Height = 21
      Align = alNone
      AutoSize = True
      ButtonHeight = 21
      ButtonWidth = 49
      Caption = 'MenuBar1'
      EdgeInner = esNone
      EdgeOuter = esNone
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      Menu = MainMenu1
    end
  end
  object MainMenu1: TMainMenu
    Left = 184
    Top = 107
    object Archivo1: TMenuItem
      Caption = '&Archivo'
      object Abrir1: TMenuItem
        Caption = 'Abrir'
        OnClick = Abrir1Click
      end
      object Guardarcomo1: TMenuItem
        Caption = 'Guardar como...'
        OnClick = Guardarcomo1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Salir1: TMenuItem
        Caption = '&Salir'
        OnClick = Salir1Click
      end
    end
  end
  object DataSource1: TDataSource
    Left = 156
    Top = 107
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'ah'
    Filter = 'Archivo de Horario (*.ah)|*.ah'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 100
    Top = 107
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'ah'
    Filter = 'Archivo de Horario (*.ah)|*.ah'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 128
    Top = 107
  end
end
