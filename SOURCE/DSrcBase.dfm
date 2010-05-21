inherited SourceBaseDataModule: TSourceBaseDataModule
  object TbAulaTipo: TkbmMemTable
    Tag = 0
    FieldDefs = <
      item
        Name = 'CodAulaTipo'
        DataType = ftAutoInc
      end
      item
        Name = 'NomAulaTipo'
        DataType = ftString
        Precision = -1
        Size = 25
        Attributes = [faRequired]
      end
      item
        Name = 'AbrAulaTipo'
        DataType = ftString
        Precision = -1
        Size = 10
        Attributes = [faRequired]
      end
      item
        Name = 'Cantidad'
        DataType = ftInteger
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 48
    Top = 48
    object TbAulaTipoCodAulaTipo: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodAulaTipo'
    end
    object TbAulaTipoNomAulaTipo: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomAulaTipo'
      Required = True
      Size = 25
    end
    object TbAulaTipoAbrAulaTipo: TStringField
      DisplayLabel = 'Abreviatura'
      FieldName = 'AbrAulaTipo'
      Required = True
      Size = 10
    end
    object TbAulaTipoCantidad: TIntegerField
      DisplayLabel = 'Cantidad'
      FieldName = 'Cantidad'
      Required = True
    end
  end
  object DSAulaTipo: TDataSource
    DataSet = TbAulaTipo
    Left = 56
    Top = 40
  end
  object TbEspecializacion: TkbmMemTable
    Tag = 1
    FieldDefs = <
      item
        Name = 'CodEspecializacion'
        DataType = ftAutoInc
      end
      item
        Name = 'NomEspecializacion'
        DataType = ftString
        Precision = -1
        Size = 20
        Attributes = [faRequired]
      end
      item
        Name = 'AbrEspecializacion'
        DataType = ftString
        Precision = -1
        Size = 10
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 144
    Top = 60
    object TbEspecializacionCodEspecializacion: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodEspecializacion'
    end
    object TbEspecializacionNomEspecializacion: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomEspecializacion'
      Required = True
      Size = 20
    end
    object TbEspecializacionAbrEspecializacion: TStringField
      DisplayLabel = 'Abreviatura'
      FieldName = 'AbrEspecializacion'
      Required = True
      Size = 10
    end
  end
  object DSEspecializacion: TDataSource
    DataSet = TbEspecializacion
    Left = 152
    Top = 52
  end
  object TbDia: TkbmMemTable
    Tag = 2
    FieldDefs = <
      item
        Name = 'CodDia'
        DataType = ftAutoInc
      end
      item
        Name = 'NomDia'
        DataType = ftString
        Precision = -1
        Size = 10
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 240
    Top = 48
    object TbDiaCodDia: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodDia'
    end
    object TbDiaNomDia: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomDia'
      Required = True
      Size = 10
    end
  end
  object DSDia: TDataSource
    DataSet = TbDia
    Left = 248
    Top = 40
  end
  object TbMateria: TkbmMemTable
    Tag = 3
    FieldDefs = <
      item
        Name = 'CodMateria'
        DataType = ftAutoInc
      end
      item
        Name = 'NomMateria'
        DataType = ftString
        Precision = -1
        Size = 20
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 336
    Top = 60
    object TbMateriaCodMateria: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodMateria'
    end
    object TbMateriaNomMateria: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomMateria'
      Required = True
      Size = 20
    end
  end
  object DSMateria: TDataSource
    DataSet = TbMateria
    Left = 344
    Top = 52
  end
  object TbNivel: TkbmMemTable
    Tag = 4
    FieldDefs = <
      item
        Name = 'CodNivel'
        DataType = ftAutoInc
      end
      item
        Name = 'NomNivel'
        DataType = ftString
        Precision = -1
        Size = 15
        Attributes = [faRequired]
      end
      item
        Name = 'AbrNivel'
        DataType = ftString
        Precision = -1
        Size = 5
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 432
    Top = 48
    object TbNivelCodNivel: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodNivel'
    end
    object TbNivelNomNivel: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomNivel'
      Required = True
      Size = 15
    end
    object TbNivelAbrNivel: TStringField
      DisplayLabel = 'Abreviatura'
      FieldName = 'AbrNivel'
      Size = 5
    end
  end
  object DSNivel: TDataSource
    DataSet = TbNivel
    Left = 440
    Top = 40
  end
  object TbHora: TkbmMemTable
    Tag = 5
    FieldDefs = <
      item
        Name = 'CodHora'
        DataType = ftAutoInc
      end
      item
        Name = 'NomHora'
        DataType = ftString
        Precision = -1
        Size = 10
        Attributes = [faRequired]
      end
      item
        Name = 'Intervalo'
        DataType = ftString
        Precision = -1
        Size = 21
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 48
    Top = 144
    object TbHoraCodHora: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodHora'
    end
    object TbHoraNomHora: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomHora'
      Required = True
      Size = 10
    end
    object TbHoraIntervalo: TStringField
      DisplayLabel = 'Intervalo'
      FieldName = 'Intervalo'
      Required = True
      Size = 21
    end
  end
  object DSHora: TDataSource
    DataSet = TbHora
    Left = 56
    Top = 136
  end
  object TbHorario: TkbmMemTable
    Tag = 6
    FieldDefs = <
      item
        Name = 'CodHorario'
        DataType = ftAutoInc
      end
      item
        Name = 'MomentoInicial'
        DataType = ftDateTime
        Attributes = [faRequired]
      end
      item
        Name = 'MomentoFinal'
        DataType = ftDateTime
        Attributes = [faRequired]
      end
      item
        Name = 'Informe'
        DataType = ftMemo
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 144
    Top = 156
    object TbHorarioCodHorario: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodHorario'
    end
    object TbHorarioMomentoInicial: TDateTimeField
      DisplayLabel = 'Momento Inicial'
      FieldName = 'MomentoInicial'
      Required = True
    end
    object TbHorarioMomentoFinal: TDateTimeField
      DisplayLabel = 'Momento Final'
      FieldName = 'MomentoFinal'
      Required = True
    end
    object TbHorarioInforme: TMemoField
      DisplayLabel = 'Informe'
      FieldName = 'Informe'
    end
  end
  object DSHorario: TDataSource
    DataSet = TbHorario
    Left = 152
    Top = 148
  end
  object TbCurso: TkbmMemTable
    Tag = 7
    FieldDefs = <
      item
        Name = 'CodNivel'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodEspecializacion'
        DataType = ftInteger
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 240
    Top = 144
    object TbCursoCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
    end
    object TbCursoCodEspecializacion: TIntegerField
      DisplayLabel = 'Especializaci'#243'n'
      FieldName = 'CodEspecializacion'
      Required = True
    end
  end
  object DSCurso: TDataSource
    DataSet = TbCurso
    Left = 248
    Top = 136
  end
  object TbParaleloId: TkbmMemTable
    Tag = 8
    FieldDefs = <
      item
        Name = 'CodParaleloId'
        DataType = ftAutoInc
      end
      item
        Name = 'NomParaleloId'
        DataType = ftString
        Precision = -1
        Size = 5
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 336
    Top = 156
    object TbParaleloIdCodParaleloId: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodParaleloId'
    end
    object TbParaleloIdNomParaleloId: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomParaleloId'
      Required = True
      Size = 5
    end
  end
  object DSParaleloId: TDataSource
    DataSet = TbParaleloId
    Left = 344
    Top = 148
  end
  object TbMateriaProhibicionTipo: TkbmMemTable
    Tag = 9
    FieldDefs = <
      item
        Name = 'CodMateProhibicionTipo'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'NomMateProhibicionTipo'
        DataType = ftString
        Precision = -1
        Size = 10
        Attributes = [faRequired]
      end
      item
        Name = 'ColMateProhibicionTipo'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'ValMateProhibicionTipo'
        DataType = ftFloat
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 432
    Top = 144
    object TbMateriaProhibicionTipoCodMateProhibicionTipo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodMateProhibicionTipo'
      Required = True
    end
    object TbMateriaProhibicionTipoNomMateProhibicionTipo: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomMateProhibicionTipo'
      Required = True
      Size = 10
    end
    object TbMateriaProhibicionTipoColMateProhibicionTipo: TIntegerField
      DisplayLabel = 'Color'
      FieldName = 'ColMateProhibicionTipo'
      Required = True
    end
    object TbMateriaProhibicionTipoValMateProhibicionTipo: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'ValMateProhibicionTipo'
      Required = True
    end
  end
  object DSMateriaProhibicionTipo: TDataSource
    DataSet = TbMateriaProhibicionTipo
    Left = 440
    Top = 136
  end
  object TbPeriodo: TkbmMemTable
    Tag = 10
    FieldDefs = <
      item
        Name = 'CodDia'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodHora'
        DataType = ftInteger
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 48
    Top = 240
    object TbPeriodoCodDia: TIntegerField
      DisplayLabel = 'D'#237'a'
      FieldName = 'CodDia'
      Required = True
    end
    object TbPeriodoCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
    end
  end
  object DSPeriodo: TDataSource
    DataSet = TbPeriodo
    Left = 56
    Top = 232
  end
  object TbParalelo: TkbmMemTable
    Tag = 11
    FieldDefs = <
      item
        Name = 'CodNivel'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodEspecializacion'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodParaleloId'
        DataType = ftInteger
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 144
    Top = 252
    object TbParaleloCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
    end
    object TbParaleloCodEspecializacion: TIntegerField
      DisplayLabel = 'Especializaci'#243'n'
      FieldName = 'CodEspecializacion'
      Required = True
    end
    object TbParaleloCodParaleloId: TIntegerField
      DisplayLabel = 'Paralelo'
      FieldName = 'CodParaleloId'
      Required = True
    end
  end
  object DSParalelo: TDataSource
    DataSet = TbParalelo
    Left = 152
    Top = 244
  end
  object TbProfesor: TkbmMemTable
    Tag = 12
    FieldDefs = <
      item
        Name = 'CodProfesor'
        DataType = ftAutoInc
      end
      item
        Name = 'CedProfesor'
        DataType = ftString
        Precision = -1
        Size = 11
        Attributes = [faRequired]
      end
      item
        Name = 'ApeProfesor'
        DataType = ftString
        Precision = -1
        Size = 15
        Attributes = [faRequired]
      end
      item
        Name = 'NomProfesor'
        DataType = ftString
        Precision = -1
        Size = 15
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 240
    Top = 240
    object TbProfesorCodProfesor: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodProfesor'
    end
    object TbProfesorCedProfesor: TStringField
      DisplayLabel = 'C'#233'dula'
      FieldName = 'CedProfesor'
      Required = True
      Size = 11
    end
    object TbProfesorApeProfesor: TStringField
      DisplayLabel = 'Apellido'
      FieldName = 'ApeProfesor'
      Required = True
      Size = 15
    end
    object TbProfesorNomProfesor: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomProfesor'
      Required = True
      Size = 15
    end
  end
  object DSProfesor: TDataSource
    DataSet = TbProfesor
    Left = 248
    Top = 232
  end
  object TbMateriaProhibicion: TkbmMemTable
    Tag = 13
    FieldDefs = <
      item
        Name = 'CodMateria'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodDia'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodHora'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodMateProhibicionTipo'
        DataType = ftInteger
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    Left = 336
    Top = 252
    object TbMateriaProhibicionCodMateria: TIntegerField
      DisplayLabel = 'Materia'
      FieldName = 'CodMateria'
      Required = True
    end
    object TbMateriaProhibicionCodDia: TIntegerField
      DisplayLabel = 'D'#237'a'
      FieldName = 'CodDia'
      Required = True
    end
    object TbMateriaProhibicionCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
    end
    object TbMateriaProhibicionCodMateProhibicionTipo: TIntegerField
      DisplayLabel = 'Tipo de Prohibici'#243'n'
      FieldName = 'CodMateProhibicionTipo'
      Required = True
    end
  end
  object DSMateriaProhibicion: TDataSource
    DataSet = TbMateriaProhibicion
    Left = 344
    Top = 244
  end
  object TbDistributivo: TkbmMemTable
    Tag = 14
    FieldDefs = <
      item
        Name = 'CodMateria'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodNivel'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodEspecializacion'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodParaleloId'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodProfesor'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodAulaTipo'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'Composicion'
        DataType = ftString
        Precision = -1
        Size = 40
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 432
    Top = 240
    object TbDistributivoCodMateria: TIntegerField
      DisplayLabel = 'Materia'
      FieldName = 'CodMateria'
      Required = True
    end
    object TbDistributivoCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
    end
    object TbDistributivoCodEspecializacion: TIntegerField
      DisplayLabel = 'Especializaci'#243'n'
      FieldName = 'CodEspecializacion'
      Required = True
    end
    object TbDistributivoCodParaleloId: TIntegerField
      DisplayLabel = 'Paralelo'
      FieldName = 'CodParaleloId'
      Required = True
    end
    object TbDistributivoCodProfesor: TIntegerField
      DisplayLabel = 'Profesor'
      FieldName = 'CodProfesor'
      Required = True
    end
    object TbDistributivoCodAulaTipo: TIntegerField
      DisplayLabel = 'Tipo de Aula'
      FieldName = 'CodAulaTipo'
      Required = True
    end
    object TbDistributivoComposicion: TStringField
      DisplayLabel = 'Composici'#243'n'
      FieldName = 'Composicion'
      Required = True
      Size = 40
    end
  end
  object DSDistributivo: TDataSource
    DataSet = TbDistributivo
    Left = 440
    Top = 232
  end
  object TbHorarioDetalle: TkbmMemTable
    Tag = 15
    FieldDefs = <
      item
        Name = 'CodHorario'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodMateria'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodNivel'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodEspecializacion'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodParaleloId'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodDia'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodHora'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'Sesion'
        DataType = ftInteger
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    Left = 48
    Top = 336
    object TbHorarioDetalleCodHorario: TIntegerField
      DisplayLabel = 'Horario'
      FieldName = 'CodHorario'
      Required = True
    end
    object TbHorarioDetalleCodMateria: TIntegerField
      DisplayLabel = 'Materia'
      FieldName = 'CodMateria'
      Required = True
    end
    object TbHorarioDetalleCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
    end
    object TbHorarioDetalleCodEspecializacion: TIntegerField
      DisplayLabel = 'Especializaci'#243'n'
      FieldName = 'CodEspecializacion'
      Required = True
    end
    object TbHorarioDetalleCodParaleloId: TIntegerField
      DisplayLabel = 'Paralelo'
      FieldName = 'CodParaleloId'
      Required = True
    end
    object TbHorarioDetalleCodDia: TIntegerField
      DisplayLabel = 'D'#237'a'
      FieldName = 'CodDia'
      Required = True
    end
    object TbHorarioDetalleCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
    end
    object TbHorarioDetalleSesion: TIntegerField
      DisplayLabel = 'Sesi'#243'n'
      FieldName = 'Sesion'
      Required = True
    end
  end
  object DSHorarioDetalle: TDataSource
    DataSet = TbHorarioDetalle
    Left = 56
    Top = 328
  end
  object TbProfesorProhibicionTipo: TkbmMemTable
    Tag = 16
    FieldDefs = <
      item
        Name = 'CodProfProhibicionTipo'
        DataType = ftAutoInc
      end
      item
        Name = 'NomProfProhibicionTipo'
        DataType = ftString
        Precision = -1
        Size = 10
        Attributes = [faRequired]
      end
      item
        Name = 'ColProfProhibicionTipo'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'ValProfProhibicionTipo'
        DataType = ftFloat
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 144
    Top = 348
    object TbProfesorProhibicionTipoCodProfProhibicionTipo: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodProfProhibicionTipo'
    end
    object TbProfesorProhibicionTipoNomProfProhibicionTipo: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomProfProhibicionTipo'
      Required = True
      Size = 10
    end
    object TbProfesorProhibicionTipoColProfProhibicionTipo: TIntegerField
      DisplayLabel = 'Color'
      FieldName = 'ColProfProhibicionTipo'
      Required = True
    end
    object TbProfesorProhibicionTipoValProfProhibicionTipo: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'ValProfProhibicionTipo'
      Required = True
    end
  end
  object DSProfesorProhibicionTipo: TDataSource
    DataSet = TbProfesorProhibicionTipo
    Left = 152
    Top = 340
  end
  object TbProfesorProhibicion: TkbmMemTable
    Tag = 17
    FieldDefs = <
      item
        Name = 'CodProfesor'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodDia'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodHora'
        DataType = ftInteger
        Attributes = [faRequired]
      end
      item
        Name = 'CodProfProhibicionTipo'
        DataType = ftInteger
        Attributes = [faRequired]
      end>
    BeforePost = DataSetBeforePost
    Left = 240
    Top = 336
    object TbProfesorProhibicionCodProfesor: TIntegerField
      DisplayLabel = 'Profesor'
      FieldName = 'CodProfesor'
      Required = True
    end
    object TbProfesorProhibicionCodDia: TIntegerField
      DisplayLabel = 'D'#237'a'
      FieldName = 'CodDia'
      Required = True
    end
    object TbProfesorProhibicionCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
    end
    object TbProfesorProhibicionCodProfProhibicionTipo: TIntegerField
      DisplayLabel = 'Tipo de prohibici'#243'n'
      FieldName = 'CodProfProhibicionTipo'
      Required = True
    end
  end
  object DSProfesorProhibicion: TDataSource
    DataSet = TbProfesorProhibicion
    Left = 248
    Top = 328
  end
end
