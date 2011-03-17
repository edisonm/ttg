unit SortAlgs;

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

  Dependencias:
    Delphi 4.0
    RxLib
    Tb97
    ArCtrls

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

procedure BubblesortInteger(var List1: array of Integer; var List2: array of
  Integer; min, max: Integer);
procedure sQuicksort(var List1: array of Smallint; min, max: Integer);
procedure lQuicksort(var List1: array of Integer; min, max: Integer);
procedure lBubblesort(var List1: array of Integer; min, max: Integer);
procedure QuicksortInteger(var List1: array of Integer; var List2: array of
  Integer; min, max: Integer);
procedure SelectionsortInteger(var List1: array of Integer; var List2: array of
  Integer; min, max: Integer);
procedure PartialSortInteger(var List1: array of Integer; var List2: array of
  Integer; min, max, med: Integer);

implementation

procedure BubblesortInteger(var List1: array of Integer; var List2: array of
  Integer; min, max: Integer);
var
  last_swap, i, j: Integer;
  tmp1: Integer;
  tmp2: Integer;
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
      if (List1[i - 1] > List1[i]) or ((List1[i - 1] = List1[i]) and (List2[i - 1] > List2[i])) then
      begin
        // See where to drop the bubble.
        tmp1 := List1[i - 1];
        tmp2 := List2[i - 1];
        j := i;
        repeat
          List1[j - 1] := List1[j];
          List2[j - 1] := List2[j];
          j := j + 1;
          if (j > max) then Break;
        until (List1[j] >= tmp1) and ((List1[j] <> tmp1) or (List2[j] >= tmp2));
        List1[j - 1] := tmp1;
        List2[j - 1] := tmp2;
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
      if (List1[i + 1] < List1[i]) or ((List1[i + 1] = List1[i]) and (List2[i + 1] < List2[i])) then
      begin
        // See where to drop the bubble.
        tmp1 := List1[i + 1];
        tmp2 := List2[i + 1];
        j := i;
        repeat
          List1[j + 1] := List1[j];
          List2[j + 1] := List2[j];
          j := j - 1;
          if j < min then Break;
        until (List1[j] <= tmp1) and ((List1[j] <> tmp1) or (List2[j] <= tmp2));
        List1[j + 1] := tmp1;
        List2[j + 1] := tmp2;
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

procedure SelectionsortInteger(var List1: array of Integer;
  var List2: array of Integer; min, max: Integer);
var
  i, j, best_j: Integer;
  best_value1: Integer;
  best_value2: Smallint;
begin
  for i := min to max - 1 do
  begin
    best_value1 := List1[i];
    best_j := i;
    for j := i + 1 to max do
    begin
      if (List1[j] < best_value1) then
      begin
        best_value1 := List1[j];
        best_j := j;
      end;
    end; // for j := i + 1 to max do
    best_value2 := List2[best_j];
    List1[best_j] := List1[i];
    List2[best_j] := List2[i];
    List1[i] := best_value1;
    List2[i] := best_value2;
  end; // for i := min to max - 1 do
end;

// Ordena una lista que esta ordenada hasta med:

procedure PartialSortInteger(var List1: array of Integer;
  var List2: array of Integer; min, max, med: Integer);
var
  value1: array[0..4095] of Integer;
  value2: array[0..4095] of Integer;
  i, j, k: Integer;
begin
  // If the list has <= 1 element, it's sorted.
  if (min >= max) then Exit;
  i := min;
  j := med;
  k := min;
  while (i < med) and (j <= max) do
  begin
    if List1[i] < List1[j] then
    begin
      value1[k] := List1[i];
      value2[k] := List2[i];
      Inc(i);
      Inc(k);
    end
    else
    begin
      value1[k] := List1[j];
      value2[k] := List2[j];
      Inc(j);
      Inc(k);
    end;
  end;
  while (i < med) do
  begin
    value1[k] := List1[i];
    value2[k] := List2[i];
    Inc(i);
    Inc(k);
  end;
  while (j <= max) do
  begin
    value1[k] := List1[j];
    value2[k] := List2[j];
    Inc(j);
    Inc(k);
  end;
  Move(value1[min], List1[min], (max - min + 1) * SizeOf(Integer));
  Move(value2[min], List2[min], (max - min + 1) * SizeOf(Smallint));
end;

procedure lBubblesort(var List1: array of Integer; min, max: Integer);
var
  last_swap, i, j: Integer;
  tmp1: Integer;
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
      if List1[i - 1] > List1[i] then
      begin
        // See where to drop the bubble.
        tmp1 := List1[i - 1];
        j := i;
        repeat
          List1[j - 1] := List1[j];
          j := j + 1;
          if (j > max) then Break;
        until (List1[j] >= tmp1);
        List1[j - 1] := tmp1;
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
      if (List1[i + 1] < List1[i]) then
      begin
        // See where to drop the bubble.
        tmp1 := List1[i + 1];
        j := i;
        repeat
          List1[j + 1] := List1[j];
          j := j - 1;
          if j < min then Break;
        until (List1[j] <= tmp1);
        List1[j + 1] := tmp1;
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

procedure sQuicksort(var List1: array of Smallint; min, max: Integer);
var
  med_value1: Smallint;
  hi, lo, i: Integer;
begin
    // If the list has <= 1 element, it's sorted.
  if (min >= max) then Exit;

    // Pick a dividing item randomly.
  i := min + Trunc(Random(max - min + 1));
  med_value1 := List1[i];
    // Swap it to the front so we can find it easily.
  List1[i] := List1[min];

    // Move the items smaller than this into the left
    // half of the list. Move the others into the right.
  lo := min;
  hi := max;
  while (True) do
  begin
        // Look down from hi for a value < med_value.
    while (List1[hi] >= med_value1) do
    begin
      hi := hi - 1;
      if (hi <= lo) then Break;
    end;
    if (hi <= lo) then
    begin
            // We're done separating the items.
      List1[lo] := med_value1;
      Break;
    end;

        // Swap the lo and hi values.
    List1[lo] := List1[hi];

        // Look up from lo for a value >= med_value.
    lo := lo + 1;
    while (List1[lo] < med_value1) do
    begin
      lo := lo + 1;
      if (lo >= hi) then Break;
    end;
    if (lo >= hi) then
    begin
            // We're done separating the items.
      lo := hi;
      List1[hi] := med_value1;
      Break;
    end;

        // Swap the lo and hi values.
    List1[hi] := List1[lo];
  end; // while (True) do
    // Sort the two sublists.
  sQuicksort(List1, min, lo - 1);
  sQuicksort(List1, lo + 1, max);
end;

procedure lQuicksort(var List1: array of Integer; min, max: Integer);
var
  med_value1: Integer;
  hi, lo, i: Integer;
begin
    // If the list has <= 1 element, it's sorted.
  if (min >= max) then Exit;

    // Pick a dividing item randomly.
  i := min + Trunc(Random(max - min + 1));
  med_value1 := List1[i];
    // Swap it to the front so we can find it easily.
  List1[i] := List1[min];

    // Move the items smaller than this into the left
    // half of the list. Move the others into the right.
  lo := min;
  hi := max;
  while (True) do
  begin
        // Look down from hi for a value < med_value.
    while (List1[hi] >= med_value1) do
    begin
      hi := hi - 1;
      if (hi <= lo) then Break;
    end;
    if (hi <= lo) then
    begin
            // We're done separating the items.
      List1[lo] := med_value1;
      Break;
    end;

        // Swap the lo and hi values.
    List1[lo] := List1[hi];

        // Look up from lo for a value >= med_value.
    lo := lo + 1;
    while (List1[lo] < med_value1) do
    begin
      lo := lo + 1;
      if (lo >= hi) then Break;
    end;
    if (lo >= hi) then
    begin
            // We're done separating the items.
      lo := hi;
      List1[hi] := med_value1;
      Break;
    end;

        // Swap the lo and hi values.
    List1[hi] := List1[lo];
  end; // while (True) do
    // Sort the two sublists.
  lQuicksort(List1, min, lo - 1);
  lQuicksort(List1, lo + 1, max);
end;

procedure QuicksortSmallint(var List1: array of Smallint; var List2: array of
  Integer; min, max: Integer);
var
  med_value1: Smallint;
  med_value2: Integer;
  hi, lo, i: Integer;
begin
    // If the list has <= 1 element, it's sorted.
  if (min >= max) then Exit;

    // Pick a dividing item randomly.
  i := min + Trunc(Random(max - min + 1));
  med_value1 := List1[i];
  med_value2 := List2[i];
    // Swap it to the front so we can find it easily.
  List1[i] := List1[min];
  List2[i] := List2[min];

    // Move the items smaller than this into the left
    // half of the list. Move the others into the right.
  lo := min;
  hi := max;
  while (True) do
  begin
    // Look down from hi for a value < med_value.
    // while (List1[hi] >= med_value1) do
    while (List1[hi] >= med_value1) and ((List1[hi] <> med_value1) or (List2[hi]
      >= med_value2)) do
    begin
      hi := hi - 1;
      if (hi <= lo) then Break;
    end;
    if (hi <= lo) then
    begin
      // We're done separating the items.
      List1[lo] := med_value1;
      List2[lo] := med_value2;
      Break;
    end;
    // Swap the lo and hi values.
    List1[lo] := List1[hi];
    List2[lo] := List2[hi];

    // Look up from lo for a value >= med_value.
    lo := lo + 1;
    while (List1[lo] < med_value1) or ((List1[lo] = med_value1) and (List2[lo] <
      med_value2)) do
    begin
      lo := lo + 1;
      if (lo >= hi) then Break;
    end;
    if (lo >= hi) then
    begin
      // We're done separating the items.
      lo := hi;
      List1[hi] := med_value1;
      List2[hi] := med_value2;
      Break;
    end;
    // Swap the lo and hi values.
    List1[hi] := List1[lo];
    List2[hi] := List2[lo];
  end; // while (True) do
    // Sort the two sublists.
  QuicksortSmallint(List1, List2, min, lo - 1);
  QuicksortSmallint(List1, List2, lo + 1, max);
end;

procedure QuicksortInteger(var List1: array of Integer; var List2: array of
  Integer;
  min, max: Integer);
var
  med_value1: Integer;
  med_value2: Integer;
  hi, lo, i: Integer;
begin
    // If the list has <= 1 element, it's sorted.
  if (min >= max) then Exit;

    // Pick a dividing item randomly.
  i := min + Trunc(Random(max - min + 1));
  med_value1 := List1[i];
  med_value2 := List2[i];
    // Swap it to the front so we can find it easily.
  List1[i] := List1[min];
  List2[i] := List2[min];

    // Move the items smaller than this into the left
    // half of the list. Move the others into the right.
  lo := min;
  hi := max;
  while (True) do
  begin
        // Look down from hi for a value < med_value.
    while (List1[hi] >= med_value1) and ((List1[hi] <> med_value1) or (List2[hi]
      >= med_value2)) do
    begin
      hi := hi - 1;
      if (hi <= lo) then Break;
    end;
    if (hi <= lo) then
    begin
            // We're done separating the items.
      List1[lo] := med_value1;
      List2[lo] := med_value2;
      Break;
    end;

        // Swap the lo and hi values.
    List1[lo] := List1[hi];
    List2[lo] := List2[hi];

        // Look up from lo for a value >= med_value.
    lo := lo + 1;
    while (List1[lo] < med_value1) or ((List1[lo] = med_value1) and (List2[lo] <
      med_value2)) do
    begin
      lo := lo + 1;
      if (lo >= hi) then Break;
    end;
    if (lo >= hi) then
    begin
            // We're done separating the items.
      lo := hi;
      List1[hi] := med_value1;
      List2[hi] := med_value2;
      Break;
    end;

        // Swap the lo and hi values.
    List1[hi] := List1[lo];
    List2[hi] := List2[lo];
  end; // while (True) do
    // Sort the two sublists.
  QuicksortInteger(List1, List2, min, lo - 1);
  QuicksortInteger(List1, List2, lo + 1, max);
end;

end.

