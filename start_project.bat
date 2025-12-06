@echo off
setlocal

REM Resolve repository root to this script's directory (with trailing backslash)
set "ROOT=%~dp0"

REM ------------------------------------------------------------
REM Django (DRF backend)
REM ------------------------------------------------------------
start "DevPlanner - Django" cmd /k "cd /d ""%ROOT%backend"" && call ""%ROOT%.venv\Scripts\activate"" && py manage.py runserver"

REM ------------------------------------------------------------
REM FastAPI (WebSocket server)
REM ------------------------------------------------------------
start "DevPlanner - FastAPI (WebSocket)" cmd /k "cd /d ""%ROOT%websocket"" && call ""%ROOT%.websocket.venv\Scripts\activate"" && uvicorn app.main:app --host 0.0.0.0 --port 8001 --log-level info"

REM ------------------------------------------------------------
REM Celery worker (using Django app)
REM ------------------------------------------------------------
start "DevPlanner - Celery Worker" cmd /k "cd /d ""%ROOT%backend"" && call ""%ROOT%.venv\Scripts\activate"" && celery -A backend worker -P solo -l info"

REM ------------------------------------------------------------
REM React frontend
REM ------------------------------------------------------------
start "DevPlanner - React" cmd /k "cd /d ""%ROOT%frontend"" && npm run dev"

echo All components launching in separate windows...
endlocal
