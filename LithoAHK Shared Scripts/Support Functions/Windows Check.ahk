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
    Windows Check Function: WinCheck
        Dependancy:
            None
		Usage:
    		WinCheck(WinCheckAction, hexHWND, strTitle, xSize, ySize)
                Possible WinCheckActions
                    Stop    - If window does not match then Exit Script
                    Error   - If window does not match then return "Error" -- Calling Script can determine follow up
                    Switch  - If window does not match then function will attempt to Activate otherwise Exit Script
                    Test    - If window does not match then function will display current Window values and Input values AND return "MisMatch"
                    GetInfo - Returns the Active Window HWND, Title and Size
                hexHWNDm, hexHWND, strTitle and x/ySize are used to determine if the current has changed

    	Testing Notes
            Built in action and commented out messages
  ******************************************************************************************************************************
*/
WinCheck(WinCheckAction:="GetInfo", hexHWND:=00, strTitle:="A", xSize:=0, ySize:=0){
	
	; Possible WinCheckActions
	;	Stop    - If window does not match then Exit Script
	;	Error   - If window does not match then return "Error" -- Calling Script can determine follow up
	;	Switch  - If window does not match then function will attempt to Activate otherwise Exit Script
	;   Test    - If window does not match then function will display current Window values and Input values AND return "MisMatch"
	;   GetInfo - Returns the Active Window HWND, Title and Size
	;
	; Work Pace Break Window
	;	Title	FRBWarn or FRBTaking
	;
	; Work Pace Micro Pause Window
	;	Title	FMPWarn or FMPTaking
	;
	
	; Get the Current Window's Values
	WinGet hexCurrentHWND, ID, A
	WinGetActiveTitle strCurrentTitle
	WinGetPos CurrentPosX, CurrentPosY, CurrentSizeX, CurrentSizeY, A
	
	if (WinCheckAction = "GetInfo") {
		objReturnValues := {HWND: hexCurrentHWND, Title: strCurrentTitle, X: CurrentSizeX, Y: CurrentSizeY}
		; MsgBox % objReturnValues.HWND . "`n" . objReturnValues.Title . "`n" . objReturnValues.X . ", " . objReturnValues.Y
		return objReturnValues.Clone()
	} ; end if
	
	; Work Pace Micro Pause
	while (WinExist("FMPTaking")) or (WinExist("FMPWarn")) {
		; Work Pace Micro Pause
		Sleep 1000 ; Wait 1 second then check again
		; Update Current Values
		WinGet hexCurrentHWND, ID, A
		WinGetActiveTitle strCurrentTitle
		WinGetPos CurrentPosX, CurrentPosY, CurrentSizeX, CurrentSizeY, A
	} ; End loop
	
	; Work Pace Breaks
	while (WinExist("FRBTaking")) or (WinExist("FRBWarn")) {
		; Work Pace Break
		Sleep 1000 ; Wait 1 second then check again
		; Update Current Values
		WinGet hexCurrentHWND, ID, A
		WinGetActiveTitle strCurrentTitle
		WinGetPos CurrentPosX, CurrentPosY, CurrentSizeX, CurrentSizeY, A
	} ; End loop
	
	; Full Match HWND, Title and Size
	; if (hexCurrentHWND = hexHWND) and (strCurrentTitle = strTitle) and (CurrentSizeX = xSize) and (CurrentSizeY = ySize) {
	; Just HWND Match
	; if (hexCurrentHWND = hexHWND) {
	; HWND and Size Match
	if (hexCurrentHWND = hexHWND) and (CurrentSizeX = xSize) and (CurrentSizeY = ySize) {
		return "Match"
	} else {
		if (WinCheckAction = "Test") {
			MsgBox % "Current HWND: " . hexCurrentHWND . "`n  Input  HWND: " . hexHWND . "`nCurrent Title: " . strCurrentTitle . "`n  Input  Title: " . strTitle . "`nCurrent Size: " . CurrentSizeX . "," . CurrentSizeY . "`n  Input  Size: " . xSize . "," . ySize
			return "MisMatch"
		} else if (WinCheckAction = "Stop") {
			MsgBox 4112, % "AutoHotkey WinCheck Error", % "The Window being used by AutoHotkey lost focus!`nThe AutoHotkey script will have to stop.`n`n  Window Title: (" . xSize . "," . ySize . ")`n  " . strTitle . "`n`n  Focus taken by Window Title: (" . CurrentSizeX . "," . CurrentSizeY . ")`n  " . strCurrentTitle, 15
			Exit 1
		} else if (WinCheckAction = "Error") {
			return "Error"
		} else if (WinCheckAction = "Switch") {
			boolTryToSwitch := True
			intSwitchCount := 1
			while (boolTryToSwitch and intSwitchCount <=5) {
				WinActivate ahk_id %hexHWND%
				Sleep 500 ; Give Windows a change to switch
				strWinCheckReturn := WinCheck("Error", hexHWND, strTitle, xSize, ySize)
				boolTryToSwitch := strWinCheckReturn = "Error"
				intSwitchCount += 1
			} ; End Loop
			if (strWinCheckReturn = "Error") {
				MsgBox 4112, % "AutoHotkey WinCheck Error", % "The Window being used by AutoHotkey lost focus and could not switch back!`nThe AutoHotkey script will have to stop.`n`n  Window Title:`n  " . strTitle, 15
				Exit 1
			} else {
				return strWinCheckReturn
			} ; end if
		} else {
			; Error unknown Action
			msgbox Unknown Action: ->%WinCheckAction%<-
			return "Error"
		} ; End if
	} ; End if
	
} ; End Function
