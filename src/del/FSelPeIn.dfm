object SelPeriodoForm: TSelPeriodoForm
  Left = 306
  Top = 249
  BorderStyle = bsDialog
  Caption = 'Seleccionar periodo'
  ClientHeight = 105
  ClientWidth = 282
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []

  Position = poScreenCenter
  PixelsPerInch = 96

  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 171
    Height = 13
    Caption = 'Seleccione el periodo a intercambiar'
  end
  object Label2: TLabel
    Left = 16
    Top = 27
    Width = 16
    Height = 13
    Caption = 'Dia'
    FocusControl = CbDia
  end
  object Label3: TLabel
    Left = 143
    Top = 27
    Width = 23
    Height = 13
    Caption = 'Hora'
    FocusControl = CbHora
  end
  object BBAceptar: TBitBtn
    Left = 107
    Top = 72
    Width = 75
    Height = 25

    Kind = bkOK

    TabOrder = 1
  end
  object BBCancelar: TBitBtn
    Left = 195
    Top = 72
    Width = 75
    Height = 25

    Kind = bkCancel

    TabOrder = 0
  end
  object CbDia: TDBLookupComboBox
    Left = 16
    Top = 43
    Width = 121
    Height = 21
    KeyField = 'CodDia'
    ListField = 'NomDia'
    ListSource = SourceDataModule.DSDia
    TabOrder = 2
  end
  object CbHora: TDBLookupComboBox
    Left = 143
    Top = 43
    Width = 121
    Height = 21
    KeyField = 'CodHora'
    ListField = 'NomHora'
    ListSource = SourceDataModule.DSHora
    TabOrder = 3
  end
end
