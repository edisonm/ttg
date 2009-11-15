// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'KerModel.pas' rev: 4.00

#ifndef KerModelHPP
#define KerModelHPP

#pragma delphiheader begin
#pragma option push -w-
#include <Forms.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <SysConst.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Kermodel
{
//-- type declarations -------------------------------------------------------
typedef DynamicArray<Word >  TDynamicWordArray;

typedef DynamicArray<DynamicArray<Word > >  TDynamicWordArrayArray;

typedef DynamicArray<short >  TDynamicSmallintArray;

typedef DynamicArray<DynamicArray<short > >  TDynamicSmallintArrayArray;

typedef DynamicArray<DynamicArray<DynamicArray<short > > >  TDynamicSmallintArrayArrayArray;

typedef DynamicArray<Shortint >  TDynamicShortintArray;

typedef DynamicArray<DynamicArray<Shortint > >  TDynamicShortintArrayArray;

typedef DynamicArray<int >  TDynamicIntegerArray;

typedef DynamicArray<DynamicArray<int > >  TDynamicIntegerArrayArray;

typedef DynamicArray<int >  TDynamicLongintArray;

typedef DynamicArray<DynamicArray<int > >  TDynamicLongintArrayArray;

typedef DynamicArray<double >  TDynamicDoubleArray;

typedef DynamicArray<DynamicArray<double > >  TDynamicDoubleArrayArray;

typedef DynamicArray<AnsiString >  TDynamicStringArray;

typedef int TLongintArray[16384];

typedef int *PLongintArray;

typedef short TSmallintArray[16384];

typedef short *PSmallintArray;

typedef short *TSmallintArrayArray[1];

typedef PSmallintArray *PSmallintArrayArray;

typedef Shortint TShortintArray[32768];

typedef Shortint *PShortintArray;

typedef double TDoubleArray[1];

typedef double *PDoubleArray;

typedef bool TBooleanArray[16384];

typedef bool *PBooleanArray;

class DELPHICLASS TModeloHorario;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TModeloHorario : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Dbtables::TQuery* FQuHorarioDetalle;
	double FCruceProfesorValor;
	double FCruceAulaTipoValor;
	double FHoraHuecaDesubicadaValor;
	double FSesionCortadaValor;
	double FProfesorFraccionamientoValor;
	double FMateriaNoDispersaValor;
	DynamicArray<short >  FHorarioLaborableADia;
	DynamicArray<short >  FHorarioLaborableAHora;
	DynamicArray<short >  FDiaAMaxHorarioLaborable;
	DynamicArray<short >  FSesionAAsignatura;
	DynamicArray<short >  FSesionAMateria;
	DynamicArray<short >  FSesionAAulaTipo;
	DynamicArray<short >  FAulaTipoACantidad;
	DynamicArray<short >  FMateriaProhibicionAMateria;
	DynamicArray<short >  FMateriaProhibicionAHorarioLaborable;
	DynamicArray<short >  FMateriaProhibicionAMateriaProhibicionTipo;
	DynamicArray<short >  FProfesorProhibicionAProfesor;
	DynamicArray<short >  FProfesorProhibicionAHorarioLaborable;
	DynamicArray<short >  FProfesorProhibicionAProfesorProhibicionTipo;
	DynamicArray<short >  FAsignaturaAAulaTipo;
	DynamicArray<short >  FParaleloACurso;
	DynamicArray<short >  FParaleloANivel;
	DynamicArray<short >  FParaleloAParaleloId;
	DynamicArray<short >  FParaleloAEspecializacion;
	DynamicArray<short >  FCursoADuracion;
	DynamicArray<short >  FProfesorCantHora;
	DynamicArray<short >  FParaleloASesionCant;
	short FSesionADuracion[16384];
	DynamicArray<DynamicArray<short > >  FDiaHoraAHorarioLaborable;
	DynamicArray<DynamicArray<short > >  FNivelEspecializacionACurso;
	DynamicArray<DynamicArray<short > >  FCursoParaleloIdAParalelo;
	DynamicArray<DynamicArray<short > >  FParaleloMateriaAProfesor;
	DynamicArray<DynamicArray<short > >  FMateriaCursoAAsignatura;
	DynamicArray<DynamicArray<short > >  FMoldeHorarioDetalle;
	DynamicArray<DynamicArray<short > >  FAsignaturaASesiones;
	DynamicArray<DynamicArray<Shortint > >  FProfesorHorarioLaborableAProfesorProhibicionTipo;
	DynamicArray<DynamicArray<Shortint > >  FMateriaHorarioLaborableAMateriaProhibicionTipo;
	double FMateriaProhibicionTipoAValor[4096];
	double FProfesorProhibicionTipoAValor[4096];
	DynamicArray<double >  FMateriaProhibicionAValor;
	DynamicArray<double >  FProfesorProhibicionAValor;
	short FParaleloCant;
	short FMateriaCant;
	short FDiaCant;
	short FHoraCant;
	short FHorarioLaborableCant;
	short FProfesorCant;
	short FNivelCant;
	short FEspecializacionCant;
	short FCursoCant;
	short FAulaTipoCant;
	short FMaxProfesorProhibicionTipo;
	short FMaxMateriaProhibicionTipo;
	double FMaxProfesorProhibicionTipoValor;
	DynamicArray<int >  FParaleloIdACodParaleloId;
	DynamicArray<int >  FMateriaACodMateria;
	DynamicArray<int >  FDiaACodDia;
	DynamicArray<int >  FHoraACodHora;
	DynamicArray<int >  FNivelACodNivel;
	DynamicArray<int >  FEspecializacionACodEspecializacion;
	DynamicArray<short >  FCodNivelANivel;
	DynamicArray<short >  FCodEspecializacionAEspecializacion;
	DynamicArray<short >  FCodParaleloIdAParaleloId;
	DynamicArray<short >  FCodDiaADia;
	DynamicArray<short >  FCodHoraAHora;
	int FMinCodNivel;
	int FMinCodEspecializacion;
	int FMinCodParaleloId;
	int FMinCodDia;
	int FMinCodHora;
	Dbtables::TDatabase* FDatabase;
	short __fastcall GetDiaAMaxHorarioLaborable(short d);
	
protected:
	__property TDynamicSmallintArrayArray MoldeHorarioDetalle = {read=FMoldeHorarioDetalle};
	
public:
	void __fastcall Configurar(double ACruceProfesorValor, double AProfesorFraccionamientoValor, double 
		ACruceAulaTipoValor, double AHoraHuecaDesubicadaValor, double ASesionCortadaValor, double AMateriaNoDispersaValor
		);
	__fastcall TModeloHorario(Dbtables::TDatabase* ADatabase, double ACruceProfesorValor, double AProfesorFraccionamientoValor
		, double ACruceAulaTipoValor, double AHoraHuecaDesubicadaValor, double ASesionCortadaValor, double 
		AMateriaNoDispersaValor);
	__fastcall virtual ~TModeloHorario(void);
	__property double CruceProfesorValor = {read=FCruceProfesorValor};
	__property double ProfesorFraccionamientoValor = {read=FProfesorFraccionamientoValor};
	__property double CruceAulaTipoValor = {read=FCruceAulaTipoValor};
	__property double HoraHuecaDesubicadaValor = {read=FHoraHuecaDesubicadaValor};
	__property double SesionCortadaValor = {read=FSesionCortadaValor};
	__property double MateriaNoDispersaValor = {read=FMateriaNoDispersaValor};
	__property Dbtables::TDatabase* Database = {read=FDatabase};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TModeloHorario(void) : System::TObject() { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS TObjetoModeloHorario;
#pragma pack(push, 4)
class PASCALIMPLEMENTATION TObjetoModeloHorario : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TModeloHorario* FModeloHorario;
	DynamicArray<DynamicArray<int > >  FClaveAleatoria;
	DynamicArray<DynamicArray<short > >  FParaleloPeriodoASesion;
	DynamicArray<DynamicArray<short > >  FMateriaHorarioLaborableCant;
	DynamicArray<DynamicArray<short > >  FProfesorHorarioLaborableCant;
	DynamicArray<DynamicArray<short > >  FAulaTipoHorarioLaborableCant;
	DynamicArray<DynamicArray<short > >  FAntMateriaDiaMinHora;
	DynamicArray<DynamicArray<short > >  FAntMateriaDiaMaxHora;
	DynamicArray<DynamicArray<short > >  FAntDiaProfesorMinHora;
	DynamicArray<DynamicArray<short > >  FAntDiaProfesorMaxHora;
	DynamicArray<DynamicArray<DynamicArray<short > > >  FParaleloMateriaDiaMinHora;
	DynamicArray<DynamicArray<DynamicArray<short > > >  FParaleloMateriaDiaMaxHora;
	Classes::TList* FAntListaCambios;
	DynamicArray<short >  FParaleloMateriaNoDispersa;
	DynamicArray<DynamicArray<short > >  FDiaProfesorFraccionamiento;
	int FCruceProfesor;
	int FCruceAulaTipo;
	int FHoraHuecaDesubicada;
	int FSesionCortada;
	int FMateriaNoDispersa;
	int FMateriaProhibicion;
	int FProfesorProhibicion;
	int FAntMateriaNoDispersa;
	int FProfesorFraccionamiento;
	double FMateriaProhibicionValor;
	double FProfesorProhibicionValor;
	double FValor;
	bool FRecalcularValor;
	double __fastcall GetValor(void);
	void __fastcall DoGetValor(void);
	void __fastcall Normalizar(short AParalelo, short &AHorarioLaborable);
	void __fastcall SetClaveAleatoriaInterno(short AParalelo, short AHorarioLaborable, int AClaveAleatoria
		)/* overload */;
	void __fastcall SetClaveAleatoriaInterno(short AParalelo, short AHorarioLaborable, short ADuracion, 
		int AClaveAleatoria)/* overload */;
	void __fastcall AleatorizarClave(short AParalelo);
	int __fastcall GetMateriaNoDispersa(void);
	void __fastcall DoGetMateriaNoDispersa(void);
	void __fastcall DoGetHoraHuecaDesubicada(void);
	void __fastcall DoGetSesionCortada(void);
	int __fastcall GetHoraHuecaDesubicada(void);
	int __fastcall GetSesionCortada(void);
	void __fastcall DoGetProfesorProhibicionValor(void);
	void __fastcall DoGetMateriaProhibicionValor(void);
	double __fastcall GetProfesorProhibicionValor(void);
	double __fastcall GetMateriaProhibicionValor(void);
	double __fastcall GetMateriaNoDispersaValor(void);
	double __fastcall GetHoraHuecaDesubicadaValor(void);
	double __fastcall GetCruceProfesorValor(void);
	double __fastcall GetProfesorFraccionamientoValor(void);
	double __fastcall GetSesionCortadaValor(void);
	double __fastcall GetCruceAulaTipoValor(void);
	int __fastcall GetProfesorProhibicion(void);
	int __fastcall GetMateriaProhibicion(void);
	void __fastcall MutarInterno(void);
	bool __fastcall DescensoRapidoInterno(void);
	void __fastcall IntercambiarInterno(short AParalelo, short AHorarioLaborable, short AHorarioLaborable1
		, bool FueEvaluado);
	void __fastcall Intercambiar(short AParalelo, short AHorarioLaborable, short AHorarioLaborable1);
	double __fastcall EvaluarIntercambioInterno(short AParalelo, short AHorarioLaborable, short AHorarioLaborable1
		);
	__property TDynamicSmallintArrayArray ProfesorHorarioLaborableCant = {read=FProfesorHorarioLaborableCant
		};
	__property TDynamicSmallintArrayArray MateriaHorarioLaborableCant = {read=FMateriaHorarioLaborableCant
		};
	__property TDynamicSmallintArrayArray AulaTipoHorarioLaborableCant = {read=FAulaTipoHorarioLaborableCant
		};
	void __fastcall DoGetCruceProfesor(void);
	void __fastcall DoGetCruceAulaTipo(void);
	void __fastcall ActualizarAulaTipoHorarioLaborableCant(void);
	void __fastcall ActualizarProfesorHorarioLaborableCant(void);
	void __fastcall ActualizarMateriaHorarioLaborableCant(void);
	void __fastcall ActualizarParaleloMateriaDiaMinMaxHora(void)/* overload */;
	void __fastcall ActualizarParaleloMateriaDiaMinMaxHora(short AParalelo)/* overload */;
	short __fastcall GetParaleloMateriaNoDispersa(short AParalelo, TDynamicSmallintArrayArray &AMateriaDiaMaxHora
		);
	void __fastcall DoGetProfesorFraccionamiento(void);
	void __fastcall ActualizarDiaProfesorFraccionamiento(void);
	short __fastcall GetDiaProfesorFraccionamiento(short di, short p);
	
protected:
	__property bool RecalcularValor = {read=FRecalcularValor, write=FRecalcularValor, nodefault};
	
public:
	bool __fastcall DescensoRapido(void);
	void __fastcall DescensoRapidoForzado(void);
	void __fastcall InvalidarValor(void);
	void __fastcall Actualizar(void);
	void __fastcall SaveToFile(const AnsiString AFileName);
	void __fastcall SaveToDatabase(int CodHorario, System::TDateTime MomentoInicial, System::TDateTime 
		MomentoFinal, Classes::TStrings* Informe);
	void __fastcall LoadFromDataBase(int CodHorario);
	void __fastcall SaveToStream(Classes::TStream* Stream);
	void __fastcall LoadFromStream(Classes::TStream* Stream);
	__fastcall TObjetoModeloHorario(TModeloHorario* AModeloHorario);
	__fastcall virtual ~TObjetoModeloHorario(void);
	void __fastcall HacerAleatorio(void);
	void __fastcall Mutar(void)/* overload */;
	void __fastcall Mutar(int Orden)/* overload */;
	void __fastcall MutarDia(void);
	void __fastcall Assign(TObjetoModeloHorario* AObjetoModeloHorario);
	__property double Valor = {read=GetValor};
	__property int CruceProfesor = {read=FCruceProfesor, nodefault};
	__property int CruceAulaTipo = {read=FCruceAulaTipo, nodefault};
	__property int HoraHuecaDesubicada = {read=GetHoraHuecaDesubicada, nodefault};
	__property int SesionCortada = {read=GetSesionCortada, nodefault};
	__property double CruceProfesorValor = {read=GetCruceProfesorValor};
	__property double ProfesorFraccionamientoValor = {read=GetProfesorFraccionamientoValor};
	__property double CruceAulaTipoValor = {read=GetCruceAulaTipoValor};
	__property double HoraHuecaDesubicadaValor = {read=GetHoraHuecaDesubicadaValor};
	__property double SesionCortadaValor = {read=GetSesionCortadaValor};
	__property int MateriaProhibicion = {read=GetMateriaProhibicion, nodefault};
	__property int ProfesorProhibicion = {read=GetProfesorProhibicion, nodefault};
	__property double MateriaProhibicionValor = {read=GetMateriaProhibicionValor};
	__property double ProfesorProhibicionValor = {read=GetProfesorProhibicionValor};
	__property int MateriaNoDispersa = {read=GetMateriaNoDispersa, nodefault};
	__property double MateriaNoDispersaValor = {read=GetMateriaNoDispersaValor};
	__property TDynamicSmallintArrayArray ParaleloPeriodoASesion = {read=FParaleloPeriodoASesion, write=
		FParaleloPeriodoASesion};
	__property TModeloHorario* ModeloHorario = {read=FModeloHorario};
	__property int ProfesorFraccionamiento = {read=FProfesorFraccionamiento, nodefault};
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TObjetoModeloHorario(void) : System::TObject() { }
	#pragma option pop
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall CrearAleatorioDesdeModelo(TObjetoModeloHorario* &AObjetoModeloHorario
	, TModeloHorario* AModeloHorario);
extern PACKAGE void __fastcall CargarPrefijadoDesdeModelo(TObjetoModeloHorario* &AObjetoModeloHorario
	, TModeloHorario* AModeloHorario, int CodHorario);
extern PACKAGE void __fastcall CruzarIndividuos(TObjetoModeloHorario* &Uno, TObjetoModeloHorario* &Dos
	);

}	/* namespace Kermodel */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Kermodel;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// KerModel
