@echo off
REM DCS Retribution - Starts React dev server AND Retribution with --dev
REM Opens two command windows
REM Run npm install on first use if node_modules doesn't exist

cd /d "%~dp0"

if not exist "client\node_modules" (
    echo First run detected - installing React dependencies...
    cd client
    npm install
    cd ..
    echo React dependencies installed.
)

echo Starting React dev server (Terminal 1)...
start "React Dev Server" cmd /k "cd client && npm start"

echo Waiting 10 seconds for React to compile...
timeout /t 10 >nul

echo Starting DCS Retribution with --dev (Terminal 2)...
start "DCS Retribution" cmd /k "call venv\Scripts\activate.bat && python -m qt_ui.main --dev"

echo.
echo Both processes started in separate windows.
echo Close the windows to stop them.
pause