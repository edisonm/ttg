inherited SourceDataModule: TSourceDataModule
  Left = 319
  Top = 144
  Height = 496
  Width = 758
  inherited TbAulaTipo: TkbmMemTable
    inherited TbAulaTipoCodAulaTipo: TAutoIncField
      Visible = False
    end
  end
  inherited TbEspecializacion: TkbmMemTable
    inherited TbEspecializacionCodEspecializacion: TAutoIncField
      Visible = False
    end
  end
  inherited TbDia: TkbmMemTable
    inherited TbDiaCodDia: TAutoIncField
      Visible = False
    end
  end
  inherited TbMateria: TkbmMemTable
    inherited TbMateriaCodMateria: TAutoIncField
      Visible = False
    end
  end
  inherited TbNivel: TkbmMemTable
    inherited TbNivelCodNivel: TAutoIncField
      Visible = False
    end
  end
  inherited TbHora: TkbmMemTable
    inherited TbHoraCodHora: TAutoIncField
      Visible = False
    end
  end
  inherited TbCurso: TkbmMemTable
    FieldDefs = <
      item
        Name = 'AbrNivel'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'AbrEspecializacion'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'CodNivel'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodEspecializacion'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    object TbCursoAbrNivel: TStringField [0]
      DisplayLabel = 'Nivel'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'AbrNivel'
      LookupDataSet = TbNivel
      LookupKeyFields = 'CodNivel'
      LookupResultField = 'AbrNivel'
      KeyFields = 'CodNivel'
      Size = 10
      Lookup = True
    end
    object TbCursoAbrEspecializacion: TStringField [1]
      DisplayLabel = 'Espec.'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'AbrEspecializacion'
      LookupDataSet = TbEspecializacion
      LookupKeyFields = 'CodEspecializacion'
      LookupResultField = 'AbrEspecializacion'
      KeyFields = 'CodEspecializacion'
      Size = 10
      Lookup = True
    end
    inherited TbCursoCodNivel: TIntegerField
      Visible = False
    end
    inherited TbCursoCodEspecializacion: TIntegerField
      Visible = False
    end
  end
  inherited TbParaleloId: TkbmMemTable
    inherited TbParaleloIdCodParaleloId: TAutoIncField
      Visible = False
    end
  end
  inherited TbMateriaProhibicionTipo: TkbmMemTable
    inherited TbMateriaProhibicionTipoCodMateProhibicionTipo: TIntegerField
      Visible = False
    end
  end
  inherited TbPeriodo: TkbmMemTable
    inherited TbPeriodoCodDia: TIntegerField
      Visible = False
    end
    inherited TbPeriodoCodHora: TIntegerField
      Visible = False
    end
  end
  inherited TbParalelo: TkbmMemTable
    FieldDefs = <
      item
        Name = 'CodNivel'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodEspecializacion'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodParaleloId'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'AbrNivel'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'AbrEspecializacion'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'NomParaleloId'
        DataType = ftString
        Size = 5
      end>
    inherited TbParaleloCodNivel: TIntegerField
      Visible = False
    end
    inherited TbParaleloCodEspecializacion: TIntegerField
      Visible = False
    end
    inherited TbParaleloCodParaleloId: TIntegerField
      Visible = False
    end
    object TbParaleloAbrNivel: TStringField
      DisplayLabel = 'Nivel'
      FieldKind = fkLookup
      FieldName = 'AbrNivel'
      LookupDataSet = TbNivel
      LookupKeyFields = 'CodNivel'
      LookupResultField = 'AbrNivel'
      KeyFields = 'CodNivel'
      Size = 5
      Lookup = True
    end
    object TbParaleloAbrEspecializacion: TStringField
      DisplayLabel = 'Especializacion'
      FieldKind = fkLookup
      FieldName = 'AbrEspecializacion'
      LookupDataSet = TbEspecializacion
      LookupKeyFields = 'CodEspecializacion'
      LookupResultField = 'AbrEspecializacion'
      KeyFields = 'CodEspecializacion'
      Size = 10
      Lookup = True
    end
    object TbParaleloNomParaleloId: TStringField
      DisplayLabel = 'Paralelo'
      FieldKind = fkLookup
      FieldName = 'NomParaleloId'
      LookupDataSet = TbParaleloId
      LookupKeyFields = 'CodParaleloId'
      LookupResultField = 'NomParaleloId'
      KeyFields = 'CodParaleloId'
      Size = 5
      Lookup = True
    end
  end
  inherited TbProfesor: TkbmMemTable
    FieldDefs = <
      item
        Name = 'CodProfesor'
        DataType = ftAutoInc
      end
      item
        Name = 'CedProfesor'
        Attributes = [faRequired]
        DataType = ftString
        Size = 11
      end
      item
        Name = 'ApeProfesor'
        Attributes = [faRequired]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'NomProfesor'
        Attributes = [faRequired]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'ApeNomProfesor'
        DataType = ftString
        Size = 31
      end>
    OnCalcFields = TbProfesorCalcFields
    inherited TbProfesorCodProfesor: TAutoIncField
      Visible = False
    end
    object TbProfesorApeNomProfesor: TStringField
      DisplayLabel = 'Apellido Nombre'
      DisplayWidth = 31
      FieldKind = fkCalculated
      FieldName = 'ApeNomProfesor'
      Visible = False
      Size = 31
      Calculated = True
    end
  end
  inherited TbMateriaProhibicion: TkbmMemTable
    FieldDefs = <
      item
        Name = 'CodMateria'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodDia'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodHora'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodMateProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NomMateProhibicionTipo'
        DataType = ftString
        Size = 10
      end>
    inherited TbMateriaProhibicionCodMateria: TIntegerField
      Visible = False
    end
    inherited TbMateriaProhibicionCodDia: TIntegerField
      Visible = False
    end
    inherited TbMateriaProhibicionCodHora: TIntegerField
      Visible = False
    end
    inherited TbMateriaProhibicionCodMateProhibicionTipo: TIntegerField
      Visible = False
    end
    object TbMateriaProhibicionNomMateProhibicionTipo: TStringField
      DisplayLabel = 'Tipo prohib. mat.'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'NomMateProhibicionTipo'
      LookupDataSet = TbMateriaProhibicionTipo
      LookupKeyFields = 'CodMateProhibicionTipo'
      LookupResultField = 'NomMateProhibicionTipo'
      KeyFields = 'CodMateProhibicionTipo'
      Size = 10
      Lookup = True
    end
  end
  inherited TbDistributivo: TkbmMemTable
    FieldDefs = <
      item
        Name = 'CodMateria'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodNivel'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodEspecializacion'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodParaleloId'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodProfesor'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodAulaTipo'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ApeNomProfesor'
        DataType = ftString
        Size = 31
      end
      item
        Name = 'AbrNivel'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'AbrEspecializacion'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'NomParaleloId'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'NomMateria'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'AbrAulaTipo'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Composicion'
        Attributes = [faRequired]
        DataType = ftString
        Size = 40
      end
      item
        Name = 'Duracion'
        DataType = ftInteger
      end>
    OnCalcFields = TbDistributivoCalcFields
    inherited TbDistributivoCodEspecializacion: TIntegerField
      Visible = False
    end
    inherited TbDistributivoCodAulaTipo: TIntegerField
      Visible = False
    end
    object TbDistributivoApeNomProfesor: TStringField [6]
      DisplayLabel = 'Profesor'
      DisplayWidth = 31
      FieldKind = fkLookup
      FieldName = 'ApeNomProfesor'
      LookupDataSet = TbProfesor
      LookupKeyFields = 'CodProfesor'
      LookupResultField = 'ApeNomProfesor'
      KeyFields = 'CodProfesor'
      Visible = False
      Size = 31
      Lookup = True
    end
    object TbDistributivoAbrNivel: TStringField [7]
      DisplayLabel = 'Nivel'
      FieldKind = fkLookup
      FieldName = 'AbrNivel'
      LookupDataSet = TbNivel
      LookupKeyFields = 'CodNivel'
      LookupResultField = 'AbrNivel'
      KeyFields = 'CodNivel'
      Size = 5
      Lookup = True
    end
    object TbDistributivoAbrEspecializacion: TStringField [8]
      DisplayLabel = 'Especializacion'
      FieldKind = fkLookup
      FieldName = 'AbrEspecializacion'
      LookupDataSet = TbEspecializacion
      LookupKeyFields = 'CodEspecializacion'
      LookupResultField = 'AbrEspecializacion'
      KeyFields = 'CodEspecializacion'
      Size = 10
      Lookup = True
    end
    object TbDistributivoNomParaleloId: TStringField [9]
      DisplayLabel = 'Paralelo'
      FieldKind = fkLookup
      FieldName = 'NomParaleloId'
      LookupDataSet = TbParaleloId
      LookupKeyFields = 'CodParaleloId'
      LookupResultField = 'NomParaleloId'
      KeyFields = 'CodParaleloId'
      Size = 5
      Lookup = True
    end
    object TbDistributivoNomMateria: TStringField [10]
      DisplayLabel = 'Materia'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'NomMateria'
      LookupDataSet = TbMateria
      LookupKeyFields = 'CodMateria'
      LookupResultField = 'NomMateria'
      KeyFields = 'CodMateria'
      Size = 15
      Lookup = True
    end
    object TbDistributivoAbrAulaTipo: TStringField [11]
      DisplayLabel = 'Tipo aula'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'AbrAulaTipo'
      LookupDataSet = TbAulaTipo
      LookupKeyFields = 'CodAulaTipo'
      LookupResultField = 'AbrAulaTipo'
      KeyFields = 'CodAulaTipo'
      Size = 10
      Lookup = True
    end
    object TbDistributivoDuracion: TIntegerField
      DisplayLabel = 'Duración'
      FieldKind = fkCalculated
      FieldName = 'Duracion'
      Calculated = True
    end
  end
  inherited TbHorarioDetalle: TkbmMemTable
    FieldDefs = <
      item
        Name = 'CodHorario'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodMateria'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodNivel'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodEspecializacion'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodParaleloId'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodDia'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodHora'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Sesion'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NomMateria'
        DataType = ftString
        Size = 15
      end>
    inherited TbHorarioDetalleCodHorario: TIntegerField
      Visible = False
    end
    inherited TbHorarioDetalleCodMateria: TIntegerField
      Visible = False
    end
    inherited TbHorarioDetalleCodNivel: TIntegerField
      Visible = False
    end
    inherited TbHorarioDetalleCodEspecializacion: TIntegerField
      Visible = False
    end
    inherited TbHorarioDetalleCodParaleloId: TIntegerField
      Visible = False
    end
    inherited TbHorarioDetalleCodDia: TIntegerField
      Visible = False
    end
    inherited TbHorarioDetalleCodHora: TIntegerField
      Visible = False
    end
    object TbHorarioDetalleNomMateria: TStringField
      DisplayLabel = 'Materia'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'NomMateria'
      LookupDataSet = TbMateria
      LookupKeyFields = 'CodMateria'
      LookupResultField = 'NomMateria'
      KeyFields = 'CodMateria'
      Size = 15
      Lookup = True
    end
  end
  inherited TbProfesorProhibicionTipo: TkbmMemTable
    inherited TbProfesorProhibicionTipoCodProfProhibicionTipo: TAutoIncField
      Visible = False
    end
  end
  inherited TbProfesorProhibicion: TkbmMemTable
    FieldDefs = <
      item
        Name = 'CodProfesor'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodDia'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodHora'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodProfProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NomProfProhibicionTipo'
        DataType = ftString
        Size = 10
      end>
    inherited TbProfesorProhibicionCodProfesor: TIntegerField
      Visible = False
    end
    inherited TbProfesorProhibicionCodDia: TIntegerField
      Visible = False
    end
    inherited TbProfesorProhibicionCodHora: TIntegerField
      Visible = False
    end
    inherited TbProfesorProhibicionCodProfProhibicionTipo: TIntegerField
      Visible = False
    end
    object TbProfesorProhibicionNomProfProhibicionTipo: TStringField
      DisplayLabel = 'Tipo prohib. prof.'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'NomProfProhibicionTipo'
      LookupDataSet = TbProfesorProhibicionTipo
      LookupKeyFields = 'CodProfProhibicionTipo'
      LookupResultField = 'NomProfProhibicionTipo'
      KeyFields = 'CodProfProhibicionTipo'
      Size = 10
      Lookup = True
    end
  end
end
