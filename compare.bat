@echo off
setlocal

:: Define file names
set FILE1=file1.txt
set FILE2=file2.txt
set DIFFERENT=Different.txt
set COMMON=Common.txt
set UNIQUE=Unique.txt

:: Clear output files if they already exist
> "%DIFFERENT%" echo.
> "%COMMON%" echo.
> "%UNIQUE%" echo.

:: Loop through each line in FILE1
for /F "delims=" %%A in (%FILE1%) do (
    findstr /x /c:"%%A" %FILE2% >nul
    if errorlevel 1 (
        echo %%A >> "%DIFFERENT%"
        echo %%A >> "%UNIQUE%"
    ) else (
        echo %%A >> "%COMMON%"
        echo %%A >> "%UNIQUE%"
    )
)

:: Loop through each line in FILE2 to find lines unique to FILE2
for /F "delims=" %%B in (%FILE2%) do (
    findstr /x /c:"%%B" %FILE1% >nul
    if errorlevel 1 (
        findstr /x /c:"%%B" "%UNIQUE%" >nul || echo %%B >> "%UNIQUE%"
        echo %%B >> "%DIFFERENT%"
    )
)

echo Comparison complete.
pause