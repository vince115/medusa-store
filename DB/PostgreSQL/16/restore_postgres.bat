@echo off
chcp 65001 >nul
setlocal

:: === 設定參數 ===
set DB_NAME=medusa-medusa-store
set DB_USER=postgres
set PGPASSWORD=test

:: ✅ 替換為你的實際 pg_restore 路徑
set PSQL=C:\Program Files\PostgreSQL\16\bin\psql.exe

:: ✅ 修改為你要還原的備份檔案路徑
set BACKUP_FILE=%~dp0backup\medusa-medusa-store_backup_20250325.sql

echo 正在還原資料庫：%DB_NAME% ← %BACKUP_FILE%
"%PSQL%" -U %DB_USER% -d %DB_NAME% -f "%BACKUP_FILE%"

if %ERRORLEVEL% equ 0 (
    echo ✅ 還原成功！
) else (
    echo ❌ 還原失敗，請確認資料庫是否存在及路徑正確。
)

pause
endlocal
