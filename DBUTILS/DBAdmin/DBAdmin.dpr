program DBAdmin;

uses
  Forms,
  FAdmin in 'FAdmin.pas' {AdminForm},
  DAdmin in 'DAdmin.pas' {AdminDM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TAdminDM, AdminDM);
  Application.CreateForm(TAdminForm, AdminForm);
  Application.Run;
end.
