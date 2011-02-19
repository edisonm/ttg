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
  OnShow = FormShow
  PixelsPerInch = 96
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 173
    Height = 13
    Caption = 'Seleccione el periodo a intercambiar'
  end
  object Label2: TLabel
    Left = 16
    Top = 24
    Width = 18
    Height = 13
    Caption = 'Dia'
    FocusControl = DBLookupComboBox1
  end
  object Label3: TLabel
    Left = 144
    Top = 24
    Width = 23
    Height = 13
    Caption = 'Hora'
    FocusControl = DBLookupComboBox2
  end
  object BBAceptar: TBitBtn
    Left = 107
    Top = 72
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BBCancelar: TBitBtn
    Left = 195
    Top = 72
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkCancel
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 16
    Top = 40
    Width = 121
    Height = 21
    DataField = 'NomDia'
    DataSource = DSDiaHora
    TabOrder = 2
  end
  object DBLookupComboBox2: TDBLookupComboBox
    Left = 144
    Top = 40
    Width = 121
    Height = 21
    DataField = 'NomHora'
    DataSource = DSDiaHora
    TabOrder = 3
  end
  object TbDiaHora: TZTable
    Left = 24
    Top = 64
    object TbDiaHoraCodDia: TIntegerField
      DisplayLabel = 'Dia'
      FieldName = 'CodDia'
      Required = True
      Visible = False
    end
    object TbDiaHoraCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
      Visible = False
    end
    object TbDiaHoraNomDia: TStringField
      DisplayLabel = 'Dia'
      FieldKind = fkLookup
      FieldName = 'NomDia'
      LookupDataSet = SourceDataModule.TbDia
      LookupKeyFields = 'CodDia'
      LookupResultField = 'NomDia'
      KeyFields = 'CodDia'
      Required = True
      Size = 10
    end
    object TbDiaHoraNomHora: TStringField
      DisplayLabel = 'Hora'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'NomHora'
      LookupDataSet = SourceDataModule.TbHora
      LookupKeyFields = 'CodHora'
      LookupResultField = 'NomHora'
      KeyFields = 'CodHora'
      Required = True
      Size = 10
    end
  end
  object DSDiaHora: TDataSource
    DataSet = TbDiaHora
    Left = 52
    Top = 64
  end
end
