; Inno Setup Script
; Created with ScriptMaker Version 1.3.12
; 4 Agosto 2000 at 18:15

[Setup]
MinVersion=4.0,4.0
AppName=Generador Automatico de Horarios
AppId=Generador Automatico de Horarios
CreateUninstallRegKey=1
UsePreviousAppDir=1
UsePreviousGroup=1
AppVersion=1.2.1
AppVerName=Generador Automatico de Horarios 1.2.1
AppCopyright=Edición 12-04-2010. Edison Mera. Quito-Ecuador. Madrid-España
WindowShowCaption=0
WindowStartMaximized=0
WindowVisible=0
WindowResizable=0
UninstallLogMode=Append
DirExistsWarning=0
DisableDirPage=0
DisableStartupPrompt=0
CreateAppDir=1
DisableProgramGroupPage=0
Uninstallable=1
DefaultDirName={pf}\TTG\1.2.1
DefaultGroupName=Generador Automatico de Horarios 1.2.1
LicenseFile=..\DOC\Licencia.txt
InfoAfterFile=..\DOC\Leame.txt
OutputBaseFilename=TTGSETUP
DiskSpanning=0
DiskClusterSize=512
ReserveBytes=4096
UseSetupLdr=1
SourceDir=.
OutputDir=OUTPUT

[Dirs]
Name: {app}\HLP
Name: {app}\BIN
Name: {app}\DEMOS
Name: {app}\DOC

[Files]
Source: ..\BIN\TTG.EXE; DestDir: {app}\BIN\; DestName: TTG.EXE
Source: ..\HLP\HORCOLEG.CNT; DestDir: {app}\HLP\; DestName: HORCOLEG.CNT
Source: ..\HLP\HORCOLEG.HLP; DestDir: {app}\HLP\; DestName: HORCOLEG.HLP
Source: ..\DOC\MANUAL.DOC; DestDir: {app}\DOC\; DestName: MANUAL.DOC
Source: ..\DEMOS\BritanicoInt2000.ttd; DestDir: {app}\DEMOS\; DestName: BRITANIC.TTD
Source: ..\DEMOS\Salamanca1999.ttd; DestDir: {app}\DEMOS\; DestName: SALAMANC.TTD
[Icons]
Name: {group}\Generador Automatico de Horarios 1.2.1; Filename: {app}\BIN\TTG.EXE; WorkingDir: {app}\BIN\; IconIndex: 0
Name: {group}\Manual del Usuario (DOC); Filename: {app}\DOC\MANUAL.DOC
Name: {group}\Manual del Usuario (HELP); Filename: {app}\HLP\HORCOLEG.HLP
Name: {group}\{cm:UninstallProgram, Generador Automatico de Horarios 1.2.1}; Filename: {uninstallexe}
[INI]

[Registry]
Root: HKCU; SubKey: Software\TTG; ValueType: none; Flags: uninsdeletekey

[UninstallDelete]

[InstallDelete]

[Run]

[UninstallRun]

[Languages]
Name: default; MessagesFile: C:\Archivos de programa\Inno Setup 5\Languages\Spanish.isl
