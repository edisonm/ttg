Attribute VB_Name = "NewMacros"
Sub Traducir()
Attribute Traducir.VB_Description = "Macro grabada el 01/06/99 por Edison"
Attribute Traducir.VB_ProcData.VB_Invoke_Func = "Normal.NewMacros.Macro1"
'
' Macro1 Macro
' Macro grabada el 01/06/99 por Edison
'
    Remplazar "Full PAM Report", "Reporte PAM Completo"
    Remplazar "Table of Contents", "Tabla de Contenidos"
    Remplazar "Process Model", "Modelo del Proceso"
    Remplazar "Project Name", "Nom. Proyecto"
    Remplazar "Project Code", "Cód. Proyecto"
    Remplazar "Name", "Nombre"
    Remplazar "Code", "Código"
    Remplazar "Label", "Rótulo"
    Remplazar "Author", "Autor"
    Remplazar "Version", "Versión"
    Remplazar "Created On", "Creado"
    Remplazar "Modified On", "Modificado"
    Remplazar "Process List", "Lista de Procesos"
    Remplazar "Process Tree", "Árbol de Procesos"
    Remplazar "Number", "Número"
    Remplazar "Lowest Level", "Menor Nivel"
    Remplazar "Process Reference List", "Lista de Referencias a Procesos"
    Remplazar "Connected via", "Conectado vía"
    Remplazar "Connected to", "Conectado a"
    Remplazar "External Entity List", "Lista de Entidades Externas"
    Remplazar "Entity Reference List", "Lista de Referencias a Entidades"
    Remplazar "External Entity", "Entidad Externa"
    Remplazar "Src", "Fuen"
    Remplazar "Dst", "Dest"
    Remplazar "Data Store List", "Lista de Almacenes de Datos"
    Remplazar "Is Entity", "Es Entidad"
    Remplazar "Type", "Tipo"
    Remplazar "Client Check Expression", "Expresión de Verificación Cliente"
    Remplazar "Server Check Expression", "Expresión de Verificación Servidor"
    Remplazar "Check", "Verificación"
    Remplazar "Domain", "Dominio"
    Remplazar "Precision", "Precisión"
    Remplazar "Data Flow List", "Lista de Flujo de Datos"
    Remplazar "Data Flow Data Item List", "Lista de Ítems de Datos del Flujo de Datos"
    Remplazar "Data Flow", "Flujo de Datos"
    Remplazar "Data Store Data Item List", "Lista de Ítems de Datos del Almacén de Datos"
    Remplazar "Data Store Reference List", "Lista de Referencias del Almacén de Datos"
    Remplazar "Data Store", "Almacén de Datos"
    Remplazar "Data Item List", "Lista de Items de Datos"
    Remplazar "Can't modify", "No modificable"
    Remplazar "Yes", "Sí"
    Remplazar "Uppercase", "Mayúsculas"
    Remplazar "Lowercase", "Minúsculas"
    Remplazar "Process", "Proceso"
    Remplazar "Low Value", "Menor Valor"
    Remplazar "High Value", "Mayor Valor"
    Remplazar "Default Value", "Valor Predeterminado"
    Remplazar "Unit", "Unidad"
    Remplazar "Format", "Formato"
    Remplazar "List of Values", "Lista de Valores"
    Remplazar "Reference List", "Lista de Referencias"
    Remplazar "Reference", "Referencia"
    Remplazar "Length", "Longitud"
End Sub
Sub Remplazar(Texto As String, TextoRemplazo As String)
    Selection.HomeKey Unit:=wdStory
    Selection.Find.ClearFormatting
    Selection.Find.Replacement.ClearFormatting
    With Selection.Find
        .Text = Texto
        .Replacement.Text = TextoRemplazo
        .Forward = True
        .Wrap = wdFindContinue
        .Format = False
        .MatchCase = False
        .MatchWholeWord = False
        .MatchWildcards = False
        .MatchSoundsLike = False
        .MatchAllWordForms = False
    End With
    Selection.Find.Execute Replace:=wdReplaceAll
End Sub
Sub Formatear()
'
' Formatear Macro
' Macro grabada el 02/06/99 por Edison
'
    For i = 0 To 20
    If Selection.Style = ActiveDocument.Styles("Normal") Then
      Selection.Style = ActiveDocument.Styles("Texto independiente")
    ElseIf Selection.Style = ActiveDocument.Styles("Título 1") Then
      Selection.Style = ActiveDocument.Styles("Título 4")
    End If
    Selection.MoveDown Unit:=wdLine, Count:=1
    Next
End Sub

