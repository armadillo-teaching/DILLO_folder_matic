@echo off
setlocal enabledelayedexpansion
title Inizializzatore Ambiente Embedded USB
color 0A

echo ========================================================
echo   Inizializzazione Ambiente Embedded Portatile USB
echo ========================================================
echo.

:: Determina la lettera e il percorso root dove si trova lo script
set "USB_ROOT=%~dp0"
:: Rimuove il backslash finale per uniformita'
if "%USB_ROOT:~-1%"=="\" set "USB_ROOT=%USB_ROOT:~0,-1%"

echo [1] Creazione dell'alberatura delle cartelle sulla chiavetta...
if not exist "%USB_ROOT%\Apps\EmbeddedBuilder" mkdir "%USB_ROOT%\Apps\EmbeddedBuilder"
if not exist "%USB_ROOT%\Apps\gcc-arm" mkdir "%USB_ROOT%\Apps\gcc-arm"
if not exist "%USB_ROOT%\Apps\Geany" mkdir "%USB_ROOT%\Apps\Geany"
if not exist "%USB_ROOT%\Apps\msys64" mkdir "%USB_ROOT%\Apps\msys64"
if not exist "%USB_ROOT%\Apps\OpenOCD" mkdir "%USB_ROOT%\Apps\OpenOCD"
if not exist "%USB_ROOT%\Apps\Ozone" mkdir "%USB_ROOT%\Apps\Ozone"
if not exist "%USB_ROOT%\Apps\Ozone" mkdir "%USB_ROOT%\Apps\SimplySerial"
if not exist "%USB_ROOT%\Configs\Geany_Config" mkdir "%USB_ROOT%\Configs\Geany_Config"
if not exist "%USB_ROOT%\Configs\MSYS2_Home" mkdir "%USB_ROOT%\Configs\MSYS2_Home"
if not exist "%USB_ROOT%\Configs\Ozone_Config" mkdir "%USB_ROOT%\Configs\Ozone_Config"
if not exist "%USB_ROOT%\Workspace" mkdir "%USB_ROOT%\Workspace"


echo.
echo [2] Generazione dei Launcher Batch Portatili...

:: ----------------------------------------------------------
:: Generazione Launcher per MSYS2
:: ----------------------------------------------------------
if exist %USB_ROOT%\Lancia_MSYS2.bat goto skip_msys
echo Scrittura di Lancia_MSYS2.bat...
echo @echo off > "%USB_ROOT%\Lancia_MSYS2.bat"
echo setlocal >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo :: Calcola il percorso relativo della chiavetta >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo set "ROOT_DIR=%%~dp0" >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo if "%%ROOT_DIR:~-1%%"=="\" set "ROOT_DIR=%%ROOT_DIR:~0,-1%%" >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo. >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo :: Configura l'ambiente  >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo set "MSYS2_PATH=%%ROOT_DIR%%\Apps\msys64" >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo set "ARM_GCC_PATH=%%ROOT_DIR%%\Apps\gcc-arm\bin" >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo set "GEANY_PATH=%%ROOT_DIR%%\Apps\Geany\bin" >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo set "OPENOCD_PATH=%%ROOT_DIR%%\Apps\OpenOCD\bin" >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo set "REALTERM_PATH=%%ROOT_DIR%%\Apps\Realterm" >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo set "SIMPLYSERIAL_PATH=%%ROOT_DIR%%\Apps\SimplySerial" >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo. >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo :: Forza la Home directory all'interno della chiavetta >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo set "HOME=%%ROOT_DIR%%\Configs\MSYS2_Home" >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo. >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo :: Inietta ARM GCC, Geany e OpenOCD nel PATH di Windows prima di avviare MSYS2 >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo set "PATH=%%ARM_GCC_PATH%%;%%GEANY_PATH%%;%%OPENOCD_PATH%%;%%REALTERM_PATH%%;%%SIMPLYSERIAL_PATH%%;%%PATH%%" >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo. >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo :: Avvia MSYS2 forzandolo ad ereditare il PATH di Windows (-use-full-path) >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo cd /d "%%MSYS2_PATH%%" >> "%USB_ROOT%\Lancia_MSYS2.bat"
rem echo start "" "%%MSYS2_PATH%%\msys2_shell.cmd" -mingw64 -use-full-path >> "%USB_ROOT%\Lancia_MSYS2.bat"
echo start ""  cmd.exe /c "%%MSYS2_PATH%%\msys2_shell.cmd -mingw64 -use-full-path" >> "%USB_ROOT%\Lancia_MSYS2.bat"
:skip_msys


:: ----------------------------------------------------------
:: Generazione Launcher per Geany
:: ----------------------------------------------------------
if exist %USB_ROOT%\Lancia_Geany.bat goto skip_geany

echo Scrittura di Lancia_Geany.bat...
echo @echo off  > "%USB_ROOT%\Lancia_Geany.bat"
echo setlocal  >> "%USB_ROOT%\Lancia_Geany.bat"
echo :: Calcola il percorso relativo della chiavetta >> "%USB_ROOT%\Lancia_Geany.bat"
echo set "ROOT_DIR=%%~dp0" >> "%USB_ROOT%\Lancia_Geany.bat"
echo if "%%ROOT_DIR:~-1%%"=="\" set "ROOT_DIR=%%ROOT_DIR:~0,-1%%" >> "%USB_ROOT%\Lancia_Geany.bat"

echo. >> "%USB_ROOT%\Lancia_Geany.bat"

echo :: Configura l'ambiente  >> "%USB_ROOT%\Lancia_Geany.bat"
echo set "MSYS2_PATH=%%ROOT_DIR%%\Apps\msys64" >> "%USB_ROOT%\Lancia_Geany.bat"
echo set "ARM_GCC_PATH=%%ROOT_DIR%%\Apps\gcc-arm\bin" >> "%USB_ROOT%\Lancia_Geany.bat"
echo set "GEANY_PATH=%%ROOT_DIR%%\Apps\Geany\bin" >> "%USB_ROOT%\Lancia_Geany.bat"
echo set "OPENOCD_PATH=%%ROOT_DIR%%\Apps\OpenOCD\bin" >> "%USB_ROOT%\Lancia_Geany.bat"
echo set "REALTERM_PATH=%%ROOT_DIR%%\Apps\Realterm" >> "%USB_ROOT%\Lancia_Geany.bat"
echo set "SIMPLYSERIAL_PATH=%%ROOT_DIR%%\Apps\SimplySerial" >> "%USB_ROOT%\Lancia_Geany.bat"

echo. >> "%USB_ROOT%\Lancia_Geany.bat"

echo :: Aggiunge GCC, OpenOCD e i tool MSYS2 (make, nano) al PATH per farli vedere a Geany >> "%USB_ROOT%\Lancia_Geany.bat"
echo set "PATH=%%ARM_GCC_PATH%%;%%GEANY_PATH%%;%%OPENOCD_PATH%%;%%REALTERM_PATH%%;%%SIMPLYSERIAL_PATH%%;%%PATH%%" >> "%USB_ROOT%\Lancia_Geany.bat"
echo set "PATH=%%ROOT_DIR%%\Apps\msys64\usr\bin;%%PATH%%" >> "%USB_ROOT%\Lancia_Geany.bat"
echo. >> "%USB_ROOT%\Lancia_Geany.bat"
echo :: Avvia Geany specificando la cartella di configurazione (-c) portatile >> "%USB_ROOT%\Lancia_Geany.bat"
echo start "Geany Portable" "%%ROOT_DIR%%\Apps\Geany\bin\geany.exe" -c "%%ROOT_DIR%%\Configs\Geany_Config" "%%ROOT_DIR%%\Workspace" >> "%USB_ROOT%\Lancia_Geany.bat"
:skip_geany


:: ----------------------------------------------------------
:: Generazione Launcher per Embedded Builder
:: ----------------------------------------------------------
if exist %USB_ROOT%\Lancia_EmbeddedBuilder.bat goto GD_EB

echo Scrittura di Lancia_EmbeddedBuilder.bat...

echo @echo off > "%USB_ROOT%\Lancia_EmbeddedBuilder.bat"
echo setlocal >> "%USB_ROOT%\Lancia_EmbeddedBuilder.bat"
echo :: Calcola il percorso relativo della chiavetta >> "%USB_ROOT%\Lancia_EmbeddedBuilder.bat"
echo set "ROOT_DIR=%%~dp0" >> "%USB_ROOT%\Lancia_EmbeddedBuilder.bat"
echo if "%%ROOT_DIR:~-1%%"=="\" set "ROOT_DIR=%%ROOT_DIR:~0,-1%%" >> "%USB_ROOT%\Lancia_EmbeddedBuilder.bat"
echo. >> "%USB_ROOT%\Lancia_EmbeddedBuilder.bat"
echo :: Aggiunge GCC al PATH (utile se l'IDE cerca la toolchain nell'ambiente) >> "%USB_ROOT%\Lancia_EmbeddedBuilder.bat"
echo set "PATH=%%ROOT_DIR%%\Apps\gcc-arm\bin;%%PATH%%" >> "%USB_ROOT%\Lancia_EmbeddedBuilder.bat"
echo.
echo :: Avvia l'IDE forzando il Workspace locale (-data) >> "%USB_ROOT%\Lancia_EmbeddedBuilder.bat"
echo set "EXE_NAME=GD32EmbeddedBuilder.exe" >> "%USB_ROOT%\Lancia_EmbeddedBuilder.bat"
echo if exist "%%ROOT_DIR%%\Apps\EmbeddedBuilder\eclipse.exe" set "EXE_NAME=eclipse.exe" >> "%USB_ROOT%\Lancia_EmbeddedBuilder.bat"
echo. >> "%USB_ROOT%\Lancia_EmbeddedBuilder.bat"
echo start "Embedded Builder" "%%ROOT_DIR%%\Apps\EmbeddedBuilder\%%EXE_NAME%%" -data "%%ROOT_DIR%%\Workspace" >> "%USB_ROOT%\Lancia_EmbeddedBuilder.bat"
:GD_EB



:: ----------------------------------------------------------
:: Generazione Launcher per Ozone
:: ----------------------------------------------------------
if exist %USB_ROOT%\Lancia_Ozone.bat goto skip_ozone
echo Scrittura di Lancia_Ozone.bat...
echo @echo off > "%USB_ROOT%\Lancia_Ozone.bat"
echo setlocal >> "%USB_ROOT%\Lancia_Ozone.bat"
echo :: Calcola il percorso relativo della chiavetta >> "%USB_ROOT%\Lancia_Ozone.bat"
echo set "ROOT_DIR=%%~dp0" >> "%USB_ROOT%\Lancia_Ozone.bat"
echo if "%%ROOT_DIR:~-1%%"=="\" set "ROOT_DIR=%%ROOT_DIR:~0,-1%%" >> "%USB_ROOT%\Lancia_Ozone.bat"
echo. >> "%USB_ROOT%\Lancia_Ozone.bat"
echo :: Aggiunge GCC al PATH in modo che Ozone trovi il GDB di ARM se necessario >> "%USB_ROOT%\Lancia_Ozone.bat"
echo set "PATH=%%ROOT_DIR%%\Apps\gcc-arm\bin;%%PATH%%" >> "%USB_ROOT%\Lancia_Ozone.bat"
echo. >> "%USB_ROOT%\Lancia_Ozone.bat"
echo :: Isolamento impostazioni J-Link/Ozone (Home e AppData nella USB) >> "%USB_ROOT%\Lancia_Ozone.bat"
echo set "USERPROFILE=%%ROOT_DIR%%\Configs\Ozone_Config" >> "%USB_ROOT%\Lancia_Ozone.bat"
echo set "APPDATA=%%ROOT_DIR%%\Configs\Ozone_Config\AppData" >> "%USB_ROOT%\Lancia_Ozone.bat"
echo set "LOCALAPPDATA=%%ROOT_DIR%%\Configs\Ozone_Config\LocalAppData" >> "%USB_ROOT%\Lancia_Ozone.bat"
echo. >> "%USB_ROOT%\Lancia_Ozone.bat"
echo :: Avvia Ozone >> "%USB_ROOT%\Lancia_Ozone.bat"
echo start "Ozone Debugger" "%%ROOT_DIR%%\Apps\Ozone\Ozone.exe" >> "%USB_ROOT%\Lancia_Ozone.bat"

:skip_ozone

:: ----------------------------------------------------------
:: Generazione Launcher per GD32_All_In_One_Programmer
:: ----------------------------------------------------------
if exist %USB_ROOT%\Lancia_GDProgrammer.bat goto skip_GDProgrammer
echo Scrittura di Lancia_GDProgrammer.bat...
echo @echo off > "%USB_ROOT%\Lancia_GDProgrammer.bat"
echo setlocal >> "%USB_ROOT%\Lancia_GDProgrammer.bat"
echo :: Calcola il percorso relativo della chiavetta >> "%USB_ROOT%\Lancia_GDProgrammer.bat"
echo set "ROOT_DIR=%%~dp0" >> "%USB_ROOT%\Lancia_GDProgrammer.bat"
echo if "%%ROOT_DIR:~-1%%"=="\" set "ROOT_DIR=%%ROOT_DIR:~0,-1%%" >> "%USB_ROOT%\Lancia_GDProgrammer.bat"
echo. >> "%USB_ROOT%\Lancia_GDProgrammer.bat"
echo set "EXE_NAME=GD32AllInOneProgrammer.exe" >> "%USB_ROOT%\Lancia_GDProgrammer.bat"
echo. >> "%USB_ROOT%\Lancia_GDProgrammer.bat"
echo cd "%%ROOT_DIR%%\Workspace">> "%USB_ROOT%\Lancia_GDProgrammer.bat"
echo start "All In One Programmer" "%%ROOT_DIR%%\Apps\GD32_All_In_One_Programmer\%%EXE_NAME%%"  -data "%ROOT_DIR%\Workspace">> "%USB_ROOT%\Lancia_GDProgrammer.bat"
:skip_GDProgrammer


:: ----------------------------------------------------------
:: Generazione Launcher per Command Shell
:: ----------------------------------------------------------
if exist %USB_ROOT%\Lancia_Cmd.bat goto skip_cmd

echo Scrittura di Lancia_Cmd.bat...
echo @echo off  > "%USB_ROOT%\Lancia_Cmd.bat"
echo setlocal  >> "%USB_ROOT%\Lancia_Cmd.bat"
echo :: Calcola il percorso relativo della chiavetta >> "%USB_ROOT%\Lancia_Cmd.bat"
echo set "ROOT_DIR=%%~dp0" >> "%USB_ROOT%\Lancia_Cmd.bat"
echo if "%%ROOT_DIR:~-1%%"=="\" set "ROOT_DIR=%%ROOT_DIR:~0,-1%%" >> "%USB_ROOT%\Lancia_Cmd.bat"

echo. >> "%USB_ROOT%\Lancia_Cmd.bat"

echo :: Configura l'ambiente  >> "%USB_ROOT%\Lancia_Cmd.bat"
echo set "MSYS2_PATH=%%ROOT_DIR%%\Apps\msys64" >> "%USB_ROOT%\Lancia_Cmd.bat"
echo set "ARM_GCC_PATH=%%ROOT_DIR%%\Apps\gcc-arm\bin" >> "%USB_ROOT%\Lancia_Cmd.bat"
echo set "GEANY_PATH=%%ROOT_DIR%%\Apps\Geany\bin" >> "%USB_ROOT%\Lancia_Cmd.bat"
echo set "OPENOCD_PATH=%%ROOT_DIR%%\Apps\OpenOCD\bin" >> "%USB_ROOT%\Lancia_Cmd.bat"
echo set "REALTERM_PATH=%%ROOT_DIR%%\Apps\Realterm" >> "%USB_ROOT%\Lancia_Cmd.bat"
echo set "SIMPLYSERIAL_PATH=%%ROOT_DIR%%\Apps\SimplySerial" >> "%USB_ROOT%\Lancia_Cmd.bat"

echo. >> "%USB_ROOT%\Lancia_Cmd.bat"

echo :: Aggiunge GCC, OpenOCD e i tool MSYS2 (make, nano) al PATH per farli vedere a Geany >> "%USB_ROOT%\Lancia_Cmd.bat"
echo set "PATH=%%ARM_GCC_PATH%%;%%GEANY_PATH%%;%%OPENOCD_PATH%%;%%REALTERM_PATH%%;%%SIMPLYSERIAL_PATH%%;%%PATH%%" >> "%USB_ROOT%\Lancia_Cmd.bat"
echo set "PATH=%%ROOT_DIR%%\Apps\msys64\usr\bin;%%PATH%%" >> "%USB_ROOT%\Lancia_Cmd.bat"
echo. >> "%USB_ROOT%\Lancia_Cmd.bat"

echo :: Avvia Command Shell >> "%USB_ROOT%\Lancia_Cmd.bat"
echo cd "%%ROOT_DIR%%\Workspace">> "%USB_ROOT%\Lancia_Cmd.bat"
echo cmd.exe /K >> "%USB_ROOT%\Lancia_Cmd.bat"
:skip_cmd



echo.
echo ========================================================
echo OPERAZIONE COMPLETATA CON SUCCESSO!
echo.
echo Cartelle create e Launcher configurati in: %USB_ROOT%
echo.
echo Ora puoi copiare i programmi estratti dentro "Apps\"
echo come descritto nella guida README.md.
echo ========================================================
pause
