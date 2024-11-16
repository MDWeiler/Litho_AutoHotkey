FillIn_Comment(pathTemplateFile:="Test.txt", boolJustView:=False) {    
	global
	
    ; msgbox strStringToParse: %strStringToParse%`npathTemplateFile: %pathTemplateFile%`nboolJustView: %boolJustView%
	
	if (boolJustView) {
		Run Notepad
		Sleep 500
		WinActivate Untitled - Notepad
		Sleep 500
		
		if (strStringSource = "Clipboard") {
			sendInput Using the Clipboard Contents:{enter}
		} else {
			sendInput Using the User Provided String:{enter}
		} ; End If
		ListPatternedVariables(boolSkipEmptyTerms:=TRUE, boolShowPatterns:=FALSE)
		sendInput {enter}
		
		sendInput {enter}Template File{enter}%pathTemplateFile%{enter}
		sendInput {enter}Auto Fill:{enter}
	} ; End If
	
	; Get Current Window Values
	local objCurrentWindow := WinCheck("GetInfo")	
	
     ; Set Spectial Tag Variables to Default Values
	local strEndOfLineSequence := "{enter}"
	local boolUsePaste := False
	local strEOLpause, strKeyPause, strMousePause, strSleepLength
	local msEOLpause := 0
	
     ; msgbox Read File: %pathTemplateFile%
	loop read, %pathTemplateFile% 
	{ ; Begin Loop
		
		; Check for Window Change - This is a catch all there will be another specificly for when send the actual data for real (not testing or viewing)
		WinCheck("Switch", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
		
          ; msgbox Line:`n%A_LoopReadLine%`nEOL seq is %strEndOfLineSequence%
          ; Is it a Special Tag?
		if (RegExMatch(A_LoopReadLine, "i)^\|\s*End of Line Sequence\s*\|\s*\K\S+", strNewEndOfLineSequence)) {
			if (strNewEndOfLineSequence == "") {
				; set to default
				strEndOfLineSequence := "{enter}"
			} else {
				strEndOfLineSequence := strNewEndOfLineSequence
			} ; End if
			if (boolJustView) {
				SendText("Notepad", "{raw}** End of Line Sequence Changed to:" . strEndOfLineSequence, "{enter}")
				; If just viewing then set back to Default
				strEndOfLineSequence := "{enter}"
			}
		} else if (RegExMatch(A_LoopReadLine, "i)^\|\s*Use Paste Function\s*\|\s*\K\S+", strPasteFunction)) {
			if (strPasteFunction == "True") {
				boolUsePaste := True
			} else {
				boolUsePaste := False
			} ; End if
			if (boolJustView) {
				SendText("Notepad","{raw}** Use Paste set to : " . boolUsePaste . " - But this option is not currently supported", "{enter}")
			}
			; *** Option not currently supported ***
			boolUsePaste := False
		} else if (RegExMatch(A_LoopReadLine, "i)^\|\s*EOL Pause\s*\|\s*\K\S+", strEOLpause)) {
			if strEOLpause is number
			{
				msEOLpause := strEOLpause
			} else {
				msEOLpause := 0
			} ; End if
			if (boolJustView) {
				SendText("Notepad","{raw}** EOL Pause set to : " . msEOLpause . "ms", "{enter}")
			}
		} else if (RegExMatch(A_LoopReadLine, "i)^\|\s*Key Pause\s*\|\s*\K\S+", strKeyPause)) {
			if strKeyPause is number
			{
				SetKeyDelay strKeyPause
				if (boolJustView) {
					SendText("Notepad","{raw}** Key Delay set to : " . strKeyPause . "ms", "{enter}")
				}
			} else {
				SetKeyDelay 10 	; AutoHotkey Default Value 10ms
				if (boolJustView) {
					SendText("Notepad","{raw}** Key Delay set to Default value", "{enter}")
				}
			} ; End if
		} else if (RegExMatch(A_LoopReadLine, "i)^\|\s*Mouse Pause\s*\|\s*\K\S+", strMousePause)) {
			if strMousePause is number
			{
				SetMouseDelay strMousePause
				if (boolJustView) {
					SendText("Notepad","{raw}** Mouse Delay set to : " . strMousePause . "ms", "{enter}")
				}
			} else {
				SetMouseDelay 0 	; AutoHotkey fast as possible
				if (boolJustView) {
					SendText("Notepad","{raw}** Mouse Delay set to Default value", "{enter}")
				}
			} ; End if
		} else if (RegExMatch(A_LoopReadLine, "i)^\|\s*(Pause|Sleep)\s*\|\s*\K\S+", strSleepLength)) {
			; Allow for pauses between lines
			sleep strSleepLength
		} else {
			RegExMatch(A_LoopReadLine, "^(\|\s*[\w ]+\s*\|\s*\K|[^\|]).+", strLineValue)
			if (strLineValue == "") {
				sleep 10
			} else if (strLineValue == "[BLANK]") {
				SendText("Notepad", "", strEndOfLineSequence)
			} else {
				RegExMatch(A_LoopReadLine, "^\|\s*[\w ]+\s*\|\s*", strPipedComment)
				; msgbox %A_LoopReadLine%`n%strPipedComment%`n%strLineValue
				if (boolJustView) {
					SendText("Notepad", strPipedComment . strLineValue, strEndOfLineSequence)
					; End of Line Pause
					if (msEOLpause > 0) {
						SendText("Notepad","{raw}Sleep  " . msEOLpause . "ms", "{enter}")
						Sleep msEOLpause
					} ; End if
				} else {
					; Check Window
					WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
					; Send Line and EOL sequence
					SendText("Notepad", strLineValue, strEndOfLineSequence)
					; End of Line Pause
					Sleep msEOLpause
				} ; End If
			} ; End if
		} ; End if
	} ; End Loop
	
	; Return Key and Mouse Delays to Default values
	SetKeyDelay 10 	; AutoHotkey Default Value 10ms
	SetMouseDelay 0 	; AutoHotkey - Fast as possible
	
	return
	
} ; End Function
