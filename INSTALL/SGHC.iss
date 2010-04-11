; Inno Setup Script
; Created with ScriptMaker Version 1.3.12
; 4 Agosto 2000 at 18:15

[Setup]
MinVersion=4.0,4.0
AppName=Horarios para Colegio
AppId=Horarios para Colegio
CreateUninstallRegKey=1
UsePreviousAppDir=1
UsePreviousGroup=1
AppVersion=1.2.1
AppVerName=Horarios para Colegio 1.2.1.4
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
DefaultDirName={pf}\SGHC1.2.1
DefaultGroupName=Horarios para Colegio 1.2.1
LicenseFile=..\DOC\Licencia.txt
InfoAfterFile=..\DOC\Leame.txt
OutputBaseFilename=SGHCSETUP
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
Source: ..\BIN\SGHC.EXE; DestDir: {app}\BIN\; DestName: SGHC.EXE
Source: ..\HLP\HORCOLEG.CNT; DestDir: {app}\HLP\; DestName: HORCOLEG.CNT
Source: ..\HLP\HORCOLEG.HLP; DestDir: {app}\HLP\; DestName: HORCOLEG.HLP
Source: ..\DOC\MANUAL.DOC; DestDir: {app}\DOC\; DestName: MANUAL.DOC
Source: ..\DEMOS\BritanicoInt\BritanicoInt2000.ttd; DestDir: {app}\DEMOS\; DestName: BRITANIC.TTD
Source: ..\DEMOS\Salamanca\Salamanca1999.ttd; DestDir: {app}\DEMOS\; DestName: SALAMANC.TTD
[Icons]
Name: {group}\Horarios Para Colegio 1.2.1; Filename: {app}\BIN\SGHC.EXE; WorkingDir: {app}\BIN\; IconIndex: 0
Name: {group}\Manual del Usuario (DOC); Filename: {app}\DOC\MANUAL.DOC
Name: {group}\Manual del Usuario (HELP); Filename: {app}\HLP\HORCOLEG.HLP
Name: {group}\{cm:UninstallProgram, Horarios Para Colegio 1.2.1}; Filename: {uninstallexe}
[INI]

[Registry]
Root: HKCU; SubKey: Software\SGHC; ValueType: none; Flags: uninsdeletekey

[UninstallDelete]

[InstallDelete]

[Run]

[UninstallRun]

[Languages]
Name: default; MessagesFile: C:\Archivos de programa\Inno Setup 5\Languages\Spanish.isl
