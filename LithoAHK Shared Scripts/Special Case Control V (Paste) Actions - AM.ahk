#SingleInstance force        ; Automatically replace any instance of this script already running
#NoEnv                       ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input               ; Recommended for new scripts due to its superior speed and reliability
; SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory -- This is not helpful when loading from a Shared Location
#IfWinActive                 ; Used to prevent any of the following
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
      Special Case Control-V (Paste) Actions - AM
      --------------------------------------------------
        Modify how Control-V pastes based on the active window (program)
        
        !! This Script CANNOT stand alone !!
            It depends on the Special_Paste function
        !! This Script CANNOT stand alone !!

*/

;---------------------------------------------------------------
;   AM - Admin Function
;      Replace End-Of-Line characters with Down Arrow
;---------------------------------------------------------------
:X*?:\\Admin::Special_Paste(clipboard, "{Down}")			; Pasting in AM - Admin Functions -- Use Down Arrow between lines -- This one if for AGS-RDP
#IfWinActive Admin Function - D1D.Lithography.
^v::Special_Paste(clipboard, "{Down}", True)			    ; Pasting in AM - Admin Functions -- Use Down Arrow between lines

;---------------------------------------------------------------
;   AM - Pasiting in Filters for a Table
;      Replace End-Of-Line characters with a Tab
;---------------------------------------------------------------
#IfWinActive AMUI -D1D.Lithography.
^v::Special_Paste(clipboard, "{Tab}", False) 		; Pasting in AM - Table Filters -- Use Tab between lines

;---------------------------------------------------------------
;   AM - LCA's CA Table Filters
;      Replace End-Of-Line characters with Tab 
;         and a sequence to clear the next field
;---------------------------------------------------------------
#IfWinActive Select filter for CA
^v::Special_Paste(clipboard, "{tab}{end}{shift down}{home}{shift up}{delete}", False)	; Pasting in LCA CA form -- Use Tab between lines and clear the field
