inherited HorarioParaleloForm: THorarioParaleloForm
  Left = 610
  Top = 192
  ClientHeight = 401
  ClientWidth = 765
  OnCreate = FormCreate


  PixelsPerInch = 96

  object Splitter1: TSplitter [0]
    Left = 233
    Top = 25
    Height = 357


  
  end
  inherited TlBShow: TToolBar
    Width = 765
  
    inherited BtnOk: TToolButton
      Enabled = False
      Visible = False
    end
    inherited BtnCancel: TToolButton
      Enabled = False
      Visible = False
    end
    object DBNavigator: TDBNavigator
      Left = 69
      Top = 0
      Width = 92
      Height = 22
      DataSource = DSParalelo
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Flat = True

      ShowHint = True
      TabOrder = 1
    end
    object cbVerParalelo: TComboBox
      Left = 161
      Top = 0
      Width = 185
      Height = 21
      Hint = 'Ver|Seleccione el parametro a ver en el horario'

      ShowHint = True
      TabOrder = 0
      Text = 'cbVerParalelo'
      OnChange = BtnMostrarClick
    end
    object BtnIntercambiarPeriodos: TToolButton
      Left = 346
      Top = 0
      Hint = 'Intercambiar periodos|Intercambiar periodos'
      ImageIndex = 6

      ShowHint = True
      OnClick = IntercambiarPeriodosClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 382
    Width = 765

  
  end
  inherited Panel1: TPanel
    Left = 236
    Width = 529
    Height = 357

  
  
  end
  inherited DrawGrid: TDrawGrid
    Left = 236
    Width = 529
    Height = 357
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
    OnDblClick = IntercambiarPeriodosClick

  
  
  end
  object DBGrid1: TDBGrid [5]
    Left = 0
    Top = 25
    Width = 233
    Height = 357
    Align = alLeft
    DataSource = DSParalelo
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  inherited ImageList: TImageList
    Left = 140
    Top = 104
    Bitmap = {
      494C010107000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
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
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF00000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000BFBF
      BF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000080000000800080808000000000000000000000000000000000000000
      00000000FF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000000080000000800000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000080000000800000008000808080000000000000000000000000000000
      FF00000080000000800080808000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000008000000080000000800000008000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000800000008000000080000000800080808000000000000000FF000000
      8000000080000000800000008000808080000000000000000000000000000000
      000000000000FFFFFF00000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000800000000080
      0000008000000080000000800000008000000080000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000800000008000000080000000800080808000000080000000
      8000000080000000800000008000808080000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C0008080
      8000808080000000000000000000000000000000000080000000008000000080
      00000080000000FF000000800000008000000080000000800000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800000008000000080000000
      8000000080000000800080808000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000FFFFFF000000000000000000FFFF
      FF000000000000000000FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C000FFFF00008080
      8000000000000000000000000000000000000000000000800000008000000080
      000000FF00000000000000FF0000008000000080000000800000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000080000000800000008000000080000000
      8000000080008080800000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C000C0C0C0008080
      8000000000000000000000000000000000000000000000FF00000080000000FF
      000000000000000000000000000000FF00000080000000800000008000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000000800000008000000080000000
      8000808080000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF0000000000FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000FFFF0000C0C0C000C0C0C0008080
      800000000000000000000000000000000000000000000000000000FF00000000
      00000000000000000000000000000000000000FF000000800000008000000080
      0000800000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000800000008000000080000000
      8000808080000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000FFFF000000000000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000080808000FFFF0000FFFF0000C0C0C0008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008000000080
      0000008000008000000000000000000000000000000000000000000000000000
      000000000000000000000000FF00000080000000800000008000000080000000
      800080808000000000000000000000000000000000000000000000000000FFFF
      FF0000FFFF000000000000FFFF00FFFFFF0000000000FFFFFF0000FFFF000000
      0000FFFFFF0000000000FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C0008080
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000080
      0000008000000080000080000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000000080000000
      8000000080008080800000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000000000FFFFFF0000FFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000000080000000800000800000000000000000000000000000000000
      00000000FF0000008000000080000000800080808000000000000000FF000000
      800000008000000080008080800000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000FFFFFF0000FFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF00000080000000800000008000000000000000000000000000000000
      00000000FF000000800000008000808080000000000000000000000000000000
      FF00000080000000800000008000808080000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000800000008000000000000000000000000000000000
      0000000000000000FF0000008000000000000000000000000000000000000000
      00000000FF00000080000000800000008000FFFF00000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00000000000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF0000008000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF00000080000000FF00FFFF0000FFFF00000000000000FF
      FF00FFFFFF0000FFFF000000000000FFFF00FFFFFF0000FFFF0000000000FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFF0000FFFF0000FFFF00000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFDF0000FFFFFFFFFFCF0000
      FFFFFFFFFFC70000FF3FFFFF00030000FC3FFCFF00010000F03FFC3F00000000
      C000FC0F000100000000000300030000C000000000070000F03F0003000F0000
      FC3FFC0F001F0000FF3FFC3F007F0000FFFFFCFF00FF0000FFFFFFFF01FF0000
      FFFFFFFF03FF0000FFFFFFFFFFFF0000FFFFF9FFE1F3F000FFFFF0FFE0E1F000
      8009E07FE040F0008001C03FF000F0008007801FF801F0008007841FFC03F000
      80078E0FFE07F0008007DF07FE07E0008007FF83FC07C000800FFFC1F8038000
      800FFFE0F0418000800FFFF0F0E00000801FFFF8F9F00000803FFFFCFFF80001
      C07FFFFEFFFF0003FFFFFFFFFFFF000700000000000000000000000000000000
      000000000000}
  end
  object QuHorarioParalelo: TZQuery
    Connection = SourceDataModule.Database
    SortedFields = 'CodHorario;CodNivel;CodEspecializacion;CodParaleloId'
    OnCalcFields = QuHorarioParaleloCalcFields
    ReadOnly = True
    SQL.Strings = (
      'select'
      '  HorarioDetalle.CodHorario,'
      '  HorarioDetalle.CodNivel,'
      '  HorarioDetalle.CodEspecializacion,'
      '  HorarioDetalle.CodParaleloId,'
      '  CodHora,'
      '  CodDia,'
      '  HorarioDetalle.CodMateria,'
      '  Distributivo.CodProfesor,'
      '  NomMateria,'
      '  ApeProfesor,'
      '  NomProfesor'
      'from'
      '  ((HorarioDetalle inner join Distributivo on'
      '  (HorarioDetalle.CodMateria = Distributivo.CodMateria)'
      '  and (HorarioDetalle.CodNivel = Distributivo.CodNivel)'
      
        '  and (HorarioDetalle.CodEspecializacion = Distributivo.CodEspec' +
        'ializacion)'
      
        '  and (HorarioDetalle.CodParaleloId = Distributivo.CodParaleloId' +
        '))'
      
        '  inner join Materia on (HorarioDetalle.CodMateria = Materia.Cod' +
        'Materia))'
      
        '  inner join Profesor on (Distributivo.CodProfesor = Profesor.Co' +
        'dProfesor)'
      'where'
      '  CodHorario=:CodHorario'
      'and HorarioDetalle.CodNivel=:CodNivel'
      'and HorarioDetalle.CodEspecializacion=:CodEspecializacion'
      'and HorarioDetalle.CodParaleloId=:CodParaleloId')
    Params = <
      item
        DataType = ftUnknown
        Name = 'CodHorario'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CodNivel'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CodEspecializacion'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CodParaleloId'
        ParamType = ptUnknown
      end>
    DataSource = DSParalelo
    MasterFields = 'CodHorario;CodNivel;CodEspecializacion;CodParaleloId'
    MasterSource = DSParalelo
    LinkedFields = 'CodHorario;CodNivel;CodEspecializacion;CodParaleloId'
    IndexFieldNames = 
      'CodHorario Asc;CodNivel Asc;CodEspecializacion Asc;CodParaleloId' +
      ' Asc'
    Left = 60
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CodHorario'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CodNivel'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CodEspecializacion'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CodParaleloId'
        ParamType = ptUnknown
      end>
    object QuHorarioParaleloCodHorario: TIntegerField
      FieldName = 'CodHorario'
      ReadOnly = True
    end
    object QuHorarioParaleloCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
      Visible = False
    end
    object QuHorarioParaleloCodEspecializacion: TIntegerField
      DisplayLabel = 'Especializacion'
      FieldName = 'CodEspecializacion'
      Required = True
      Visible = False
    end
    object QuHorarioParaleloCodParaleloId: TIntegerField
      DisplayLabel = 'Paralelo'
      FieldName = 'CodParaleloId'
      Required = True
      Visible = False
    end
    object QuHorarioParaleloCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
      Visible = False
    end
    object QuHorarioParaleloCodDia: TIntegerField
      DisplayLabel = 'Dia'
      FieldName = 'CodDia'
      Required = True
      Visible = False
    end
    object QuHorarioParaleloCodMateria: TIntegerField
      DisplayLabel = 'Materia'
      FieldName = 'CodMateria'
      Required = True
      Visible = False
    end
    object QuHorarioParaleloCodProfesor: TIntegerField
      DisplayLabel = 'Codigo'
      FieldName = 'CodProfesor'
      Visible = False
    end
    object QuHorarioParaleloNombre: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Nombre'
      Size = 40
  
    end
    object QuHorarioParaleloNomMateria: TWideStringField
      FieldName = 'NomMateria'
      ReadOnly = True
    end
    object QuHorarioParaleloApeProfesor: TWideStringField
      FieldName = 'ApeProfesor'
      Required = True
      Size = 15
    end
    object QuHorarioParaleloNomProfesor: TWideStringField
      FieldName = 'NomProfesor'
      Required = True
      Size = 15
    end
  end
  object DSParalelo: TDataSource
    DataSet = QuParalelo
    OnDataChange = DSParaleloDataChange
    Left = 140
    Top = 157
  end
  object QuParalelo: TZQuery
    Connection = SourceDataModule.Database
    OnCalcFields = QuParaleloCalcFields
    ReadOnly = True
    SQL.Strings = (
      'select'
      '  Horario.CodHorario,'
      '  Paralelo.CodNivel,'
      '  Paralelo.CodEspecializacion,'
      '  Paralelo.CodParaleloId,'
      '  AbrNivel,'
      '  AbrEspecializacion,'
      '  NomParaleloId'
      'from'
      '  ((Paralelo inner join Nivel on'
      '    (Paralelo.CodNivel=Nivel.CodNivel))'
      '    inner join Especializacion on'
      
        '    (Paralelo.CodEspecializacion=Especializacion.CodEspecializac' +
        'ion))'
      '    inner join ParaleloId on'
      '    (Paralelo.CodParaleloId=ParaleloId.CodParaleloId),'
      '  Horario'
      'where'
      '  Horario.CodHorario=:CodHorario'
      'order by'
      '  Paralelo.CodNivel,'
      '  Paralelo.CodEspecializacion,'
      '  Paralelo.CodParaleloId')
    Params = <
      item
        DataType = ftUnknown
        Name = 'CodHorario'
        ParamType = ptUnknown
      end>
    DataSource = SourceDataModule.DSHorario
    MasterFields = 'CodHorario'
    MasterSource = SourceDataModule.DSHorario
    LinkedFields = 'CodHorario'
    Left = 60
    Top = 157
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CodHorario'
        ParamType = ptUnknown
      end>
    object QuParaleloCodHorario: TIntegerField
      FieldName = 'CodHorario'
      ReadOnly = True
      Visible = False
    end
    object QuParaleloCodNivel: TIntegerField
      FieldName = 'CodNivel'
      ReadOnly = True
      Visible = False
    end
    object QuParaleloCodEspecializacion: TIntegerField
      FieldName = 'CodEspecializacion'
      ReadOnly = True
      Visible = False
    end
    object QuParaleloCodParaleloId: TIntegerField
      FieldName = 'CodParaleloId'
      Visible = False
    end
    object QuParaleloAbrNivel: TWideStringField
      FieldName = 'AbrNivel'
      ReadOnly = True
      Visible = False
      Size = 5
    end
    object QuParaleloAbrEspecializacion: TWideStringField
      FieldName = 'AbrEspecializacion'
      ReadOnly = True
      Visible = False
      Size = 10
    end
    object QuParaleloNomParaleloId: TWideStringField
      FieldName = 'NomParaleloId'
      Required = True
      Visible = False
      Size = 5
    end
    object QuParaleloNomParalelo: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'NomParalelo'
      Size = 30
  
    end
  end
end
