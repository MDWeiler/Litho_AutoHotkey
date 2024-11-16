#SingleInstance force        ; Automatically replace any instance of this script already running
#NoEnv                       ; Recommended for performance and compatibility with future AutoHotkey releases
ListLines Off			     ; Minor performance improvement - Disable for debugging if necessary
; #Warn                      ; Enable to see warnings to help detect common errors

/* 
	Show GUI at center of the current screen - multiple monitors
	By: AutoHotKey Board User - DigiDon
	Link: https://www.autohotkey.com/boards/viewtopic.php?t=31716
	
	To make your GUI showing at center of the current screen i.e. make your script working great with multiple monitors
		Include the following Functions:
			GetCurrentMonitorIndex
			CoordXCenterScreen
		 	CoordYCenterScreen
			GetClientSize

		When you create your GUI, instead of putting the usual "Gui, Show", put : (provided the GUI was made default)	

			;---------GET CENTER OF CURRENT MONITOR---------
				;get current monitor index
				CurrentMonitorIndex:=GetCurrentMonitorIndex()
				;get Hwnd of current GUI
				DetectHiddenWindows On
				Gui, +LastFound
				Gui, Show, Hide
				GUI_Hwnd := WinExist()
				;Calculate size of GUI
				GetClientSize(GUI_Hwnd,GUI_Width,GUI_Height)
				DetectHiddenWindows Off
				;Calculate where the GUI should be positioned
				GUI_X:=CoordXCenterScreen(GUI_Width,CurrentMonitorIndex)
				GUI_Y:=CoordYCenterScreen(GUI_Height,CurrentMonitorIndex)
			;------- / GET CENTER OF CURRENT MONITOR--------- 
			;SHOW GUI AT CENTER OF CURRENT SCREEN
				Gui, Show, % "x" GUI_X " y" GUI_Y, GUI TITLE

		You can adapt this part if you already created the GUI and just want to show it again.
			In this case provided you have the GUI Hwnd (or number) in GUI_Hwnd, you can just use:

			;---------GET CENTER OF CURRENT MONITOR---------
				;get current monitor index
				CurrentMonitorIndex:=GetCurrentMonitorIndex()
				;Calculate size of GUI
				Gui, %GUI_Hwnd%: Show, Hide
				GetClientSize(GUI_Hwnd,GUI_Width,GUI_Height)
				;Calculate where the GUI should be positioned
				GUI_X:=CoordXCenterScreen(GUI_Width,CurrentMonitorIndex)
				GUI_Y:=CoordYCenterScreen(GUI_Height,CurrentMonitorIndex)
			;------- / GET CENTER OF CURRENT MONITOR--------- 
			;SHOW GUI AT CENTER OF CURRENT SCREEN
				Gui, %GUI_Hwnd%: Show, % "x" GUI_X " y" GUI_Y, GUI TITLE
*/				

GetCurrentMonitorIndex(){
	CoordMode, Mouse, Screen
	MouseGetPos, mx, my
	SysGet, monitorsCount, 80
	
	Loop %monitorsCount%{
		SysGet, monitor, Monitor, %A_Index%
		if (monitorLeft <= mx && mx <= monitorRight && monitorTop <= my && my <= monitorBottom){
			Return A_Index
		}
	}
	Return 1
}
	
CoordXCenterScreen(WidthOfGUI,ScreenNumber){
	SysGet, Mon1, Monitor, %ScreenNumber%
	return (( Mon1Right-Mon1Left - WidthOfGUI ) / 2) + Mon1Left
}
	
CoordYCenterScreen(HeightofGUI,ScreenNumber){
	SysGet, Mon1, Monitor, %ScreenNumber%
	return ((Mon1Bottom-Mon1Top - 30 - HeightofGUI ) / 2) + Mon1Top
}

GetClientSize(hwnd, ByRef w, ByRef h){
	VarSetCapacity(rc, 16)
	DllCall("GetClientRect", "uint", hwnd, "uint", &rc)
	w := NumGet(rc, 8, "int")
	h := NumGet(rc, 12, "int")
}