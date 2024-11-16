#SingleInstance force       ; Automatically replace any instance of this script already running
#NoEnv                      ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input              ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory
#IfWinActive                ; Used to prevent any of the following
;    scripts from being window specific due to previous code
ListLines Off               ; Minor performance improvement - Disable for debugging if necessary
; #Warn                     ; Enable to see warnings to help detect common errors
#Persistent	                ; Keep LithoAHK running - Needed during early development where there are no HotKeys or HotStrings

; *******************************************************************
; **                                                               **
; **  Do NOT place any Hot Strings above the Auto Fill UI Include  **
; **     For some reason it prevents the pattern variables from    **
; **         being global                                          **
; **                                                               **
; *******************************************************************

; Script Version = 3.1.9  -- DO NOT CHANGE this line is used for Version Management

; Setup Function - Called before any Includes that have HotKeys or HotStrings
LithoAHK_Shared_Setup_Functions()
LithoAHK_Personal_Setup_Functions()

; Includes - Remember they are relative to LithoAHK's position
#Include LithoAHK Shared Scripts\LithoAHK Shared Scripts.ahk
#Include LithoAHK Personal Scripts\LithoAHK Personal Scripts.ahk
