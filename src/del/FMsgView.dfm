object MessageViewForm: TMessageViewForm
  Left = 243
  Top = 186
  ActiveControl = Panel1
  Caption = 'Visor de mensajes'
  ClientHeight = 373
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 434
    Height = 333
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 273
      Width = 432
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object MemLogistic: TMemo
      Left = 1
      Top = 1
      Width = 432
      Height = 272
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object MemResumen: TMemo
      Left = 1
      Top = 276
      Width = 432
      Height = 56
      Align = alBottom
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 333
    Width = 434
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object lblMsg: TLabel
      Left = 8
      Top = 16
      Width = 3
      Height = 13
      Color = clBtnFace
      ParentColor = False
    end
    object bbtnClose: TBitBtn
      Left = 336
      Top = 3
      Width = 88
      Height = 30
      Anchors = [akRight, akBottom]
      DoubleBuffered = True
      Kind = bkClose
      ParentDoubleBuffered = False
      TabOrder = 0
    end
  end
end