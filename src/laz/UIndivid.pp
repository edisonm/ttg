unit UIndivid;

{$I ttg.inc}

interface

uses
  Classes, SysUtils; 

type

  IIndividual = interface(IUnknown)
    function GetImplementor: TObject;
    property Implementor: TObject read GetImplementor;
    property Value: Double;
  end;

  IModel = interface(IUnknown)
    function GetElitistCount: Smallint;
    property ElitistCount: Smallint read GetElitistCount;
    function NewIndividual: TObject;
    {procedure DoProgress(Position, RefreshInterval: Integer;
      Individual: IIndividual; var Stop: Boolean);}
  end;

implementation

end.

