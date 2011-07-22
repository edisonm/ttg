{ -*- mode: Delphi -*- }
unit UTTGSQL;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, UConfigStorage;

procedure FillTTGSQL(AStrings: TStrings);

implementation

procedure FillTTGSQL(AStrings: TStrings);
begin
  with AStrings do
  begin
    {$I ttgsql.inc}
  end;
end;

end.

