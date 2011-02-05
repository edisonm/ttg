inherited CrossManyToManyEditor0Form: TCrossManyToManyEditor0Form
  Left = 58
  Top = 222
  PixelsPerInch = 96
  object Splitter: TSplitter [0]
    Left = 532
    Top = 25
    Width = 3
    Height = 216
    Cursor = crHSplit
    Align = alRight
  end
  object Panel2: TPanel [3]
    Left = 535
    Top = 25
    Width = 113
    Height = 216
    Align = alRight
    Caption = 'Panel2'
    TabOrder = 4
    object ListBox: TListBox
      Left = 1
      Top = 1
      Width = 111
      Height = 214
      Style = lbOwnerDrawFixed
      Align = alClient
      ItemHeight = 18
      Items.Strings = (
        'No Asignar'
        'Asignar')
      TabOrder = 0
      OnClick = ListBoxClick
      OnDrawItem = ListBoxDrawItem
      OnKeyUp = ListBoxKeyUp
    end
  end
  inherited Panel1: TPanel
    Width = 532
  end
  inherited DrawGrid: TDrawGrid
    Width = 532
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
    OnKeyUp = DrawGridKeyUp
    OnMouseUp = DrawGridMouseUp
  end
end
