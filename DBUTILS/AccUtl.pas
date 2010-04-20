unit AccUtl;

interface

uses
  SysUtils, Classes, DB, DAO_TLB;

function IndexOfFieldName(AFields: Fields; AFieldName: string): Integer;
procedure EmptyAccDatabase(DBAcc: Database);
procedure GetAccTableNamesByRefIntOrder(DBAcc: Database; VList: TStrings);
procedure EmptyAccDatabaseList(DBAcc: Database; List: TStrings);
procedure SecureFree(AList: TStrings);

var
  Engine: DBEngine;

implementation


function IndexOfFieldName(AFields: Fields; AFieldName: string): Integer;
var
  n: Integer;
begin
  Result := 0;
  with AFields do
  begin
    n := Count;
    while (Result < n) and (Item[Result].Name <> AFieldName) do Inc(Result);
    if Result = n then Result := -1;
  end;
end;

procedure SecureFree(AList: TStrings);
var
  i: Integer;
begin
  with AList do
  begin
    for i := Count - 1 downto 0 do
      Objects[i].Free;
    Free;
  end;
end;

procedure EmptyAccDatabaseList(DBAcc: Database; List: TStrings);
const
  SDelete: string = 'DELETE * FROM %s';
var
  i: Integer;
begin
  with DBAcc, List do
  begin
    for i := Count - 1 downto 0 do
      Execute(Format(SDelete, [Strings[i]]), 0);
  end;
end;

procedure GetAccTableNamesByRefIntOrder(DBAcc: Database; VList: TStrings);
var
  i, j, k: Integer;
  VTableDef: TableDef;
begin
  with DBAcc do begin
    with TableDefs do
    begin
      for i := 0 to Count - 1 do
      begin
        VTableDef := Item[i];
        with VTableDef do
        begin
          if (Attributes and (dbSystemObject or dbHiddenObject)) <> 0 then
            Continue;
          VList.Add(Name);
          VList.Objects[VList.Count - 1] := TStringList.Create;
        end;
      end;
    end;
    with Relations do
    begin
      i := 0;
      while i < Count do
      begin
        with Item[i] do
        begin
          j := VList.IndexOf(ForeignTable);
          k := VList.IndexOf(Table);
          if j < k then
          begin
            VList.Exchange(j, k);
            i := 0;
          end
          else
            Inc(i);
        end;
      end;
      for i := 0 to Count - 1 do
      begin
        j := VList.IndexOf(Item[i].ForeignTable);
        (VList.Objects[j] as TStrings).Add(Item[i].Name);
      end;
    end;
  end;
end;

procedure EmptyAccDatabase(DBAcc: Database);
var
  List: TStrings;
begin
  List := TStringList.Create;
  try
    GetAccTableNamesByRefIntOrder(DBAcc, List);
    EmptyAccDatabaseList(DBAcc, List);
  finally
    List.Free;
  end;
end;

end.
