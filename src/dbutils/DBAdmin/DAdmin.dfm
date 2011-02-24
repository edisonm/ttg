object AdminDM: TAdminDM
  object kbmAulaTipo: TkbmMemTable
    left = 48
    top = 48
    active = True
    BeforePost = kbmAulaTipoBeforePost
    BeforeDelete = kbmAulaTipoBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmAulaTipoixAbrAulaTipo'
        Fields = 'AbrAulaTipo'
        Options = [ixUnique]
      end
      item
        Name = 'kbmAulaTipoixNomAulaTipo'
        Fields = 'NomAulaTipo'
        Options = [ixUnique]
      end
      item
        Name = 'kbmAulaTipoPrimaryKey'
        Fields = 'CodAulaTipo'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmAulaTipoCodAulaTipo:TAutoIncField
      FieldName = 'CodAulaTipo'
      DisplayLabel = 'Código'
    end
    object kbmAulaTipoNomAulaTipo:TStringField
      FieldName = 'NomAulaTipo'
      DisplayLabel = 'Nombre'
      Required = True
      Size = 25
    end
    object kbmAulaTipoAbrAulaTipo:TStringField
      FieldName = 'AbrAulaTipo'
      DisplayLabel = 'Abreviatura'
      Required = True
      Size = 10
    end
    object kbmAulaTipoCantidad:TIntegerField
      FieldName = 'Cantidad'
      DisplayLabel = 'Cantidad'
      Required = True
    end
  end
  object dsAulaTipo: TDataSource
    DataSet = kbmAulaTipo
    left = 56
    top = 40
  end
  object kbmEspecializacion: TkbmMemTable
    left = 144
    top = 60
    active = True
    BeforePost = kbmEspecializacionBeforePost
    BeforeDelete = kbmEspecializacionBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmEspecializacionixAbrEspecializacion'
        Fields = 'AbrEspecializacion'
        Options = [ixUnique]
      end
      item
        Name = 'kbmEspecializacionixNomEspecializacion'
        Fields = 'NomEspecializacion'
        Options = [ixUnique]
      end
      item
        Name = 'kbmEspecializacionPrimaryKey'
        Fields = 'CodEspecializacion'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmEspecializacionCodEspecializacion:TAutoIncField
      FieldName = 'CodEspecializacion'
      DisplayLabel = 'Código'
    end
    object kbmEspecializacionNomEspecializacion:TStringField
      FieldName = 'NomEspecializacion'
      DisplayLabel = 'Nombre'
      Required = True
      Size = 20
    end
    object kbmEspecializacionAbrEspecializacion:TStringField
      FieldName = 'AbrEspecializacion'
      DisplayLabel = 'Abreviatura'
      Required = True
      Size = 10
    end
  end
  object dsEspecializacion: TDataSource
    DataSet = kbmEspecializacion
    left = 152
    top = 52
  end
  object kbmMateria: TkbmMemTable
    left = 240
    top = 48
    active = True
    BeforePost = kbmMateriaBeforePost
    BeforeDelete = kbmMateriaBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmMateriaixNomMateria'
        Fields = 'NomMateria'
        Options = [ixUnique]
      end
      item
        Name = 'kbmMateriaPrimaryKey'
        Fields = 'CodMateria'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmMateriaCodMateria:TAutoIncField
      FieldName = 'CodMateria'
      DisplayLabel = 'Código'
    end
    object kbmMateriaNomMateria:TStringField
      FieldName = 'NomMateria'
      DisplayLabel = 'Nombre'
      Required = True
      Size = 20
    end
  end
  object dsMateria: TDataSource
    DataSet = kbmMateria
    left = 248
    top = 40
  end
  object kbmNivel: TkbmMemTable
    left = 336
    top = 60
    active = True
    BeforePost = kbmNivelBeforePost
    BeforeDelete = kbmNivelBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmNivelixAbrNivel'
        Fields = 'AbrNivel'
        Options = [ixUnique]
      end
      item
        Name = 'kbmNivelixNomNivel'
        Fields = 'NomNivel'
        Options = [ixUnique]
      end
      item
        Name = 'kbmNivelPrimaryKey'
        Fields = 'CodNivel'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmNivelCodNivel:TAutoIncField
      FieldName = 'CodNivel'
      DisplayLabel = 'Código'
    end
    object kbmNivelNomNivel:TStringField
      FieldName = 'NomNivel'
      DisplayLabel = 'Nombre'
      Required = True
      Size = 15
    end
    object kbmNivelAbrNivel:TStringField
      FieldName = 'AbrNivel'
      DisplayLabel = 'Abreviatura'
      Size = 5
    end
  end
  object dsNivel: TDataSource
    DataSet = kbmNivel
    left = 344
    top = 52
  end
  object kbmDia: TkbmMemTable
    left = 432
    top = 48
    active = True
    BeforePost = kbmDiaBeforePost
    BeforeDelete = kbmDiaBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmDiaixNomDia'
        Fields = 'NomDia'
        Options = [ixUnique]
      end
      item
        Name = 'kbmDiaPrimaryKey'
        Fields = 'CodDia'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmDiaCodDia:TAutoIncField
      FieldName = 'CodDia'
      DisplayLabel = 'Código'
    end
    object kbmDiaNomDia:TStringField
      FieldName = 'NomDia'
      DisplayLabel = 'Nombre'
      Required = True
      Size = 10
    end
  end
  object dsDia: TDataSource
    DataSet = kbmDia
    left = 440
    top = 40
  end
  object kbmCurso: TkbmMemTable
    left = 48
    top = 144
    active = True
    BeforePost = kbmCursoBeforePost
    BeforeDelete = kbmCursoBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmCursoEspecializacionCurso'
        Fields = 'CodEspecializacion'
      end
      item
        Name = 'kbmCursoNivelCurso'
        Fields = 'CodNivel'
      end
      item
        Name = 'kbmCursoPrimaryKey'
        Fields = 'CodNivel;CodEspecializacion'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmCursoCodNivel:TIntegerField
      FieldName = 'CodNivel'
      DisplayLabel = 'Nivel'
      Required = True
    end
    object kbmCursoCodEspecializacion:TIntegerField
      FieldName = 'CodEspecializacion'
      DisplayLabel = 'Especialización'
      Required = True
    end
  end
  object dsCurso: TDataSource
    DataSet = kbmCurso
    left = 56
    top = 136
  end
  object kbmHora: TkbmMemTable
    left = 144
    top = 156
    active = True
    BeforePost = kbmHoraBeforePost
    BeforeDelete = kbmHoraBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmHoraixIntervalo'
        Fields = 'Intervalo'
        Options = [ixUnique]
      end
      item
        Name = 'kbmHoraixNomHora'
        Fields = 'NomHora'
        Options = [ixUnique]
      end
      item
        Name = 'kbmHoraPrimaryKey'
        Fields = 'CodHora'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmHoraCodHora:TAutoIncField
      FieldName = 'CodHora'
      DisplayLabel = 'Código'
    end
    object kbmHoraNomHora:TStringField
      FieldName = 'NomHora'
      DisplayLabel = 'Nombre'
      Required = True
      Size = 10
    end
    object kbmHoraIntervalo:TStringField
      FieldName = 'Intervalo'
      DisplayLabel = 'Intervalo'
      Required = True
      Size = 21
    end
  end
  object dsHora: TDataSource
    DataSet = kbmHora
    left = 152
    top = 148
  end
  object kbmHorario: TkbmMemTable
    left = 240
    top = 144
    active = True
    BeforePost = kbmHorarioBeforePost
    BeforeDelete = kbmHorarioBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmHorarioixMomentoFinal'
        Fields = 'MomentoFinal'
      end
      item
        Name = 'kbmHorarioixMomentoInicial'
        Fields = 'MomentoInicial'
      end
      item
        Name = 'kbmHorarioPrimaryKey'
        Fields = 'CodHorario'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmHorarioCodHorario:TAutoIncField
      FieldName = 'CodHorario'
      DisplayLabel = 'Código'
    end
    object kbmHorarioMomentoInicial:TDateField
      FieldName = 'MomentoInicial'
      DisplayLabel = 'Momento Inicial'
      Required = True
    end
    object kbmHorarioMomentoFinal:TDateField
      FieldName = 'MomentoFinal'
      DisplayLabel = 'Momento Final'
      Required = True
    end
    object kbmHorarioInforme:TMemoField
      FieldName = 'Informe'
      DisplayLabel = 'Informe'
    end
  end
  object dsHorario: TDataSource
    DataSet = kbmHorario
    left = 248
    top = 136
  end
  object kbmHorarioLaborable: TkbmMemTable
    left = 336
    top = 156
    active = True
    BeforePost = kbmHorarioLaborableBeforePost
    BeforeDelete = kbmHorarioLaborableBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmHorarioLaborableDiaHorarioLaborable'
        Fields = 'CodDia'
      end
      item
        Name = 'kbmHorarioLaborableHoraHorarioLaborable'
        Fields = 'CodHora'
      end
      item
        Name = 'kbmHorarioLaborablePrimaryKey'
        Fields = 'CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmHorarioLaborableCodDia:TIntegerField
      FieldName = 'CodDia'
      DisplayLabel = 'Día'
      Required = True
    end
    object kbmHorarioLaborableCodHora:TIntegerField
      FieldName = 'CodHora'
      DisplayLabel = 'Hora'
      Required = True
    end
  end
  object dsHorarioLaborable: TDataSource
    DataSet = kbmHorarioLaborable
    left = 344
    top = 148
  end
  object kbmParaleloId: TkbmMemTable
    left = 432
    top = 144
    active = True
    BeforePost = kbmParaleloIdBeforePost
    BeforeDelete = kbmParaleloIdBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmParaleloIdixNomParaleloId'
        Fields = 'NomParaleloId'
        Options = [ixUnique]
      end
      item
        Name = 'kbmParaleloIdPrimaryKey'
        Fields = 'CodParaleloId'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmParaleloIdCodParaleloId:TAutoIncField
      FieldName = 'CodParaleloId'
      DisplayLabel = 'Código'
    end
    object kbmParaleloIdNomParaleloId:TStringField
      FieldName = 'NomParaleloId'
      DisplayLabel = 'Nombre'
      Required = True
      Size = 5
    end
  end
  object dsParaleloId: TDataSource
    DataSet = kbmParaleloId
    left = 440
    top = 136
  end
  object kbmParalelo: TkbmMemTable
    left = 48
    top = 240
    active = True
    BeforePost = kbmParaleloBeforePost
    BeforeDelete = kbmParaleloBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmParaleloCursoParalelo'
        Fields = 'CodNivel;CodEspecializacion'
      end
      item
        Name = 'kbmParaleloParaleloIdParalelo'
        Fields = 'CodParaleloId'
      end
      item
        Name = 'kbmParaleloPrimaryKey'
        Fields = 'CodNivel;CodEspecializacion;CodParaleloId'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmParaleloCodNivel:TIntegerField
      FieldName = 'CodNivel'
      DisplayLabel = 'Nivel'
      Required = True
    end
    object kbmParaleloCodEspecializacion:TIntegerField
      FieldName = 'CodEspecializacion'
      DisplayLabel = 'Especialización'
      Required = True
    end
    object kbmParaleloCodParaleloId:TIntegerField
      FieldName = 'CodParaleloId'
      DisplayLabel = 'Paralelo'
      Required = True
    end
  end
  object dsParalelo: TDataSource
    DataSet = kbmParalelo
    left = 56
    top = 232
  end
  object kbmMateriaProhibicionTipo: TkbmMemTable
    left = 144
    top = 252
    active = True
    BeforePost = kbmMateriaProhibicionTipoBeforePost
    BeforeDelete = kbmMateriaProhibicionTipoBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmMateriaProhibicionTipoixNomMateProhibicionTipo'
        Fields = 'NomMateProhibicionTipo'
        Options = [ixUnique]
      end
      item
        Name = 'kbmMateriaProhibicionTipoPrimaryKey'
        Fields = 'CodMateProhibicionTipo'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmMateriaProhibicionTipoCodMateProhibicionTipo:TIntegerField
      FieldName = 'CodMateProhibicionTipo'
      DisplayLabel = 'Código'
      Required = True
    end
    object kbmMateriaProhibicionTipoNomMateProhibicionTipo:TStringField
      FieldName = 'NomMateProhibicionTipo'
      DisplayLabel = 'Nombre'
      Required = True
      Size = 10
    end
    object kbmMateriaProhibicionTipoColMateProhibicionTipo:TIntegerField
      FieldName = 'ColMateProhibicionTipo'
      DisplayLabel = 'Color'
      Required = True
    end
    object kbmMateriaProhibicionTipoValMateProhibicionTipo:TFloatField
      FieldName = 'ValMateProhibicionTipo'
      DisplayLabel = 'Valor'
      Required = True
    end
  end
  object dsMateriaProhibicionTipo: TDataSource
    DataSet = kbmMateriaProhibicionTipo
    left = 152
    top = 244
  end
  object kbmMateriaProhibicion: TkbmMemTable
    left = 240
    top = 240
    active = True
    BeforePost = kbmMateriaProhibicionBeforePost
    IndexDefs = <
      item
        Name = 'kbmMateriaProhibicionHorarioLaborableMateriaProhibicion'
        Fields = 'CodDia;CodHora'
      end
      item
        Name = 'kbmMateriaProhibicionMateriaMateriaProhibicion'
        Fields = 'CodMateria'
      end
      item
        Name = 'kbmMateriaProhibicionMateriaProhibicionTipoMateriaProhibicion'
        Fields = 'CodMateProhibicionTipo'
      end
      item
        Name = 'kbmMateriaProhibicionPrimaryKey'
        Fields = 'CodMateria;CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmMateriaProhibicionCodMateria:TIntegerField
      FieldName = 'CodMateria'
      DisplayLabel = 'Materia'
      Required = True
    end
    object kbmMateriaProhibicionCodDia:TIntegerField
      FieldName = 'CodDia'
      DisplayLabel = 'Día'
      Required = True
    end
    object kbmMateriaProhibicionCodHora:TIntegerField
      FieldName = 'CodHora'
      DisplayLabel = 'Hora'
      Required = True
    end
    object kbmMateriaProhibicionCodMateProhibicionTipo:TIntegerField
      FieldName = 'CodMateProhibicionTipo'
      DisplayLabel = 'Tipo de Prohibición'
      Required = True
    end
  end
  object dsMateriaProhibicion: TDataSource
    DataSet = kbmMateriaProhibicion
    left = 248
    top = 232
  end
  object kbmAsignatura: TkbmMemTable
    left = 336
    top = 252
    active = True
    BeforePost = kbmAsignaturaBeforePost
    IndexDefs = <
      item
        Name = 'kbmAsignaturaAulaTipoAsignatura'
        Fields = 'CodAulaTipo'
      end
      item
        Name = 'kbmAsignaturaCursoAsignatura'
        Fields = 'CodNivel;CodEspecializacion'
      end
      item
        Name = 'kbmAsignaturaMateriaAsignatura'
        Fields = 'CodMateria'
      end
      item
        Name = 'kbmAsignaturaPrimaryKey'
        Fields = 'CodMateria;CodNivel;CodEspecializacion'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmAsignaturaCodMateria:TIntegerField
      FieldName = 'CodMateria'
      DisplayLabel = 'Materia'
      Required = True
    end
    object kbmAsignaturaCodNivel:TIntegerField
      FieldName = 'CodNivel'
      DisplayLabel = 'Nivel'
      Required = True
    end
    object kbmAsignaturaCodEspecializacion:TIntegerField
      FieldName = 'CodEspecializacion'
      DisplayLabel = 'Especialización'
      Required = True
    end
    object kbmAsignaturaCodAulaTipo:TIntegerField
      FieldName = 'CodAulaTipo'
      DisplayLabel = 'Tipo de Aula'
      Required = True
    end
    object kbmAsignaturaComposicion:TStringField
      FieldName = 'Composicion'
      DisplayLabel = 'Composición'
      Required = True
      Size = 20
    end
  end
  object dsAsignatura: TDataSource
    DataSet = kbmAsignatura
    left = 344
    top = 244
  end
  object kbmProfesor: TkbmMemTable
    left = 432
    top = 240
    active = True
    BeforePost = kbmProfesorBeforePost
    BeforeDelete = kbmProfesorBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmProfesorixApeNomProfesor'
        Fields = 'ApeProfesor;NomProfesor'
        Options = [ixUnique]
      end
      item
        Name = 'kbmProfesorixNomApeProfesor'
        Fields = 'NomProfesor;ApeProfesor'
        Options = [ixUnique]
      end
      item
        Name = 'kbmProfesorPrimaryKey'
        Fields = 'CodProfesor'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmProfesorCodProfesor:TAutoIncField
      FieldName = 'CodProfesor'
      DisplayLabel = 'Código'
    end
    object kbmProfesorCedProfesor:TStringField
      FieldName = 'CedProfesor'
      DisplayLabel = 'Cédula'
      Required = True
      Size = 11
    end
    object kbmProfesorApeProfesor:TStringField
      FieldName = 'ApeProfesor'
      DisplayLabel = 'Apellido'
      Required = True
      Size = 15
    end
    object kbmProfesorNomProfesor:TStringField
      FieldName = 'NomProfesor'
      DisplayLabel = 'Nombre'
      Required = True
      Size = 15
    end
  end
  object dsProfesor: TDataSource
    DataSet = kbmProfesor
    left = 440
    top = 232
  end
  object kbmCargaAcademica: TkbmMemTable
    left = 48
    top = 336
    active = True
    BeforePost = kbmCargaAcademicaBeforePost
    BeforeDelete = kbmCargaAcademicaBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmCargaAcademicaCargaAcademicaNivel'
        Fields = 'CodNivel'
      end
      item
        Name = 'kbmCargaAcademicaMateriaCargaAcademica'
        Fields = 'CodMateria'
      end
      item
        Name = 'kbmCargaAcademicaParaleloCargaAcademica'
        Fields = 'CodNivel;CodEspecializacion;CodParaleloId'
      end
      item
        Name = 'kbmCargaAcademicaPrimaryKey'
        Fields = 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'kbmCargaAcademicaProfesorCargaAcademica'
        Fields = 'CodProfesor'
      end>
    object kbmCargaAcademicaCodMateria:TIntegerField
      FieldName = 'CodMateria'
      DisplayLabel = 'Materia'
      Required = True
    end
    object kbmCargaAcademicaCodNivel:TIntegerField
      FieldName = 'CodNivel'
      DisplayLabel = 'Nivel'
      Required = True
    end
    object kbmCargaAcademicaCodEspecializacion:TIntegerField
      FieldName = 'CodEspecializacion'
      DisplayLabel = 'Especialización'
      Required = True
    end
    object kbmCargaAcademicaCodParaleloId:TIntegerField
      FieldName = 'CodParaleloId'
      DisplayLabel = 'Paralelo'
      Required = True
    end
    object kbmCargaAcademicaCodProfesor:TIntegerField
      FieldName = 'CodProfesor'
      DisplayLabel = 'Profesor'
      Required = True
    end
  end
  object dsCargaAcademica: TDataSource
    DataSet = kbmCargaAcademica
    left = 56
    top = 328
  end
  object kbmHorarioDetalle: TkbmMemTable
    left = 144
    top = 348
    active = True
    BeforePost = kbmHorarioDetalleBeforePost
    IndexDefs = <
      item
        Name = 'kbmHorarioDetalleCargaAcademicaHorarioDetalle'
        Fields = 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId'
      end
      item
        Name = 'kbmHorarioDetalleHorarioHorarioDetalle'
        Fields = 'CodHorario'
      end
      item
        Name = 'kbmHorarioDetalleHorarioLaborableHorarioDetalle'
        Fields = 'CodDia;CodHora'
      end
      item
        Name = 'kbmHorarioDetallePrimaryKey'
        Fields = 'CodHorario;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmHorarioDetalleCodHorario:TIntegerField
      FieldName = 'CodHorario'
      DisplayLabel = 'Horario'
      Required = True
    end
    object kbmHorarioDetalleCodNivel:TIntegerField
      FieldName = 'CodNivel'
      DisplayLabel = 'Nivel'
      Required = True
    end
    object kbmHorarioDetalleCodEspecializacion:TIntegerField
      FieldName = 'CodEspecializacion'
      DisplayLabel = 'Especialización'
      Required = True
    end
    object kbmHorarioDetalleCodParaleloId:TIntegerField
      FieldName = 'CodParaleloId'
      DisplayLabel = 'Paralelo'
      Required = True
    end
    object kbmHorarioDetalleCodDia:TIntegerField
      FieldName = 'CodDia'
      DisplayLabel = 'Día'
      Required = True
    end
    object kbmHorarioDetalleCodHora:TIntegerField
      FieldName = 'CodHora'
      DisplayLabel = 'Hora'
      Required = True
    end
    object kbmHorarioDetalleCodMateria:TIntegerField
      FieldName = 'CodMateria'
      DisplayLabel = 'Materia'
      Required = True
    end
    object kbmHorarioDetalleSesion:TIntegerField
      FieldName = 'Sesion'
      DisplayLabel = 'Sesión'
      Required = True
    end
  end
  object dsHorarioDetalle: TDataSource
    DataSet = kbmHorarioDetalle
    left = 152
    top = 340
  end
  object kbmProfesorProhibicionTipo: TkbmMemTable
    left = 240
    top = 336
    active = True
    BeforePost = kbmProfesorProhibicionTipoBeforePost
    BeforeDelete = kbmProfesorProhibicionTipoBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmProfesorProhibicionTipoixNomProfProhibicionTipo'
        Fields = 'NomProfProhibicionTipo'
        Options = [ixUnique]
      end
      item
        Name = 'kbmProfesorProhibicionTipoPrimaryKey'
        Fields = 'CodProfProhibicionTipo'
        Options = [ixPrimary, ixUnique]
      end>
    object kbmProfesorProhibicionTipoCodProfProhibicionTipo:TAutoIncField
      FieldName = 'CodProfProhibicionTipo'
      DisplayLabel = 'Código'
    end
    object kbmProfesorProhibicionTipoNomProfProhibicionTipo:TStringField
      FieldName = 'NomProfProhibicionTipo'
      DisplayLabel = 'Nombre'
      Required = True
      Size = 10
    end
    object kbmProfesorProhibicionTipoColProfProhibicionTipo:TIntegerField
      FieldName = 'ColProfProhibicionTipo'
      DisplayLabel = 'Color'
      Required = True
    end
    object kbmProfesorProhibicionTipoValProfProhibicionTipo:TFloatField
      FieldName = 'ValProfProhibicionTipo'
      DisplayLabel = 'Valor'
      Required = True
    end
  end
  object dsProfesorProhibicionTipo: TDataSource
    DataSet = kbmProfesorProhibicionTipo
    left = 248
    top = 328
  end
  object kbmProfesorProhibicion: TkbmMemTable
    left = 336
    top = 348
    active = True
    BeforePost = kbmProfesorProhibicionBeforePost
    IndexDefs = <
      item
        Name = 'kbmProfesorProhibicionHorarioLaborableProfesorProhibicion'
        Fields = 'CodDia;CodHora'
      end
      item
        Name = 'kbmProfesorProhibicionPrimaryKey'
        Fields = 'CodProfesor;CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'kbmProfesorProhibicionProfesorProfesorProhibicion'
        Fields = 'CodProfesor'
      end
      item
        Name = 'kbmProfesorProhibicionProfesorProhibicionTipoProfesorProhibicion'
        Fields = 'CodProfProhibicionTipo'
      end>
    object kbmProfesorProhibicionCodProfesor:TIntegerField
      FieldName = 'CodProfesor'
      DisplayLabel = 'Profesor'
      Required = True
    end
    object kbmProfesorProhibicionCodDia:TIntegerField
      FieldName = 'CodDia'
      DisplayLabel = 'Día'
      Required = True
    end
    object kbmProfesorProhibicionCodHora:TIntegerField
      FieldName = 'CodHora'
      DisplayLabel = 'Hora'
      Required = True
    end
    object kbmProfesorProhibicionCodProfProhibicionTipo:TIntegerField
      FieldName = 'CodProfProhibicionTipo'
      DisplayLabel = 'Tipo de prohibición'
      Required = True
    end
  end
  object dsProfesorProhibicion: TDataSource
    DataSet = kbmProfesorProhibicion
    left = 344
    top = 340
  end
end
