{ -*- mode: Delphi -*- }
unit USortAlgs;

{$I ttg.inc}

(*******************************************************************************

  Archivo: SortAlgs.pas
  Sistema: Common Unit
  Version: 1.0

  Creado:
    15/02/1999

  Descripcion:
    Contiene funciones de ordenamiento de datos en memoria.

  Referencia:
    Delphi Informant Vol. ? No. ?

  Compatibilidad:
    Delphi 4.0 / Tiene caracteristicas propias del Delphi 4.0, que lo hacen
    dificil de hacer compatible con Delphi 3.0/2.0/1.0

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
  efmera@gmail.com

*******************************************************************************)

interface

uses
  Dialogs;

type
  generic TSortAlgorithm<K,T> = class
    class procedure Quicksort(var KeyList: array of K; var ValueList: array of T; min, max: Integer); overload;
    class procedure BubbleSort(var KeyList: array of K; var ValueList: array of T; min, max: Integer); overload;
    procedure SelectionSort(var KeyList: array of K; var ValueList: array of T; min, max: Integer);
    procedure PartialSort(var KeyList: array of K; var ValueList: array of T; min, max, med: Integer);

    class procedure Quicksort(var KeyList: array of K; min, max: Integer); overload;
    class procedure BubbleSort(var KeyList: array of K; min, max: Integer); overload;
  end;

implementation

class procedure TSortAlgorithm.Quicksort(var KeyList: array of K; var ValueList: array of T; min, max: Integer);
var
  med_value1: K;
  med_value2: T;
  hi, lo, i: Integer;
begin
    // If the list has <= 1 element, it's sorted.
  if (min >= max) then Exit;

    // Pick a dividing item randomly.
  i := min + Trunc(Random(max - min + 1));
  med_value1 := KeyList[i];
  med_value2 := ValueList[i];
    // Swap it to the front so we can find it easily.
  KeyList[i] := KeyList[min];
  ValueList[i] := ValueList[min];

    // Move the items smaller than this into the left
    // half of the list. Move the others into the right.
  lo := min;
  hi := max;
  while (True) do
  begin
        // Look down from hi for a value < med_value.
    while (KeyList[hi] >= med_value1) and ((KeyList[hi] <> med_value1) or (ValueList[hi]
      >= med_value2)) do
    begin
      hi := hi - 1;
      if (hi <= lo) then Break;
    end;
    if (hi <= lo) then
    begin
            // We're done separating the items.
      KeyList[lo] := med_value1;
      ValueList[lo] := med_value2;
      Break;
    end;

        // Swap the lo and hi values.
    KeyList[lo] := KeyList[hi];
    ValueList[lo] := ValueList[hi];

        // Look up from lo for a value >= med_value.
    lo := lo + 1;
    while (KeyList[lo] < med_value1) or ((KeyList[lo] = med_value1) and (ValueList[lo] <
      med_value2)) do
    begin
      lo := lo + 1;
      if (lo >= hi) then Break;
    end;
    if (lo >= hi) then
    begin
            // We're done separating the items.
      lo := hi;
      KeyList[hi] := med_value1;
      ValueList[hi] := med_value2;
      Break;
    end;

        // Swap the lo and hi values.
    KeyList[hi] := KeyList[lo];
    ValueList[hi] := ValueList[lo];
  end; // while (True) do
    // Sort the two sublists.
  Quicksort(KeyList, ValueList, min, lo - 1);
  Quicksort(KeyList, ValueList, lo + 1, max);
end;

class procedure TSortAlgorithm.BubbleSort(var KeyList: array of K;
                                          var ValueList: array of T;
                                          min, max: Integer);
var
  last_swap, i, j: Integer;
  tmp1: K;
  tmp2: T;
begin
  // Repeat until we are done.
  while (min < max) do
  begin
    // Bubble up.
    last_swap := min - 1;
    // for i := min + 1 to max
    i := min + 1;
    while (i <= max) do
    begin
      // Find a bubble.
      if (KeyList[i - 1] > KeyList[i]) or ((KeyList[i - 1] = KeyList[i]) and (ValueList[i - 1] > ValueList[i])) then
      begin
        // See where to drop the bubble.
        tmp1 := KeyList[i - 1];
        tmp2 := ValueList[i - 1];
        j := i;
        repeat
          KeyList[j - 1] := KeyList[j];
          ValueList[j - 1] := ValueList[j];
          j := j + 1;
          if (j > max) then Break;
        until (KeyList[j] >= tmp1) and ((KeyList[j] <> tmp1) or (ValueList[j] >= tmp2));
        KeyList[j - 1] := tmp1;
        ValueList[j - 1] := tmp2;
        last_swap := j - 1;
        i := j + 1;
      end else
        i := i + 1;
    end; // while (i <= max) do.
    // End bubbling up.

    // Update max.
    max := last_swap - 1;

    // Bubble down.
    last_swap := max + 1;
    // for i := max - 1 downto min
    i := max - 1;
    while (i >= min) do
    begin
    // Find a bubble.
      if (KeyList[i + 1] < KeyList[i]) or ((KeyList[i + 1] = KeyList[i]) and (ValueList[i + 1] < ValueList[i])) then
      begin
        // See where to drop the bubble.
        tmp1 := KeyList[i + 1];
        tmp2 := ValueList[i + 1];
        j := i;
        repeat
          KeyList[j + 1] := KeyList[j];
          ValueList[j + 1] := ValueList[j];
          j := j - 1;
          if j < min then Break;
        until (KeyList[j] <= tmp1) and ((KeyList[j] <> tmp1) or (ValueList[j] <= tmp2));
        KeyList[j + 1] := tmp1;
        ValueList[j + 1] := tmp2;
        last_swap := j + 1;
        i := j - 1;
      end else
        i := i - 1;
    end; // while (i >= min) do
    // End bubbling down.
    // Update min.
    min := last_swap + 1;
  end; // while (min < max) do
end;

// Run selectionsort.

procedure TSortAlgorithm.SelectionSort(var KeyList: array of K;
                                       var ValueList: array of T;
                                       min, max: Integer);
var
  i, j, best_j: Integer;
  best_value1: K;
  best_value2: T;
begin
  for i := min to max - 1 do
  begin
    best_value1 := KeyList[i];
    best_j := i;
    for j := i + 1 to max do
    begin
      if (KeyList[j] < best_value1) then
      begin
        best_value1 := KeyList[j];
        best_j := j;
      end;
    end; // for j := i + 1 to max do
    best_value2 := ValueList[best_j];
    KeyList[best_j] := KeyList[i];
    ValueList[best_j] := ValueList[i];
    KeyList[i] := best_value1;
    ValueList[i] := best_value2;
  end; // for i := min to max - 1 do
end;

// Ordena una lista que esta ordenada hasta med:

procedure TSortAlgorithm.PartialSort(var KeyList: array of K;
                                     var ValueList: array of T;
                                     min, max, med: Integer);
var
  value1: array[0..4095] of K;
  value2: array[0..4095] of T;
  i, j, l: Integer;
begin
  // If the list has <= 1 element, it's sorted.
  if (min >= max) then Exit;
  i := min;
  j := med;
  l := min;
  while (i < med) and (j <= max) do
  begin
    if KeyList[i] < KeyList[j] then
    begin
      value1[l] := KeyList[i];
      value2[l] := ValueList[i];
      Inc(i);
      Inc(l);
    end
    else
    begin
      value1[l] := KeyList[j];
      value2[l] := ValueList[j];
      Inc(j);
      Inc(l);
    end;
  end;
  while (i < med) do
  begin
    value1[l] := KeyList[i];
    value2[l] := ValueList[i];
    Inc(i);
    Inc(l);
  end;
  while (j <= max) do
  begin
    value1[l] := KeyList[j];
    value2[l] := ValueList[j];
    Inc(j);
    Inc(l);
  end;
  Move(value1[min], KeyList[min], (max - min + 1) * SizeOf(K));
  Move(value2[min], ValueList[min], (max - min + 1) * SizeOf(T));
end;

class procedure TSortAlgorithm.BubbleSort(var KeyList: array of K; min, max: Integer);
var
  last_swap, i, j: Integer;
  tmp1: K;
begin
  // Repeat until we are done.
  while (min < max) do
  begin
    // Bubble up.
    last_swap := min - 1;
    // for i := min + 1 to max
    i := min + 1;
    while (i <= max) do
    begin
            // Find a bubble.
      if KeyList[i - 1] > KeyList[i] then
      begin
        // See where to drop the bubble.
        tmp1 := KeyList[i - 1];
        j := i;
        repeat
          KeyList[j - 1] := KeyList[j];
          j := j + 1;
          if (j > max) then Break;
        until (KeyList[j] >= tmp1);
        KeyList[j - 1] := tmp1;
        last_swap := j - 1;
        i := j + 1;
      end else
        i := i + 1;
    end; // while (i <= max) do.
    // End bubbling up.

    // Update max.
    max := last_swap - 1;

    // Bubble down.
    last_swap := max + 1;
    // for i := max - 1 downto min
    i := max - 1;
    while (i >= min) do
    begin
    // Find a bubble.
      if (KeyList[i + 1] < KeyList[i]) then
      begin
        // See where to drop the bubble.
        tmp1 := KeyList[i + 1];
        j := i;
        repeat
          KeyList[j + 1] := KeyList[j];
          j := j - 1;
          if j < min then Break;
        until (KeyList[j] <= tmp1);
        KeyList[j + 1] := tmp1;
        last_swap := j + 1;
        i := j - 1;
      end else
        i := i - 1;
    end; // while (i >= min) do
    // End bubbling down.
    // Update min.
    min := last_swap + 1;
  end; // while (min < max) do
end;

// Run quicksort.

class procedure TSortAlgorithm.Quicksort(var KeyList: array of K; min, max: Integer);
var
  med_value1: K;
  hi, lo, i: Integer;
begin
    // If the list has <= 1 element, it's sorted.
  if (min >= max) then Exit;

    // Pick a dividing item randomly.
  i := min + Trunc(Random(max - min + 1));
  med_value1 := KeyList[i];
    // Swap it to the front so we can find it easily.
  KeyList[i] := KeyList[min];

    // Move the items smaller than this into the left
    // half of the list. Move the others into the right.
  lo := min;
  hi := max;
  while (True) do
  begin
        // Look down from hi for a value < med_value.
    while (KeyList[hi] >= med_value1) do
    begin
      hi := hi - 1;
      if (hi <= lo) then Break;
    end;
    if (hi <= lo) then
    begin
            // We're done separating the items.
      KeyList[lo] := med_value1;
      Break;
    end;

        // Swap the lo and hi values.
    KeyList[lo] := KeyList[hi];

        // Look up from lo for a value >= med_value.
    lo := lo + 1;
    while (KeyList[lo] < med_value1) do
    begin
      lo := lo + 1;
      if (lo >= hi) then Break;
    end;
    if (lo >= hi) then
    begin
            // We're done separating the items.
      lo := hi;
      KeyList[hi] := med_value1;
      Break;
    end;

        // Swap the lo and hi values.
    KeyList[hi] := KeyList[lo];
  end; // while (True) do
    // Sort the two sublists.
  Quicksort(KeyList, min, lo - 1);
  Quicksort(KeyList, lo + 1, max);
end;

end.
