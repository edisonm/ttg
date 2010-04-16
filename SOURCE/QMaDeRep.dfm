inherited MasterDetailReportQrp: TMasterDetailReportQrp
  Left = 6
  Top = 180
  Width = 1013
  Height = 476
  VertScrollBar.Position = 0
  Caption = 'MasterDetailReportQrp'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited qrpSingleReport: TQuickRep
    Top = 24
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Page.Values = (
      250
      2970
      250
      2100
      300
      200
      0)
    inherited TitleBand1: TQRBand
      Size.Values = (
        367.770833333333
        1600.72916666667)
      inherited qrlTitle: TQRLabel
        Top = 81
        Size.Values = (
          79.375
          0
          214.3125
          182.5625)
        FontSize = 16
      end
      inherited QRSysData2: TQRSysData
        Top = 113
        Size.Values = (
          44.9791666666667
          0
          298.979166666667
          224.895833333333)
        FontSize = 10
      end
      inherited qrlSuperTitle: TQRLabel
        Height = 31
        Size.Values = (
          82.0208333333333
          0
          2.64583333333333
          396.875)
        FontSize = 18
      end
      inherited qrlAnioLectivo: TQRLabel
        Top = 49
        Size.Values = (
          79.375
          0
          129.645833333333
          391.583333333333)
        FontSize = 16
      end
    end
    inherited ColumnHeaderBand1: TQRBand
      Size.Values = (
        58.2083333333333
        1600.72916666667)
    end
    inherited PageFooterBand1: TQRBand
      Top = 355
      Size.Values = (
        317.5
        1600.72916666667)
      inherited QRSysData1: TQRSysData
        Size.Values = (
          44.9791666666667
          1441.97916666667
          259.291666666667
          158.75)
        FontSize = 8
      end
      inherited qrlPosition1: TQRLabel
        Size.Values = (
          44.9791666666667
          0
          259.291666666667
          182.5625)
        FontSize = 10
      end
      inherited qrlName1: TQRLabel
        Size.Values = (
          44.9791666666667
          0
          211.666666666667
          148.166666666667)
        FontSize = 10
      end
      inherited qrlFirm1: TQRLabel
        Size.Values = (
          44.9791666666667
          0
          63.5
          142.875)
        FontSize = 10
      end
      inherited qrlFirm2: TQRLabel
        Size.Values = (
          44.9791666666667
          740.833333333333
          63.5
          142.875)
        FontSize = 10
      end
      inherited qrlName2: TQRLabel
        Size.Values = (
          44.9791666666667
          740.833333333333
          211.666666666667
          148.166666666667)
        FontSize = 10
      end
      inherited qrlPosition2: TQRLabel
        Size.Values = (
          44.9791666666667
          740.833333333333
          259.291666666667
          182.5625)
        FontSize = 10
      end
    end
    object GroupHeaderBand1: TQRBand [3]
      Left = 113
      Top = 271
      Width = 605
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        68.7916666666667
        1600.72916666667)
      BandType = rbGroupHeader
    end
    object QRSubDetail1: TQRSubDetail [4]
      Left = 113
      Top = 297
      Width = 605
      Height = 18
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        47.625
        1600.72916666667)
      Master = Owner
      FooterBand = GroupFooterBand1
      HeaderBand = GroupHeaderBand1
      PrintBefore = False
      PrintIfEmpty = True
    end
    inherited DetailBand1: TQRBand
      ForceNewColumn = True
      Size.Values = (
        42.3333333333333
        1600.72916666667)
    end
    object GroupFooterBand1: TQRBand [6]
      Left = 113
      Top = 315
      Width = 605
      Height = 22
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        58.2083333333333
        1600.72916666667)
      BandType = rbGroupFooter
      object qreDetailSum: TQRExpr
        Left = 520
        Top = 2
        Width = 85
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.9791666666667
          1375.83333333333
          5.29166666666667
          224.895833333333)
        Alignment = taRightJustify
        AlignToBand = True
        AutoSize = True
        AutoStretch = False
        Color = clWhite
        Master = QRSubDetail1
        ResetAfterPrint = True
        Transparent = False
        WordWrap = True
        Expression = 'sum(Duracion)'
        Mask = '"SubTotal = "#'
        FontSize = 10
      end
    end
    inherited QRBand1: TQRBand
      Top = 337
      Size.Values = (
        47.625
        1600.72916666667)
      inherited qreSum: TQRExpr
        Size.Values = (
          44.9791666666667
          1375.83333333333
          0
          224.895833333333)
        FontSize = 10
      end
    end
  end
end
