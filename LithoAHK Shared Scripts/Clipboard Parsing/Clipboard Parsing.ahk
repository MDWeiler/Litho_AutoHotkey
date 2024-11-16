#SingleInstance force        ; Automatically replace any instance of this script already running
#NoEnv                       ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input               ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory
#IfWinActive                 ; Used to prevent any of the following
                             ;    scripts from being window specific due to previous code
ListLines Off			     ; Minor performance improvement - Disable for debugging if necessary
; #Warn                      ; Enable to see warnings to help detect common errors

; Function Includes - Remember they are relative to LithoAHK's position
#Include LithoAHK Shared Scripts\Clipboard Parsing\Clipboard Parsing Functions_Add Pattern.ahk
#Include LithoAHK Shared Scripts\Clipboard Parsing\Clipboard Parsing Functions_Beyond Compare Paste.ahk
#Include LithoAHK Shared Scripts\Clipboard Parsing\Clipboard Parsing Functions_Camel Case Product.ahk
#Include LithoAHK Shared Scripts\Clipboard Parsing\Clipboard Parsing Functions_List Patterned Variables.ahk
#Include LithoAHK Shared Scripts\Clipboard Parsing\Clipboard Parsing Functions_Parse Clipboard With Filters.ahk
#Include LithoAHK Shared Scripts\Clipboard Parsing\Clipboard Parsing Functions_Parse Clipboard.ahk
#Include LithoAHK Shared Scripts\Clipboard Parsing\Clipboard Parsing Functions_Parse List of Values.ahk
#Include LithoAHK Shared Scripts\Clipboard Parsing\Clipboard Parsing Functions_Parse Seperated Values.ahk
#Include LithoAHK Shared Scripts\Clipboard Parsing\Clipboard Parsing Functions_Type String.ahk

; Pattern and HotString Includes - Remember they are relatice to Litho AHK's position
#Include LithoAHK Shared Scripts\Clipboard Parsing\Clipboard Parsing Patterns.ahk
#Include LithoAHK Shared Scripts\Clipboard Parsing\Clipboard Parsing HotStrings.ahk
