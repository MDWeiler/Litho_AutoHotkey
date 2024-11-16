#SingleInstance force        ; Automatically replace any instance of this script already running
#NoEnv                       ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input               ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory
#IfWinActive                 ; Used to prevent any of the following
                             ;    scripts from being window specific due to previous code
; #Warn                      ; Enable to see warnings to help detect common errors

/*
  ******************************************************************************************************************************
    Include statements for any personal AutoHotkey scripts
  ******************************************************************************************************************************
    
    **                                                                                     **
    **    Remember that the File Path for the Include can be either absolute or relative   **
    **      When relative is has to relative to the position of LithoAHK.ahk               **
    **                                                                                     **

    Examples:
      1) Absolute File Path
        Your File: C:\Users\LayerET\OneDrive - Intel Corporation\Documents\AutoHotkey\Cool AutoHotkey Script.ahk
        The Include line:
          #Include C:\Users\LayerET\OneDrive - Intel Corporation\Documents\AutoHotkey\Cool AutoHotkey Script.ahk
      2) Relative File Path
        Your File is the "LithoAHK Personal Scripts" folder and it is called "Cool AutoHotkey Script.ahk"
          ** The "LithoAHK Personal Scripts" folder is the same folder that this (LithoAHK Personal Scripts.ahk) file is in
        The Inclue line:
          #Include LithoAHK Personal Scripts\Cool AutoHotkey Script.ahk

*/
; #Include LithoAHK Personal Scripts\Cool AutoHotkey Script.ahk

; Window Specific Includes
; #Include LithoAHK Personal Scripts\Window Specific AutoHotkey Script.ahk

#IfWinActive                 ; Used to prevent any of the following
                             ;    code from being window specific due to previous code

/*
  Personal Setup Functions
    Some Scripts require setting up before they can be used, if your does you can list the setup function call within
      LithoAHK_Personal_Setup_Functions and it will be called with LithoAHK is loaded.
*/
LithoAHK_Personal_Setup_Functions(){
  ; None Currently
  return
} ; end function

/*
          Personal List of HotStrings    
      -----------------------------------
            To you get you started
*/

:*?:\\+-::±        ; Plus/Minus
:*?:\\um::µm       ; Micrometer
:*?:\\deg::°       ; Degree
:*?:\\cb::[_]      ; Plain text Check Box [_]
:*?:\\sigma::σ     ; Lowercase sigma
:*?:\\ck::✔       ; Checkmark

/*
    HotString Syntax (also see AutoHotkey manual page https://www.autohotkey.com/docs/Hotstrings.htm)
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

:X*?:\\Admin::Special_Paste(clipboard, "{Down}", True)  ; Pasting in AM - Admin Functions -- Use Down Arrow between lines

