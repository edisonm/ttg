unit rand;
(*******************************************************************************

  Archivo: rand.pas
  Sistema: Unidad com�n.
  Versi�n: 1.0

  Creado:
    07/02/1998

  Descripci�n
    generador de n�meros aleatorios 32/64 bits

    algoritmo lineal congruente con carga, dos generadores acoplados:


    sean
      x1 = seed1, y1 = seed2,
      x2 = seed3, y2 = seed4,
    (seed1, seed2, seed3 y seed4 son dados como semilla)

    x1' = low(m1*x1) + y1;         (m1*x1)mod(2^32) + y1
    y1' = hig(m1*x1);              (m1*x1)div(2^32)
    x1 = x1';
    y1 = y1';
    x2' = low(m2*x2) + y2;         (m2*x2)mod(2^32) + y2
    y2' = hig(m2*x2);              (m2*x2)div(2^32)
    x2 = x2';
    y2 = y2';

    return (x1 + y2) * 2^32 + (x2 + y1);


    Per�odo: p = p1*p2 ~ 2^126
    p1 = [(m1/2)*2^32-1]
    p2 = [(m2/2)*2^32-1]
    m1 <> m2
    donde m1, m2 pueden ser:


      1439034780
      1674588495
      2006575059
      2298585264
      1184232405
      2154852864
      4090517964
      1219071924
      1253763714
      3599538054    -695429242
      2477845215
      1264635735
      3407045559
      ...
      en general, pi y (pi-1)/2 deben ser primos (i =1,2).

  Dependencias:
    Delphi / Pascal
  Compatibilidad:
    Delphi 2.0 en adelante / Debe funcionar en C++ Builder.  Algunas funciones
    s�lo funcionan en Delphi 4.0.

  �ltimas revisiones:
    20-04-1999

  Lista de cosas por hacer:

  Responsable(s):
    Edison Mera

  Derechos de Autor (c) 1999, Edison Mera.  Todos los derechos reservados.

  Este c�digo fuente contiene informaci�n privada con secretos de f�brica,
  y no est� disponible para publicaci�n.  Este c�digo no debe ser desclasificado
  a NADIE, excepto a quienes tengan una autorizaci�n escrita.

  Recuerde que la pirater�a est� penada por la Ley.

  Edison Mera.
  edmera@yahoo.com
  593-2-451-004

*******************************************************************************)

interface

uses
  SysUtils;

procedure setseeds(ASeed1, ASeed2, ASeed3, ASeed4: LongInt);
procedure getseeds(var ASeed1, ASeed2, ASeed3, ASeed4: LongInt);

// generador acoplado de 32 bits con signo:
// -2147483648 <= rand32 < 2147483648
function rand32: Longint;

// generador acoplado de 31 bits:
// 0 <= crand32 < 2147483648
function crand32: Longint;

// generador acoplado de 32 bits sin signo:
// 0 <= crand32 < 4294967296
function urand32: Longword;

// generador de n�meros flotantes de precisi�n extendida:
// 0 <= randl < 1
function randl: Extended;

// Generador acoplado de 64 bits con signo:
// -2^63 <= rand64 < 2^63
function rand64: Int64;
// assembler;

// Funci�n que llena una �rea de memoria con bits generados aleatoriamente.
procedure FillRandom(var X; Count: Integer);

// Funci�n que llena un arreglo de Longint con n�meros generados aleatoriamente,
// de 31 bits.
procedure Fillcrand32(var X: array of Longint; Count: Integer);

// aleatorizador, tomando el tiempo para calcular la semilla:
procedure srandom;

//---------------------------------------------------------------------------

implementation

const
  MULTIPLIER1: LongInt = 2006575059; //m1
  MULTIPLIER2: LongInt = 1219071924; //m2

var
  Seed1, Seed2, Seed3, Seed4: Longint;

(*---------------------------------------------------------------------------- )
( Observese que esta funci�n se program� en ensamblador, para evitar que el    )
( compilador realice alguna optimizaci�n no deseada.                           )
(-----------------------------------------------------------------------------*)

procedure setseeds(ASeed1, ASeed2, ASeed3, ASeed4: LongInt); assembler;
asm
    mov     eax, ASeed1
    mov     Seed1, eax
    mov     eax, ASeed2
    mov     Seed2, eax
    mov     eax, ASeed3
    mov     Seed3, eax
    mov     eax, ASeed4
    mov     Seed4, eax
end;

procedure getseeds(var ASeed1, ASeed2, ASeed3, ASeed4: Longint);
begin
  ASeed1 := Seed1;
  ASeed2 := Seed2;
  ASeed3 := Seed3;
  ASeed4 := Seed4;
end;
// aleatorizador, tomando el tiempo para calcular la semilla:

procedure srandom;
const
  m = 65536.0;
  k = 31329;
var
  x: TDateTime;
begin
  x := Now;
  //x := (x - 0.5) * m;
  Seed1 := Round(x);
  x := (abs(x - Seed1) - 0.5) * m;
  Seed2 := Round(x);
  x := (abs(x - Seed2) - 0.5) * m;
  Seed3 := Round(x);
  x := (abs(x - Seed3) - 0.5) * m;
  Seed4 := Round(x);
  Seed1 := Seed1 * k; Inc(Seed1);
  Seed2 := Seed2 * k; Inc(Seed2);
  Seed3 := Seed3 * k; Inc(Seed3);
  Seed4 := Seed4 * k; Inc(Seed4);
end;

function _rand321: Longint; assembler;
asm
    mov     eax, Seed1
    mul     MULTIPLIER1
    add     eax, Seed2
    mov     Seed1, eax
    mov     Seed2, edx
end;

function _rand322: Longint; assembler;
asm
    mov     eax, Seed3
    mul     MULTIPLIER2
    add     eax, Seed4
    mov     Seed3, eax
    mov     Seed4, edx
end;

// funci�n que genera un n�mero aleatorio de 32 bits con signo

function rand32: Longint; assembler;
asm
    call     _rand321
    call     _rand322
    add      eax, Seed1
end;

// funci�n que genera un n�mero aleatorio de 31 bits sin signo

function crand32: Longint; assembler;
asm
    call     _rand321
    call     _rand322
    add      eax, Seed1
    and      eax, $7FFFFFFF
    wait
end;
// funci�n que genera un n�mero aleatorio de 32 bits sin signo

function urand32: Longword; assembler;
asm
    call     _rand321
    call     _rand322
    add      eax, Seed1
end;

function rand64: Int64; assembler;
asm
  call    _rand321
  call    _rand322
  add     eax, Seed2
  add     edx, Seed1
end;

procedure FillRandom(var X; Count: Integer);
type
  PInt64Array = ^TInt64Array;
  TInt64Array = array[0..4095] of Int64;
var
  i, j, l: Integer;
  k: Int64;
begin
  i := Count div 8;
  for j := 0 to i - 1 do
    PInt64Array(@X)^[j] := rand64;
  l := Count mod 8;
  k := rand64;
  for j := 0 to l - 1 do
    PByteArray(@(PInt64Array(@X)^[i]))^[j] := PByteArray(@k)^[j];
end;

procedure Fillcrand32(var X: array of Longint; Count: Integer);
type
  PInt64Array = ^TInt64Array;
  TInt64Array = array[0..4095] of Int64;
  PLongintArray = ^TLongintArray;
  TLongintArray = array[0..8191] of Longint;
var
  j, n: Integer;
begin
  j := 0;
  n := Count div 2;
  while j < n do
  begin
    PInt64Array(@X)^[j] := rand64 and $7FFFFFFF7FFFFFFF;
    Inc(j);
  end;
  if Count mod 2 = 1 then
    PLongintArray(@X)^[Count - 1] := crand32;
end;

(*-----------------------------------------------------------------------------)
(  la funci�n en ensamblador es 140% m�s r�pida que su equivalente en Pascal:  )
(  n�tese que debido a lo cr�tico de esta funci�n, las funciones _rand321 y    )
(  _rand322 fueron expandidas en l�nea                                         )
(-----------------------------------------------------------------------------*)

function randl: extended; assembler;
var
  x: extended;
asm
    fld1
    fstp    x
//    call    _rand321
    mov     eax, Seed1
    mul     MULTIPLIER1
    add     eax, Seed2
    mov     Seed1, eax
    mov     Seed2, edx
    mov     ecx, edx

//    call    _rand322
    mov     eax, Seed3
    mul     MULTIPLIER2
    add     eax, Seed4
    mov     Seed3, eax
    mov     Seed4, edx

    add     eax, ecx
    add     edx, Seed1
    or      edx, $80000000
    mov     dword ptr x[0], eax
    mov     dword ptr x[4], edx
    fld     x
    fld1
    fsubp
end;

initialization
  (*
    si usted quiere inicializar aleatoriamente...
  *)
  {srandom;}

  Seed1 := 1;
  Seed2 := 1;
  Seed3 := 1;
  Seed4 := 1;

end.
