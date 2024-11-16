Echo Off
REM **********************************************************
REM *                                                        *
REM * Create a Snapshot of the current Script Files          *
REM *    This creates a backup of ALL of the LithoAHK files  *
REM *      including the Personal Scripts and Archive which  *
REM *      are not included in the Git repository            *
REM *                                                        *
REM *   LithoAHK Snapshot                                    *
REM *   xCopy has a String Limit of 254 chaaracters          *
REM *     "insufficient memory" error is generated when      *
REM *        the path plus filename is too long              *
REM *   The final snapshot path is very long to begin with   *
REM *     To get around this issue the files are first       *
REM *     xCopied to a Temp folder then the Temp folder is   *
REM *     Moved to the Snapshot directory                    *
REM **********************************************************

REM Some Variables
REM %date% is YYYY-MM-DD and %time% is HH:MM:SS.ss
Set SnapshotFolder=C:\temp\LithoAHK\SnapShots\LithoAHK_%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%
Set FinalSnapshotFolder=Snapshot

REM Copy the files to the Snapshot folder
xCopy /V/C/R/K/Y "*.ahk" "%SnapshotFolder%\*"
xCopy /V/C/R/K/Y "*.bat" "%SnapshotFolder%\*"
xCopy /V/C/R/K/Y "*.md"  "%SnapshotFolder%\*"
xCopy /V/C/R/K/Y/S "LithoAHK Shared Scripts"   "%SnapshotFolder%\LithoAHK Shared Scripts\*"
xCopy /V/C/R/K/Y/S "LithoAHK Personal Scripts" "%SnapshotFolder%\LithoAHK Personal Scripts\*"

REM Move Snapshot Directory
Echo On
Move "%SnapshotFolder%" "%FinalSnapshotFolder%"

REM Finished
Echo.
Echo Done! Double check files
Pause