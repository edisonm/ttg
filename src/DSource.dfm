inherited SourceDataModule: TSourceDataModule
  inherited Database: TSqlitePassDatabase
    Connected = True
    Database = 'E:\apps\pascal\TTG\dat\TTG.s3fpc'
    DatatypeOptions.BooleanFormat = 'True,Yes,On,1,-False,No,Off,0'
    DatatypeOptions.DateTimeFormat = 'YYYY-MM-DD hh:mm:ss'
    DatatypeOptions.DateTimeStorage = dtsText
    DatatypeOptions.DecimalSeparator = '.'
    DatatypeOptions.DefaultFieldType = ftString
    DatatypeOptions.SaveOptions = []
    DatatypeOptions.pCustomFieldDefs = ()
    DatatypeOptions.pTranslationsRules = (
      '__memo'
      4
      'Memo'
      '__string'
      4
      'String'
      'autoinc'
      4
      'Largeint'
      'boolean'
      4
      'Boolean'
      'currency'
      4
      'Currency'
      'datetime'
      4
      'DateTime'
      'date'
      4
      'Date'
      'float'
      4
      'Float'
      'int'
      4
      'Integer'
      'integer'
      4
      'Integer'
      'largeint'
      4
      'Largeint'
      'numeric'
      4
      'Float'
      'text'
      4
      'Memo'
      'time'
      4
      'Time'
      'varchar'
      4
      'String'
      'word'
      4
      'Word')
    Options.MaxPageCount = 1073741823
    VersionInfo.Schema = 19
    VersionInfo.SqliteLibrary = '3.7.5'
    VersionInfo.SqliteLibraryNumber = 3007005
    VersionInfo.SqliteSourceId = '2011-01-28 17:03:50 ed759d5a9edb3bba5f48f243df47be29e3fe8cd7'
    VersionInfo.UserTag = 0
  end
  inherited TbAulaTipo: TSqlitePassDataset
    pParams = ()
  end
  inherited TbEspecializacion: TSqlitePassDataset
    pParams = ()
  end
  inherited TbDia: TSqlitePassDataset
    Indexed = False
    IndexedBy = ''
    SQL.Strings = (
      'SELECT * FROM "Dia";')
    pParams = ()
  end
  inherited TbMateria: TSqlitePassDataset
    pParams = ()
  end
  inherited TbNivel: TSqlitePassDataset
    pParams = ()
  end
  inherited TbHora: TSqlitePassDataset
    pParams = ()
  end
  inherited TbHorario: TSqlitePassDataset
    pParams = ()
  end
  inherited TbCurso: TSqlitePassDataset
    pParams = ()
  end
  inherited TbParaleloId: TSqlitePassDataset
    pParams = ()
  end
  inherited TbMateriaProhibicionTipo: TSqlitePassDataset
    pParams = ()
  end
  inherited TbPeriodo: TSqlitePassDataset
    DatasetName = 'Periodo'
    Indexed = False
    IndexedBy = ''
    SQL.Strings = (
      'SELECT * FROM "Periodo";')
    pParams = ()
  end
  inherited TbParalelo: TSqlitePassDataset
    pParams = ()
  end
  inherited TbProfesor: TSqlitePassDataset
    pParams = ()
  end
  inherited TbMateriaProhibicion: TSqlitePassDataset
    pParams = ()
  end
  inherited TbDistributivo: TSqlitePassDataset
    pParams = ()
  end
  inherited TbHorarioDetalle: TSqlitePassDataset
    pParams = ()
  end
  inherited TbProfesorProhibicionTipo: TSqlitePassDataset
    pParams = ()
  end
  inherited TbProfesorProhibicion: TSqlitePassDataset
    pParams = ()
  end
end
