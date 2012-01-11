{ -*- mode: Delphi -*- }
unit PdxUtils;

interface

uses
  BDE, DBTables;
type
  TDynamicTblTypeArray = array of TblType;
  TDynamicFLDTypeArray = array of FLDType;
  TDynamicIDXTypeArray = array of IDXType;
procedure GetTableTypesList(Driver: string; var TblTypes: TDynamicTblTypeArray);
procedure GetFieldTypesList(DrvType, TblType: string; var FieldTypes: TDynamicFLDTypeArray);
procedure GetIndexTypesList(DrvType: string; var IDXTypes: TDynamicIDXTypeArray);

implementation
//uses


procedure GetTableTypesList(Driver: string; var TblTypes: TDynamicTblTypeArray);
var
  hTypeCur: hDBICur;
  i, n: Integer;
begin
  hTypeCur := nil;
  Check(DbiOpenTableTypesList(PAnsiChar(Driver), hTypeCur));
  Check(DbiGetRecordCount(hTypeCur, n));
  i := 0;
  SetLength(TblTypes, n);
  while //(i < n) and
    (DbiGetNextRecord(hTypeCur, dbiNOLOCK, @TblTypes[i], nil) = DBIERR_NONE) do
    Inc(i);
  Check(DbiCloseCursor(hTypeCur));
end;

procedure GetFieldTypesList(DrvType, TblType: string;
  var FieldTypes: TDynamicFLDTypeArray);
var
  TmpCursor: hDbiCur;
  i, n: Integer;
begin
  TmpCursor := nil;
  Check(DbiOpenFieldTypesList(PAnsiChar(DrvType), PAnsiChar(TblType), TmpCursor));
  Check(DbiGetRecordCount(TmpCursor, n));
  SetLength(FieldTypes, n);
  i := 0;
  while (DbiGetNextRecord(TmpCursor, dbiNOLOCK, @FieldTypes[i], nil) = DBIERR_NONE) do
    Inc(i);
  Check(DbiCloseCursor(TmpCursor));
end;

procedure GetIndexTypesList(DrvType: string; var IDXTypes: TDynamicIDXTypeArray);
var
  TmpCursor: hDBICur;
  i, n: Integer;
begin
  TmpCursor := nil;
  Check(DbiOpenIndexTypesList(PAnsiChar(DrvType), TmpCursor));
  Check(DbiGetRecordCount(TmpCursor, n));
  SetLength(IDXTypes, n);
  i := 0;
  while (DbiGetNextRecord(TmpCursor, dbiNOLOCK, @IDXTypes[i], nil) = DBIERR_NONE) do
    Inc(i);
  Check(DbiCloseCursor(TmpCursor));
end;

end.
