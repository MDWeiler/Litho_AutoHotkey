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
    Special Paste Functions: SpecialPaste
        Dependancy:
            WinCheck Function
		Usage:
    		Special_Paste(strClipboard, strEOL, boolSkipBlanks, boolUsePasteFunction){
                strClipboard - The Text to be psated
                strEOL - The End Of Line sequence to used used at the end of each line in StrClipboard
                    The String will be sent using SEND so any SEND acceptable string is allowed
                boolSkipBlanks - Should blank lines in strClipboard be skipped
                    False - If the line is Blank then just the strEOL will be sent
                    True - If the line is Blank then nothing is sent
                boolUsePasteFunction - Should the line text be SENT or Pasted
                    True - The Clipboard is assigned the line text then pasted with Shift-Insert
                    False - SEND is used to type the line text
                    In either case the strEOL is always typed using SEND

    	Testing Notes
            - boolTestingThisFunction - With this set to true a set of message boxes will display some basic status informtion
            - There is also a commented out HotString that can be used for testing different EOL sequences
  ******************************************************************************************************************************
*/
Special_Paste(strClipboard, strEOL, boolSkipBlanks:=False, boolUsePasteFunction:=False){
	
	; Wait for Crtl and V to be released
	KeyWait Control
	KeyWait V
	
	boolTestingThisFunction := False
	dblClipboardWaitSleepTime := 400
	
	; Get Current Window Values
	objCurrentWindow := WinCheck("GetInfo")	
	
	If boolTestingThisFunction {
		msgBox % "00 strClipboard:`n" . strClipboard
		msgBox % "strEOL: " . strEOL . "`nboolSkipBlanks: " . boolSkipBlanks . "`nboolUsePasteFunction: " . boolUsePasteFunction
		WinCheck("Switch", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
	} ; End if
	
	; Send each line
	boolFirstLine := True
	Loop PARSE , strClipboard, `n, `r	; Split on NewLine and Ignore Carriage Return 
	{ ; Begin Loop
		; If desired skip blank lines
		strLine := StrReplace(A_LoopField, "`n")
		If (strLen(strLine) > 0 or Not(boolSkipBlanks)) {
			
			if not(boolFirstLine) {
				SendEvent %strEOL%
			} else {
				boolFirstLine := False
			} ; End if
			
			If (boolUsePasteFunction) {
                ; Use PasteFunction
				clipboard := strLine
				Sleep dblClipboardWaitSleepTime
				WinCheck("Switch", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
				SendEvent +{Insert}
				Sleep dblClipboardWaitSleepTime
			} else {
				; SendEvent {raw}%strLine%   ;SendEvent used bacuse SendInput does not work on some remote terminals
				; Break up the line into words
				boolFirstWord := True
				loop PARSE, strLine, %A_Space%
				{ ; Begin Loop
					WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
					if boolFirstWord {
						SendEvent {raw}%A_LoopField%
						boolFirstWord := False
					} else {
						SendEvent {raw}%A_Space%%A_LoopField%
					} ; End if
				} ; End loop
			} ; End If
		} ; End if
	} ; End Parse Loop
	
} ; End Special Paste Function

; Hotstring usually for testing different EOL sequences
/* 
    :*:\\SpPST::
        strEOL = {tab}{Sleep 20}
        Special_Paste(clipboard,strEOL,True)
    return
*/