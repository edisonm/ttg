inherited CrossManyToManyEditorRForm: TCrossManyToManyEditorRForm
  Left = 324
  Top = 384
  Width = 625
  Height = 276
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter: TSplitter [0]
    Left = 501
    Top = 25
    Width = 3
    Height = 205
    Cursor = crHSplit
    Align = alRight
  end
  inherited tb97Show: TToolBar
    Width = 617
  end
  inherited pnlStatus: TPanel
    Top = 230
    Width = 617
  end
  object Panel2: TPanel [3]
    Left = 504
    Top = 25
    Width = 113
    Height = 205
    Align = alRight
    TabOrder = 4
    object ListBox: TListBox
      Left = 1
      Top = 1
      Width = 111
      Height = 203
      Align = alClient
      ItemHeight = 18
      ParentShowHint = False
      ShowHint = True
      Style = lbOwnerDrawFixed
      TabOrder = 0
      OnClick = ListBoxClick
      OnDrawItem = ListBoxDrawItem
      OnKeyUp = ListBoxKeyUp
    end
  end
  inherited Panel1: TPanel
    Width = 501
    Height = 205
  end
  inherited RxDrawGrid: TRxDrawGrid
    Width = 501
    Height = 205
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
    OnKeyUp = RxDrawGridKeyUp
    OnMouseUp = RxDrawGridMouseUp
  end
end
