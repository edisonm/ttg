unit Rand;

{$I ttg.inc}

(*******************************************************************************

  Archivo: rand.pas
  Sistema: Unidad comun.
  Version: 1.0

  Creado:
    07/02/1998

  Descripcion
    generador de numeros aleatorios 32/64 bits

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


    Periodo: p = p1*p2 ~ 2^126
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
    solo funcionan en Delphi 4.0.

  Últimas revisiones:
    20-04-1999

  Lista de cosas por hacer:

  Responsable(s):
    Edison Mera

  Derechos de Autor (c) 1999, Edison Mera.  Todos los derechos reservados.

  Este codigo fuente contiene informacion privada con secretos de fabrica,
  y no esta disponible para publicacion.  Este codigo no debe ser desclasificado
  a NADIE, excepto a quienes tengan una autorizacion escrita.

  Recuerde que la pirateria esta penada por la Ley.

  Edison Mera.
  edmera@gmail.com

*******************************************************************************)

{ $DEFINE USEASSEMBLER}

interface

uses
  SysUtils;

procedure SetSeeds(ASeed1, ASeed2, ASeed3, ASeed4: LongInt);
procedure GetSeeds(var ASeed1, ASeed2, ASeed3, ASeed4: LongInt);

// generador acoplado de 32 bits con signo:
// -2147483648 <= rand32 < 2147483648
function rand32: Longint;

// generador acoplado de 31 bits:
// 0 <= crand32 < 2147483648
function crand32: Longint;

// generador acoplado de 32 bits sin signo:
// 0 <= crand32 < 4294967296
function urand32: Longword;

// generador de numeros flotantes de precision extendida:
// 0 <= randl < 1
function randl: Extended;

// Generador acoplado de 64 bits con signo:
// -2^63 <= rand64 < 2^63
function rand64: Int64;
// assembler;

// Funcion que llena un area de memoria con bits generados aleatoriamente.
procedure FillRandom(var X; Count: Integer);

// Funcion que llena un arreglo de Longint con numeros generados aleatoriamente,
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
  Seed1: Longint;
  Seed2: Longint;
  Seed3: Longint;
  Seed4: Longint;

(*---------------------------------------------------------------------------- )
( Observese que esta funcion se programo en ensamblador, para evitar que el    )
( compilador realice alguna optimizacion no deseada.                           )
(-----------------------------------------------------------------------------*)

{$IFDEF USEASSEMBLER}
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
{$ELSE}
procedure SetSeeds(ASeed1, ASeed2, ASeed3, ASeed4: LongInt);
begin
  Seed1 := ASeed1;
  Seed2 := ASeed2;
  Seed3 := ASeed3;
  Seed4 := ASeed4;
end;
{$ENDIF}

procedure GetSeeds(var ASeed1, ASeed2, ASeed3, ASeed4: Longint);
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

{$IFDEF USEASSEMBLER}
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

// funcion que genera un numero aleatorio de 32 bits con signo

function rand32: Longint; assembler;
asm
    call     _rand321
    call     _rand322
    add      eax, Seed1
end;

// funcion que genera un numero aleatorio de 31 bits sin signo

function crand32: Longint; assembler;
asm
    call     _rand321
    call     _rand322
    add      eax, Seed1
    and      eax, $7FFFFFFF
    wait
end;
// funcion que genera un numero aleatorio de 32 bits sin signo

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

{$ELSE}

function _rand321: Longint;
var
  x: Int64;
begin
  x := Int64(Seed1) * MULTIPLIER1 + Seed2;
  Seed1 := x and $FFFFFFFF;
  Seed2 := x shr 32;
  Result := Seed1;
end;

function _rand322: Longint;
var
  x: Int64;
begin
  x := Int64(Seed3) * MULTIPLIER2 + Seed4;
  Seed3 := x and $FFFFFFFF;
  Seed4 := x shr 32;
  Result := Seed3;
end;

// funcion que genera un numero aleatorio de 32 bits con signo

function rand32: Longint;
begin
  Result := _rand321 + _rand322;
end;

// funcion que genera un numero aleatorio de 31 bits sin signo

function crand32: Longint;
begin
  Result := (_rand321 + _rand322) and $7FFFFFFF;
end;

// funcion que genera un numero aleatorio de 32 bits sin signo

function urand32: Longword;
begin
  Result := _rand321 + _rand322;
end;

function rand64: Int64;
begin
  Result := Int64(_rand321) shl 32 + _rand322;
end;

{$ENDIF}

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
(  la funcion en ensamblador es 140% mas rapida que su equivalente en Pascal:  )
(  notese que debido a lo critico de esta funcion, las funciones _rand321 y    )
(  _rand322 fueron expandidas en linea                                         )
(-----------------------------------------------------------------------------*)

{$IFDEF USEASSEMBLER}
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
{$ELSE}
function randl: extended;
begin
  Result := (LongWord(_rand321) + LongWord(_rand322)/$100000000)/$100000000;
end;
{$ENDIF}

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
