#SingleInstance force ; Automatically replace any instance of this script already running
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory
#IfWinActive ; Used to prevent any of the following
;    scripts from being window specific due to previous code
ListLines Off			 ; Minor performance improvement - Disable for debugging if necessary
; #Warn                      ; Enable to see warnings to help detect common errors

; LithoAHK Shared Setup Functions
LithoAHK_Shared_Setup_Functions() {
  CheckVersion() ; Version Control
  AddPatterns() ; Clipboard Parsing Patterns
  return
} ; end function

/*
    **                                                                                                         **
   **                                                                                                           **
  **************                                                                                     **************
******************   Remember that the INCLUDE path is relative to ===> LithoAHK's <=== position   ******************
**********                                                                                                 **********
  *******                                                                                                   *******
*/

; Function Includes
#Include LithoAHK Shared Scripts\Support Functions\DateParse.ahk
#Include LithoAHK Shared Scripts\Support Functions\GUI Centering.ahk
#Include LithoAHK Shared Scripts\Support Functions\Has Value.ahk
#Include LithoAHK Shared Scripts\Support Functions\Special Paste.ahk
#Include LithoAHK Shared Scripts\Support Functions\Version Control.ahk
#Include LithoAHK Shared Scripts\Support Functions\Windows Check.ahk
#Include LithoAHK Shared Scripts\Support Functions\TablePivot.ahk

; Clipboard Parsing
#Include LithoAHK Shared Scripts\Clipboard Parsing\Clipboard Parsing.ahk

; Auto Fill User Interface
#Include LithoAHK Shared Scripts\Auto Fill User Interface\Auto Fill User Interface.ahk

; Hotkey and HotString Includes
#Include LithoAHK Shared Scripts\Litho Email and Pagers.ahk

; HotString Index
#Include LithoAHK Shared Scripts\HotString Index\HotString Index.ahk

; The Litho CDSEM Tools script is skipped by the Index script because it has too many Hot Strings
; <IndexCmt>	<b>CDSEM Hot Strings:</b>
; <IndexCmt>	\\CDSEM -- Replaces with CDSEM's IP Address (For Example: \\CDK451 --> 10.8.167.104)
; <IndexCmt>	\\pwCDSEM -- Replaces with the password needed by tvnViewer to take control
; <IndexCmt>	OLE Names: 74CuOLE 74NCOLE 76OLE 78OLE
#Include LithoAHK Shared Scripts\Litho CDSEM Tools.ahk

; The Litho Scanners script is skipped by the Index script because it has too many Hot Strings
; <IndexCmt>	<br/><b>Scanner Hot Strings:</b>
; <IndexCmt>	\\S### will generate a popup with the Name of Scanner and Track (For Example Try \\S451)
#Include LithoAHK Shared Scripts\Litho Scanners.ahk

; Window Specific Hotkeys and HotString Includes
;       The following are Window Specific Includes and should be listed last to ensure
;           they do not accidently cause others to be window specific
#Include LithoAHK Shared Scripts\Special Case Control V (Paste) Actions - LotPlanEditor.ahk
#Include LithoAHK Shared Scripts\Special Case Control V (Paste) Actions - AM.ahk

; Group Specific HotStrings
#Include LithoAHK Shared Scripts\BE Dry 193 HotStrings.ahk

#IfWinActive ; Used to prevent any of the following
;    code from being window specific due to previous code

:*?:\\HUDz::/nfs/tapeout/disks/clt_na01/HUDZ_LAUNCH_SCRIPT_LATEST/hudz-cit.sh ; Terminal command to launch HUDz
:*X?:\\Pivot::Pivot_Function(clipboard)  ; Pivot a TSV table on the Clipboard