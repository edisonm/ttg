�
 THORARIOPROFESORFORM 0;  TPF0�THorarioProfesorFormHorarioProfesorFormLeftTop� WidthHeight�OnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight �TDock97do97TopWidth� �
TToolbar97tb97ShowLeft�DockPos�  �
TToolbar97tb97NavigationVisible	 TToolbarButton97btn97MostrarLeft�Top WidthHeightHintMostrar|Mostrar el horario
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 33      33wwwwww33�����33?�??�33  �33wssw733�����33?��?�33 � �33w7sw733�����33�3?��33 �� ��33w?�w�730� ����373w77��3�����3s73s7770������7�373s370������7�3s73?� ����  w�33�ww࿿� ��w�37w?7���w�s?ss�࿿ � 3ww��w�w3��    3wwwwwws3	NumGlyphsParentShowHintShowHint	OnClickbtn97MostrarClick  TToolbarButton97	btn97NextLeft�Top WidthHeight
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 33333333333333333333333333333333333333333333333333333333333?�333333 3333333w?�33333	 333333w?�3333	� 33?��3w?�   	�� 3wwws33w?	������ ���33?w   	�� 3www3?w3333	� 33333?w33333	 333333w333333 3333333w3333333333333333333333333333333333333333333333333333	NumGlyphsOnClickbtn97NextClick  TToolbarButton97
btn97PriorLeftjTop WidthHeight
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 33333333333333333333333333333333333333333333?�333333 333333?w�33333 �33333?w7�3333 ��3333?w37���3 ���   ?w337www �������w?�33���3 ���   3w?�7www33 ��33333w?��33333 �333333w7�333333 3333333w3333333333333333333333333333333333333333333333333333333333333333333	NumGlyphsOnClickbtn97PriorClick  TRxDBLookupCombodlcProfesorLeft Top Width� HeightDropDownCountDisplayEmpty
(Profesor)	ListStylelsDelimitedLookupFieldCodProfesorLookupDisplayApeNomProfesorLookupSource
DSProfesorTabOrder   	TComboBoxcbVerProfesorLeft� Top Width� HeightHint&Ver|Qu� ver en el horario del profesor
ItemHeightParentShowHintShowHint	TabOrder   �
TToolbar97tb97EditLeft�DockPos�Visible   �TPanel	pnlStatusTopaWidth�  �TPanelPanel1Width�Height>  �TDock97	do97RightLeft�Height>  �TDock97
do97BottomTopXWidth�  �TDock97do97LeftHeight>  �TRxDrawGrid
RxDrawGridWidth�Height>OptionsgoFixedVertLinegoFixedHorzLine
goVertLine
goHorzLinegoDrawFocusSelectedgoColSizing   �TFormStorageFormStorageActive	
IniSection$\Software\SGHC1\MMEd1HorarioProfesor  TRxQueryQuHorarioProfesorDatabaseNameSGHCSessionNameseMain_1SQL.StringsSELECT  HorarioDetalle.CodDia,  HorarioDetalle.CodHora,'  CAST(%FieldKey AS CHAR(50)) AS NombreFROM  ((((HorarioDetalleT  INNER JOIN CargaAcademica ON (HorarioDetalle.CodMateria=CargaAcademica.CodMateria)7  AND (HorarioDetalle.CodNivel=CargaAcademica.CodNivel)K  AND (HorarioDetalle.CodEspecializacion=CargaAcademica.CodEspecializacion)B  AND (HorarioDetalle.CodParaleloId=CargaAcademica.CodParaleloId))=  INNER JOIN Nivel ON HorarioDetalle.CodNivel=Nivel.CodNivel)e  INNER JOIN Especializacion ON HorarioDetalle.CodEspecializacion=Especializacion.CodEspecializacion)Q  INNER JOIN ParaleloId ON CargaAcademica.CodParaleloId=ParaleloId.CodParaleloId)D  INNER JOIN Materia ON CargaAcademica.CodMateria=Materia.CodMateriaWHEREU  (CargaAcademica.CodProfesor=:CodProfesor)AND(HorarioDetalle.CodHorario=:CodHorario)	UNION ALLSELECT  ProfesorProhibicion.CodDia,  ProfesorProhibicion.CodHora,4  CAST(NomProfProhibicionTipo AS CHAR(50)) AS NombreFROM8  ProfesorProhibicion INNER JOIN ProfesorProhibicionTipo`    ON ProfesorProhibicion.CodProfProhibicionTipo=ProfesorProhibicionTipo.CodProfProhibicionTipoWHERE=  ProfesorProhibicion.CodProfesor=:CodProfesor AND (%Excluir)6ORDER BY HorarioDetalle.CodDia, HorarioDetalle.CodHora MacrosDataTypeftStringNameFieldKey	ParamTypeptInputValue0=0 DataTypeftStringNameExcluir	ParamTypeptInputValue0=0  LeftHTop0	ParamDataDataType	ftUnknownNameCodProfesor	ParamType	ptUnknown DataType	ftUnknownName
CodHorario	ParamType	ptUnknown DataType	ftUnknownNameCodProfesor	ParamType	ptUnknown    TQuery
QuProfesorDatabaseNameSGHCSessionNameseMain_1SQL.Strings�SELECT Profesor.CodProfesor, Profesor.ApeProfesor, Profesor.NomProfesor, Profesor.ApeProfesor + " " + Profesor.NomProfesor As ApeNomProfesorFROM Profesor3ORDER BY Profesor.ApeProfesor, Profesor.NomProfesor LeftpTop0  TDataSource
DSProfesorDataSet
QuProfesorLeftpTopX   