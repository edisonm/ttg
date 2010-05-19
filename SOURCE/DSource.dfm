inherited SourceDataModule: TSourceDataModule
  inherited TbAulaTipo: TDbf
    inherited TbAulaTipoCodAulaTipo: TIntegerField
      Visible = False
    end
  end
  inherited TbEspecializacion: TDbf
    inherited TbEspecializacionCodEspecializacion: TIntegerField
      Visible = False
    end
  end
  inherited TbDia: TDbf
    inherited TbDiaCodDia: TIntegerField
      Visible = False
    end
  end
  inherited TbMateria: TDbf
    inherited TbMateriaCodMateria: TIntegerField
      Visible = False
    end
  end
  inherited TbNivel: TDbf
    inherited TbNivelCodNivel: TIntegerField
      Visible = False
    end
  end
  inherited TbHora: TDbf
    inherited TbHoraCodHora: TIntegerField
      Visible = False
    end
  end
  inherited TbCurso: TDbf
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
  inherited TbParaleloId: TDbf
    inherited TbParaleloIdCodParaleloId: TIntegerField
      Visible = False
    end
  end
  inherited TbMateriaProhibicionTipo: TDbf
    inherited TbMateriaProhibicionTipoCodMateProhibicionTipo: TIntegerField
      Visible = False
    end
  end
  inherited TbPeriodo: TDbf
    inherited TbPeriodoCodDia: TIntegerField
      Visible = False
    end
    inherited TbPeriodoCodHora: TIntegerField
      Visible = False
    end
  end
  inherited TbParalelo: TDbf
    FieldDefs = <
      item
        Name = 'CodParalelo'
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
      end>
    OnCalcFields = TbParaleloCalcFields
    object TbParaleloCodParalelo: TIntegerField [0]
      AutoGenerateValue = arAutoInc
      DefaultExpression = '0'
      FieldName = 'CodParalelo'
    end
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
    object TbParaleloNomParalelo: TStringField
      FieldKind = fkCalculated
      FieldName = 'NomParalelo'
      Calculated = True
    end
  end
  inherited TbProfesor: TDbf
    OnCalcFields = TbProfesorCalcFields
    inherited TbProfesorCodProfesor: TIntegerField
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
  inherited TbMateriaProhibicion: TDbf
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
  inherited TbDistributivo: TDbf
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
  inherited TbHorarioDetalle: TDbf
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
  inherited TbProfesorProhibicionTipo: TDbf
    inherited TbProfesorProhibicionTipoCodProfProhibicionTipo: TIntegerField
      Visible = False
    end
  end
  inherited TbProfesorProhibicion: TDbf
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
