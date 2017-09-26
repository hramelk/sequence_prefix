@ECHO OFF

TITLE Copy with seuqnce prefix by Hramelk95
ECHO Batch script for copying files with sequence number prefix by Hramelk95
ECHO Place this file in the folder with your .mp3 files and 0_list.txt and run it
ECHO The script will create a new folder named sequenced_^<DATE^>_^<TIME^>
ECHO and copy the files listed in 0_list.txt into it with new names
ECHO.

ECHO Press any key to start copying
PAUSE >nul

CHCP 65001 >nul

IF NOT EXIST 0_list.txt (
    ECHO.
    ECHO ERROR: 0_list.txt file not found
    GOTO :exitme
)

IF NOT EXIST *.mp3 (
    ECHO.
    ECHO No *.mp3 files found
    GOTO :exitme
)

SET "newFolderName=sequenced_%DATE%_%TIME::=.%"
SET "newFolderName=%newFolderName: =%"
SET _NL=^


REM Two empty lines are required here

ECHO.
ECHO Creating folder
MD "%newFolderName%"
IF EXIST "%newFolderName%"\ (
    ECHO Folder %newFolderName% created
) ELSE (
    ECHO ERROR: Failed to create folder "%newFolderName%"
    ECHO.
    GOTO :exitme
)

ECHO.
ECHO Copying files
ECHO.
SET "_count=1"
SET "_fail=0"
SET "_list="
SET "_temp="
FOR /f "eol=: delims=" %%a IN ('type 0_list.txt') DO (
    SETLOCAL DisableDelayedExpansion
        ECHO %%a
        SET "_temp=%%a"
        SETLOCAL EnableDelayedExpansion
            REM echo !_temp!
            SET "_temp=!_temp:"=!"
            REM echo !_temp!
            COPY "!_temp!" "%newFolderName%\!_count!__!_temp!"                   
        ENDLOCAL
    ENDLOCAL
    SET /a "_count+=1"
    ECHO.

)

SET /a "_count-=1"

ECHO.
ECHO Copy completed, %_count% entries processed
ECHO.

:exitme
ECHO Press any key to exit the script
PAUSE >nul
EXIT /b 0
