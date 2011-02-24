object DMPrueba: TDMPrueba
  object kbmAulaTipo: TkbmMemTable
    left = 48
    top = 48
    BeforePost = kbmAulaTipoBeforePost
    BeforeDelete = kbmAulaTipoBeforeDelete
    IndexDefs = <
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
    object tbmAulaTipoCodAulaTipo:TIntegerField
      FieldName = 'CodAulaTipo'
      Required = True
    end
    object tbmAulaTipoNomAulaTipo:TStringField
      FieldName = 'NomAulaTipo'
      Required = True
      Size = 25
    end
    object tbmAulaTipoCantidad:TIntegerField
      FieldName = 'Cantidad'
      Required = True
    end
  end
  object dsAulaTipo: TDataSource
    DataSet = kbmAulaTipo
    left = 56
    top = 40
  end
  object kbmCurso: TkbmMemTable
    left = 144
    top = 60
    BeforePost = kbmCursoBeforePost
    BeforeDelete = kbmCursoBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmCursoNomCurso'
        Fields = 'NomCurso'
        Options = [ixUnique]
      end
      item
        Name = 'kbmCursoPrimaryKey'
        Fields = 'CodCurso'
        Options = [ixPrimary, ixUnique]
      end>
    object tbmCursoCodCurso:TIntegerField
      FieldName = 'CodCurso'
      Required = True
    end
    object tbmCursoNomCurso:TStringField
      FieldName = 'NomCurso'
      Required = True
      Size = 25
    end
  end
  object dsCurso: TDataSource
    DataSet = kbmCurso
    left = 152
    top = 52
  end
  object kbmDia: TkbmMemTable
    left = 240
    top = 48
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
    object tbmDiaCodDia:TIntegerField
      FieldName = 'CodDia'
      Required = True
    end
    object tbmDiaNomDia:TStringField
      FieldName = 'NomDia'
      Required = True
      Size = 10
    end
  end
  object dsDia: TDataSource
    DataSet = kbmDia
    left = 248
    top = 40
  end
  object kbmMateria: TkbmMemTable
    left = 336
    top = 60
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
    object tbmMateriaCodMateria:TIntegerField
      FieldName = 'CodMateria'
      Required = True
    end
    object tbmMateriaNomMateria:TStringField
      FieldName = 'NomMateria'
      Required = True
      Size = 20
    end
  end
  object dsMateria: TDataSource
    DataSet = kbmMateria
    left = 344
    top = 52
  end
  object kbmParaleloId: TkbmMemTable
    left = 432
    top = 48
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
    object tbmParaleloIdCodParaleloId:TIntegerField
      FieldName = 'CodParaleloId'
      Required = True
    end
    object tbmParaleloIdNomParaleloId:TStringField
      FieldName = 'NomParaleloId'
      Required = True
      Size = 5
    end
  end
  object dsParaleloId: TDataSource
    DataSet = kbmParaleloId
    left = 440
    top = 40
  end
  object kbmParalelo: TkbmMemTable
    left = 48
    top = 144
    BeforePost = kbmParaleloBeforePost
    BeforeDelete = kbmParaleloBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmParaleloCursoParalelo'
        Fields = 'CodCurso'
      end
      item
        Name = 'kbmParaleloParaleloIdParalelo'
        Fields = 'CodParaleloId'
      end
      item
        Name = 'kbmParaleloPrimaryKey'
        Fields = 'CodCurso;CodParaleloId'
        Options = [ixPrimary, ixUnique]
      end>
    object tbmParaleloCodCurso:TIntegerField
      FieldName = 'CodCurso'
      Required = True
    end
    object tbmParaleloCodParaleloId:TIntegerField
      FieldName = 'CodParaleloId'
      Required = True
    end
  end
  object dsParalelo: TDataSource
    DataSet = kbmParalelo
    left = 56
    top = 136
  end
  object kbmHora: TkbmMemTable
    left = 144
    top = 156
    BeforePost = kbmHoraBeforePost
    BeforeDelete = kbmHoraBeforeDelete
    IndexDefs = <
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
    object tbmHoraCodHora:TIntegerField
      FieldName = 'CodHora'
      Required = True
    end
    object tbmHoraNomHora:TStringField
      FieldName = 'NomHora'
      Required = True
      Size = 10
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
    object tbmHorarioCodHorario:TIntegerField
      FieldName = 'CodHorario'
      Required = True
    end
    object tbmHorarioMomentoInicial:TDateField
      FieldName = 'MomentoInicial'
      Required = True
    end
    object tbmHorarioMomentoFinal:TDateField
      FieldName = 'MomentoFinal'
      Required = True
    end
    object tbmHorarioInforme:TMemoField
      FieldName = 'Informe'
    end
  end
  object dsHorario: TDataSource
    DataSet = kbmHorario
    left = 248
    top = 136
  end
  object kbmPeriodo: TkbmMemTable
    left = 336
    top = 156
    BeforePost = kbmPeriodoBeforePost
    BeforeDelete = kbmPeriodoBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmPeriodoDiaHorarioLaborable'
        Fields = 'CodDia'
      end
      item
        Name = 'kbmPeriodoHoraHorarioLaborable'
        Fields = 'CodHora'
      end
      item
        Name = 'kbmPeriodoPrimaryKey'
        Fields = 'CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end>
    object tbmPeriodoCodDia:TIntegerField
      FieldName = 'CodDia'
      Required = True
    end
    object tbmPeriodoCodHora:TIntegerField
      FieldName = 'CodHora'
      Required = True
    end
  end
  object dsPeriodo: TDataSource
    DataSet = kbmPeriodo
    left = 344
    top = 148
  end
  object kbmDistributivo: TkbmMemTable
    left = 432
    top = 144
    BeforePost = kbmDistributivoBeforePost
    BeforeDelete = kbmDistributivoBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmDistributivoAulaTipoCargaAcademica'
        Fields = 'CodAulaTipo'
      end
      item
        Name = 'kbmDistributivoMateriaCargaAcademica'
        Fields = 'CodMateria'
      end
      item
        Name = 'kbmDistributivoParaleloCargaAcademica'
        Fields = 'CodCurso;CodParaleloId'
      end
      item
        Name = 'kbmDistributivoPrimaryKey'
        Fields = 'CodMateria;CodCurso;CodParaleloId'
        Options = [ixPrimary, ixUnique]
      end>
    object tbmDistributivoCodMateria:TIntegerField
      FieldName = 'CodMateria'
      Required = True
    end
    object tbmDistributivoCodCurso:TIntegerField
      FieldName = 'CodCurso'
      Required = True
    end
    object tbmDistributivoCodParaleloId:TIntegerField
      FieldName = 'CodParaleloId'
      Required = True
    end
    object tbmDistributivoCodAulaTipo:TIntegerField
      FieldName = 'CodAulaTipo'
      DefaultExpression = '0'
    end
    object tbmDistributivoComposicion:TStringField
      FieldName = 'Composicion'
      Required = True
      Size = 50
    end
  end
  object dsDistributivo: TDataSource
    DataSet = kbmDistributivo
    left = 440
    top = 136
  end
  object kbmMateriaProhibicionTipo: TkbmMemTable
    left = 48
    top = 240
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
    object tbmMateriaProhibicionTipoCodMateProhibicionTipo:TIntegerField
      FieldName = 'CodMateProhibicionTipo'
      Required = True
    end
    object tbmMateriaProhibicionTipoNomMateProhibicionTipo:TStringField
      FieldName = 'NomMateProhibicionTipo'
      Required = True
      Size = 10
    end
    object tbmMateriaProhibicionTipoColMateProhibicionTipo:TIntegerField
      FieldName = 'ColMateProhibicionTipo'
      Required = True
    end
    object tbmMateriaProhibicionTipoValMateProhibicionTipo:TFloatField
      FieldName = 'ValMateProhibicionTipo'
      Required = True
    end
  end
  object dsMateriaProhibicionTipo: TDataSource
    DataSet = kbmMateriaProhibicionTipo
    left = 56
    top = 232
  end
  object kbmMateriaProhibicion: TkbmMemTable
    left = 144
    top = 252
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
    object tbmMateriaProhibicionCodMateria:TIntegerField
      FieldName = 'CodMateria'
      Required = True
    end
    object tbmMateriaProhibicionCodDia:TIntegerField
      FieldName = 'CodDia'
      Required = True
    end
    object tbmMateriaProhibicionCodHora:TIntegerField
      FieldName = 'CodHora'
      Required = True
    end
    object tbmMateriaProhibicionCodMateProhibicionTipo:TIntegerField
      FieldName = 'CodMateProhibicionTipo'
      Required = True
    end
  end
  object dsMateriaProhibicion: TDataSource
    DataSet = kbmMateriaProhibicion
    left = 152
    top = 244
  end
  object kbmDistributivoVinculo: TkbmMemTable
    left = 240
    top = 240
    BeforePost = kbmDistributivoVinculoBeforePost
    IndexDefs = <
      item
        Name = 'kbmDistributivoVinculoCodCurso'
        Fields = 'CodCurso1'
      end
      item
        Name = 'kbmDistributivoVinculoCodCurso1'
        Fields = 'CodCurso2'
      end
      item
        Name = 'kbmDistributivoVinculoDistributivoVinculo'
        Fields = 'CodMateria1;CodCurso1;CodParaleloId1'
      end
      item
        Name = 'kbmDistributivoVinculoDistributivoVinculo1'
        Fields = 'CodMateria2;CodCurso2;CodParaleloId2'
      end
      item
        Name = 'kbmDistributivoVinculoPrimaryKey'
        Fields = 'CodMateria1;CodCurso1;CodParaleloId1;CodMateria2;CodCurso2;CodParaleloId2'
        Options = [ixPrimary, ixUnique]
      end>
    object tbmDistributivoVinculoCodMateria1:TIntegerField
      FieldName = 'CodMateria1'
      Required = True
    end
    object tbmDistributivoVinculoCodCurso1:TIntegerField
      FieldName = 'CodCurso1'
      Required = True
    end
    object tbmDistributivoVinculoCodParaleloId1:TIntegerField
      FieldName = 'CodParaleloId1'
      Required = True
    end
    object tbmDistributivoVinculoCodMateria2:TIntegerField
      FieldName = 'CodMateria2'
      Required = True
    end
    object tbmDistributivoVinculoCodCurso2:TIntegerField
      FieldName = 'CodCurso2'
      Required = True
    end
    object tbmDistributivoVinculoCodParaleloId2:TIntegerField
      FieldName = 'CodParaleloId2'
      Required = True
    end
  end
  object dsDistributivoVinculo: TDataSource
    DataSet = kbmDistributivoVinculo
    left = 248
    top = 232
  end
  object kbmProfesor: TkbmMemTable
    left = 336
    top = 252
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
    object tbmProfesorCodProfesor:TIntegerField
      FieldName = 'CodProfesor'
      Required = True
    end
    object tbmProfesorApeProfesor:TStringField
      FieldName = 'ApeProfesor'
      Required = True
      Size = 15
    end
    object tbmProfesorNomProfesor:TStringField
      FieldName = 'NomProfesor'
      Required = True
      Size = 15
    end
  end
  object dsProfesor: TDataSource
    DataSet = kbmProfesor
    left = 344
    top = 244
  end
  object kbmParaleloProhibicionTipo: TkbmMemTable
    left = 432
    top = 240
    BeforePost = kbmParaleloProhibicionTipoBeforePost
    BeforeDelete = kbmParaleloProhibicionTipoBeforeDelete
    IndexDefs = <
      item
        Name = 'kbmParaleloProhibicionTipoixNomMateProhibicionTipo'
        Fields = 'NomParaProhibicionTipo'
        Options = [ixUnique]
      end
      item
        Name = 'kbmParaleloProhibicionTipoPrimaryKey'
        Fields = 'CodParaProhibicionTipo'
        Options = [ixPrimary, ixUnique]
      end>
    object tbmParaleloProhibicionTipoCodParaProhibicionTipo:TIntegerField
      FieldName = 'CodParaProhibicionTipo'
      Required = True
    end
    object tbmParaleloProhibicionTipoNomParaProhibicionTipo:TStringField
      FieldName = 'NomParaProhibicionTipo'
      Required = True
      Size = 10
    end
    object tbmParaleloProhibicionTipoColParaProhibicionTipo:TIntegerField
      FieldName = 'ColParaProhibicionTipo'
      Required = True
    end
    object tbmParaleloProhibicionTipoValParaProhibicionTipo:TFloatField
      FieldName = 'ValParaProhibicionTipo'
      Required = True
    end
  end
  object dsParaleloProhibicionTipo: TDataSource
    DataSet = kbmParaleloProhibicionTipo
    left = 440
    top = 232
  end
  object kbmParaleloProhibicion: TkbmMemTable
    left = 48
    top = 336
    BeforePost = kbmParaleloProhibicionBeforePost
    IndexDefs = <
      item
        Name = 'kbmParaleloProhibicionCodParaleloId'
        Fields = 'CodParaleloId'
      end
      item
        Name = 'kbmParaleloProhibicionHorarioLaborableParaleloProhibicion'
        Fields = 'CodDia;CodHora'
      end
      item
        Name = 'kbmParaleloProhibicionParaleloParaleloProhibicion'
        Fields = 'CodCurso;CodParaleloId'
      end
      item
        Name = 'kbmParaleloProhibicionParaleloProhibicionTipoParaleloProhibicion'
        Fields = 'CodParaProhibicionTipo'
      end
      item
        Name = 'kbmParaleloProhibicionPrimaryKey'
        Fields = 'CodCurso;CodParaleloId;CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end>
    object tbmParaleloProhibicionCodCurso:TIntegerField
      FieldName = 'CodCurso'
      Required = True
    end
    object tbmParaleloProhibicionCodParaleloId:TIntegerField
      FieldName = 'CodParaleloId'
      DefaultExpression = '0'
    end
    object tbmParaleloProhibicionCodDia:TIntegerField
      FieldName = 'CodDia'
      Required = True
    end
    object tbmParaleloProhibicionCodHora:TIntegerField
      FieldName = 'CodHora'
      Required = True
    end
    object tbmParaleloProhibicionCodParaProhibicionTipo:TIntegerField
      FieldName = 'CodParaProhibicionTipo'
      Required = True
    end
  end
  object dsParaleloProhibicion: TDataSource
    DataSet = kbmParaleloProhibicion
    left = 56
    top = 328
  end
  object kbmHorarioDetalle: TkbmMemTable
    left = 144
    top = 348
    BeforePost = kbmHorarioDetalleBeforePost
    IndexDefs = <
      item
        Name = 'kbmHorarioDetalleCargaAcademicaHorarioDetalle'
        Fields = 'CodMateria;CodCurso;CodParaleloId'
      end
      item
        Name = 'kbmHorarioDetalleHorarioDetalleCodMateria'
        Fields = 'CodMateria'
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
        Fields = 'CodHorario;CodCurso;CodParaleloId;CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end>
    object tbmHorarioDetalleCodHorario:TIntegerField
      FieldName = 'CodHorario'
      Required = True
    end
    object tbmHorarioDetalleCodCurso:TIntegerField
      FieldName = 'CodCurso'
      Required = True
    end
    object tbmHorarioDetalleCodParaleloId:TIntegerField
      FieldName = 'CodParaleloId'
      Required = True
    end
    object tbmHorarioDetalleCodDia:TIntegerField
      FieldName = 'CodDia'
      Required = True
    end
    object tbmHorarioDetalleCodHora:TIntegerField
      FieldName = 'CodHora'
      Required = True
    end
    object tbmHorarioDetalleCodMateria:TIntegerField
      FieldName = 'CodMateria'
      Required = True
    end
    object tbmHorarioDetalleSesion:TIntegerField
      FieldName = 'Sesion'
      Required = True
    end
  end
  object dsHorarioDetalle: TDataSource
    DataSet = kbmHorarioDetalle
    left = 152
    top = 340
  end
  object kbmDistributivoProfesor: TkbmMemTable
    left = 240
    top = 336
    BeforePost = kbmDistributivoProfesorBeforePost
    IndexDefs = <
      item
        Name = 'kbmDistributivoProfesorDistributivoDistributivoProfesor'
        Fields = 'CodMateria;CodCurso;CodParaleloId'
      end
      item
        Name = 'kbmDistributivoProfesorPrimaryKey'
        Fields = 'CodMateria;CodCurso;CodParaleloId;CodProfesor'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'kbmDistributivoProfesorProfesorDistributivoProfesor'
        Fields = 'CodProfesor'
      end>
    object tbmDistributivoProfesorCodMateria:TIntegerField
      FieldName = 'CodMateria'
      Required = True
    end
    object tbmDistributivoProfesorCodCurso:TIntegerField
      FieldName = 'CodCurso'
      Required = True
    end
    object tbmDistributivoProfesorCodParaleloId:TIntegerField
      FieldName = 'CodParaleloId'
      Required = True
    end
    object tbmDistributivoProfesorCodProfesor:TIntegerField
      FieldName = 'CodProfesor'
      Required = True
    end
  end
  object dsDistributivoProfesor: TDataSource
    DataSet = kbmDistributivoProfesor
    left = 248
    top = 328
  end
  object kbmProfesorProhibicionTipo: TkbmMemTable
    left = 336
    top = 348
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
    object tbmProfesorProhibicionTipoCodProfProhibicionTipo:TIntegerField
      FieldName = 'CodProfProhibicionTipo'
      Required = True
    end
    object tbmProfesorProhibicionTipoNomProfProhibicionTipo:TStringField
      FieldName = 'NomProfProhibicionTipo'
      Required = True
      Size = 10
    end
    object tbmProfesorProhibicionTipoColProfProhibicionTipo:TIntegerField
      FieldName = 'ColProfProhibicionTipo'
      Required = True
    end
    object tbmProfesorProhibicionTipoValProfProhibicionTipo:TFloatField
      FieldName = 'ValProfProhibicionTipo'
      Required = True
    end
  end
  object dsProfesorProhibicionTipo: TDataSource
    DataSet = kbmProfesorProhibicionTipo
    left = 344
    top = 340
  end
  object kbmProfesorProhibicion: TkbmMemTable
    left = 432
    top = 336
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
    object tbmProfesorProhibicionCodProfesor:TIntegerField
      FieldName = 'CodProfesor'
      Required = True
    end
    object tbmProfesorProhibicionCodDia:TIntegerField
      FieldName = 'CodDia'
      Required = True
    end
    object tbmProfesorProhibicionCodHora:TIntegerField
      FieldName = 'CodHora'
      Required = True
    end
    object tbmProfesorProhibicionCodProfProhibicionTipo:TIntegerField
      FieldName = 'CodProfProhibicionTipo'
      Required = True
    end
  end
  object dsProfesorProhibicion: TDataSource
    DataSet = kbmProfesorProhibicion
    left = 440
    top = 328
  end
end
