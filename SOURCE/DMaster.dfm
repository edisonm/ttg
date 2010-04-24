object MasterDataModule: TMasterDataModule
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 222
  Top = 122
  Height = 404
  Width = 748
  object TbTmpProfesorCarga: TkbmMemTable
    FieldDefs = <>
    IndexDefs = <>
    Left = 250
    Top = 11
    object TbTmpProfesorCargaCodProfesor: TIntegerField
      DisplayLabel = 'Profesor'
      FieldName = 'CodProfesor'
    end
    object TbTmpProfesorCargaApeProfesor: TStringField
      DisplayLabel = 'Apellido'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'ApeProfesor'
      LookupKeyFields = 'CodProfesor'
      LookupResultField = 'ApeProfesor'
      KeyFields = 'CodProfesor'
      Size = 31
    end
    object TbTmpProfesorCargaNomProfesor: TStringField
      DisplayLabel = 'Nombre'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'NomProfesor'
      LookupKeyFields = 'CodProfesor'
      LookupResultField = 'NomProfesor'
      KeyFields = 'CodProfesor'
      Size = 31
    end
    object TbTmpProfesorCargaCarga: TIntegerField
      FieldName = 'Carga'
    end
  end
  object QuDistributivoProfesor: TkbmMemTable
    FieldDefs = <>
    IndexDefs = <>
    Left = 250
    Top = 115
    object QuDistributivoProfesorCodMateria: TIntegerField
      FieldName = 'CodMateria'
      Visible = False
    end
    object QuDistributivoProfesorCodNivel: TIntegerField
      FieldName = 'CodNivel'
      Visible = False
    end
    object QuDistributivoProfesorCodEspecializacion: TIntegerField
      FieldName = 'CodEspecializacion'
    end
    object QuDistributivoProfesorCodParaleloId: TIntegerField
      FieldName = 'CodParaleloId'
      Visible = False
    end
    object QuDistributivoProfesorCodProfesor: TIntegerField
      FieldName = 'CodProfesor'
      Visible = False
    end
    object QuDistributivoProfesorNomMateria: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Materia'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'NomMateria'
      LookupKeyFields = 'CodMateria'
      LookupResultField = 'NomMateria'
      KeyFields = 'CodMateria'
      Size = 15
    end
    object QuDistributivoProfesorAbrNivel: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Nivel'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'AbrNivel'
      LookupKeyFields = 'CodNivel'
      LookupResultField = 'AbrNivel'
      KeyFields = 'CodNivel'
      Size = 10
    end
    object QuDistributivoProfesorAbrEspecializacion: TStringField
      DisplayLabel = 'Espec.'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'AbrEspecializacion'
      LookupKeyFields = 'CodEspecializacion'
      LookupResultField = 'AbrEspecializacion'
      KeyFields = 'CodEspecializacion'
      Required = True
      Size = 10
    end
    object QuDistributivoProfesorNomParaleloId: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Par.'
      FieldKind = fkLookup
      FieldName = 'NomParaleloId'
      LookupKeyFields = 'CodParaleloId'
      LookupResultField = 'NomParaleloId'
      KeyFields = 'CodParaleloId'
      Size = 5
    end
    object QuDistributivoProfesorApeNomProfesor: TStringField
      DisplayLabel = 'Profesor'
      DisplayWidth = 31
      FieldKind = fkLookup
      FieldName = 'ApeNomProfesor'
      LookupKeyFields = 'CodProfesor'
      LookupResultField = 'ApeNomProfesor'
      KeyFields = 'CodProfesor'
      Size = 31
    end
  end
  object QuProfesorProhibicionCant: TkbmMemTable
    FieldDefs = <>
    IndexDefs = <>
    Left = 58
    Top = 157
    object QuProfesorProhibicionCantCodProfesor: TIntegerField
      FieldName = 'CodProfesor'
    end
    object QuProfesorProhibicionCantCantidad: TIntegerField
      FieldName = 'Cantidad'
    end
  end
  object TbTmpAulaTipoCarga: TkbmMemTable
    FieldDefs = <>
    IndexDefs = <>
    Left = 250
    Top = 62
    object TbTmpAulaTipoCargaCodAulaTipo: TIntegerField
      DisplayLabel = 'Tipo de aula'
      FieldName = 'CodAulaTipo'
    end
    object TbTmpAulaTipoCargaAbrAulaTipo: TStringField
      DisplayLabel = 'Nombre'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'AbrAulaTipo'
      LookupKeyFields = 'CodAulaTipo'
      LookupResultField = 'AbrAulaTipo'
      KeyFields = 'CodAulaTipo'
      Size = 31
    end
    object TbTmpAulaTipoCargaCarga: TIntegerField
      FieldName = 'Carga'
    end
  end
end
