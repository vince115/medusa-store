@echo off
chcp 65001 >nul
setlocal

:: === 設定你的資料庫參數 ===
set DB_NAME=medusa-medusa-store
set DB_USER=postgres
set PGPASSWORD=test
set BACKUP_DIR=%~dp0backup

:: === 使用穩定日期格式：YYYYMMDD ===
for /f %%i in ('wmic os get localdatetime ^| find "."') do set datetime=%%i
set BACKUP_FILE=%BACKUP_DIR%\%DB_NAME%_backup_%datetime:~0,8%.sql

:: === 指定 pg_dump 路徑 ===
set PG_DUMP="C:\Program Files\PostgreSQL\16\bin\pg_dump.exe"

:: === 確保備份資料夾存在 ===
if not exist "%BACKUP_DIR%" (
    mkdir "%BACKUP_DIR%"
)

:: === 執行備份 ===
echo 備份中：%DB_NAME% → %BACKUP_FILE%
%PG_DUMP% -U %DB_USER% -d %DB_NAME% -F p -f "%BACKUP_FILE%"

if %ERRORLEVEL% equ 0 (
    echo ✅ 備份成功！
) else (
    echo ❌ 備份失敗，請檢查資料庫連線資訊或權限。
)

pause
endlocal
