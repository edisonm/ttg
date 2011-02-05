program Convert;

uses
  Forms,
  FConvert in 'FConvert.pas' {ConvertForm},
  DSrcBase in '..\src\DSrcBase.pas' {SourceBaseDataModule: TDataModule},
  RelUtils in '..\src\RelUtils.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TSourceBaseDataModule, SourceBaseDataModule);
  Application.CreateForm(TConvertForm, ConvertForm);
  Application.Run;
end.
