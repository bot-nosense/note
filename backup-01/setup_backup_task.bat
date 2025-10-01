@echo off

REM Đường dẫn tới script backup
set SCRIPT=C:\BOT_NOSENSE\note\backup-01\backup_01.bat

REM Kiểm tra file backup script có tồn tại không
if not exist "%SCRIPT%" (
    echo [ERROR] File backup script không tồn tại: %SCRIPT%
    echo Vui lòng kiểm tra lại đường dẫn copy_data.bat trước khi chạy.
    pause
    exit /b 1
)

echo [OK] Đã tìm thấy file script: %SCRIPT%

REM Tạo task chạy khi khởi động máy
schtasks /Create /TN "Backup Data" ^
 /TR "%SCRIPT%" ^
 /SC ONSTART ^
 /RU SYSTEM ^
 /RL HIGHEST ^
 /F

REM Tạo task chạy lúc 10h sáng mỗi ngày
schtasks /Create /TN "Backup Data 10AM" ^
 /TR "%SCRIPT%" ^
 /SC DAILY /ST 10:00 ^
 /RU SYSTEM ^
 /RL HIGHEST ^
 /F

REM Tạo task chạy lúc 2h chiều mỗi ngày
schtasks /Create /TN "Backup Data 2PM" ^
 /TR "%SCRIPT%" ^
 /SC DAILY /ST 14:00 ^
 /RU SYSTEM ^
 /RL HIGHEST ^
 /F

REM Tạo task chạy lúc 5h chiều mỗi ngày
schtasks /Create /TN "Backup Data 5PM" ^
 /TR "%SCRIPT%" ^
 /SC DAILY /ST 17:00 ^
 /RU SYSTEM ^
 /RL HIGHEST ^
 /F

echo [OK] Task Scheduler đã được tạo:
echo - Khi bật máy
echo - 10h sáng
echo - 2h chiều
echo - 5h chiều
echo (Chạy dưới quyền SYSTEM, không cần đăng nhập)
pause
