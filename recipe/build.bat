echo on
setlocal EnableDelayedExpansion

mkdir build
if errorlevel 1 exit 1
cd build
if errorlevel 1 exit 1

REM BUILD_SHARED_LIBS=ON is unsupported on Windows.
cmake ^
    -G "NMake Makefiles" ^
    -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH:PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    %SRC_DIR%
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1

xcopy %SRC_DIR%\examples %LIBRARY_PREFIX%\share\doc\systemc\examples\ /F /E /H /Y
if errorlevel 1 exit 1
