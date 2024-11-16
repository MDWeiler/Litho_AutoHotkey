Echo Off
REM **********************************************************
REM *                                                        *
REM * Publish the Current Branch to the Global Shared Drive  *
REM *                                                        *
REM *   Publish_LithoAHK                                     *
REM **********************************************************

REM Some Variables
Set GlobalShareFolder=\\VMSPFSFSEG14\D1C_global\AutoHotkey\LithoAHK Files
Set GlobalLogFilePath=\\VMSPFSFSEG14\D1C_global\AutoHotkey\LithoAHK.Log


REM Verify that the Version line in LithoAHK has been updated
Echo Are you ready to publish?
Echo   [_] Updated the Version value in LithoAHK?
Echo   [_] All new files added to Setup\Update\Publish scripts?
Echo   [_] All deleted files added to Update script?
Echo If you are not ready to publish use Ctrl-C to Terminate job
Echo.
Set /p UserReady="Are you ready to Publish? (Press Enter to continue) "

REM Make Log Entry
REM UserName | Date Time | Action | Start\Completed | Notes - Publish from Directory
Echo %UserName%,"%Date% %Time%",Publish,Start,"Publishing LithoAHK Update" >> "%GlobalLogFilePath%"
Echo On

REM Clean out the Global Folder
RmDir /S/Q "%GlobalShareFolder%"

REM Copy the files to Global Folder
xCopy /V/C/R/K/Y "LithoAHK.ahk" "%GlobalShareFolder%\*"
xCopy /V/C/R/K/Y "LithoAHK Setup.bat" "%GlobalShareFolder%\*"
xCopy /V/C/R/K/Y/S "LithoAHK Shared Scripts" "%GlobalShareFolder%\LithoAHK Shared Scripts\*"
xCopy /V/C/R/K/Y "LithoAHK Personal Scripts\Auto Fill Templates\CMT Templates\_Blank Auto Fill Template.txt" "%GlobalShareFolder%\LithoAHK Personal Scripts\Auto Fill Templates\CMT Templates\*"
xCopy /V/C/R/K/Y "LithoAHK Personal Scripts\Auto Fill Templates\SIF Templates\_Blank SIF Template.txt" "%GlobalShareFolder%\LithoAHK Personal Scripts\Auto Fill Templates\SIF Templates\*"
Copy /B/V/Y "LithoAHK Personal Scripts\_Blank LithoAHK Personal Scripts.ahk" "%GlobalShareFolder%\LithoAHK Personal Scripts\LithoAHK Personal Scripts.ahk"

Echo Off
REM Make Log Entry
REM UserName | Date Time | Action | Start\Completed | Notes - Publish from Directory
Echo %UserName%,"%Date% %Time%",Publish,Completed,"Publishing LithoAHK Update" >> "%GlobalLogFilePath%"

REM Finished
Echo.
Echo Done! Double check files
Pause