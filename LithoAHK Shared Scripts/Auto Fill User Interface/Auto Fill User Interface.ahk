#SingleInstance force        ; Automatically replace any instance of this script already running
#NoEnv                       ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input               ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory
#IfWinActive                 ; Used to prevent any of the following
                             ;    scripts from being window specific due to previous code
ListLines Off			     ; Minor performance improvement - Disable for debugging if necessary
; #Warn                      ; Enable to see warnings to help detect common errors

; Function Includes - Remember they are relative to LithoAHK's position
#Include LithoAHK Shared Scripts\Auto Fill User Interface\Auto Fill UI Functions_Auto Fill UI Start.ahk
#Include LithoAHK Shared Scripts\Auto Fill User Interface\Auto Fill UI Functions_Auto Fill UI.ahk
#Include LithoAHK Shared Scripts\Auto Fill User Interface\Auto Fill UI Functions_FillIn Comment.ahk
#Include LithoAHK Shared Scripts\Auto Fill User Interface\Auto Fill UI Functions_FillIn SIF.ahk
#Include LithoAHK Shared Scripts\Auto Fill User Interface\Auto Fill UI Functions_Send Text.ahk
#Include LithoAHK Shared Scripts\Auto Fill User Interface\Auto Fill UI Functions_Test Toggle Check Box Control.ahk

; HotString Includes - Remember they are relatice to Litho AHK's position
#Include LithoAHK Shared Scripts\Auto Fill User Interface\Auto Fill UI HotStrings.ahk
