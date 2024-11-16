#SingleInstance force        ; Automatically replace any instance of this script already running
#NoEnv                       ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input               ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory -- This is not helpful when loading from a Shared Location
#IfWinActive                 ; Used to prevent any of the following
                             ;    scripts from being window specific due to previous code
; #Warn                      ; Enable to see warnings to help detect common errors

/*
      AutoHot Key Script for Filling In SIFs, Comments and Forms
      ----------------------------------------------------------
        \\SIF to launch - This will only run if in one of the SIF Add\Edit windows (else it will output to Notepad)
        \\CMT to launch - This will run in the window with the current focus
	
*/

:*?:\\SIF::	; Opens the Auto Fill UI for SIFs
    Auto_Fill_UI_Start("SIF")
return

:*?:\\CMT::	; Opens the Auto Fill UI for Comments (everything else)
    Auto_Fill_UI_Start("Comment")
return
