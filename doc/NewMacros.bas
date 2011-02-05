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
    Remplazar "Project Code", "C�d. Proyecto"
    Remplazar "Name", "Nombre"
    Remplazar "Code", "C�digo"
    Remplazar "Label", "R�tulo"
    Remplazar "Author", "Autor"
    Remplazar "Version", "Versi�n"
    Remplazar "Created On", "Creado"
    Remplazar "Modified On", "Modificado"
    Remplazar "Process List", "Lista de Procesos"
    Remplazar "Process Tree", "�rbol de Procesos"
    Remplazar "Number", "N�mero"
    Remplazar "Lowest Level", "Menor Nivel"
    Remplazar "Process Reference List", "Lista de Referencias a Procesos"
    Remplazar "Connected via", "Conectado v�a"
    Remplazar "Connected to", "Conectado a"
    Remplazar "External Entity List", "Lista de Entidades Externas"
    Remplazar "Entity Reference List", "Lista de Referencias a Entidades"
    Remplazar "External Entity", "Entidad Externa"
    Remplazar "Src", "Fuen"
    Remplazar "Dst", "Dest"
    Remplazar "Data Store List", "Lista de Almacenes de Datos"
    Remplazar "Is Entity", "Es Entidad"
    Remplazar "Type", "Tipo"
    Remplazar "Client Check Expression", "Expresi�n de Verificaci�n Cliente"
    Remplazar "Server Check Expression", "Expresi�n de Verificaci�n Servidor"
    Remplazar "Check", "Verificaci�n"
    Remplazar "Domain", "Dominio"
    Remplazar "Precision", "Precisi�n"
    Remplazar "Data Flow List", "Lista de Flujo de Datos"
    Remplazar "Data Flow Data Item List", "Lista de �tems de Datos del Flujo de Datos"
    Remplazar "Data Flow", "Flujo de Datos"
    Remplazar "Data Store Data Item List", "Lista de �tems de Datos del Almac�n de Datos"
    Remplazar "Data Store Reference List", "Lista de Referencias del Almac�n de Datos"
    Remplazar "Data Store", "Almac�n de Datos"
    Remplazar "Data Item List", "Lista de Items de Datos"
    Remplazar "Can't modify", "No modificable"
    Remplazar "Yes", "S�"
    Remplazar "Uppercase", "May�sculas"
    Remplazar "Lowercase", "Min�sculas"
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
    ElseIf Selection.Style = ActiveDocument.Styles("T�tulo 1") Then
      Selection.Style = ActiveDocument.Styles("T�tulo 4")
    End If
    Selection.MoveDown Unit:=wdLine, Count:=1
    Next
End Sub

