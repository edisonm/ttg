program Convert;

uses
  Forms,
  FConvert in 'FConvert.pas' {ConvertForm},
  DSrcBase in '..\SOURCE\DSrcBase.pas' {SourceBaseDataModule: TDataModule},
  RelUtils in '..\SOURCE\RelUtils.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TSourceBaseDataModule, SourceBaseDataModule);
  Application.CreateForm(TConvertForm, ConvertForm);
  Application.Run;
end.
