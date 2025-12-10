@echo off
chcp 65001 >nul
echo ==========================================
echo           Auto Deploy Script
echo ==========================================

echo [1/4] Adding changes...
git add .

echo [2/4] Committing changes...
set "timestamp=%date% %time%"
git commit -m "Site update %timestamp%"

echo [3/4] Pushing to remote...
git push
if %errorlevel% neq 0 (
    echo Error: Git push failed.
    pause
    exit /b %errorlevel%
)

echo ==========================================
echo           Deploy Success!
echo ==========================================
pause
