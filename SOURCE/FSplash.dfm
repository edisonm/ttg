object SplashForm: TSplashForm
  Left = 185
  Top = 223
  BorderStyle = bsNone
  ClientHeight = 182
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 373
    Height = 182
    Align = alClient
    Stretch = True
  end
  object lblProductName: TLabel
    Left = 88
    Top = 24
    Width = 15
    Height = 22
    Caption = '...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblProductVersion: TLabel
    Left = 168
    Top = 64
    Width = 9
    Height = 16
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object lblCopyright: TLabel
    Left = 168
    Top = 88
    Width = 9
    Height = 16
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel
    Left = 8
    Top = 136
    Width = 69
    Height = 16
    Caption = 'Cargando...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object lblTable: TLabel
    Left = 104
    Top = 136
    Width = 257
    Height = 13
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object lblYearLabel: TLabel
    Left = 168
    Top = 112
    Width = 9
    Height = 16
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 88
    Top = 64
    Width = 46
    Height = 16
    Caption = 'Versi'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 88
    Top = 88
    Width = 64
    Height = 16
    Caption = 'Ejecutable'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 88
    Top = 112
    Width = 45
    Height = 16
    Caption = 'Edici'#243'n'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object PBLoad: TProgressBar
    Left = 8
    Top = 160
    Width = 353
    Height = 13
    Min = 0
    Max = 8
    TabOrder = 0
  end
end
