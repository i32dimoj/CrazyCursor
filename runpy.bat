@echo off
set "PYTHON_EXE=C:\Program Files\Python313\python.exe"
set "PYTHON_INSTALLER=%TEMP%\python_installer.exe"

:: 1. Verificar si Python existe en la ruta
if exist "%PYTHON_EXE%" (
    echo [OK] Python detectado.
    goto :run
)

echo [!] Python no encontrado. Iniciando descarga...

:: 2. Descargar instalador de Python 3.13 (64-bit)
:: Usamos curl que viene integrado en Windows 10/11
curl -L "https://www.python.org" -o "%PYTHON_INSTALLER%"

if %ERRORLEVEL% neq 0 (
    echo [ERROR] No se pudo descargar Python. Revisa tu conexion.
    pause
    exit
)

echo [*] Instalando Python... Por favor, espera.
:: 3. Instalacion silenciosa (Añade Python al PATH e instala para todos los usuarios)
start /wait "" "%PYTHON_INSTALLER%" /quiet InstallAllUsers=1 PrependPath=1

:: 4. Borrar el instalador tras terminar
del "%PYTHON_INSTALLER%"

:run
echo [🚀] Arrancando CrazyCursor...
::start "" /MAX "%PYTHON_EXE%" "d:/@JORGED/MisProgramas/PY/CrazyCursor/crazy.py"
start "" cmd /c "mode con: cols=80 lines=10 && "%PYTHON_EXE%" "d:/@JORGED/MisProgramas/PY/CrazyCursor/crazy.py""

