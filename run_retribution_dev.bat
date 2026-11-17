@echo off
REM DCS Retribution - Run with --dev flag (requires React dev server on port 3000)
REM Usage: run_retribution_dev.bat

cd /d "%~dp0"

REM Auto-install React deps if needed
if not exist "client\node_modules" (
    echo First run detected - installing React dependencies...
    cd client
    npm install
    cd ..
    echo React dependencies installed.
)

echo Activating virtual environment...
call venv\Scripts\activate.bat

echo Starting DCS Retribution with --dev flag...
echo.
echo NOTE: Make sure React dev server is running in another terminal:
echo   cd client && npm start
echo.

python -m qt_ui.main --dev

pause