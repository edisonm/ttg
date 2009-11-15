program Convert;

uses
  Forms,
  FConvert in 'FConvert.pas' {ConvertForm},
  DSrcBase in 'DSrcBase.pas' {SourceBaseDataModule: TDataModule},
  RelUtils in 'RelUtils.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TSourceBaseDataModule, SourceBaseDataModule);
  Application.CreateForm(TConvertForm, ConvertForm);
  Application.Run;
end.
