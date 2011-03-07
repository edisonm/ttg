unit UIndivid;

{$I ttg.inc}

interface

uses
  Classes, SysUtils; 

type
  IModel = interface(IUnknown)
    property ElitistCount: Integer;
  end;

  IIndividual = interface(IUnknown)
    property Value: Double;
  end;

implementation

end.

