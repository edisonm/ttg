object ProgressForm: TProgressForm
  Left = 554
  Top = 210
  ActiveControl = pnlProgress
  BorderStyle = bsDialog
  Caption = 'Progreso de la busqueda'
  ClientHeight = 350
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlProgress: TPanel
    Left = 8
    Top = 8
    Width = 448
    Height = 297
    TabOrder = 0
    object pnlValorTotal: TPanel
      Left = 8
      Top = 246
      Width = 433
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Valor Total:'
      TabOrder = 0
      object lblValorTotal: TLabel
        Left = 420
        Top = 1
        Width = 12
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object pnlCruceProfesor: TPanel
      Left = 8
      Top = 54
      Width = 181
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Cruce de profesores:'
      TabOrder = 1
    end
    object pnlCruceProfesorValor: TPanel
      Left = 312
      Top = 54
      Width = 129
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Valor:'
      TabOrder = 2
      object lblCruceProfesorValor: TLabel
        Left = 119
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object pnlCruceAulaTipo: TPanel
      Left = 8
      Top = 102
      Width = 181
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Cruce de aulas:'
      TabOrder = 3
    end
    object pnlCruceAulaTipoValor: TPanel
      Left = 312
      Top = 102
      Width = 129
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Valor:'
      TabOrder = 4
      object lblCruceAulaTipoValor: TLabel
        Left = 119
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object pnlCruceProfesorCantidad: TPanel
      Left = 192
      Top = 54
      Width = 117
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Cantidad:'
      TabOrder = 5
      object lblCruceProfesor: TLabel
        Left = 107
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object pnlCruceAulaTipoCantidad: TPanel
      Left = 192
      Top = 102
      Width = 117
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Cantidad:'
      TabOrder = 6
      object lblCruceAulaTipo: TLabel
        Left = 107
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object pnlHoraHuecaDesubicada: TPanel
      Left = 8
      Top = 126
      Width = 181
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Horas huecas desubicadas'
      TabOrder = 7
    end
    object pnlHoraHuecaDesubicadaCantidad: TPanel
      Left = 192
      Top = 126
      Width = 117
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Cantidad:'
      TabOrder = 8
      object lblHoraHuecaDesubicada: TLabel
        Left = 107
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object pnlHoraHuecaDesubicadaValor: TPanel
      Left = 312
      Top = 126
      Width = 129
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Valor:'
      TabOrder = 9
      object lblHoraHuecaDesubicadaValor: TLabel
        Left = 119
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object pnlSesionCortada: TPanel
      Left = 8
      Top = 150
      Width = 181
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Materias cortadas'
      TabOrder = 10
    end
    object pnlSesionCortadaCantidad: TPanel
      Left = 192
      Top = 150
      Width = 117
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Cantidad:'
      TabOrder = 11
      object lblSesionCortada: TLabel
        Left = 107
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object pnlSesionCortadaValor: TPanel
      Left = 312
      Top = 150
      Width = 129
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Valor:'
      TabOrder = 12
      object lblSesionCortadaValor: TLabel
        Left = 119
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object pnlInitDateTime: TPanel
      Left = 8
      Top = 6
      Width = 215
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = 'Iniciado el:'
      TabOrder = 13
      object lblInit: TLabel
        Left = 211
        Top = 1
        Width = 3
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 429
        ExplicitHeight = 13
      end
    end
    object pnlElapsedTime: TPanel
      Left = 8
      Top = 30
      Width = 215
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Tiempo transcurrido:'
      TabOrder = 14
      object lblElapsedTime: TLabel
        Left = 205
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 222
        ExplicitHeight = 13
      end
    end
    object pnlEstimatedTime: TPanel
      Left = 226
      Top = 30
      Width = 215
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = 'Tiempo restante:'
      TabOrder = 15
      object lblRemainingTime: TLabel
        Left = 205
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 187
        ExplicitHeight = 13
      end
    end
    object pnlMateriaProhibicion: TPanel
      Left = 8
      Top = 198
      Width = 181
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Prohibiciones de materia:'
      TabOrder = 16
    end
    object pnlMateriaProhibicionCantidad: TPanel
      Left = 192
      Top = 198
      Width = 117
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Cantidad:'
      TabOrder = 17
      object lblMateriaProhibicion: TLabel
        Left = 107
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object pnlMateriaProhibicionValor: TPanel
      Left = 312
      Top = 198
      Width = 129
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Valor:'
      TabOrder = 18
      object lblMateriaProhibicionValor: TLabel
        Left = 119
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object pnlProfesorProhibicion: TPanel
      Left = 8
      Top = 222
      Width = 181
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Prohibiciones de profesor:'
      TabOrder = 19
    end
    object pnlProfesorProhibicionCantidad: TPanel
      Left = 192
      Top = 222
      Width = 117
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Cantidad:'
      TabOrder = 20
      object lblProfesorProhibicion: TLabel
        Left = 107
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object Panel26: TPanel
      Left = 312
      Top = 222
      Width = 129
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Valor:'
      TabOrder = 21
      object lblProfesorProhibicionValor: TLabel
        Left = 119
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object pnlMateriaNoDispersa: TPanel
      Left = 8
      Top = 174
      Width = 181
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Materias no dispersas:'
      TabOrder = 22
    end
    object Panel28: TPanel
      Left = 192
      Top = 174
      Width = 117
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Cantidad:'
      TabOrder = 23
      object lblMateriaNoDispersa: TLabel
        Left = 107
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object Panel29: TPanel
      Left = 312
      Top = 174
      Width = 129
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Valor:'
      TabOrder = 24
      object lblMateriaNoDispersaValor: TLabel
        Left = 119
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object Panel1: TPanel
      Left = 8
      Top = 78
      Width = 181
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Fracc. del h. de profesores:'
      TabOrder = 25
    end
    object Panel2: TPanel
      Left = 192
      Top = 78
      Width = 117
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Cantidad:'
      TabOrder = 26
      object lblProfesorFraccionamiento: TLabel
        Left = 107
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object Panel3: TPanel
      Left = 312
      Top = 78
      Width = 129
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Valor:'
      TabOrder = 27
      object lblProfesorFraccionamientoValor: TLabel
        Left = 119
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object Panel5: TPanel
      Left = 8
      Top = 270
      Width = 117
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = 'Importaciones:'
      TabOrder = 28
      object lblImportaciones: TLabel
        Left = 107
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object Panel6: TPanel
      Left = 128
      Top = 270
      Width = 117
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = 'Exportaciones:'
      TabOrder = 29
      object lblExportaciones: TLabel
        Left = 107
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object Panel4: TPanel
      Left = 248
      Top = 270
      Width = 117
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = 'Colisiones:'
      TabOrder = 30
      object lblColisiones: TLabel
        Left = 107
        Top = 1
        Width = 9
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 13
      end
    end
    object pnlPosition: TPanel
      Left = 226
      Top = 6
      Width = 215
      Height = 21
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Caption = ' Iteracion:'
      TabOrder = 31
      object lblPosition: TLabel
        Left = 202
        Top = 1
        Width = 12
        Height = 19
        Align = alRight
        Alignment = taRightJustify
        Caption = '0 '
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 184
        ExplicitHeight = 13
      end
    end
  end
  object bbtnClose: TBitBtn
    Left = 360
    Top = 312
    Width = 96
    Height = 28
    Caption = '&Finalizar'
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
      F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
      000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
      338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
      45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
      3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
      F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
      000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
      338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
      4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
      8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
      333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
      0000}
    NumGlyphs = 2
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 1
    OnClick = bbtnCloseClick
  end
  object bbtnCancel: TBitBtn
    Left = 248
    Top = 312
    Width = 107
    Height = 28
    Cancel = True
    Caption = 'Cancelar'
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    ModalResult = 2
    NumGlyphs = 2
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 2
    OnClick = bbtnCancelClick
  end
  object PBProgress: TProgressBar
    Left = 9
    Top = 312
    Width = 232
    Height = 28
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
end
