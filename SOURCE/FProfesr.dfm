inherited ProfesorForm: TProfesorForm
  Left = 375
  Top = 194
  Width = 710
  Height = 427
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited tb97Show: TToolBar
    Width = 702
    object btn97ProfesorProhibicion: TToolButton [2]
      Left = 46
      Top = 0
      Hint = 'Prohibiciones de profesor|Prohibiciones de profesor'
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = btn97ProfesorProhibicionClick
    end
    object btn97Distributivo: TToolButton [3]
      Left = 69
      Top = 0
      Hint = 'Distributivo|Ver distributivo del profesor'
      ImageIndex = 3
      ParentShowHint = False
      ShowHint = True
      OnClick = btn97DistributivoClick
    end
    inherited DBNavigator: TDBNavigator
      Left = 92
      Hints.Strings = ()
    end
  end
  inherited pnlStatus: TPanel
    Top = 381
    Width = 702
  end
  inherited Panel1: TPanel
    Width = 702
    Height = 356
    inherited DBGrid: TDBGrid
      Width = 700
      Height = 354
    end
  end
end
