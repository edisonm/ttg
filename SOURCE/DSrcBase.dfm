inherited SourceBaseDataModule: TSourceBaseDataModule
  object TbAulaTipo: TDbf
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'AulaTipo'
    TableLevel = 7
    FieldDefs = <
      item
        Name = 'CodAulaTipo'
        DataType = ftInteger
      end
      item
        Name = 'NomAulaTipo'
        Attributes = [faRequired]
        DataType = ftString
        Size = 25
      end
      item
        Name = 'AbrAulaTipo'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Cantidad'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    AfterOpen = DataSetAfterOpen
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 48
    Top = 48
    object TbAulaTipoCodAulaTipo: TIntegerField
      AutoGenerateValue = arAutoInc
      DefaultExpression = '0'
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
      FieldName = 'Cantidad'
      Required = True
    end
  end
  object DSAulaTipo: TDataSource
    DataSet = TbAulaTipo
    Left = 56
    Top = 40
  end
  object TbEspecializacion: TDbf
    Tag = 1
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'Especializacion'
    TableLevel = 7
    FieldDefs = <
      item
        Name = 'CodEspecializacion'
        DataType = ftInteger
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
    AfterOpen = DataSetAfterOpen
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 144
    Top = 60
    object TbEspecializacionCodEspecializacion: TIntegerField
      AutoGenerateValue = arAutoInc
      DefaultExpression = '0'
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodEspecializacion'
    end
    object TbEspecializacionNomEspecializacion: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomEspecializacion'
      Required = True
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
  object TbDia: TDbf
    Tag = 2
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'Dia'
    TableLevel = 7
    FieldDefs = <
      item
        Name = 'CodDia'
        DataType = ftInteger
      end
      item
        Name = 'NomDia'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end>
    AfterOpen = DataSetAfterOpen
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 240
    Top = 48
    object TbDiaCodDia: TIntegerField
      AutoGenerateValue = arAutoInc
      DefaultExpression = '0'
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
  object TbMateria: TDbf
    Tag = 3
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'Materia'
    TableLevel = 7
    FieldDefs = <
      item
        Name = 'CodMateria'
        DataType = ftInteger
      end
      item
        Name = 'NomMateria'
        Attributes = [faRequired]
        DataType = ftString
        Size = 20
      end>
    AfterOpen = DataSetAfterOpen
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 336
    Top = 60
    object TbMateriaCodMateria: TIntegerField
      AutoGenerateValue = arAutoInc
      DefaultExpression = '0'
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodMateria'
    end
    object TbMateriaNomMateria: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomMateria'
      Required = True
    end
  end
  object DSMateria: TDataSource
    DataSet = TbMateria
    Left = 344
    Top = 52
  end
  object TbNivel: TDbf
    Tag = 4
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'Nivel'
    TableLevel = 7
    FieldDefs = <
      item
        Name = 'CodNivel'
        DataType = ftInteger
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
    AfterOpen = DataSetAfterOpen
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 432
    Top = 48
    object TbNivelCodNivel: TIntegerField
      AutoGenerateValue = arAutoInc
      DefaultExpression = '0'
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
  object TbHora: TDbf
    Tag = 5
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'Hora'
    TableLevel = 7
    FieldDefs = <
      item
        Name = 'CodHora'
        DataType = ftInteger
      end
      item
        Name = 'NomHora'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Intervalo'
        Attributes = [faRequired]
        DataType = ftString
        Size = 21
      end>
    AfterOpen = DataSetAfterOpen
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 48
    Top = 144
    object TbHoraCodHora: TIntegerField
      AutoGenerateValue = arAutoInc
      DefaultExpression = '0'
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
  object TbHorario: TDbf
    Tag = 6
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'Horario'
    TableLevel = 7
    FieldDefs = <
      item
        Name = 'CodHorario'
        DataType = ftInteger
      end
      item
        Name = 'MomentoInicial'
        Attributes = [faRequired]
        DataType = ftDateTime
      end
      item
        Name = 'MomentoFinal'
        Attributes = [faRequired]
        DataType = ftDateTime
      end
      item
        Name = 'Informe'
        DataType = ftMemo
      end>
    AfterOpen = DataSetAfterOpen
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 144
    Top = 156
    object TbHorarioCodHorario: TIntegerField
      AutoGenerateValue = arAutoInc
      DefaultExpression = '0'
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
      FieldName = 'Informe'
      BlobType = ftMemo
    end
  end
  object DSHorario: TDataSource
    DataSet = TbHorario
    Left = 152
    Top = 148
  end
  object TbCurso: TDbf
    Tag = 7
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'Curso'
    TableLevel = 7
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
      end>
    AfterOpen = DataSetAfterOpen
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
  object TbParaleloId: TDbf
    Tag = 8
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'ParaleloId'
    TableLevel = 7
    FieldDefs = <
      item
        Name = 'CodParaleloId'
        DataType = ftInteger
      end
      item
        Name = 'NomParaleloId'
        Attributes = [faRequired]
        DataType = ftString
        Size = 5
      end>
    AfterOpen = DataSetAfterOpen
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 336
    Top = 156
    object TbParaleloIdCodParaleloId: TIntegerField
      AutoGenerateValue = arAutoInc
      DefaultExpression = '0'
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
  object TbMateriaProhibicionTipo: TDbf
    Tag = 9
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'MateriaProhibicionTipo'
    TableLevel = 7
    FieldDefs = <
      item
        Name = 'CodMateProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NomMateProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ColMateProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ValMateProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftFloat
      end>
    AfterOpen = DataSetAfterOpen
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
  object TbPeriodo: TDbf
    Tag = 10
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'Periodo'
    TableLevel = 7
    FieldDefs = <
      item
        Name = 'CodDia'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodHora'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    AfterOpen = DataSetAfterOpen
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
  object TbParalelo: TDbf
    Tag = 11
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'Paralelo'
    TableLevel = 7
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
    AfterOpen = DataSetAfterOpen
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
  object TbProfesor: TDbf
    Tag = 12
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'Profesor'
    TableLevel = 7
    FieldDefs = <
      item
        Name = 'CodProfesor'
        DataType = ftInteger
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
    AfterOpen = DataSetAfterOpen
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 240
    Top = 240
    object TbProfesorCodProfesor: TIntegerField
      AutoGenerateValue = arAutoInc
      DefaultExpression = '0'
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
  object TbMateriaProhibicion: TDbf
    Tag = 13
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'MateriaProhibicion'
    TableLevel = 7
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
      end>
    AfterOpen = DataSetAfterOpen
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
  object TbDistributivo: TDbf
    Tag = 14
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'Distributivo'
    TableLevel = 7
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
        Name = 'Composicion'
        Attributes = [faRequired]
        DataType = ftString
        Size = 40
      end>
    AfterOpen = DataSetAfterOpen
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
  object TbHorarioDetalle: TDbf
    Tag = 15
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'HorarioDetalle'
    TableLevel = 7
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
      end>
    AfterOpen = DataSetAfterOpen
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
  object TbProfesorProhibicionTipo: TDbf
    Tag = 16
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'ProfesorProhibicionTipo'
    TableLevel = 7
    FieldDefs = <
      item
        Name = 'CodProfProhibicionTipo'
        DataType = ftInteger
      end
      item
        Name = 'NomProfProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ColProfProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ValProfProhibicionTipo'
        Attributes = [faRequired]
        DataType = ftFloat
      end>
    AfterOpen = DataSetAfterOpen
    BeforePost = DataSetBeforePost
    BeforeDelete = DataSetBeforeDelete
    Left = 144
    Top = 348
    object TbProfesorProhibicionTipoCodProfProhibicionTipo: TIntegerField
      AutoGenerateValue = arAutoInc
      DefaultExpression = '0'
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
  object TbProfesorProhibicion: TDbf
    Tag = 17
    IndexDefs = <>
    Storage = stoMemory
    StoreDefs = True
    TableName = 'ProfesorProhibicion'
    TableLevel = 7
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
      end>
    AfterOpen = DataSetAfterOpen
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
