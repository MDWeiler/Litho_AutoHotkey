#SingleInstance force        ; Automatically replace any instance of this script already running
#NoEnv                       ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input               ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory -- This is not helpful when loading from a Shared Location
#IfWinActive                 ; Used to prevent any of the following
                             ;    scripts from being window specific due to previous code
; #Warn                      ; Enable to see warnings to help detect common errors

/*

	The goal is to produce and open an HTML page that lists all of the HotStrings and Patterns available
        Dependancy: Has Value function

*/

#Z::ParseAutoHotkey() ; Generate and Open an HTML page listing LithoAHK's HotStrings and Patterns

; Function Includes
#Include LithoAHK Shared Scripts\HotString Index\HotString Index Functions_Generate HTML File.ahk
#Include LithoAHK Shared Scripts\HotString Index\HotString Index Functions_HTML List Of Patterns.ahk
#Include LithoAHK Shared Scripts\HotString Index\HotString Index Functions_Parse AutoHotkey.ahk
#Include LithoAHK Shared Scripts\HotString Index\HotString Index Functions_Parse_File.ahk
