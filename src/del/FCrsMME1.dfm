inherited CrossManyToManyEditor1Form: TCrossManyToManyEditor1Form
  Left = 82
  Top = 218
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited DrawGrid: TDrawGrid
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goEditing]
    OnGetEditText = DrawGridGetEditText
    OnSetEditText = DrawGridSetEditText
  end
end
