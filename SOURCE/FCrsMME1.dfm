inherited CrossManyToManyEditor1Form: TCrossManyToManyEditor1Form
  Left = 81
  Top = 251
  PixelsPerInch = 96
  TextHeight = 13
  inherited RxDrawGrid: TRxDrawGrid
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goEditing]
    OnGetEditText = RxDrawGridGetEditText
    OnSetEditText = RxDrawGridSetEditText
  end
  inherited FormStorage: TFormStorage
    Left = 120
    Top = 88
  end
end
