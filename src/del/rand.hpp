// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'rand.pas' rev: 4.00

#ifndef randHPP
#define randHPP

#pragma delphiheader begin
#pragma option push -w-
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Rand
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall setseeds(int ASeed1, int ASeed2, int ASeed3, int ASeed4);
extern PACKAGE void __fastcall getseeds(int &ASeed1, int &ASeed2, int &ASeed3, int &ASeed4);
extern PACKAGE void __fastcall srandom(void);
extern PACKAGE int __fastcall rand32(void);
extern PACKAGE int __fastcall crand32(void);
extern PACKAGE unsigned __fastcall urand32(void);
extern PACKAGE __int64 __fastcall rand64(void);
extern PACKAGE void __fastcall FillRandom(void *X, int Count);
extern PACKAGE void __fastcall Fillcrand32(int * X, const int X_Size, int Count);
extern PACKAGE Extended __fastcall randl(void);

}	/* namespace Rand */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Rand;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// rand
