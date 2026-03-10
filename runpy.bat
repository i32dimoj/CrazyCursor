@echo off
setlocal enabledelayedexpansion

:: 1. Definir rutas absolutas
set "PYTHON_EXE=C:\Program Files\Python313\python.exe"
set "SCRIPT_PY=%~dp0crazy.py"

:: 2. Si no existe Python, instalarlo con TODO incluido
if not exist "%PYTHON_EXE%" (
    echo [!] Python 3.13 no encontrado. Instalando con PIP habilitado...
    curl -L "https://www.python.org/ftp/python/3.13.12/python-3.13.12-amd64.exe" -o "%TEMP%\py_inst.exe"
    :: PrependPath=1 y Include_pip=1 son claves aquí
    start /wait "" "%TEMP%\py_inst.exe" /quiet InstallAllUsers=1 PrependPath=1 Include_pip=1 TargetDir="C:\Program Files\Python313"
    del "%TEMP%\py_inst.exe"
)

:: 3. REPARAR PIP E INSTALAR LIBRERÍAS (Solución al ModuleNotFoundError)
echo [*] Verificando gestor de paquetes y librerias...
:: Forceamos la activación de pip por si el instalador lo omitió
"%PYTHON_EXE%" -m ensurepip --upgrade >nul 2>&1
:: Instalamos las librerias ignorando configuraciones de usuario previas
"%PYTHON_EXE%" -m pip install --upgrade pip
"%PYTHON_EXE%" -m pip install pyautogui keyboard --no-warn-script-location

:: 4. Ejecución verificando el archivo .py
if not exist "%SCRIPT_PY%" (
    echo [ERROR] No se encuentra crazy.py en: %SCRIPT_PY%
    pause
    exit /b
)

echo [🚀] Arrancando CrazyCursor con "%PYTHON_EXE%"
start "" cmd /k "mode con: cols=80 lines=10 && title CrazyCursor && "%PYTHON_EXE%" "%SCRIPT_PY%""
