@ECHO OFF
CLS
ECHO.
ECHO #########################################################
ECHO # Build Vivado project for EBAZ4205 board
ECHO # Part: xc7z010clg400-1
ECHO # Author: abigsam@gmail.com
ECHO # Vivado version: 2020.1
ECHO #########################################################
ECHO.
ECHO Avaliable options:
ECHO [1] Build project
ECHO [2] Cleanup Git repository
ECHO [3] Exit
ECHO.

CHOICE /C 123 /N /M "Enter your choice:"
IF ERRORLEVEL 3 GOTO END
IF ERRORLEVEL 2 GOTO RUN_CLEANUP_PRJ
IF ERRORLEVEL 1 GOTO RUN_BUILD

:RUN_CLEANUP_PRJ
ECHO Cleanup project folder...
rmdir /s /q "%~dp0\vivado"
del "%~dp0\*.log"

:RUN_CLEANUP
ECHO Cleanup Vivado files...
del "%~dp0\*.jou"
del "%~dp0\*.dmp"
rmdir /s /q "%~dp0\.Xil"
goto END

:RUN_BUILD
rem Run Vivado batch file with Tcl build script
rem Tcl script has two arguments:
rem - run Vivado GUI
rem - use derictive "exit" at Tcl script
rem After this, batch file changes run directory to the vivado project ("vivado/" by default) and call for Vivado with GUI
ECHO Run Tcl build script...
call C:\Xilinx\Vivado\2020.1\bin\vivado.bat -mode batch -nojournal -source "%~dp0\scripts\build.tcl" -tclargs 0 1
cd "%~dp0\vivado"
C:\Xilinx\Vivado\2020.1\bin\unwrapped\win64.o\vvgl.exe C:\Xilinx\Vivado\2020.1\bin\vivado.bat -project "%~dp0\vivado\ebaz4205.xpr"
goto RUN_CLEANUP

:END
rem pause
