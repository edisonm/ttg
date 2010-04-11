object ConfiguracionForm: TConfiguracionForm
  Left = 362
  Top = 22
  BorderStyle = bsDialog
  Caption = 'Configuración'
  ClientHeight = 451
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object bbtnOk: TBitBtn
    Left = 255
    Top = 424
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object pgcConfig: TPageControl
    Left = 8
    Top = 8
    Width = 401
    Height = 409
    ActivePage = tbsUnidadEducativa
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object tbsUnidadEducativa: TTabSheet
      Hint = 'Datos del colegio'
      Caption = 'Colegio'
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      object Label14: TLabel
        Left = 8
        Top = 109
        Width = 130
        Height = 13
        Caption = 'Carga Máxima por Profesor:'
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
        Caption = 'Año Lectivo:'
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
      object memComentarios: TMemo
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
        OnChange = edtNomColegioChange
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
        Caption = 'Generador de números aleatorios:'
      end
      object Label28: TLabel
        Left = 8
        Top = 160
        Width = 52
        Height = 13
        Caption = 'Aplicación:'
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
        Caption = 'Expresión de exclusión de prohibiciones:'
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
        Caption = 'Directorio de comunicación asincrónica:'
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
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 1
      end
      object speSeed2: TSpinEdit
        Left = 152
        Top = 79
        Width = 233
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 1
      end
      object speSeed3: TSpinEdit
        Left = 152
        Top = 103
        Width = 233
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 1
      end
      object speSeed4: TSpinEdit
        Left = 152
        Top = 127
        Width = 233
        Height = 22
        MaxValue = 0
        MinValue = 0
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
        Left = 72
        Top = 296
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
      object dedCompartir: TDirectoryEdit
        Left = 216
        Top = 224
        Width = 169
        Height = 21
        NumGlyphs = 1
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
        Top = 264
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
      object creCruceProfesor: TCurrencyEdit
        Left = 152
        Top = 8
        Width = 233
        Height = 21
        AutoSize = False
        DecimalPlaces = 20
        DisplayFormat = '0'
        TabOrder = 0
        Value = 200
        ZeroEmpty = False
      end
      object creCruceAulaTipo: TCurrencyEdit
        Left = 152
        Top = 56
        Width = 233
        Height = 21
        AutoSize = False
        DecimalPlaces = 20
        DisplayFormat = '0'
        TabOrder = 2
        Value = 200
        ZeroEmpty = False
      end
      object creHoraHueca: TCurrencyEdit
        Left = 152
        Top = 80
        Width = 233
        Height = 21
        AutoSize = False
        DecimalPlaces = 20
        DisplayFormat = '0'
        TabOrder = 3
        Value = 100
        ZeroEmpty = False
      end
      object creSesionCortada: TCurrencyEdit
        Left = 152
        Top = 104
        Width = 233
        Height = 21
        AutoSize = False
        DecimalPlaces = 20
        DisplayFormat = '0'
        TabOrder = 4
        Value = 150
        ZeroEmpty = False
      end
      object creMateriaNoDispersa: TCurrencyEdit
        Left = 152
        Top = 128
        Width = 233
        Height = 21
        AutoSize = False
        DecimalPlaces = 20
        DisplayFormat = '0'
        TabOrder = 5
        Value = 5
        ZeroEmpty = False
      end
      object DBGrid1: TRxDBGrid
        Left = 8
        Top = 176
        Width = 233
        Height = 73
        DataSource = SourceDataModule.dsMateriaProhibicionTipo
        TabOrder = 6
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnGetCellParams = DBGridGetCellParams
      end
      object DBGrid2: TRxDBGrid
        Left = 8
        Top = 280
        Width = 233
        Height = 97
        DataSource = SourceDataModule.dsProfesorProhibicionTipo
        TabOrder = 7
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnGetCellParams = DBGridGetCellParams
      end
      object creProfesorFraccionamiento: TCurrencyEdit
        Left = 152
        Top = 32
        Width = 233
        Height = 21
        AutoSize = False
        DecimalPlaces = 20
        DisplayFormat = '0'
        TabOrder = 1
        Value = 50
        ZeroEmpty = False
      end
      object dbeNomMateProhibicionTipo: TDBEdit
        Left = 304
        Top = 176
        Width = 81
        Height = 21
        DataField = 'NomMateProhibicionTipo'
        DataSource = SourceDataModule.dsMateriaProhibicionTipo
        TabOrder = 8
      end
      object dbcColMateProhibicionTipo: TDBColorComboBox
        Left = 304
        Top = 200
        Width = 81
        Height = 21
        DataField = 'ColMateProhibicionTipo'
        DataSource = SourceDataModule.dsMateriaProhibicionTipo
        ItemHeight = 13
        TabOrder = 9
      end
      object dbeValMateProhibicionTipo: TDBEdit
        Left = 304
        Top = 224
        Width = 81
        Height = 21
        DataField = 'ValMateProhibicionTipo'
        DataSource = SourceDataModule.dsMateriaProhibicionTipo
        TabOrder = 10
      end
      object dbeNomProfProhibicionTipo: TDBEdit
        Left = 304
        Top = 280
        Width = 81
        Height = 21
        DataField = 'NomProfProhibicionTipo'
        DataSource = SourceDataModule.dsProfesorProhibicionTipo
        TabOrder = 11
      end
      object dbcColProfProhibicionTipo: TDBColorComboBox
        Left = 304
        Top = 304
        Width = 81
        Height = 21
        DataField = 'ColProfProhibicionTipo'
        DataSource = SourceDataModule.dsProfesorProhibicionTipo
        ItemHeight = 13
        TabOrder = 12
      end
      object dbeValProfProhibicionTipo: TDBEdit
        Left = 304
        Top = 328
        Width = 81
        Height = 21
        DataField = 'ValProfProhibicionTipo'
        DataSource = SourceDataModule.dsProfesorProhibicionTipo
        TabOrder = 13
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
        Caption = 'Tamaño de la población:'
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
        Caption = 'Probabilidad de Mutación 1:'
      end
      object Label13: TLabel
        Left = 8
        Top = 37
        Width = 121
        Height = 13
        Caption = 'Máximo de generaciones:'
      end
      object Label7: TLabel
        Left = 8
        Top = 109
        Width = 114
        Height = 13
        Caption = 'Orden de la Mutación 1:'
      end
      object Label9: TLabel
        Left = 8
        Top = 133
        Width = 132
        Height = 13
        Caption = 'Probabilidad de Mutación 2:'
      end
      object Label12: TLabel
        Left = 8
        Top = 157
        Width = 134
        Height = 13
        Caption = 'Probabilidad de Reparación:'
      end
      object Label43: TLabel
        Left = 8
        Top = 181
        Width = 108
        Height = 13
        Caption = 'Rango de polinización:'
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
      object creProbCruzamiento: TCurrencyEdit
        Left = 152
        Top = 56
        Width = 233
        Height = 21
        AutoSize = False
        DecimalPlaces = 20
        DisplayFormat = '0.00'
        MaxValue = 1
        TabOrder = 2
        Value = 0.3
      end
      object creProbMutacion1: TCurrencyEdit
        Left = 152
        Top = 80
        Width = 233
        Height = 21
        AutoSize = False
        DecimalPlaces = 20
        DisplayFormat = '0.00'
        MaxValue = 1
        TabOrder = 3
        Value = 0.2
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
      object creProbMutacion2: TCurrencyEdit
        Left = 152
        Top = 128
        Width = 233
        Height = 21
        AutoSize = False
        DecimalPlaces = 20
        DisplayFormat = '0.00'
        MaxValue = 1
        TabOrder = 5
        Value = 0.2
      end
      object creProbReparacion: TCurrencyEdit
        Left = 152
        Top = 152
        Width = 233
        Height = 21
        AutoSize = False
        DecimalPlaces = 20
        DisplayFormat = '0.00'
        MaxValue = 1
        TabOrder = 6
        Value = 0.2
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
    Kind = bkCancel
  end
  object FormStorage: TFormStorage
    Active = False
    IniFileName = 'CONFIG.INI'
    IniSection = 'CONFIG'
    Options = []
    StoredProps.Strings = (
      'edtNomColegio.Text'
      'edtAnioLectivo.Text'
      'edtNomAutoridad.Text'
      'edtCarAutoridad.Text'
      'edtNomResponsable.Text'
      'edtCarResponsable.Text'
      'speMaxCargaProfesor.Value'
      'lblHorarioSeleccionado.Caption'
      'memComentarios.Lines'
      'CBRandomize.Checked'
      'speSeed1.Value'
      'speSeed2.Value'
      'speSeed3.Value'
      'speSeed4.Value'
      'speNumIteraciones.Value'
      'creCruceProfesor.Value'
      'creProfesorFraccionamiento.Value'
      'creCruceAulaTipo.Value'
      'creHoraHueca.Value'
      'creSesionCortada.Value'
      'creMateriaNoDispersa.Value'
      'speTamPoblacion.Value'
      'speNumMaxGeneracion.Value'
      'creProbCruzamiento.Value'
      'creProbMutacion1.Value'
      'speOrdenMutacion1.Value'
      'creProbMutacion2.Value'
      'creProbReparacion.Value'
      'edtMostrarProfesorHorarioTexto.Text'
      'speMostrarProfesorHorarioLongitud.Value'
      'edtProfesorHorarioExcluirProfProhibicion.Text'
      'edtHorarioIni.Text'
      'dedCompartir.Text'
      'speRangoPolinizacion.Value')
    StoredValues = <>
    Left = 368
    Top = 248
  end
end
