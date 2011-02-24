object BaseDataModule: TBaseDataModule
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 928
  object Database: TZConnection
    Protocol = 'sqlite-3'
    Database = ':memory:'
    Left = 528
    Top = 16
  end
end
