echo on
setlocal EnableDelayedExpansion

mkdir build
if errorlevel 1 exit 1
cd build
if errorlevel 1 exit 1


REM    -DBUILD_SHARED_LIBS=ON ^
REM    in 2.3.4 causes The compilation of SystemC as a DLL on Windows is currently not supported!
REM    should check this when moving forward

cmake ^
    -G "NMake Makefiles" ^
    -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH:PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    %SRC_DIR%
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1

REM manually install the examples as in unix so that they can be split into
REM systemc-doc package
xcopy %SRC_DIR%\examples %LIBRARY_PREFIX%\share\doc\systemc\examples\ /F /E /H
if errorlevel 1 exit 1
