@echo off
setlocal

REM Resolve repository root
set "ROOT=%~dp0"

echo.
echo [DevPlanner] Stopping all components...

REM ------------------------------------------------------------
REM Kill React (Vite/Next/CRA) - npm run dev
REM ------------------------------------------------------------
taskkill /FI "WindowTitle eq DevPlanner - React (Vite/Next/CRA)*" /F /T >nul 2>&1
if %errorlevel%==0 (
    echo   [OK] React frontend stopped.
) else (
    echo   [INFO] React frontend not running.
)

REM ------------------------------------------------------------
REM Kill FastAPI (WebSocket server) - uvicorn
REM ------------------------------------------------------------
taskkill /FI "WindowTitle eq DevPlanner - FastAPI (WebSocket)*" /F /T >nul 2>&1
if %errorlevel%==0 (
    echo   [OK] FastAPI WebSocket server stopped.
) else (
    echo   [INFO] FastAPI WebSocket not running.
)

REM ------------------------------------------------------------
REM Kill Celery worker
REM ------------------------------------------------------------
taskkill /FI "WindowTitle eq DevPlanner - Celery Worker*" /F /T >nul 2>&1
if %errorlevel%==0 (
    echo   [OK] Celery worker stopped.
) else (
    echo   [INFO] Celery worker not running.
)

REM ------------------------------------------------------------
REM Kill Django development server
REM ------------------------------------------------------------
taskkill /FI "WindowTitle eq DevPlanner - Django*" /F /T >nul 2>&1
if %errorlevel%==0 (
    echo   [OK] Django server stopped.
) else (
    echo   [INFO] Django server not running.
)

REM ------------------------------------------------------------
REM Optional: Force kill by process name (backup safety)
REM ------------------------------------------------------------
echo.
echo [Backup] Terminating stray processes by name...
taskkill /IM "python.exe" /F /FI "COMMANDLINE eq *manage.py runserver*" >nul 2>&1
taskkill /IM "uvicorn.exe" /F >nul 2>&1
taskkill /IM "celery.exe" /F >nul 2>&1
taskkill /IM "node.exe" /F /FI "COMMANDLINE eq *npm run dev*" >nul 2>&1

echo.
echo [Done] All components stopped and windows closed.
timeout /t 2 >nul
endlocal
exit