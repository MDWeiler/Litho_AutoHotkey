' **********************************************************************************************
' *                                                                                            *
' * Launcher for Litho AutoHotkey Scripts                                                      *
' *                                                                                            *
' *   Usage:                                                                                   *
' *     -- Placed in the Users Windows Startup folder:                                         *
' *              %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup   *
' *          C:\Users\[UserID]\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup   *
' *     It will execute Windows starts                                                         *
' *                                                                                            *
' **********************************************************************************************

' Local Variables
Dim objShell
Dim pathOneDrive
Dim pathLithoAHK

' Read Windows environment Variable: 
'   OneDrive - OneDrive path
Set objShell = CreateObject("WScript.Shell")
pathOneDrive = objShell.ExpandEnvironmentStrings("%OneDrive%")
Set objShell = Nothing

' Build path to LithoAHK
pathLithoAHK = pathOneDrive & "\Documents\AutoHotkey\LithoAHK\" ' Default location
' pathLithoAHK = pathOneDrive & "\Documents\Work Documents\Programming Projects\AutoHotkey\D1_LTDM_Litho_AutoHotkey" ' Repository location

' Launch LithoAHK
Set objShell = CreateObject("Shell.Application")
objShell.ShellExecute "LithoAHK.ahk", , pathLithoAHK
Set objShell = Nothing