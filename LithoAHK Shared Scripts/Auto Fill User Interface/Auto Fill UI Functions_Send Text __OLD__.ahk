SendText(strSIFeditor, strText, strEOL:="") {

	/*
		Escape the following symbools:
		! - Alt Key
		+ - Shift Key
		^ - Ctrl
		# - Window Key
		This needs to be done again after the Transform function
	*/
	strText := StrReplace(strText,"!","{!}")
	strText := StrReplace(strText,"+","{+}")
	strText := StrReplace(strText,"^","{^}")
	strText := StrReplace(strText,"#","{#}")
	; Use SendEvent sending the line of text instead of SendInput
	; 	SendInput sends the text to the Keyboard buffer then goes to the next line before all of the keys have been typed
	;
	if (strSIFeditor == "Notepad") {
		Transform strText, Deref, %strText%
		strText := StrReplace(strText,"!","{!}")
		strText := StrReplace(strText,"+","{+}")
		strText := StrReplace(strText,"^","{^}")
		strText := StrReplace(strText,"#","{#}")
		SendEvent %strText%
		sleep 100
		SendInput %strEOL%
		sleep 100
	} else if (strSIFeditor == "EMS") {
		if (strText == "[BLANK]") {
			SendInput {end}+{home}{delete}
		} else if (strText == "[SKIP]") {
			sleep 100 ; Skip - Do nothing
		} else {
			Transform strText, Deref, %strText%
			strText := StrReplace(strText,"!","{!}")
			strText := StrReplace(strText,"+","{+}")
			strText := StrReplace(strText,"^","{^}")
			strText := StrReplace(strText,"#","{#}")
			SendEvent %strText%
			sleep 100
		} ; End If
		SendInput %strEOL%
		sleep 100
	} else if (strSIFeditor == "MES") {
		if (strText == "[BLANK]") {
			SendInput {end}+{home}{delete}
		} else if (strText == "[SKIP]") {
			sleep 100 ; Skip - Do nothing
		} else {
			Transform strText, Deref, %strText%
			strText := StrReplace(strText,"!","{!}")
			strText := StrReplace(strText,"+","{+}")
			strText := StrReplace(strText,"^","{^}")
			strText := StrReplace(strText,"#","{#}")
			SendEvent %strText%
			sleep 100
		} ; End If
		SendInput %strEOL%
		sleep 100
	} ; End If

} ; End Function
