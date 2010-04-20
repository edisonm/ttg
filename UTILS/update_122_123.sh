#!/bin/sh
##
## update.sh
## 
## Made by Edison Mera
## Login   <edison@vaio2edison>
## 
## Started on  Wed Apr 21 01:03:49 2010 Edison Mera
## Last update Wed Apr 21 01:11:47 2010 Edison Mera
##

find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace edtNomColegio_Text NomColegio {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace edtAnioLectivo_Text AnioLectivo {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace edtNomAutoridad_Text NomAutoridad {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace edtCarAutoridad_Text CarAutoridad {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace edtNomResponsable_Text NomResponsable {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace edtCarResponsable_Text CarResponsable {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace speMaxCargaProfesor_Value MaxCargaProfesor {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace lblHorarioSeleccionado_Caption HorarioSeleccionado {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace memComentarios_Lines Comentarios {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace CBRandomize_Checked Randomize {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace speSeed1_Value Seed1 {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace speSeed2_Value Seed2 {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace speSeed3_Value Seed3 {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace speSeed4_Value Seed4 {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace speNumIteraciones_Value NumIteraciones {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace creCruceProfesor_Value CruceProfesor {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace creProfesorFraccionamiento_Value ProfesorFraccionamiento {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace creCruceAulaTipo_Value CruceAulaTipo {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace creHoraHueca_Value HoraHueca {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace creSesionCortada_Value SesionCortada {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace creMateriaNoDispersa_Value MateriaNoDispersa {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace speTamPoblacion_Value TamPoblacion {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace speNumMaxGeneracion_Value NumMaxGeneracion {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace creProbCruzamiento_Value ProbCruzamiento {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace creProbMutacion1_Value ProbMutacion1 {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace speOrdenMutacion1_Value OrdenMutacion1 {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace creProbMutacion2_Value ProbMutacion2 {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace creProbReparacion_Value ProbReparacion {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace edtMostrarProfesorHorarioTexto_Text MostrarProfesorHorarioTexto {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace speMostrarProfesorHorarioLongitud_Value MostrarProfesorHorarioLongitud {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace edtProfesorHorarioExcluirProfProhibicion_Text ProfesorHorarioExcluirProfProhibicion {} \;
find . -name ".svn" -prune -o \( -name "*.pas" -o -name "*.ttd" \) -exec str_replace speRangoPolinizacion_Value RangoPolinizacion {} \;
