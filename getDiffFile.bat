@ECHO off
chcp 65001
SETLOCAL ENABLEDELAYEDEXPANSION
REM Set variables
SET "FileListTxt=diffFileTemp.txt"
SET "SourceFolder=D:\project\git_source_folder"
set "locatedFolder=%cd%"
set /P diffBranchName=Please input your branch name: 
set /P mainBranchName=Please input your main branch name (default: master): 
set /P DestinationFolder=Please input your destination folder (default: current path): 
if not defined DestinationFolder set "DestinationFolder=%cd%\INAD"
if not defined mainBranchName set "mainBranchName=master"
REM Switch to project directory and execute git diff
pushd "%SourceFolder%"
git diff %mainBranchName% %diffBranchName% --name-only > "%locatedFolder%\%FileListTxt%"
popd
ECHO Starting script execution
ECHO File list: %FileListTxt%
ECHO Source folder: %SourceFolder%
ECHO Destination folder: %DestinationFolder%
REM Check if file list exists
IF NOT EXIST "%FileListTxt%" (
    ECHO Error: File list %FileListTxt% does not exist, please check and try again.
    GOTO :ERROR_EXIT
)
REM Check if source folder exists
IF NOT EXIST "%SourceFolder%" (
    ECHO Error: Source folder %SourceFolder% does not exist, please check and try again.
    GOTO :ERROR_EXIT
)
REM Check if destination folder exists, create if it doesn't
IF NOT EXIST "%DestinationFolder%" (
    ECHO Destination folder %DestinationFolder% does not exist, attempting to create...
    MKDIR "%DestinationFolder%" 2>nul
    IF !ERRORLEVEL! NEQ 0 (
        ECHO Error: Cannot create destination folder %DestinationFolder%
        GOTO :ERROR_EXIT
    )
)
ECHO Starting to read file list and copy files
REM Read file list and copy files
FOR /F "usebackq delims=" %%A IN ("%FileListTxt%") DO (
    SET "RelativePath=%%A"
    SET "RelativePath=!RelativePath:/=\!"
    SET "SourceFile=%SourceFolder%\!RelativePath!"
    SET "DestFile=%DestinationFolder%\!RelativePath!"
    
    ECHO Processing: !RelativePath!
    ECHO Source: !SourceFile!
    ECHO Target: !DestFile!
    
    IF NOT EXIST "!SourceFile!" (
        ECHO Warning: Source file does not exist - !RelativePath!
    ) ELSE (
        REM Create directory for target file
        FOR %%B IN ("!DestFile!") DO (
            IF NOT EXIST "%%~dpB" (
                ECHO Creating directory: %%~dpB
                MKDIR "%%~dpB" 2>nul
                IF !ERRORLEVEL! NEQ 0 (
                    ECHO Error: Cannot create directory %%~dpB
                    GOTO :ERROR_EXIT
                )
            )
        )
        
        ECHO Copying file...
        ECHO Source: "!SourceFile!"
        ECHO Target: "!DestFile!"
        COPY "!SourceFile!" "!DestFile!" /Y
        IF !ERRORLEVEL! EQU 0 (
            ECHO Successfully copied: !RelativePath!
        ) ELSE (
            ECHO Error: Copy failed - !RelativePath!
            GOTO :ERROR_EXIT
        )
    )
    ECHO.
)
ECHO File copying operation completed.
GOTO :NORMAL_EXIT
:ERROR_EXIT
ECHO An error occurred during script execution.
PAUSE
EXIT /B 1
:NORMAL_EXIT
PAUSE
EXIT /B 0
