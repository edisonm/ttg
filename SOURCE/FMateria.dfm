inherited MateriaForm: TMateriaForm
  Left = 286
  Top = 248
  Width = 602
  Caption = 'Materias'
  PixelsPerInch = 96
  TextHeight = 13
  inherited TlBShow: TToolBar
    Width = 594
    object BtnMateriaProhibicion: TToolButton [2]
      Left = 46
      Top = 0
      Hint = 
        'Prohibiciones de materia|Ingresar el horario de prohibiciones de' +
        ' materia'
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnMateriaProhibicionClick
    end
    inherited DBNavigator: TDBNavigator
      Left = 69
      Hints.Strings = ()
    end
  end
  inherited pnlStatus: TPanel
    Width = 594
    inherited SLRecordNo: TDBStatusLabel
      Left = 523
    end
  end
  inherited Panel1: TPanel
    Width = 594
    inherited DBGrid: TDBGrid
      Width = 592
    end
  end
  inherited FormStorage: TFormStorage
    Active = True
    IniSection = '\Software\SGHC\SEMateria'
  end
  inherited ImageList: TImageList
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C0008080
      8000808080000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C000FFFF00008080
      800000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000080808000808080008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000808080008080800080808000C0C0C000C0C0C0008080
      800080808000C0C0C00000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C000C0C0C0008080
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000080808000C0C0C000C0C0C000808080000000
      00008080800080808000000000000000000000000000FFFFFF00C0C0C000FFFF
      FF0000000000C0C0C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000FFFF0000C0C0C000C0C0C0008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000C0C0C000C0C0C000FFFFFF00C0C0C0008080
      80000000000080808000000000000000000000000000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000080808000FFFF0000FFFF0000C0C0C0008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00C0C0
      C0008080800000000000000000000000000000000000FFFFFF00C0C0C000FFFF
      FF000000000080808000C0C0C000C0C0C00000000000C0C0C000C0C0C0008080
      8000C0C0C000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C0008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFF
      FF00C0C0C00000000000000000000000000000000000C0C0C000C0C0C0000000
      800000008000000000008080800000000000C0C0C000C0C0C00080808000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C00000000000000000000000000000000000FFFFFF00C0C0C0000000
      FF0000008000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C0008080800080808000000000000000000000000000FFFFFF00C0C0C000FFFF
      FF00FFFFFF00C0C0C000FFFFFF00FFFFFF00C0C0C000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800080808000C0C0C000C0C0C000C0C0C0008080
      8000000000000000000000000000000000000000000080808000808080008080
      8000FF000000FF000000FF000000FF0000008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFF0000000
      8009E3FFE00000008001C3FFF00000008007C1FFF00000008007C00F00000000
      8007F003000000008007F803000000008007F80300010000800FF80300030000
      800FF80300070000800FF803001F0000801FFC07001F0000803FFC0FFFFF0000
      C07FFFFFFFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
end
