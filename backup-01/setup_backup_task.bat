@echo off
chcp 65001 >nul

REM Xóa task cũ nếu có
schtasks /Delete /TN "Backup Planning 01" /F >nul 2>&1
schtasks /Delete /TN "Backup Planning 02" /F >nul 2>&1
schtasks /Delete /TN "Backup Planning 03" /F >nul 2>&1
schtasks /Delete /TN "Backup Planning 04" /F >nul 2>&1

REM Đường dẫn tới script backup
set SCRIPT=C:\BOT_NOSENSE\note\backup-01\backup_01.bat

REM Kiểm tra file backup script có tồn tại không
if not exist "%SCRIPT%" (
    echo [LỖI] Không tìm thấy file backup script: %SCRIPT%
    echo Vui lòng kiểm tra lại đường dẫn backup_01.bat trước khi chạy.
    pause
    exit /b 1
)

echo [OK] Đã tìm thấy file backup script: %SCRIPT%

REM Tạo task chạy khi khởi động máy
schtasks /Create /TN "Backup Planning 01" ^
 /TR "%SCRIPT%" ^
 /SC ONSTART ^
 /RU SYSTEM ^
 /RL HIGHEST ^
 /F

REM Tạo task chạy lúc 10h sáng mỗi ngày
schtasks /Create /TN "Backup Planning 02" ^
 /TR "%SCRIPT%" ^
 /SC DAILY /ST 10:00 ^
 /RU SYSTEM ^
 /RL HIGHEST ^
 /F

REM Tạo task chạy lúc 2h chiều mỗi ngày
schtasks /Create /TN "Backup Planning 03" ^
 /TR "%SCRIPT%" ^
 /SC DAILY /ST 14:00 ^
 /RU SYSTEM ^
 /RL HIGHEST ^
 /F

REM Tạo task chạy lúc 5h chiều mỗi ngày
schtasks /Create /TN "Backup Planning 04" ^
 /TR "%SCRIPT%" ^
 /SC DAILY /ST 17:00 ^
 /RU SYSTEM ^
 /RL HIGHEST ^
 /F

echo.
echo [HOÀN TẤT] Đã tạo lịch sao lưu tự động:
echo - Khi bật máy
echo - 10h sáng
echo - 14h chiều
echo - 17h chiều
echo (Chạy bằng tài khoản SYSTEM, không cần đăng nhập)
pause
