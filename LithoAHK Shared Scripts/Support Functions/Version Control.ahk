#SingleInstance force        ; Automatically replace any instance of this script already running
#NoEnv                       ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input               ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory
#IfWinActive                 ; Used to prevent any of the following
                             ;    scripts from being window specific due to previous code
ListLines Off			     ; Minor performance improvement - Disable for debugging if necessary
; #Warn                      ; Enable to see warnings to help detect common errors

/*
  ******************************************************************************************************************************
    Version Control Functions: CheckVersion and VersionCompare
		Usage:
    		CheckVersion()
				Add to List of Setup Functions

    	** Testing Sequences and Notes at the bottom **
  ******************************************************************************************************************************
*/

/*
  ******************************************************************************************************************************
	Check Version - Checks the version of the Local Script File with the Global version and updates if necessary  
    	(GLOBAL) cvModuleTestingLevel - Default is Zero (no testing)
       		1 - Fully functioning with Status Messages
        	2 - Fully functioning with all Testing messages
        	3 - Partially functioning with all Testing messages
        		Version will be checked, but no update will be made
                Additionally strGlobalScriptFolder will be miss spelled to test the timer - after 2 trys it will be corrected
    	cvModuleTestingLevel is a global because its value needs to be remembered from timer to timer
  ******************************************************************************************************************************
*/
CheckVersion() {

    ; Module Testing Level
   	global cvModuleTestingLevel := 0 ; 0 (No Testing) to 3 (Full testing)

	; The following are global so that the states are saved between checks
	global dblVersionCheckCounter := 0				; Number of times version hsa been checked
	global dblVersionCheckLimit := 5				; Max number of times version will be checked
	global msVersionCheckPeroid := -900000 			; Negitive values means that timer will only run once (900 000msec = 15min)
													;       We only want the timer to run once, it will be manually restarted if needed
	global strLocalScriptFolder := A_ScriptDir
	global strVersionScriptFile := "LithoAHK.ahk"	; Script file to check for Version
	global strLocalScriptVersion := "v?.?.?"		; Default Value until able to check - Global so that it can be used by Index
	global strGlobalScriptFolder := "\\VMSPFSFSEG14\D1C_global\AutoHotkey\LithoAHK Files"

	; Miss spell the location to test timer - it will be corrected on the third try
	if (cvModuleTestingLevel >= 3) {
		strGlobalScriptFolder := "\\VMSPFSFSEG14\D1G_global\AutoHotkey\LithoAHK Files"
		msVersionCheckPeroid := -10000 	; Negitive values means that timer will only run once (10 000msec = 10sec)
	} ; end if
	
	; Check the Status of the Global Drive - can it be reached?
	CheckDriveStatus:	; Timer return point
	if (cvModuleTestingLevel > 0) {
		Msgbox Module testing level is %cvModuleTestingLevel%`n    Press OK to Coninue and Check Drive Status
	} ; end if
	strDriveStatus := "None"
	DriveGet strDriveStatus, Status, %strGlobalScriptFolder%
	
	; Testing Message - Report Drive Status
	if (cvModuleTestingLevel > 0) {
		MsgBox strDriveStatus is %strDriveStatus% 
	} ; end if

	if not(strDriveStatus = "Ready") {
		dblVersionCheckCounter := dblVersionCheckCounter + 1
		if (dblVersionCheckCounter <= dblVersionCheckLimit) {
			SetTimer CheckDriveStatus, %msVersionCheckPeroid%	; Version Check Timer
			if (cvModuleTestingLevel > 0) {
				MsgBox Checking again in %msVersionCheckPeroid%ms`nVersion has been checked %dblVersionCheckCounter% times
			} ; end if
			if (cvModuleTestingLevel >= 3) {
				if (dblVersionCheckCounter = 2) {
					strGlobalScriptFolder := "\\VMSPFSFSEG14\D1C_global\AutoHotkey\LithoAHK Files" ; Corect Spelling - Used for testing
				} ; end if
			} ; end if
		} else {				
			; Done Checking
			if (cvModuleTestingLevel > 0) {
				MsgBox Version Check Limit (%dblVersionCheckLimit%) reached. Will stop checking.
			} ; end if
		} ; end if
	} else {
		strGlobalScriptVersion := "Unknown"
        strLocalScriptVersion  := "Unknown"

		if (cvModuleTestingLevel > 1) {
			MsgBox Global Script File Path is`n%strGlobalScriptFolder%\%strVersionScriptFile%
		} ; end if

		loop Read, %strGlobalScriptFolder%\%strVersionScriptFile%
		{ ; begin Read Loop - A_LoopReadLine
			if (RegExMatch(A_LoopReadLine, "i)Script\s*Version\s*=\s*\K[\S]+", strScriptVersion)) {
				strGlobalScriptVersion := strScriptVersion
				break ; Exit the Loop with Script Version
			} ; end if
		} ; end Read Loop

		if (cvModuleTestingLevel > 1) {
			MsgBox Local Script File Path is`n%strLocalScriptFolder%\%strVersionScriptFile%
		} ; end if

		loop Read, %strLocalScriptFolder%\%strVersionScriptFile%
		{ ; begin Read Loop - A_LoopReadLine
			if (RegExMatch(A_LoopReadLine, "i)Script\s*Version\s*=\s*\K[\S]+", strScriptVersion)) {
				strLocalScriptVersion := strScriptVersion
				break ; Exit the Loop with Script Version
			} ; end if
		} ; end Read Loop

		if (cvModuleTestingLevel > 0) {
			MsgBox % "Global_Ver= >" . strGlobalScriptVersion . "< and Local_Ver= >" . strLocalScriptVersion . "<`nVersionCompare(" . strGlobalScriptVersion . "," . strLocalScriptVersion . ") == " . (VersionCompare(strGlobalScriptVersion, strLocalScriptVersion)) . "`n  0 means versions are Equal`n  1 means Global > Local / -1 means Global < Local"
		} ; end if
		
		if (VersionCompare(strGlobalScriptVersion, strLocalScriptVersion)) == 0 {
			; Using the current version - No update needed
			if (cvModuleTestingLevel > 0) {
				MsgBox All up to date! (v%strLocalScriptVersion%)
			} ; end if
		} else if (VersionCompare(strGlobalScriptVersion, strLocalScriptVersion) == -1) {
			; Using a newer version
			MsgBox Your LithoAHK version (v%strLocalScriptVersion%) is newer than the Global version (v%strGlobalScriptVersion%)
		} else {
			; Update
			if (cvModuleTestingLevel > 0) {
				MsgBox You need to update!`nv%strLocalScriptVersion% to v%strGlobalScriptVersion%
			} ; end if
            UpdateBatchFileFullPath := "\\VMSPFSFSEG14\D1C_global\AutoHotkey\LithoAHK Files\LithoAHK Shared Scripts\Support Functions\LithoAHK Update.bat"
			if (cvModuleTestingLevel < 3) {
				Run %UpdateBatchFileFullPath% "v%strLocalScriptVersion% to v%strGlobalScriptVersion%", , Hide
				Sleep 30000  ; Wait 30 seconds before reloading to give the batch file time to finish
				Reload
			} ; end if
		} ; end if
	} ; end if
	return
} ; End Function

/*
  ******************************************************************************************************************************
    Version Compare - Used to compare two version numbers that are in the standard dot format to determine which is greater
    	Returns  1 if Ver1 > Ver2   - Example: 2.0 > 1.9.A
    	Returns -1 if Ver1 < Ver2   - Example: 2.1 < 2.1A
    	Returns  0 if Ver1 = Ver2   - Example: 3.0 = 3
    	vcModuleTesting - Default is False (no testing)
    		True - Fully functioning with Testing messages
  ******************************************************************************************************************************
*/
VersionCompare(strVersion1, strVersion2) {
	
	; Local Number Values and String position
    local dblVersion1, dblVersion2
    posVersion1 := 1
    posVersion2 := 1

	; Module Testing (True\False)
	vcModuleTesting := False
    
    ; Ordered list of version sequence (Zero and any character not listed is Zero)
    versionNumbers := "123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    ; Start at Zero (both versions are equal)
    CompareResult := 0

    ; Convert to UpperCase
    StringUpper strVersion1, strVersion1
    StringUpper strVersion2, strVersion2

	if (vcModuleTesting) {
		MsgBox strVersion1 = >%strVersion1%<`nstrVersion2 = >%strVersion2%<
	} ; end if
    
    ; Loop until both strings are processed or one version is no longer equal
    while ((posVersion1 <= StrLen(strVersion1) or posVersion2 <= StrLen(strVersion2)) and CompareResult == 0)
    { ; begin loop
        ; Start at Zero and add the value of the character
        dblVersion1 = 0

		; During testing clear the Version Step string
		if (vcModuleTesting) {
			strVersionStep1 := ""
			strVersionStep2 := ""
		} ; end if

        while posVersion1 <= StrLen(strVersion1) and Not(SubStr(strVersion1, posVersion1, 1) = ".")
        { ; begin loop
            dblVersion1 := (dblVersion1 * StrLen(versionNumbers)) + InStr(versionNumbers, SubStr(strVersion1, posVersion1, 1))
			if (vcModuleTesting) {
				strVersionStep1 := strVersionStep1 . SubStr(strVersion1, posVersion1, 1)
			} ; end if
            posVersion1 := posVersion1 + 1
        } ; end loop

        ; Start at Zero and add the value of the character
        dblVersion2 = 0
        while posVersion2 <= StrLen(strVersion2) and Not(SubStr(strVersion2, posVersion2, 1) = ".")
        { ; begin loop
            dblVersion2 := (dblVersion2 * StrLen(versionNumbers)) + InStr(versionNumbers, SubStr(strVersion2, posVersion2, 1))
			if (vcModuleTesting) {
				strVersionStep2 := strVersionStep2 . SubStr(strVersion2, posVersion2, 1)
			} ; end if
            posVersion2 := posVersion2 + 1
        } ; end loop
    
		if (vcModuleTesting) {
			MsgBox strVersionStep1 = >%strVersionStep1%< ==> dblVersion1 = %dblVersion1%`nstrVersionStep2 = >%strVersionStep2%< ==> dblVersion2 = %dblVersion2%
		} ; end if
    
        ; Compare the two values
        if (dblVersion1 > dblVersion2) {
            CompareResult := 1
        } else if (dblVersion1 < dblVersion2) {
            CompareResult := -1
        } else {
            ; Move past the "."
            posVersion1 := posVersion1 + 1
            posVersion2 := posVersion2 + 1
        } ; end if

		if (vcModuleTesting) {
			MsgBox % "1=True 0=False`nLoop Continues when`n  posVer1 (" . posVersion1 . ") <= StrLen(strVer1) (" . StrLen(strVersion1) . ") is " . (posVersion1 <= StrLen(strVersion1)) . "`n   OR`n  posVer2 (" . posVersion2 . ") <= StrLen(strVer2) (" . StrLen(strVersion2) . ") is " . (posVersion2 <= StrLen(strVersion2)) . "`nAND`nCompareResult (" . CompareResult . ") == 0 is " . (CompareResult == 0)
		} ; end if
            
    } ; end loop
    
    return CompareResult
} ; end function

/*
  ******************************************************************************************************************************
	Testing Notes and Sequences:

	Check Version uses timers, for testing this means that if running Version Control.ahk seperatly the script needs a reason 
    	to remain running while the timer counts. The easiest was to accomplish this is to uncomment the following HotString and 
    	use it for launching CheckVersion also..
    	** If Testing by running Version Control.ahk you will need to update strLocalScriptFolder to **
    		global strLocalScriptFolder := "..\.." -- Up two levels (i have tried up one level ".." but not two yet)
   	Update cvModuleTestingLevel in CheckVersion to the neceesary Testing Level
  ******************************************************************************************************************************
*/
; ScrollLock & 1::CheckVersion() ; ScrollLock and 1 to launch CheckVersion
   
/*
  ******************************************************************************************************************************
	Version Comparison Testing Sequences
    	To see testing messages update vcModuleTesting to True (This is not necessary to just run TestVersionCompare)
    	The following sequences run VersionCompare directly and do not use the CheckVersion function,
        	so it does not need to be in testing.
  ******************************************************************************************************************************
*/
; ScrollLock & 2::TestVersionCompare() ; ScrollLock and 2 to launch Version Compare testing
/*
	TestVersionCompare() {
		v1 := "1.0"
		v2 := "2.0"
		MsgBox % v1 . " and " . v2 . " result (-1) " . VersionCompare(v1,v2)
		
		v1 := "2.0"
		v2 := "1.0"
		MsgBox % v1 . " and " . v2 . " result (1) " . VersionCompare(v1,v2)
		
		v1 := "1.9"
		v2 := "1.9A"
		MsgBox % v1 . " and " . v2 . " result (-1) " . VersionCompare(v1,v2)

		v1 := "2"
		v2 := "2.0"
		MsgBox % v1 . " and " . v2 . " result (0) " . VersionCompare(v1,v2)
		
		v1 := "2.1.5"
		v2 := "2.2.4"
		MsgBox % v1 . " and " . v2 . " result (-1) " . VersionCompare(v1,v2)
	} ; end function
*/