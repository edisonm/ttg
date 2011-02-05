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
    AppVerName=Horarios para Colegio 1.2.1
    AppCopyright=Edición 15-10-2000, Edison Mera, Quito - Ecuador
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
    AlwaysCreateUninstallIcon=1
    UninstallIconName=Desinstalación de Horarios para Colegio 1.2.1
    Uninstallable=1
    DefaultDirName={pf}\HorCole1.2.1
    DefaultGroupName=Horarios para Colegio 1.2.1
    LicenseFile=..\DOC\Licencia.txt
    InfoAfterFile=..\DOC\Leame.txt
    OutputBaseFilename=INSTALAR
    MessagesFile=C:\Archivos de programa\Inno Setup 1.3\Spanish-2-1.3.14.isl
    DiskSpanning=0
    ;DiskSize=1716224
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
    Name: {tmp}\PACKS; Flags: uninsneveruninstall  deleteafterinstall

[Files]
    ;Source: ..\BIN\HORCOLEG.DB0; DestDir: {app}\BIN\; DestName: HORCOLEG.DB0
    Source: ..\BIN\HORCOLEG.EXE; DestDir: {app}\BIN\; DestName: HORCOLEG.EXE
    Source: ..\HLP\HORCOLEG.CNT; DestDir: {app}\HLP\; DestName: HORCOLEG.CNT
    Source: ..\HLP\HORCOLEG.HLP; DestDir: {app}\HLP\; DestName: HORCOLEG.HLP
    Source: ..\DOC\MANUAL.DOC; DestDir: {app}\DOC\; DestName: MANUAL.DOC
    Source: ..\DEMOS\DEMO1.HPC; DestDir: {app}\DEMOS\; DestName: DEMO1.HPC
    Source: ..\DEMOS\DEMO2.HPC; DestDir: {app}\DEMOS\; DestName: DEMO2.HPC
    Source: ..\DEMOS\DEMO3.HPC; DestDir: {app}\DEMOS\; DestName: DEMO3.HPC
    ;Source: C:\Archivos de programa\Archivos comunes\Borland Shared\BDE\bdeinst.dll; DestDir: {tmp}\PACKS\; DestName: BDEINST.DLL; Flags: uninsneveruninstall
    Source: C:\WINDOWS\SYSTEM\Comctl32.dll; DestDir: {sys}\; DestName: Comctl32.dll; Flags: uninsneveruninstall restartreplace
    ;Source: IDR20009.DLL; DestDir: {cf}\Borland Shared\BDE\IDR20009.DLL; Flags: uninsneveruninstall
[Icons]
    Name: {group}\Horarios Para Colegio 1.2.1; Filename: {app}\BIN\HORCOLEG.EXE; WorkingDir: {app}\BIN\; IconIndex: 0
    Name: {group}\Manual del Usuario (DOC); Filename: {app}\DOC\MANUAL.DOC
    Name: {group}\Manual del Usuario (HELP); Filename: {app}\HLP\HORCOLEG.HLP

[INI]

[Registry]
    Root: HKCU; SubKey: Software\SGHC; ValueType: none; Flags: uninsdeletekey

[UninstallDelete]

[InstallDelete]

[Run]
    Filename: {sys}\REGSVR32.EXE; Parameters: /s {tmp}\PACKS\BDEINST.DLL

[UninstallRun]


; ==============================================
; The lines below are used by ScriptMaker
; They are not required by Inno Setup
; DO NOT DELETE THEM or you may be unable to reload the script

;[Readme Source]
;Licence=..\DOC\Licencia.txt
;PreReadme=
;PostReadme=..\DOC\Leame.txt

;[ScriptSetup]
;VerNum=1.2.1
;InnoVer=1.3
;AddVerTo=AppVerName
;SetupFilename=INSTALAR.EXE
;OutputFolder=OUTPUT
;CopyrightText=Edición 15-10-2000, Edison Mera, Quito - Ecuador

