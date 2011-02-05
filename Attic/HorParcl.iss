; Inno Setup Script
; Created with ScriptMaker Version 1.11.3 rev2
; 3 Junio 1999 at 08:27

[Setup]
MinVersion=4.0,4.0
AppName=Horarios para Colegio
AppVerName=Horarios para Colegio 1.1
AppCopyright=Edición 09-01-1999, Edison Mera, SOLAR, Quito - Ecuador
; SingleEXE=0
; Bits=32
BackColor=$FF0000
BackSolid=0
; DisableDirExistsWarning=0
DisableDirPage=0
DisableStartupPrompt=0
CreateAppDir=1
DisableProgramGroupPage=0
; OverwriteUninstRegEntries=1
Uninstallable=1
AllowNoIcons=0
AlwaysRestart=0
DefaultDirName={pf}\HorCole1
; InstallToProgramFiles=1
DefaultGroupName=Horarios para Colegio 1.1
LicenseFile=..\DOC\Licencia.txt
DiskSpanning=0
SourceDir=.
OutputDir=..\INSTALL\PARCIAL
Compression=zip/9

[Dirs]
Name: {app}\HLP
Name: {app}\BIN
Name: {app}\DEMOS
Name: {app}\DOC

[Files]
Source: ..\BIN\HORCOLEG.DB0; DestDir: {app}\BIN\; DestName: HORCOLEG.DB0
Source: ..\BIN\HORCOLEG.EXE; DestDir: {app}\BIN\; DestName: HORCOLEG.EXE
Source: ..\HLP\HORCOLEG.CNT; DestDir: {app}\HLP\; DestName: HORCOLEG.CNT
Source: ..\HLP\HORCOLEG.HLP; DestDir: {app}\HLP\; DestName: HORCOLEG.HLP
Source: ..\DOC\MANUAL.DOC; DestDir: {app}\DOC\; DestName: MANUAL.DOC
; Source: ..\DEMOS\DEMO1998.DBP; DestDir: {app}\DEMOS\; DestName: DEMO1998.DBP
; Source: ..\DEMOS\DEMO1999.DBP; DestDir: {app}\DEMOS\; DestName: DEMO1999.DBP

[Icons]
Name: {group}\Horarios Para Colegio 1.1; Filename: {app}\BIN\HORCOLEG.EXE; WorkingDir: {app}\BIN\; IconIndex: 0
Name: {group}\Manual del Usuario (DOC); Filename: {app}\DOC\MANUAL.DOC
Name: {group}\Manual del Usuario (HELP); Filename: {app}\HLP\HORCOLEG.HLP

[INI]

[Registry]
Root: HKCU; SubKey: Software\SGHC; ValueType: NONE; Flags: uninsdeletekey

[UninstallDelete]

[InstallDelete]

[Run]

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
;OutputFolder=..\INSTALL\PARCIAL
