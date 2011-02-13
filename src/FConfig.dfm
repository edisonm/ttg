object ConfiguracionForm: TConfiguracionForm
  Left = 765
  Top = 116
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n'
  ClientHeight = 451
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object bbtnOk: TBitBtn
    Left = 255
    Top = 424
    Width = 75
    Height = 25
    TabOrder = 0
    OnClick = bbtnOkClick
    Kind = bkOK
  end
  object pgcConfig: TPageControl
    Left = 8
    Top = 8
    Width = 401
    Height = 409
    ActivePage = tbsOpciones
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object tbsUnidadEducativa: TTabSheet
      Hint = 'Datos del colegio'
      Caption = 'Colegio'
      ImageIndex = 2
      object Label14: TLabel
        Left = 8
        Top = 109
        Width = 130
        Height = 13
        Caption = 'Carga M'#225'xima por Profesor:'
      end
      object lblComentarios: TLabel
        Left = 8
        Top = 165
        Width = 61
        Height = 13
        Caption = 'Comentarios:'
      end
      object Label17: TLabel
        Left = 8
        Top = 13
        Width = 38
        Height = 13
        Caption = 'Colegio:'
      end
      object Label4: TLabel
        Left = 8
        Top = 85
        Width = 65
        Height = 13
        Caption = 'Responsable:'
      end
      object Label25: TLabel
        Left = 240
        Top = 85
        Width = 31
        Height = 13
        Caption = 'Cargo:'
      end
      object Label26: TLabel
        Left = 8
        Top = 61
        Width = 48
        Height = 13
        Caption = 'Autoridad:'
      end
      object Label27: TLabel
        Left = 240
        Top = 61
        Width = 31
        Height = 13
        Caption = 'Cargo:'
      end
      object Label31: TLabel
        Left = 8
        Top = 36
        Width = 60
        Height = 13
        Caption = 'A'#241'o Lectivo:'
      end
      object lblHorarioSeleccionado: TLabel
        Left = 152
        Top = 140
        Width = 46
        Height = 13
        Caption = '(Ninguno)'
      end
      object Label33: TLabel
        Left = 8
        Top = 140
        Width = 103
        Height = 13
        Caption = 'Horario seleccionado:'
      end
      object speMaxCargaProfesor: TSpinEdit
        Left = 152
        Top = 104
        Width = 233
        Height = 22
        MaxValue = 2147483647
        MinValue = 1
        TabOrder = 6
        Value = 20
      end
      object MemComentarios: TMemo
        Left = 8
        Top = 184
        Width = 377
        Height = 169
        TabOrder = 7
      end
      object edtNomColegio: TEdit
        Left = 80
        Top = 8
        Width = 305
        Height = 21
        Hint = 'Colegio|Nombre del colegio'
        TabOrder = 0
      end
      object edtNomResponsable: TEdit
        Left = 80
        Top = 80
        Width = 137
        Height = 21
        TabOrder = 4
      end
      object edtCarResponsable: TEdit
        Left = 280
        Top = 80
        Width = 105
        Height = 21
        TabOrder = 5
      end
      object edtNomAutoridad: TEdit
        Left = 80
        Top = 56
        Width = 137
        Height = 21
        TabOrder = 2
      end
      object edtCarAutoridad: TEdit
        Left = 280
        Top = 56
        Width = 105
        Height = 21
        TabOrder = 3
      end
      object edtAnioLectivo: TEdit
        Left = 80
        Top = 32
        Width = 305
        Height = 21
        TabOrder = 1
      end
    end
    object tbsOpciones: TTabSheet
      Caption = 'Opciones'
      ImageIndex = 3
      object Label19: TLabel
        Left = 16
        Top = 60
        Width = 45
        Height = 13
        Caption = 'Semilla 1:'
      end
      object Label20: TLabel
        Left = 16
        Top = 84
        Width = 45
        Height = 13
        Caption = 'Semilla 2:'
      end
      object Label21: TLabel
        Left = 16
        Top = 108
        Width = 45
        Height = 13
        Caption = 'Semilla 3:'
      end
      object Label22: TLabel
        Left = 16
        Top = 132
        Width = 45
        Height = 13
        Caption = 'Semilla 4:'
      end
      object Label23: TLabel
        Left = 8
        Top = 12
        Width = 159
        Height = 13
        Caption = 'Generador de n'#250'meros aleatorios:'
      end
      object Label28: TLabel
        Left = 8
        Top = 160
        Width = 52
        Height = 13
        Caption = 'Aplicaci'#243'n:'
      end
      object Label29: TLabel
        Left = 16
        Top = 181
        Width = 167
        Height = 13
        Caption = 'Iteraciones para actualizar pantalla:'
      end
      object Label24: TLabel
        Left = 8
        Top = 256
        Width = 169
        Height = 13
        Caption = 'En el horario de profesores, mostrar:'
      end
      object Label32: TLabel
        Left = 16
        Top = 276
        Width = 30
        Height = 13
        Caption = 'Texto:'
      end
      object Label34: TLabel
        Left = 16
        Top = 301
        Width = 44
        Height = 13
        Caption = 'Longitud:'
      end
      object Label35: TLabel
        Left = 16
        Top = 328
        Width = 191
        Height = 13
        Caption = 'Expresi'#243'n de exclusi'#243'n de prohibiciones:'
      end
      object Label36: TLabel
        Left = 16
        Top = 204
        Width = 141
        Height = 13
        Caption = 'Horarios tomados como inicio:'
      end
      object Label42: TLabel
        Left = 16
        Top = 228
        Width = 189
        Height = 13
        Caption = 'Directorio de comunicaci'#243'n asincr'#243'nica:'
      end
      object CBRandomize: TCheckBox
        Left = 16
        Top = 36
        Width = 257
        Height = 17
        Caption = 'Inicializar con la hora del sistema'
        TabOrder = 0
        OnClick = CBRandomizeClick
      end
      object speSeed1: TSpinEdit
        Left = 152
        Top = 55
        Width = 233
        Height = 22
        MaxValue = 2147483647
        MinValue = -2147483648
        TabOrder = 1
        Value = 1
      end
      object speSeed2: TSpinEdit
        Left = 152
        Top = 79
        Width = 233
        Height = 22
        MaxValue = 2147483647
        MinValue = -2147483648
        TabOrder = 2
        Value = 1
      end
      object speSeed3: TSpinEdit
        Left = 152
        Top = 103
        Width = 233
        Height = 22
        MaxValue = 2147483647
        MinValue = -2147483648
        TabOrder = 3
        Value = 1
      end
      object speSeed4: TSpinEdit
        Left = 152
        Top = 127
        Width = 233
        Height = 22
        MaxValue = 2147483647
        MinValue = -2147483648
        TabOrder = 4
        Value = 1
      end
      object speNumIteraciones: TSpinEdit
        Left = 216
        Top = 176
        Width = 169
        Height = 22
        MaxValue = 2147483647
        MinValue = 1
        TabOrder = 5
        Value = 1
      end
      object edtMostrarProfesorHorarioTexto: TEdit
        Left = 72
        Top = 272
        Width = 313
        Height = 21
        TabOrder = 6
      end
      object speMostrarProfesorHorarioLongitud: TSpinEdit
        Left = 77
        Top = 299
        Width = 313
        Height = 22
        MaxValue = 2147483647
        MinValue = 1
        TabOrder = 7
        Value = 20
      end
      object edtProfesorHorarioExcluirProfProhibicion: TEdit
        Left = 16
        Top = 344
        Width = 369
        Height = 21
        TabOrder = 8
      end
      object edtHorarioIni: TEdit
        Left = 216
        Top = 200
        Width = 169
        Height = 21
        TabOrder = 9
      end
      object dedCompartir: TEdit
        Left = 216
        Top = 224
        Width = 169
        Height = 21
        TabOrder = 10
      end
    end
    object tbsPesos: TTabSheet
      Caption = 'Pesos'
      object Label1: TLabel
        Left = 8
        Top = 12
        Width = 98
        Height = 13
        Caption = 'Cruce de profesores:'
      end
      object Label2: TLabel
        Left = 8
        Top = 60
        Width = 74
        Height = 13
        Caption = 'Cruce de aulas:'
      end
      object Label3: TLabel
        Left = 8
        Top = 84
        Width = 132
        Height = 13
        Caption = 'Horas huecas desubicadas:'
      end
      object Label5: TLabel
        Left = 8
        Top = 108
        Width = 87
        Height = 13
        Caption = 'Materias cortadas:'
      end
      object Label6: TLabel
        Left = 8
        Top = 132
        Width = 105
        Height = 13
        Caption = 'Materias no dispersas:'
      end
      object Label15: TLabel
        Left = 8
        Top = 160
        Width = 118
        Height = 13
        Caption = 'Prohibiciones de materia:'
      end
      object Label18: TLabel
        Left = 8
        Top = 272
        Width = 122
        Height = 13
        Caption = 'Prohibiciones de profesor:'
      end
      object Label16: TLabel
        Left = 8
        Top = 36
        Width = 129
        Height = 13
        Caption = 'Fracc. del h. de profesores:'
      end
      object Label30: TLabel
        Left = 248
        Top = 180
        Width = 40
        Height = 13
        Caption = 'Nombre:'
      end
      object Label37: TLabel
        Left = 248
        Top = 205
        Width = 27
        Height = 13
        Caption = 'Color:'
      end
      object Label38: TLabel
        Left = 248
        Top = 228
        Width = 27
        Height = 13
        Caption = 'Valor:'
      end
      object Label39: TLabel
        Left = 248
        Top = 284
        Width = 40
        Height = 13
        Caption = 'Nombre:'
      end
      object Label40: TLabel
        Left = 248
        Top = 309
        Width = 27
        Height = 13
        Caption = 'Color:'
      end
      object Label41: TLabel
        Left = 248
        Top = 332
        Width = 27
        Height = 13
        Caption = 'Valor:'
      end
      object creCruceProfesor: TEdit
        Left = 152
        Top = 8
        Width = 233
        Height = 21
        AutoSize = False
        TabOrder = 0
      end
      object creCruceAulaTipo: TEdit
        Left = 152
        Top = 56
        Width = 233
        Height = 21
        AutoSize = False
        TabOrder = 2
      end
      object creHoraHueca: TEdit
        Left = 152
        Top = 80
        Width = 233
        Height = 21
        AutoSize = False
        TabOrder = 3
      end
      object creSesionCortada: TEdit
        Left = 152
        Top = 104
        Width = 233
        Height = 21
        AutoSize = False
        TabOrder = 4
      end
      object creMateriaNoDispersa: TEdit
        Left = 152
        Top = 128
        Width = 233
        Height = 21
        AutoSize = False
        TabOrder = 5
      end
      object creProfesorFraccionamiento: TEdit
        Left = 152
        Top = 32
        Width = 233
        Height = 21
        AutoSize = False
        TabOrder = 1
      end
      object dbeNomMateProhibicionTipo: TDBEdit
        Left = 304
        Top = 176
        Width = 81
        Height = 21
        DataField = 'NomMateProhibicionTipo'
        DataSource = SourceDataModule.DSMateriaProhibicionTipo
        TabOrder = 8
      end
      object dbeValMateProhibicionTipo: TDBEdit
        Left = 304
        Top = 224
        Width = 81
        Height = 21
        DataField = 'ValMateProhibicionTipo'
        DataSource = SourceDataModule.DSMateriaProhibicionTipo
        TabOrder = 10
      end
      object dbeNomProfProhibicionTipo: TDBEdit
        Left = 304
        Top = 280
        Width = 81
        Height = 21
        DataField = 'NomProfProhibicionTipo'
        DataSource = SourceDataModule.DSProfesorProhibicionTipo
        TabOrder = 11
      end
      object dbeValProfProhibicionTipo: TDBEdit
        Left = 304
        Top = 328
        Width = 81
        Height = 21
        DataField = 'ValProfProhibicionTipo'
        DataSource = SourceDataModule.DSProfesorProhibicionTipo
        TabOrder = 13
      end
      object DBGrid1: TDBGrid
        Left = 8
        Top = 176
        Width = 233
        Height = 89
        DataSource = SourceDataModule.DSMateriaProhibicionTipo
        TabOrder = 6
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object DBGrid2: TDBGrid
        Left = 8
        Top = 288
        Width = 233
        Height = 89
        DataSource = SourceDataModule.DSProfesorProhibicionTipo
        TabOrder = 7
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object CBColMateProhibicionTipo: TColorBox
        Left = 304
        Top = 200
        Width = 81
        Height = 22
        ItemHeight = 16
        TabOrder = 9
        OnChange = CBColMateProhibicionTipoChange
        OnExit = CBColMateProhibicionTipoExit
      end
      object CBColProfProhibicionTipo: TColorBox
        Left = 304
        Top = 304
        Width = 81
        Height = 22
        ItemHeight = 16
        TabOrder = 12
        OnChange = CBColProfProhibicionTipoChange
        OnExit = CBColProfProhibicionTipoExit
      end
    end
    object tbsAlgoritmoEvolutivo: TTabSheet
      Caption = 'Algoritmo Evolutivo'
      ImageIndex = 1
      object Label8: TLabel
        Left = 8
        Top = 13
        Width = 117
        Height = 13
        Caption = 'Tama'#241'o de la poblaci'#243'n:'
      end
      object Label10: TLabel
        Left = 8
        Top = 61
        Width = 136
        Height = 13
        Caption = 'Probabilidad de cruzamiento:'
      end
      object Label11: TLabel
        Left = 8
        Top = 85
        Width = 132
        Height = 13
        Caption = 'Probabilidad de Mutaci'#243'n 1:'
      end
      object Label13: TLabel
        Left = 8
        Top = 37
        Width = 121
        Height = 13
        Caption = 'M'#225'ximo de generaciones:'
      end
      object Label7: TLabel
        Left = 8
        Top = 109
        Width = 114
        Height = 13
        Caption = 'Orden de la Mutaci'#243'n 1:'
      end
      object Label9: TLabel
        Left = 8
        Top = 133
        Width = 132
        Height = 13
        Caption = 'Probabilidad de Mutaci'#243'n 2:'
      end
      object Label12: TLabel
        Left = 8
        Top = 157
        Width = 134
        Height = 13
        Caption = 'Probabilidad de Reparaci'#243'n:'
      end
      object Label43: TLabel
        Left = 8
        Top = 181
        Width = 108
        Height = 13
        Caption = 'Rango de polinizaci'#243'n:'
      end
      object speTamPoblacion: TSpinEdit
        Left = 152
        Top = 8
        Width = 233
        Height = 22
        MaxValue = 2147483647
        MinValue = 1
        TabOrder = 0
        Value = 10
      end
      object creProbCruzamiento: TEdit
        Left = 152
        Top = 56
        Width = 233
        Height = 21
        AutoSize = False
        TabOrder = 2
      end
      object creProbMutacion1: TEdit
        Left = 152
        Top = 80
        Width = 233
        Height = 21
        AutoSize = False
        TabOrder = 3
      end
      object speNumMaxGeneracion: TSpinEdit
        Left = 152
        Top = 32
        Width = 233
        Height = 22
        MaxValue = 2147483647
        MinValue = 1
        TabOrder = 1
        Value = 10000
      end
      object speOrdenMutacion1: TSpinEdit
        Left = 152
        Top = 104
        Width = 233
        Height = 22
        MaxValue = 2147483647
        MinValue = 1
        TabOrder = 4
        Value = 3
      end
      object creProbMutacion2: TEdit
        Left = 152
        Top = 128
        Width = 233
        Height = 21
        AutoSize = False
        TabOrder = 5
      end
      object creProbReparacion: TEdit
        Left = 152
        Top = 152
        Width = 233
        Height = 21
        AutoSize = False
        TabOrder = 6
      end
      object speRangoPolinizacion: TSpinEdit
        Left = 152
        Top = 176
        Width = 233
        Height = 22
        MaxValue = 2147483647
        MinValue = 1
        TabOrder = 7
        Value = 1
      end
    end
  end
  object bbtnCancel: TBitBtn
    Left = 335
    Top = 424
    Width = 75
    Height = 25
    TabOrder = 2
    OnClick = bbtnCancelClick
    Kind = bkCancel
  end
  object DSMateriaProhibicionTipo: TDataSource
    DataSet = SourceDataModule.TbMateriaProhibicionTipo
    OnDataChange = DSMateriaProhibicionTipoDataChange
    Left = 208
    Top = 232
  end
  object DSProfesorProhibicionTipo: TDataSource
    DataSet = SourceDataModule.TbProfesorProhibicionTipo
    OnDataChange = DSProfesorProhibicionTipoDataChange
    Left = 208
    Top = 340
  end
end
