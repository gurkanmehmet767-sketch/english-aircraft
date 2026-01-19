
@echo off
echo ===================================================
echo     ENGLISH AIRCRAFT - SECURE BUILD SCRIPT
echo ===================================================
echo.
echo Bu islem kodlarinizi 'obfuscate' yontemiyle gizleyerek
echo calinmasini veya okunmasini zorlastirir.
echo.
echo Lutfen bekleyin...
echo.

flutter build web --release --obfuscate --split-debug-info=./debug_info

echo.
echo ===================================================
echo     ISLEM TAMAMLANDI!
echo ===================================================
echo build/web klasoru hazir!
echo.
echo Firebase'e yuklemek icin:
echo   firebase deploy --only hosting
echo.
pause
