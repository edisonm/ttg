inherited CrossManyToManyEditorRForm: TCrossManyToManyEditorRForm
  Left = 379
  Top = 320
  ClientHeight = 249
  ClientWidth = 617
  OnCreate = FormCreate
  ExplicitWidth = 625
  ExplicitHeight = 276
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter: TSplitter [0]
    Left = 501
    Top = 25
    Height = 205
    Align = alRight
  end
  inherited TlBShow: TToolBar
    Width = 617
    ExplicitWidth = 617
  end
  inherited pnlStatus: TPanel
    Top = 230
    Width = 617
    ExplicitTop = 230
    ExplicitWidth = 617
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
      Style = lbOwnerDrawFixed
      Align = alClient
      ItemHeight = 18
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = ListBoxClick
      OnDrawItem = ListBoxDrawItem
      OnKeyUp = ListBoxKeyUp
    end
  end
  inherited Panel1: TPanel
    Width = 501
    Height = 205
    ExplicitWidth = 501
    ExplicitHeight = 205
  end
  inherited DrawGrid: TDrawGrid
    Width = 501
    Height = 205
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
    OnKeyUp = DrawGridKeyUp
    OnMouseUp = DrawGridMouseUp
    ExplicitWidth = 501
    ExplicitHeight = 205
    RowHeights = (
      18
      24)
  end
end
