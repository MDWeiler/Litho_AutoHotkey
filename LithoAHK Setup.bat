Echo Off
REM **********************************************
REM *                                            *
REM * Setup Script for Litho AutoHotkey Scripts  *
REM *                                            *
REM *   Usage: Setup_LithoAHK                    *
REM **********************************************

REM Variables
Set LocalDrive=%OneDrive%\Documents\AutoHotkey\LithoAHK
Set GlobalShareFolder=\\VMSPFSFSEG14\D1C_global\AutoHotkey\LithoAHK Files
Set GlobalLogFilePath=\\VMSPFSFSEG14\D1C_global\AutoHotkey\LithoAHK.Log

Set LocalStartUpFolder1=%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
Set LocalStartUpFolder2=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp

REM Make Log Entry
REM UserName | Date Time | Action | Start\Completed | Notes - Publish from Directory
Echo %UserName%,"%Date% %Time%",Setup,Start,"Installing LithoAHK" >> "%GlobalLogFilePath%"

Echo On
REM Attempt to Clear StartUp links to AHK scripts
Erase /F/Q "%LocalStartUpFolder1%"\*.ahk*.lnk
Erase /F/Q "%LocalStartUpFolder1%"\*AutoHotkey*.lnk
Erase /F/Q "%LocalStartUpFolder2%"\*.ahk*.lnk
Erase /F/Q "%LocalStartUpFolder2%"\*AutoHotkey*.lnk

REM Clean Install - Remove the Local Path
RmDir /S/Q "%LocalDrive%"

REM Copy the files to the local drive 
xCopy /V/C/R/K/Y "%GlobalShareFolder%\LithoAHK.ahk" "%LocalDrive%\*"
xCopy /V/C/R/K/Y/S "%GlobalShareFolder%\LithoAHK Shared Scripts" "%LocalDrive%\LithoAHK Shared Scripts\*"
xCopy /V/C/R/K/Y "%GlobalShareFolder%\LithoAHK Personal Scripts\Auto Fill Templates\CMT Templates\_Blank Auto Fill Template.txt" "%LocalDrive%\LithoAHK Personal Scripts\Auto Fill Templates\CMT Templates\*"
xCopy /V/C/R/K/Y "%GlobalShareFolder%\LithoAHK Personal Scripts\Auto Fill Templates\SIF Templates\_Blank SIF Template.txt" "%LocalDrive%\LithoAHK Personal Scripts\Auto Fill Templates\SIF Templates\*"
Copy /B/V/Y "%GlobalShareFolder%\LithoAHK Personal Scripts\LithoAHK Personal Scripts.ahk" "%LocalDrive%\LithoAHK Personal Scripts\LithoAHK Personal Scripts.ahk"

REM xCopy the StartUp Launcher
xCopy /V/C/R/K/Y "%GlobalShareFolder%\LithoAHK Shared Scripts\Support Functions\LithoAHK Launcher.vbs" "%LocalStartUpFolder1%\*"

Echo Off
REM Make Log Entry
REM UserName | Date Time | Action | Start\Completed | Notes - Publish from Directory
Echo %UserName%,"%Date% %Time%",Setup,Completed,"Installing LithoAHK" >> "%GlobalLogFilePath%"

REM Display Completed message for 10sec or until a key is pressed
Echo.
Echo ******************************************
Echo         LithoAHK Setup Completed
Echo   You can close this window any time now
Echo ******************************************
Echo.

REM Start LithoAHK
Call "%LocalStartUpFolder1%\LithoAHK Launcher.vbs"