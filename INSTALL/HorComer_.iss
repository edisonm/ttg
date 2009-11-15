; Inno Setup Script
; Created with ScriptMaker Version 1.11.3 rev2
; 23 Agosto 1999 at 00:51

[Setup]
MinVersion=4.0,3.51
AppName=Horarios para Colegio
AppVerName=Horarios para Colegio 1.2
AppCopyright=Edición 01-02-1999, Edison Mera, Quito - Ecuador
SingleEXE=0
Bits=32
BackColor=$FF0000
BackSolid=0
DisableDirExistsWarning=0
DisableDirPage=0
DisableStartupPrompt=0
CreateAppDir=1
DisableProgramGroupPage=0
AlwaysCreateUninstallIcon=1
OverwriteUninstRegEntries=1
UninstallIconName=Desinstalación de Horarios para Colegio 1.2
Uninstallable=1
AllowNoIcons=0
AlwaysRestart=0
CompressLevel=9
DefaultDirName={pf}\HorCole1
InstallToProgramFiles=1
DefaultGroupName=Horarios para Colegio 1.2
LicenseFile=..\DOC\Licencia.txt
InfoAfterFile=..\DOC\Leame.txt
DiskSpanning=1
DiskSize=1716224
DiskClusterSize=2048
ReserveBytes=4096
UseSetupLdr=1
OutputDir="..\INSTALL\COMERC"

[Dirs]
Name: "{app}\HLP"
Name: "{app}\BIN"
Name: "{app}\DEMOS"
Name: "{app}\DOC"
Name: "{app}\SRC\SGHC\1.2\BIN"
Name: "{app}\SRC\SGHC\1.2\BAT"
Name: "{tmp}\PACKS"; Flags: uninsneveruninstall  deleteafterinstall

[Files]
Source: ..\BIN\HORCOLEG.DB0; DestDir: {app}\BIN\; DestName: HORCOLEG.DB0
Source: ..\BIN\HORCOLEG.EXE; DestDir: {app}\BIN\; DestName: HORCOLEG.EXE
Source: ..\HLP\HORCOLEG.CNT; DestDir: {app}\HLP\; DestName: HORCOLEG.CNT
Source: ..\HLP\HORCOLEG.HLP; DestDir: {app}\HLP\; DestName: HORCOLEG.HLP
Source: ..\DOC\MANUAL.DOC; DestDir: {app}\DOC\; DestName: MANUAL.DOC
Source: ..\DEMOS\DEMO1.DBP; DestDir: {app}\DEMOS\; DestName: DEMO1.DBP
Source: ..\DEMOS\DEMO2.DBP; DestDir: {app}\DEMOS\; DestName: DEMO2.DBP
Source: C:\Archivos de programa\Archivos comunes\Borland Shared\BDE\bdeinst.dll; DestDir: {tmp}\PACKS\; DestName: BDEINST.DLL; Flags: uninsneveruninstall
Source: C:\WINDOWS\SYSTEM\Comctl32.dll; DestDir: {sys}\; DestName: Comctl32.dll; Flags: uninsneveruninstall restartreplace

[Icons]
Name: {group}\Horarios Para Colegio 1.2; Filename: {app}\BIN\HORCOLEG.EXE; WorkingDir: {app}\BIN\; IconIndex: 0
Name: {group}\Manual del Usuario (DOC); Filename: {app}\DOC\MANUAL.DOC
Name: {group}\Manual del Usuario (HELP); Filename: {app}\HLP\HORCOLEG.HLP

[INI]

[Registry]
Root: HKCU; SubKey: Software\HORCOLEG; ValueType: NONE; Flags: uninsdeletekey
Root: HKCU; SubKey: Software\SGHC1; ValueType: NONE; Flags: uninsdeletekey

[UninstallDelete]

[InstallDelete]

[Run]
Filename: {sys}\REGSVR32.EXE; Parameters: /s {tmp}\PACKS\BDEINST.DLL
[UninstallRun]


; ==============================================
; The lines below are used by ScriptMaker
; They are not required by Inno Setup
; DO NOT DELETE THEM or you will be unable to reload script

;[Readme Source]
;Licence=..\DOC\Licencia.txt
;PreReadme=
;PostReadme=

;[ScriptSetup]
;VerNum=1.0
;InnoVer=1.11
;AddVerTo=AppVerName
;SetupFilename=INSTALAR.EXE
;OutputFolder=..\INSTALL\COMERC