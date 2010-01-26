inherited SourceDataModule: TSourceDataModule
  Left = 319
  Top = 144
  Height = 496
  Width = 758
  inherited kbmAulaTipo: TkbmMemTable
    inherited kbmAulaTipoCodAulaTipo: TAutoIncField
      Visible = False
    end
  end
  inherited kbmEspecializacion: TkbmMemTable
    inherited kbmEspecializacionCodEspecializacion: TAutoIncField
      Visible = False
    end
  end
  inherited kbmDia: TkbmMemTable
    inherited kbmDiaCodDia: TAutoIncField
      Visible = False
    end
  end
  inherited kbmMateria: TkbmMemTable
    inherited kbmMateriaCodMateria: TAutoIncField
      Visible = False
    end
  end
  inherited kbmNivel: TkbmMemTable
    inherited kbmNivelCodNivel: TAutoIncField
      Visible = False
    end
  end
  inherited kbmHora: TkbmMemTable
    inherited kbmHoraCodHora: TAutoIncField
      Visible = False
    end
  end
  inherited kbmCurso: TkbmMemTable
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
    object kbmCursoAbrNivel: TStringField [0]
      DisplayLabel = 'Nivel'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'AbrNivel'
      LookupDataSet = kbmNivel
      LookupKeyFields = 'CodNivel'
      LookupResultField = 'AbrNivel'
      KeyFields = 'CodNivel'
      Size = 10
      Lookup = True
    end
    object kbmCursoAbrEspecializacion: TStringField [1]
      DisplayLabel = 'Espec.'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'AbrEspecializacion'
      LookupDataSet = kbmEspecializacion
      LookupKeyFields = 'CodEspecializacion'
      LookupResultField = 'AbrEspecializacion'
      KeyFields = 'CodEspecializacion'
      Size = 10
      Lookup = True
    end
    inherited kbmCursoCodNivel: TIntegerField
      Visible = False
    end
    inherited kbmCursoCodEspecializacion: TIntegerField
      Visible = False
    end
  end
  inherited kbmParaleloId: TkbmMemTable
    inherited kbmParaleloIdCodParaleloId: TAutoIncField
      Visible = False
    end
  end
  inherited kbmMateriaProhibicionTipo: TkbmMemTable
    inherited kbmMateriaProhibicionTipoCodMateProhibicionTipo: TIntegerField
      Visible = False
    end
  end
  inherited kbmPeriodo: TkbmMemTable
    inherited kbmPeriodoCodDia: TIntegerField
      Visible = False
    end
    inherited kbmPeriodoCodHora: TIntegerField
      Visible = False
    end
  end
  inherited kbmParalelo: TkbmMemTable
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
    inherited kbmParaleloCodNivel: TIntegerField
      Visible = False
    end
    inherited kbmParaleloCodEspecializacion: TIntegerField
      Visible = False
    end
    inherited kbmParaleloCodParaleloId: TIntegerField
      Visible = False
    end
    object kbmParaleloAbrNivel: TStringField
      DisplayLabel = 'Nivel'
      FieldKind = fkLookup
      FieldName = 'AbrNivel'
      LookupDataSet = kbmNivel
      LookupKeyFields = 'CodNivel'
      LookupResultField = 'AbrNivel'
      KeyFields = 'CodNivel'
      Size = 5
      Lookup = True
    end
    object kbmParaleloAbrEspecializacion: TStringField
      DisplayLabel = 'Especializacion'
      FieldKind = fkLookup
      FieldName = 'AbrEspecializacion'
      LookupDataSet = kbmEspecializacion
      LookupKeyFields = 'CodEspecializacion'
      LookupResultField = 'AbrEspecializacion'
      KeyFields = 'CodEspecializacion'
      Size = 10
      Lookup = True
    end
    object kbmParaleloNomParaleloId: TStringField
      DisplayLabel = 'Paralelo'
      FieldKind = fkLookup
      FieldName = 'NomParaleloId'
      LookupDataSet = kbmParaleloId
      LookupKeyFields = 'CodParaleloId'
      LookupResultField = 'NomParaleloId'
      KeyFields = 'CodParaleloId'
      Size = 5
      Lookup = True
    end
  end
  inherited kbmProfesor: TkbmMemTable
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
    OnCalcFields = kbmProfesorCalcFields
    inherited kbmProfesorCodProfesor: TAutoIncField
      Visible = False
    end
    object kbmProfesorApeNomProfesor: TStringField
      DisplayLabel = 'Apellido Nombre'
      DisplayWidth = 31
      FieldKind = fkCalculated
      FieldName = 'ApeNomProfesor'
      Visible = False
      Size = 31
      Calculated = True
    end
  end
  inherited kbmMateriaProhibicion: TkbmMemTable
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
    inherited kbmMateriaProhibicionCodMateria: TIntegerField
      Visible = False
    end
    inherited kbmMateriaProhibicionCodDia: TIntegerField
      Visible = False
    end
    inherited kbmMateriaProhibicionCodHora: TIntegerField
      Visible = False
    end
    inherited kbmMateriaProhibicionCodMateProhibicionTipo: TIntegerField
      Visible = False
    end
    object TbMateriaProhibicionNomMateProhibicionTipo: TStringField
      DisplayLabel = 'Tipo prohib. mat.'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'NomMateProhibicionTipo'
      LookupDataSet = kbmMateriaProhibicionTipo
      LookupKeyFields = 'CodMateProhibicionTipo'
      LookupResultField = 'NomMateProhibicionTipo'
      KeyFields = 'CodMateProhibicionTipo'
      Size = 10
      Lookup = True
    end
  end
  inherited kbmDistributivo: TkbmMemTable
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
    OnCalcFields = kbmDistributivoCalcFields
    inherited kbmDistributivoCodEspecializacion: TIntegerField
      Visible = False
    end
    inherited kbmDistributivoCodAulaTipo: TIntegerField
      Visible = False
    end
    object kbmDistributivoApeNomProfesor: TStringField [6]
      DisplayLabel = 'Profesor'
      DisplayWidth = 31
      FieldKind = fkLookup
      FieldName = 'ApeNomProfesor'
      LookupDataSet = kbmProfesor
      LookupKeyFields = 'CodProfesor'
      LookupResultField = 'ApeNomProfesor'
      KeyFields = 'CodProfesor'
      Visible = False
      Size = 31
      Lookup = True
    end
    object kbmDistributivoAbrNivel: TStringField [7]
      DisplayLabel = 'Nivel'
      FieldKind = fkLookup
      FieldName = 'AbrNivel'
      LookupDataSet = kbmNivel
      LookupKeyFields = 'CodNivel'
      LookupResultField = 'AbrNivel'
      KeyFields = 'CodNivel'
      Size = 5
      Lookup = True
    end
    object kbmDistributivoAbrEspecializacion: TStringField [8]
      DisplayLabel = 'Especializacion'
      FieldKind = fkLookup
      FieldName = 'AbrEspecializacion'
      LookupDataSet = kbmEspecializacion
      LookupKeyFields = 'CodEspecializacion'
      LookupResultField = 'AbrEspecializacion'
      KeyFields = 'CodEspecializacion'
      Size = 10
      Lookup = True
    end
    object kbmDistributivoNomParaleloId: TStringField [9]
      DisplayLabel = 'Paralelo'
      FieldKind = fkLookup
      FieldName = 'NomParaleloId'
      LookupDataSet = kbmParaleloId
      LookupKeyFields = 'CodParaleloId'
      LookupResultField = 'NomParaleloId'
      KeyFields = 'CodParaleloId'
      Size = 5
      Lookup = True
    end
    object kbmDistributivoNomMateria: TStringField [10]
      DisplayLabel = 'Materia'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'NomMateria'
      LookupDataSet = kbmMateria
      LookupKeyFields = 'CodMateria'
      LookupResultField = 'NomMateria'
      KeyFields = 'CodMateria'
      Size = 15
      Lookup = True
    end
    object kbmDistributivoAbrAulaTipo: TStringField [11]
      DisplayLabel = 'Tipo aula'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'AbrAulaTipo'
      LookupDataSet = kbmAulaTipo
      LookupKeyFields = 'CodAulaTipo'
      LookupResultField = 'AbrAulaTipo'
      KeyFields = 'CodAulaTipo'
      Size = 10
      Lookup = True
    end
    object kbmDistributivoDuracion: TIntegerField
      DisplayLabel = 'Duración'
      FieldKind = fkCalculated
      FieldName = 'Duracion'
      Calculated = True
    end
  end
  inherited kbmHorarioDetalle: TkbmMemTable
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
    inherited kbmHorarioDetalleCodHorario: TIntegerField
      Visible = False
    end
    inherited kbmHorarioDetalleCodMateria: TIntegerField
      Visible = False
    end
    inherited kbmHorarioDetalleCodNivel: TIntegerField
      Visible = False
    end
    inherited kbmHorarioDetalleCodEspecializacion: TIntegerField
      Visible = False
    end
    inherited kbmHorarioDetalleCodParaleloId: TIntegerField
      Visible = False
    end
    inherited kbmHorarioDetalleCodDia: TIntegerField
      Visible = False
    end
    inherited kbmHorarioDetalleCodHora: TIntegerField
      Visible = False
    end
    object kbmHorarioDetalleNomMateria: TStringField
      DisplayLabel = 'Materia'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'NomMateria'
      LookupDataSet = kbmMateria
      LookupKeyFields = 'CodMateria'
      LookupResultField = 'NomMateria'
      KeyFields = 'CodMateria'
      Size = 15
      Lookup = True
    end
  end
  inherited kbmProfesorProhibicionTipo: TkbmMemTable
    inherited kbmProfesorProhibicionTipoCodProfProhibicionTipo: TAutoIncField
      Visible = False
    end
  end
  inherited kbmProfesorProhibicion: TkbmMemTable
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
    inherited kbmProfesorProhibicionCodProfesor: TIntegerField
      Visible = False
    end
    inherited kbmProfesorProhibicionCodDia: TIntegerField
      Visible = False
    end
    inherited kbmProfesorProhibicionCodHora: TIntegerField
      Visible = False
    end
    inherited kbmProfesorProhibicionCodProfProhibicionTipo: TIntegerField
      Visible = False
    end
    object TbProfesorProhibicionNomProfProhibicionTipo: TStringField
      DisplayLabel = 'Tipo prohib. prof.'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'NomProfProhibicionTipo'
      LookupDataSet = kbmProfesorProhibicionTipo
      LookupKeyFields = 'CodProfProhibicionTipo'
      LookupResultField = 'NomProfProhibicionTipo'
      KeyFields = 'CodProfProhibicionTipo'
      Size = 10
      Lookup = True
    end
  end
end
