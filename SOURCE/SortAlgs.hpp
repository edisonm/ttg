// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SortAlgs.pas' rev: 4.00

#ifndef SortAlgsHPP
#define SortAlgsHPP

#pragma delphiheader begin
#pragma option push -w-
#include <Dialogs.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sortalgs
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall BubblesortLongint(int * List1, const int List1_Size, short * List2, const 
	int List2_Size, int min, int max);
extern PACKAGE void __fastcall SelectionsortLongint(int * List1, const int List1_Size, short * List2
	, const int List2_Size, int min, int max);
extern PACKAGE void __fastcall MySorterLongint(int * List1, const int List1_Size, short * List2, const 
	int List2_Size, int min, int max, int med);
extern PACKAGE void __fastcall sQuicksort(short * List1, const int List1_Size, int min, int max);
extern PACKAGE void __fastcall lQuicksort(int * List1, const int List1_Size, int min, int max);
extern PACKAGE void __fastcall QuicksortSmallint(short * List1, const int List1_Size, int * List2, const 
	int List2_Size, int min, int max);
extern PACKAGE void __fastcall QuicksortLongint(int * List1, const int List1_Size, short * List2, const 
	int List2_Size, int min, int max);

}	/* namespace Sortalgs */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Sortalgs;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SortAlgs
