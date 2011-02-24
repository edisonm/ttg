object LogisticForm: TLogisticForm
  Left = 243
  Top = 186
  Caption = 'Visor de mensajes'
  ClientHeight = 367
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop

  Position = poScreenCenter
  PixelsPerInch = 96

  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 434
    Height = 337
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 269
      Width = 432
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object MemLogistic: TMemo
      Left = 1
      Top = 1
      Width = 432
      Height = 268
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
      Top = 272
      Width = 432
      Height = 64
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
    Top = 337
    Width = 434
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object lblMsg: TLabel
      Left = 8
      Top = 16
      Width = 3
      Height = 13
    end
    object bbtnClose: TBitBtn
      Left = 349
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
  
      Kind = bkClose
  
      TabOrder = 0
    end
  end
end
