inherited SourceDataModule: TSourceDataModule
  Left = 488
  Top = 108
  Height = 496
  Width = 758
  inherited TbAulaTipo: TkbmMemTable
    inherited TbAulaTipoCodAulaTipo: TAutoIncField
      Visible = False
    end
  end
  inherited TbEspecializacion: TkbmMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'CodEspecializacion'
        DataType = ftAutoInc
      end
      item
        Name = 'NomEspecializacion'
        Attributes = [faRequired]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AbrEspecializacion'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end>
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
    Active = True
    FieldDefs = <
      item
        Name = 'CodMateria'
        DataType = ftAutoInc
      end
      item
        Name = 'NomMateria'
        Attributes = [faRequired]
        DataType = ftString
        Size = 20
      end>
    inherited TbMateriaCodMateria: TAutoIncField
      Visible = False
    end
  end
  inherited TbNivel: TkbmMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'CodNivel'
        DataType = ftAutoInc
      end
      item
        Name = 'NomNivel'
        Attributes = [faRequired]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'AbrNivel'
        DataType = ftString
        Size = 5
      end>
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
    Active = True
    FieldDefs = <
      item
        Name = 'CodParaleloId'
        DataType = ftAutoInc
      end
      item
        Name = 'NomParaleloId'
        Attributes = [faRequired]
        DataType = ftString
        Size = 5
      end>
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
    AttachMaxCount = 2
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
    Active = True
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
      DisplayLabel = 'Duraci'#243'n'
      FieldKind = fkCalculated
      FieldName = 'Duracion'
      Calculated = True
    end
  end
  inherited TbHorarioDetalle: TkbmMemTable
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
