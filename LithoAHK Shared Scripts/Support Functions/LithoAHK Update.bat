Echo Off
REM *******************************************************
REM *                                                     *
REM * Update Script for Litho AutoHotkey Scripts          *
REM *                                                     *
REM *   Usage: Update_LithoAHK "OldVerion to NewVersion"  *
REM ********************************************************************************
REM * Erase /F/Q %LocalDrive%\[FileName] 					                       *
REM *	  /F            Force deleting of read-only files      		               *
REM *	  /Q            Quiet mode, do not ask if ok to delete on global wildcard  *
REM ********************************************************************************

REM Variables
Set LocalDrive=%OneDrive%\Documents\AutoHotkey\LithoAHK
Set GlobalShareFolder=\\VMSPFSFSEG14\D1C_global\AutoHotkey\LithoAHK Files
Set GlobalLogFilePath=\\VMSPFSFSEG14\D1C_global\AutoHotkey\LithoAHK.Log

Set LocalStartUpFolder1=%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
Set LocalStartUpFolder2=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp

REM Make Log Entry
REM UserName | Date Time | Action | Start\Completed | Notes - Publish from Directory
Echo %UserName%,"%Date% %Time%",Update,Start,"%1" >> "%GlobalLogFilePath%"

REM Files to be Erased - Keep older version Erase commands for those that do not update often
REM v0.1 -- None

REM Files to be Moved - Keep older version Move commands for thise that do not update often
REM Version 2.1.4 Templates are moved to either CMT or SIF folders and renamed to txt
xCopy /V/C/R/K/Y "%LocalDrive%\LithoAHK Personal Scripts\Auto Fill Templates\*.aft" "%LocalDrive%\LithoAHK Personal Scripts\Auto Fill Templates\CMT Templates\*"
Rename "%LocalDrive%\LithoAHK Personal Scripts\Auto Fill Templates\CMT Templates\*.aft" ".*txt"
xCopy /V/C/R/K/Y "%LocalDrive%\LithoAHK Personal Scripts\Auto Fill Templates\*.ast" "%LocalDrive%\LithoAHK Personal Scripts\Auto Fill Templates\SIF Templates\*"
Rename "%LocalDrive%\LithoAHK Personal Scripts\Auto Fill Templates\SIF Templates\*.ast" ".*txt"

REM Remove the Local Shared Scripts
RmDir /S/Q "%LocalDrive%\LithoAHK Shared Scripts"

REM Copy the files to the local drive 
xCopy /V/C/R/K/Y "%GlobalShareFolder%\LithoAHK.ahk" "%LocalDrive%\*"
xCopy /V/C/R/K/Y/S "%GlobalShareFolder%\LithoAHK Shared Scripts" "%LocalDrive%\LithoAHK Shared Scripts\*"
xCopy /V/C/R/K/Y "%GlobalShareFolder%\LithoAHK Personal Scripts\Auto Fill Templates\_Blank Auto Fill Template.txt" "%LocalDrive%\LithoAHK Personal Scripts\Auto Fill Templates\*"
xCopy /V/C/R/K/Y "%GlobalShareFolder%\LithoAHK Personal Scripts\Auto Fill Templates\_Blank SIF Template.txt" "%LocalDrive%\LithoAHK Personal Scripts\Auto Fill Templates\*"

REM Make Log Entry
REM UserName | Date Time | Action | Start\Completed | Notes - Publish from Directory
Echo %UserName%,"%Date% %Time%",Update,Completed,"%1" >> "%GlobalLogFilePath%"