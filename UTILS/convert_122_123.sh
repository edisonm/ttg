#!/bin/sh
##
## convert_122_123.sh
## 
## Made by Edison Mera
## Login   <edison@vaio2edison>
## 
## Started on  Wed Apr 21 01:14:53 2010 Edison Mera
## Last update Wed Apr 21 01:15:41 2010 Edison Mera
##

str_replace edtNomColegio_Text NomColegio "$1"
str_replace edtAnioLectivo_Text AnioLectivo "$1"
str_replace edtNomAutoridad_Text NomAutoridad "$1"
str_replace edtCarAutoridad_Text CarAutoridad "$1"
str_replace edtNomResponsable_Text NomResponsable "$1"
str_replace edtCarResponsable_Text CarResponsable "$1"
str_replace speMaxCargaProfesor_Value MaxCargaProfesor "$1"
str_replace lblHorarioSeleccionado_Caption HorarioSeleccionado "$1"
str_replace memComentarios_Lines Comentarios "$1"
str_replace CBRandomize_Checked Randomize "$1"
str_replace speSeed1_Value Seed1 "$1"
str_replace speSeed2_Value Seed2 "$1"
str_replace speSeed3_Value Seed3 "$1"
str_replace speSeed4_Value Seed4 "$1"
str_replace speNumIteraciones_Value NumIteraciones "$1"
str_replace creCruceProfesor_Value CruceProfesor "$1"
str_replace creProfesorFraccionamiento_Value ProfesorFraccionamiento "$1"
str_replace creCruceAulaTipo_Value CruceAulaTipo "$1"
str_replace creHoraHueca_Value HoraHueca "$1"
str_replace creSesionCortada_Value SesionCortada "$1"
str_replace creMateriaNoDispersa_Value MateriaNoDispersa "$1"
str_replace speTamPoblacion_Value TamPoblacion "$1"
str_replace speNumMaxGeneracion_Value NumMaxGeneracion "$1"
str_replace creProbCruzamiento_Value ProbCruzamiento "$1"
str_replace creProbMutacion1_Value ProbMutacion1 "$1"
str_replace speOrdenMutacion1_Value OrdenMutacion1 "$1"
str_replace creProbMutacion2_Value ProbMutacion2 "$1"
str_replace creProbReparacion_Value ProbReparacion "$1"
str_replace edtMostrarProfesorHorarioTexto_Text MostrarProfesorHorarioTexto "$1"
str_replace speMostrarProfesorHorarioLongitud_Value MostrarProfesorHorarioLongitud "$1"
str_replace edtProfesorHorarioExcluirProfProhibicion_Text ProfesorHorarioExcluirProfProhibicion "$1"
str_replace speRangoPolinizacion_Value RangoPolinizacion "$1"
