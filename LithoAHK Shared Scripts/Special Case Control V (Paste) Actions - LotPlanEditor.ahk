#SingleInstance force ; Automatically replace any instance of this script already running
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input ; Recommended for new scripts due to its superior speed and reliability
; SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory -- This is not helpful when loading from a Shared Location
#IfWinActive ; Used to prevent any of the following
;    scripts from being window specific due to previous code
; #Warn                      ; Enable to see warnings to help detect common errors

/*
    Auto Correction Syntax (Called Hotstrings in the manual)
      :[Options]:[What You Type]::[What to Replace it with]
	  Options: (common)
		* - Removes the need for an end character before the HotSting fires
		b0 - prevents the backspacing that clears the HotString
        ? - Allow within word replacements (:*?:al::line would replace the al in cal with line resulting in cline)
      Special Characters need to be wrapped in {} to use normally Example: Hello World{!}
        ! - Alt Key
        + - Shift Key
        ^ - Ctrl
        # - Window Key
        { and } - Escape braces
       Extra Special Characters when using Transform
       % needs to be escaped with `` --> ``%
        ` needs to be double escaped --> ````
*/

/*
      Special Case Control-V (Paste) Actions - For Lot Plan Editor
      ------------------------------------------------
        Modify how Control-V pastes based on the active window (program)

        !! This Script CANNOT stand alone !!
            It depends on the Special_Paste function
        !! This Script CANNOT stand alone !!

*/

;---------------------------------------------------------------
;   Lot Plan Editor - Add SIF window
;      Primarily to convert OneNote images to plan text
;      Useful when adding Copy/Pasting SIF instructions from OneNote
;---------------------------------------------------------------
;   Lot Plan Editor - Add SIF - Paste Clipboard without formating
#IfWinActive Add SIF
  ^v::Special_Paste(clipboard, "{Enter}", False)			; Pasting into SIF fields -- remove any formating

;---------------------------------------------------------------
;   MES Lot Plan Editor - Add  Instructions window or
;   MES Lot Plan Editor - Edit Instructions window
;      Convert EOL to Ctrl-A for adding multiple INST steps
;---------------------------------------------------------------
#If WinActive("Add Instructions") || WinActive("Edit Instructions")
  ^v::Special_Paste(clipboard, "!A{Sleep 20}", True)		; Pasting in INSTs when using the MES Lot Plan Editor (Ctrl A)

;---------------------------------------------------------------
;   EMS Lot Plan Editor - [ Add ] Instruction Flag  (Remote) or
;   EMS Lot Plan Editor - [ Edit ] Instruction Flag  (Remote)
;      Convert EOL to {Enter}
;---------------------------------------------------------------
#If WinActive("[ Add ] Instruction Flag") || WinActive("[ Edit ] Instruction Flag")
  ; Use this when adding INSTs to the end of the list of steps
  ; By combining both Enter and Alt-A it now works for all situations
  ^v::Special_Paste(clipboard, "{Enter}!A{Sleep 20}", True)	; Pasting in INSTs when using the EMS Lot Plan Editor (Enter Ctrl A)

