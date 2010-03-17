object SplashForm: TSplashForm
  Left = 181
  Top = 260
  BorderStyle = bsNone
  ClientHeight = 182
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010002002020100000000000E80200002600000010101000000000002801
    00000E0300002800000020000000400000000100040000000000800200000000
    0000000000000000000000000000000000000000800000800000008080008000
    00008000800080800000C0C0C000808080000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000088
    8888888888888888888888888880000000000000000000000000000000800077
    0777787777877778777787777080007707777877778777787777877770800088
    0888888888888888888888888080007707777877778777787777877770800077
    0F77787777877778777787777080008808888888888888888888888880800077
    0777787777877778777787777080007707777877778777787777877770800088
    088888888888888888888888808000FF0FFFF8FFFF8FFFF8FFFF8FFFF08000FF
    0FFFF8FFFF8FFFF8FFFF8FFFF080008808888888888888888888888880800077
    0777787777877778777787777080007707777877778777787777877770800088
    0888888888888888888888888080007707777877778777787777877770800077
    0777787777877778777787777080008808888888888888888888888880800077
    0777787777877778777787777080007707777877778777787777877770800000
    000000000000000000000000008000770F7778F7778F7778F7778F7770800000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFC00000018000
    0001800000018000000180000001800000018000000180000001800000018000
    0001800000018000000180000001800000018000000180000001800000018000
    000180000001800000018000000180000001800000018000000180000003FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFF280000001000000020000000010004000000
    0000C00000000000000000000000000000000000000000000000000080000080
    000000808000800000008000800080800000C0C0C000808080000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000000
    00000000000000000000000000000770FF8FF8FF8FF00FF07787787787700770
    FF8FF8FF8FF00FF07787787787700770FF8FF8FF8FF00FF07787787787700770
    FF8FF8FF8FF00FF07787787787700770FF8FF8FF8FF000000000000000000770
    F78F78F7877000000000000000000000000000000000FFFF0000FFFF00000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000FFFF0000}
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 373
    Height = 182
    Align = alClient
    Stretch = True
  end
  object lblProductName: TLabel
    Left = 88
    Top = 24
    Width = 15
    Height = 22
    Caption = '...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblProductVersion: TLabel
    Left = 168
    Top = 64
    Width = 9
    Height = 16
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object lblCopyright: TLabel
    Left = 168
    Top = 88
    Width = 9
    Height = 16
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel
    Left = 8
    Top = 136
    Width = 69
    Height = 16
    Caption = 'Cargando...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object lblTable: TLabel
    Left = 104
    Top = 136
    Width = 257
    Height = 13
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object lblYearLabel: TLabel
    Left = 168
    Top = 112
    Width = 9
    Height = 16
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 88
    Top = 64
    Width = 46
    Height = 16
    Caption = 'Versión'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 88
    Top = 88
    Width = 64
    Height = 16
    Caption = 'Ejecutable'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 88
    Top = 112
    Width = 45
    Height = 16
    Caption = 'Edición'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object PBLoad: TProgressBar
    Left = 8
    Top = 160
    Width = 353
    Height = 13
    Min = 0
    Max = 8
    TabOrder = 0
  end
end
