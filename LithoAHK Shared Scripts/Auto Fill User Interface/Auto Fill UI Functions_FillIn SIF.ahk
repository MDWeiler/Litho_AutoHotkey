FillIn_SIF(pathSifTemplateFile:="Test.txt", boolJustView:=False) {    
	global
	
    ; msgbox strStringToParse: %strStringToParse%`npathSifTemplateFile: %pathSifTemplateFile%`nboolJustView: %boolJustView%
	
	local strWarningMessages
	strWarningMessages := "Warnings:"
	
	local arraySifGeneralInformation, arraySifEngineeringFields, arraySifRecipeFields, intField
	arraySifGeneralInformation := []
	arraySifEngineeringFields  := []
	arraySifRecipeFields       := []
	local intSGI_ReqInsts, intSGI_ModInsts, intSGI_EngInsts, intSGI_SOinsts, intSGI_Approval
	local intSGI_RnU, intSGI_SignOut, intSGI_SaveApproved, intSGI_Download, intSGI_Prelook
	local intSGI_MAX, intEngineeringFields, intRecipeFields
	intSGI_ReqInsts      := 1
	intSGI_ModInsts      := 2
	intSGI_EngInsts      := 3
	intSGI_SOinsts       := 4
	intSGI_Approval      := 5
	intSGI_RnU           := 6
	intSGI_SignOut       := 7
	intSGI_SaveApproved  := 8
	intSGI_Download      := 9
	intSGI_Prelook       := 10
	intSGI_MAX           := 10 ; Max Index
	intEngineeringFields := 20
	intRecipeFields      := 30
	arraySifGeneralInformation[intSGI_ReqInsts]      := "[SKIP]"
	arraySifGeneralInformation[intSGI_ModInsts]      := "[SKIP]"
	arraySifGeneralInformation[intSGI_EngInsts]      := "[SKIP]"
	arraySifGeneralInformation[intSGI_SOinsts]       := "[SKIP]"
	arraySifGeneralInformation[intSGI_Approval]      := "[SKIP]"
	arraySifGeneralInformation[intSGI_RnU]           := "[SKIP]"
	arraySifGeneralInformation[intSGI_SignOut]       := "[SKIP]"
	arraySifGeneralInformation[intSGI_SaveApproved]  := "[SKIP]"
	arraySifGeneralInformation[intSGI_Download]      := "[SKIP]"
	arraySifGeneralInformation[intSGI_Prelook]       := "[SKIP]"
	
	local intCurrentSection
	intCurrentSection := 0

	local SIF_MouseSpeed := 5

	; General Information Section Open\Close chevrons
	local mousePosX_GeneralInformation := 14
	local mousePosY_SifTemplateInformation := 144
	local mousePosY_GeneralInformation := 168
	local mousePosY_SpecialProcessingInstructions := 195
	local mousePosY_Requestor_Approver := 220
	local mousePosY_SifOptions := 246

	; General Information Section Value Fields
	local mousePosX_GeneralInformationValues := 419	; This is also the center of the Options check box
													;    however this is dependent on the width of the Gen Info frame
													; For the Options boxes the Y position is where the 
													;    color is 0x444444 or 0x868686 (EMS) when 
													;    checked at the above X Pos
	local mousePosY_RnuRequired := 295		 		; mousePosY_SifOptions + 46
	local mousePosY_SignOutRequired := 318			; mousePosY_RnuRequired + 23
	local mousePosY_SaveApproved := 341				; mousePosY_SignOutRequired + 23
	local mousePosY_RecipeDownload := 364			; mousePosY_RecipeDownload + 23

	local mousePosY_ApproverComments := 350			; mousePosY_Requestor_Approver + 130
	local mousePosY_FromRequestor := 240			; mousePosY_SpecialProcessingInstructions + 20

	; Eng/Rec Fields Tab
	local mousePosX_EngRecTab := 660
	local mousePosY_EngRecTab := 140

	; Eng/Rec Fields Tab - Engineering Fields Open\Close chevron
	local mousePosX_EngFields := 626
	local mousePosY_EngFields := 173

	; Eng/Rec Fields - Recipe Fields
	local mousePosX_RCT := 630
	local mousePosY_RCT := 226
	local mousePosX_AllEntities := 633
	local mousePosY_AllEntities := 195
	local mousePosX_EngRecFieldValues := 1325 ; 1188
	local mousePosY_RecipeFields_Recipe := 287
	local mousePosY_EngineeringFields_Entity := 240

	; Prelook SIF Recipe Tab
	local mousePosX_PrelookTab := 864
	local mousePosY_PrelookTab := 140
	local mousePosX_GetSifRecipe := 1145
	local mousePosY_GetSifRecipe := 175

    ; msgbox Read File: %pathSifTemplateFile%
	loop read, %pathSifTemplateFile% 
	{ ; Begin Loop
		switch A_LoopReadLine {
			case "Requestor Instructions:":
			intCurrentSection := intSGI_ReqInsts
			intField := 0
			case "Module Owner Instructions:":
			intCurrentSection := intSGI_ModInsts
			intField := 0
			case "Engineering Field Instructions:":
			intCurrentSection := intSGI_EngInsts
			intField := 0
			case "SignOff Instructions:":
			intCurrentSection := intSGI_SOinsts
			intField := 0
			case "Approval Comments:":
			intCurrentSection := intSGI_Approval
			intField := 0
			case "SIF Options":
			intCurrentSection := intSGI_RnU
			intField := 0
			case "Engineering Fields":
			intCurrentSection := intEngineeringFields
			intField := 0
			case "Recipe Fields":
			intCurrentSection := intRecipeFields
			intField := 0
		} ; End Case
		
        ; msgbox Line:`n%A_LoopReadLine%`nCurrent Section ID: %intCurrentSection%`nField Counter: %intField%
		
		if (intField == 0) {
			intField := 1
		} else {
			if (intCurrentSection == 0) {
				sleep 100 ; Skip - Do nothing
			} else if (intCurrentSection <= intSGI_MAX) {
;                if not(trim(arraySifGeneralInformation[intCurrentSection]) == "") {
				if not(trim(A_LoopReadLine) == "") {
                    ; strTemp := (Trim(SubStr(Trim(A_LoopReadLine), 5)))
                    ; msgbox SIF Option: >%strTemp%<
					switch Trim(SubStr(Trim(A_LoopReadLine), 5)) {
						case "RnU Required":
						arraySifGeneralInformation[intSGI_RnU] := (SubStr(Trim(A_LoopReadLine), 2, 1) = "X")
						case "SignOut Required":
						arraySifGeneralInformation[intSGI_SignOut] := (SubStr(Trim(A_LoopReadLine), 2, 1) = "X")
						case "Enable Save As Approved":
						arraySifGeneralInformation[intSGI_SaveApproved] := (SubStr(Trim(A_LoopReadLine), 2, 1) = "X")
						case "Recipe Download":
						arraySifGeneralInformation[intSGI_Download] := (SubStr(Trim(A_LoopReadLine), 2, 1) = "X")
						case "Prelook SIF Recipe":
						arraySifGeneralInformation[intSGI_Prelook] := (SubStr(Trim(A_LoopReadLine), 2, 1) = "X")
						default: 
						if (intField == 1) {
							arraySifGeneralInformation[intCurrentSection] := A_LoopReadLine
							intField := 2
						} else {
							arraySifGeneralInformation[intCurrentSection] := arraySifGeneralInformation[intCurrentSection] . "{enter}" . A_LoopReadLine
						} ; End If
					} ; End Switch
				} ; End If
			} else if (intCurrentSection == intEngineeringFields) {
				if (intField == 1 and Trim(SubStr(Trim(A_LoopReadLine), -12)) = "All Entities") {
					arraySifEngineeringFields[intField] := (SubStr(Trim(A_LoopReadLine), 2, 1) = "X")
					intField := 2
				} else {
					if (intField == 1) {
						arraySifEngineeringFields[intField] := "[SKIP]" ; Skip the All Entities Check Box
						intField := intField + 1
					} ; End if
					if (SubStr(A_LoopReadLine,1,1) == "|") {
						arraySifEngineeringFields[intField] := LTrim(SubStr(A_LoopReadLine, InStr(A_LoopReadLine, "|", false, 2)+1))
					} else {
						arraySifEngineeringFields[intField] := A_LoopReadLine
					} ; End If
					intField := intField + 1
				} ; End If
			} else if (intCurrentSection == intRecipeFields) {
				if (intField == 1 and Trim(SubStr(Trim(A_LoopReadLine), -4)) = "] RCT") {
					arraySifRecipeFields[intField] := (SubStr(Trim(A_LoopReadLine), 2, 1) = "X")
					intField := 2
				} else {
					if (intField == 1) {
						arraySifRecipeFields[intField] := "[SKIP]" ; Skip the RCT Check box
						intField := intField + 1
					} ; End if
					if (SubStr(A_LoopReadLine,1,1) == "|") {
						arraySifRecipeFields[intField] := LTrim(SubStr(A_LoopReadLine, InStr(A_LoopReadLine, "|", false, 2)+1))
					} else {
						arraySifRecipeFields[intField] := A_LoopReadLine
					} ; End If
					intField := intField + 1
				} ; End If            
			} ; end If
		} ; End If
	} ; End Loop
	
	if (boolJustView) {
		Run Notepad
		Sleep 500
		WinActivate Untitled - Notepad
		Sleep 500
	} ; End If
	
	;ParseStringTo_strVariables(strStringToParse)
	ParseClipboard(boolClearEmptyTerms:=FALSE, strStringToParse:=strStringToParse)
	
	; Get Current Window Values
	local objCurrentWindow := WinCheck("GetInfo")	
	
	if (boolJustView) {
        ; Dump All values
		strSIFeditor := "Notepad"
	} else if WinActive("Add SIF") or WinActive("Approve SIF") or WinActive("Edit SIF"){
        ; MES SIF Editors
		strSIFeditor := "MES"
	} else if WinActive("[ Add ] SIF Flag") or WinActive("[ Edit ] SIF Flag") {
        ; EMS SIF Editors
		strSIFeditor := "EMS"
	} ; End If
	
    ; msgbox strSIFeditor: %strSIFeditor%
	
	if (strSIFeditor == "Notepad") {
		
		if (strStringSource = "Clipboard") {
			sendInput Using the Clipboard Contents:{enter}
		} else {
			sendInput Using the User Provided String:{enter}
		} ; End If
		ListPatternedVariables(boolSkipEmptyTerms:=TRUE, boolShowPatterns:=FALSE)
		sendInput {enter}
		
		sendInput {enter}Template File{enter}%pathSifTemplateFile%{enter}
		
		if not(arraySifGeneralInformation[intSGI_ReqInsts] = "[SKIP]") {
			Send {enter}Requestor's Instructions{enter}
			SendText(strSIFeditor, arraySifGeneralInformation[intSGI_ReqInsts], "{enter}")
		} ; End if
		if not(arraySifGeneralInformation[intSGI_ModInsts] = "[SKIP]") {
			Send {enter}Module Owner Instructions{enter}
			SendText(strSIFeditor, arraySifGeneralInformation[intSGI_ModInsts], "{enter}")
		} ; End if
		if not(arraySifGeneralInformation[intSGI_EngInsts] = "[SKIP]") {
			Send {enter}Instructions for SIF Values{enter}
			SendText(strSIFeditor, arraySifGeneralInformation[intSGI_EngInsts], "{enter}")
		} ; End if
		if not(arraySifGeneralInformation[intSGI_SOinsts] = "[SKIP]") {
			Send {enter}Sign Out INSTs{enter}
			SendText(strSIFeditor, arraySifGeneralInformation[intSGI_SOinsts], "{enter}")
		} ; End if
		if not(arraySifGeneralInformation[intSGI_Approval] = "[SKIP]") {
			Send {enter}Approver Comments{enter}
			SendText(strSIFeditor, arraySifGeneralInformation[intSGI_Approval], "{enter}")
		} ; End if
		
		if  not(arraySifGeneralInformation[intSGI_RnU]          = "[SKIP]")
           or not(arraySifGeneralInformation[intSGI_SignOut]      = "[SKIP]")
           or not(arraySifGeneralInformation[intSGI_SaveApproved] = "[SKIP]")
           or not(arraySifGeneralInformation[intSGI_Download]     = "[SKIP]")
           or not(arraySifGeneralInformation[intSGI_Prelook]      = "[SKIP]")
		{ ; Then
			
			Send {enter}SIF Options{enter}
			
			if not(arraySifGeneralInformation[intSGI_RnU] = "[SKIP]") {
				if (arraySifGeneralInformation[intSGI_RnU]) {
					Send [X]
				} else {
					Send [_]
				} ; End If
				Send {space}RnU Required{enter}
			} ; End If
			
			if not(arraySifGeneralInformation[intSGI_SignOut] = "[SKIP]") {
				if (arraySifGeneralInformation[intSGI_SignOut]) {
					Send [X]
				} else {
					Send [_]
				} ; End If
				Send {space}SignOut Required{enter}
			} ; End If
			
			if not(arraySifGeneralInformation[intSGI_SaveApproved] = "[SKIP]") {
				if (arraySifGeneralInformation[intSGI_SaveApproved]) {
					Send [X]
				} else {
					Send [_]
				} ; End If
				Send {space}Enable Save As Approved{enter}
			} ; End If
			
			if not(arraySifGeneralInformation[intSGI_Download] = "[SKIP]") {
				if (arraySifGeneralInformation[intSGI_Download]) {
					Send [X]
				} else {
					Send [_]
				} ; End If
				Send {space}Recipe Download{enter}
			} ; End If
			
			if not(arraySifGeneralInformation[intSGI_Prelook] = "[SKIP]") {
				if (arraySifGeneralInformation[intSGI_Prelook]) {
					Send [X]
				} else {
					Send [_]
				} ; End If
				Send {space}Prelook SIF Recipe{enter}
			} ; End If
		} ; End If
		
		if not(arraySifEngineeringFields.Length() = 0) {
			Send {enter}Engineering Fields{enter}
			
			if not(arraySifEngineeringFields[1] = "[SKIP]") {
				if (arraySifEngineeringFields[1]) {
					Send [X]
				} else {
					Send [_]
				} ; End If
				Send {space}All Entities{enter}
			} ; End If
			
			for index, strEngValue in arraySifEngineeringFields {
				if (index > 1) {
					Send % "|" . (index-1) . "| "
					SendText(strSIFeditor, strEngValue, "{enter}")
				} ; End If
			} ; End For
		} ; End If
		
		if not(arraySifRecipeFields.Length() = 0) {
			Send {enter}Recipe Fields{enter}
			
			if not(arraySifRecipeFields[1] = "[SKIP]") {
				if (arraySifRecipeFields[1]) {
					Send [X]
				} else {
					Send [_]
				} ; End If
				Send {space}RCT{enter}
			} ; End If
			
			for index, strRecipeValue in arraySifRecipeFields {
				if (index > 1) {
					Send % "|" . (index-1) . "| "
					SendText(strSIFeditor, strRecipeValue, "{enter}")
				} ; End If
			} ; End For
		} ; End If
		
	} else if (strSIFeditor == "EMS") {
        ; Minimize All of the General Information Sections
        ;   SIF Template Info
		MouseMove mousePosX_GeneralInformation, mousePosY_SifTemplateInformation, SIF_MouseSpeed
		WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
		Click                    
		sleep 100
        ;   General Info
		MouseMove mousePosX_GeneralInformation, mousePosY_GeneralInformation, SIF_MouseSpeed
		WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
		Click                    
		sleep 100
        ;   Special Processing Instructions
		MouseMove mousePosX_GeneralInformation, mousePosY_SpecialProcessingInstructions, SIF_MouseSpeed
		WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
		Click                    
		sleep 100
        ;   Requestor\Approver
		MouseMove mousePosX_GeneralInformation, mousePosY_Requestor_Approver, SIF_MouseSpeed
		WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
		Click                    
		sleep 100
        ;   SIF Options - No need to Minimize this
        ;    MouseMove mousePosX_GeneralInformation, mousePosY_SifOptions, 5
        ;    Click
		
        ; Test\Set\Warn as necessary each SIF Option
        ;   SIF Option - Save As Approved
		if  not(arraySifGeneralInformation[intSGI_SaveApproved] = "[SKIP]") {
			strWarningMessages := strWarningMessages . TestToggleCheckBoxControl("Save As Approved", strSIFeditor, arraySifGeneralInformation[intSGI_SaveApproved], mousePosX_GeneralInformationValues, mousePosY_SaveApproved)
		} ; End If
        ;   SIF Option - Recipe Download
		if  not(arraySifGeneralInformation[intSGI_Download] = "[SKIP]") {
			strWarningMessages := strWarningMessages . TestToggleCheckBoxControl("Recipe Download", strSIFeditor,  arraySifGeneralInformation[intSGI_Download],     mousePosX_GeneralInformationValues, mousePosY_RecipeDownload)
		} ; End If
        ;   SIF Option - SignOut Required
		if  not(arraySifGeneralInformation[intSGI_SignOut] = "[SKIP]") {
			strWarningMessages := strWarningMessages . TestToggleCheckBoxControl("SignOut Required", strSIFeditor, arraySifGeneralInformation[intSGI_SignOut],      mousePosX_GeneralInformationValues, mousePosY_SignOutRequired)
		} ; End If
        ;   SIF Option - RnU Required
		if  not(arraySifGeneralInformation[intSGI_RnU] = "[SKIP]") {
			strWarningMessages := strWarningMessages . TestToggleCheckBoxControl("RnU Required",  strSIFeditor,    arraySifGeneralInformation[intSGI_RnU],          mousePosX_GeneralInformationValues, mousePosY_RnuRequired)
		} ; End If
		
        ; Add Approver Comments if Necessary
		if not(arraySifGeneralInformation[intSGI_Approval] = "[SKIP]") {
            ;   Expand Section
			MouseMove mousePosX_GeneralInformation, mousePosY_Requestor_Approver, SIF_MouseSpeed
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			Click
			sleep 100
            ;   Move to and select Input Field
			MouseMove mousePosX_GeneralInformationValues , mousePosY_ApproverComments, SIF_MouseSpeed
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			Click
			sleep 100
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			SendText(strSIFeditor, arraySifGeneralInformation[intSGI_Approval])
		} ; End If
		
        ; Add Special Processing Instructions
		if not(arraySifGeneralInformation[intSGI_ReqInsts] = "[SKIP]") 
            or not(arraySifGeneralInformation[intSGI_ModInsts] = "[SKIP]")
            or not(arraySifGeneralInformation[intSGI_EngInsts] = "[SKIP]")
            or not(arraySifGeneralInformation[intSGI_SOinsts]  = "[SKIP]")
		{ ; Then        
            ;   Expand Section
			MouseMove mousePosX_GeneralInformation, mousePosY_SpecialProcessingInstructions, SIF_MouseSpeed
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			Click
			sleep 100
            ;   Move to and select Input Field
			MouseMove mousePosX_GeneralInformationValues, mousePosY_FromRequestor, SIF_MouseSpeed
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			Click
			sleep 100
                ; Requestor's Instructions
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			SendText(strSIFeditor, arraySifGeneralInformation[intSGI_ReqInsts], "{tab}")
                ; Module Owner Instructions
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			SendText(strSIFeditor, arraySifGeneralInformation[intSGI_ModInsts], "{tab}")
                ; Instructions for SIF Values
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			SendText(strSIFeditor, arraySifGeneralInformation[intSGI_EngInsts], "{tab}")
                ; Sign Out INSTs
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			SendText(strSIFeditor, arraySifGeneralInformation[intSGI_SOinsts])
		} ; End If
		
		if not(arraySifRecipeFields.Length() = 0 and arraySifEngineeringFields.Length() = 0) {
            ; Select the Eng/Rec Tab then Minimize Engineering Fields
			MouseMove mousePosX_EngRecTab, mousePosY_EngRecTab, SIF_MouseSpeed ; Select the Eng/Rec Fields
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			Click
			sleep 100
			MouseMove mousePosX_EngFields, mousePosY_EngFields, 5SIF_MouseSpeed ; Engineering Fields
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			Click                    
			sleep 100
			
            ; Add Recipe Values
            ; Test\Set\Warn as necessary RCT
			if not(arraySifRecipeFields[1] = "[SKIP]") {
				strWarningMessages := strWarningMessages . TestToggleCheckBoxControl("RCT", strSIFeditor, arraySifRecipeFields[1],  mousePosX_RCT, mousePosY_RCT)
			} ; End If
			
			if not(arraySifRecipeFields.Length() = 0) {
                ;   Move to and select First Input Field
				MouseMove mousePosX_EngRecFieldValues, mousePosY_RecipeFields_Recipe, SIF_MouseSpeed
				WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
				Click 3 ; Triple Click
				sleep 100
				
				for index, strRecipeValue in arraySifRecipeFields {
					if (index > 1) {
						WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
						SendText(strSIFeditor, strRecipeValue, "{down}")
					} ; End If
				} ; End For
			} ; End If 
			
            ; Add Engineering Field Values
            ;   Expand Section
			MouseMove mousePosX_EngFields, mousePosY_EngFields, SIF_MouseSpeed ; Engineering Fields
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			Click
			sleep 100
			
            ; Add Engineering Values
            ; Test\Set\Warn as necessary All Entites
			if not(arraySifEngineeringFields[1] = "[SKIP]") {
				strWarningMessages := strWarningMessages . TestToggleCheckBoxControl("All Entites", strSIFeditor, arraySifEngineeringFields[1],  mousePosX_AllEntities, mousePosY_AllEntities)        
			} ; End If
			
			if not(arraySifEngineeringFields.Length() = 0) {
                ;   Move to and select Input Field
				MouseMove mousePosX_EngRecFieldValues, mousePosY_EngineeringFields_Entity, SIF_MouseSpeed
				WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
				Click 3
				sleep 100
				
				for index, strEngineeringValue in arraySifEngineeringFields {
					if (index > 1) {
						WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
						SendText(strSIFeditor, strEngineeringValue, "{down}")
					} ; End If
				} ; End For
			} ; End If
		} ; End If
		
        ; Prelook SIF Recipe
		if not(arraySifGeneralInformation[intSGI_Prelook] = "[SKIP]") {
			if (arraySifGeneralInformation[intSGI_Prelook]) {
				MouseMove mousePosX_PrelookTab, mousePosY_PrelookTab, SIF_MouseSpeed ; Select the Prelook SIF Recipe
				WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
				Click
				sleep 100
                ; Replace Mouse Move with Tabx2 and Enter - Hopfully it will work better with different screen sizes
				Send {tab 2}{enter}
                ; MouseMove mousePosX_GetSifRecipe, mousePosY_GetSifRecipe, SIF_MouseSpeed ; Get SIF Recipe
                ; Click                    
				sleep 100
			} ; End if
		} ; End If
		
	} else if (strSIFeditor == "MES") {
		
		if not(arraySifGeneralInformation[intSGI_SOinsts] = "[SKIP]") {
            ; Switch To Lot Signout Tab
			MouseMove 300, 140, 5
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			Click                    
			sleep 100
			
            ; Add Signout Instructions
			MouseMove 300, 230, 5
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			Click
			sleep 100
			send +{home}
                ; Sign Out INSTs
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			SendText(strSIFeditor, arraySifGeneralInformation[intSGI_SOinsts])
		} ; End If
		
        ; Switch To Lot Instructions Tab
		MouseMove 200, 140, 5
		WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
		Click                    
		sleep 100
		
        ; Add Special Processing Instructions
		if not(arraySifGeneralInformation[intSGI_ReqInsts] = "[SKIP]")
           or not(arraySifGeneralInformation[intSGI_ModInsts] = "[SKIP]")
           or not(arraySifGeneralInformation[intSGI_EngInsts] = "[SKIP]")
		{ ; Then
            ;   Move to and select Input Field
			MouseMove 300, 200, 5
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			Click 3
			sleep 100
                ; Requestor's Instructions
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			SendText(strSIFeditor, arraySifGeneralInformation[intSGI_ReqInsts], "{tab}")
                ; Module Owner Instructions
			send +{home}
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			SendText(strSIFeditor, arraySifGeneralInformation[intSGI_ModInsts], "{tab}")
                ; Instructions for SIF Values
			send +{home}
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			SendText(strSIFeditor, arraySifGeneralInformation[intSGI_EngInsts])
		} ; End If
		
        ; Add Engineering Values
		if not(arraySifEngineeringFields.Length() = 0) {
            ; Test\Set\Warn as necessary All Entites
			if not(arraySifEngineeringFields[1] = "[SKIP]") {
				strWarningMessages := strWarningMessages . TestToggleCheckBoxControl("All Entites", strSIFeditor, arraySifEngineeringFields[1],  33, 400)     
			} ; End If
            ;   Move to and select Input Field
			MouseMove 450, 450, 5
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			Click
			sleep 100
			
			for index, strEngineeringValue in arraySifEngineeringFields {
				if (index > 1) {
					WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
					SendText(strSIFeditor, strEngineeringValue, "{down}")
				} ; End If
			} ; End For
		} ; End If
		
        ; Add Recipe Values
		if not(arraySifRecipeFields.Length() = 0) {
            ; Test\Set\Warn as necessary RCT
			if not(arraySifRecipeFields[1] = "[SKIP]") {
				strWarningMessages := strWarningMessages . TestToggleCheckBoxControl("RCT", strSIFeditor, arraySifRecipeFields[1],  40, 550)        
			} ; End if
            ;   Move to and select First Input Field
			MouseMove 450, 600, 5
			WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
			Click
			sleep 100
			send {pgup}{pgup}{pgup}{pgup}{pgup}
			
			for index, strRecipeValue in arraySifRecipeFields {
				if (index > 1) {
					WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
					SendText(strSIFeditor, strRecipeValue, "{down}")
				} ; End If
			} ; End For
		} ; End If
		
        ; Switch To General Tab
		MouseMove 75, 140, 5
		WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
		Click                    
		sleep 100
		
        ; Test\Set\Warn as necessary each SIF Option
        ;   SIF Option - Save As Approved
		if not(arraySifGeneralInformation[intSGI_SaveApproved] = "[SKIP]") {
			strWarningMessages := strWarningMessages . TestToggleCheckBoxControl("Save As Approved", strSIFeditor, arraySifGeneralInformation[intSGI_SaveApproved], 429, 637)
		} ; End If
        ;   SIF Option - Recipe Download
		if not(arraySifGeneralInformation[intSGI_Download] = "[SKIP]") {
			strWarningMessages := strWarningMessages . TestToggleCheckBoxControl("Recipe Download",  strSIFeditor, arraySifGeneralInformation[intSGI_Download],     45, 612)
		} ; End If
        ;   SIF Option - SignOut Required
		if not(arraySifGeneralInformation[intSGI_SignOut] = "[SKIP]") {
			strWarningMessages := strWarningMessages . TestToggleCheckBoxControl("SignOut Required", strSIFeditor, arraySifGeneralInformation[intSGI_SignOut],      45, 639)
		} ; End If
        ;   SIF Option - RnU Required
		if not(arraySifGeneralInformation[intSGI_RnU] = "[SKIP]") {
			strWarningMessages := strWarningMessages . TestToggleCheckBoxControl("RnU Required",  strSIFeditor,    arraySifGeneralInformation[intSGI_RnU],          260, 639)
		} ; End If
        ; Add Approver Comments if Necessary
		MouseMove 300, 500, 5
		WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
		Click
		sleep 100
		WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
		SendText(strSIFeditor, arraySifGeneralInformation[intSGI_Approval])
		
        ; Prelook SIF Recipe
		if not(arraySifGeneralInformation[intSGI_Prelook] = "[SKIP]") {
			if (arraySifGeneralInformation[intSGI_Prelook]) {
				MouseMove 515, 293, 5 ; Select the Prelook SIF Recipe
				WinCheck("Stop", objCurrentWindow.HWND, objCurrentWindow.Title, objCurrentWindow.X, objCurrentWindow.Y)
				Click
				sleep 250
					; I tried both !S and {Alt Down}S{Alt Up} and neither worked (however I just realized that maybe I should have tried with a lower case s)
				send {tab 8}{enter}
				sleep 100
			} ; End If
		} ; End If
		
	} ; End If
	
    ; Ending Message
	if (strWarningMessages == "Warnings:") {
		msgbox Finished...`n  You may roam around the SIF now.
	} else {
		strWarningMessages := "Finished`n`n" . strWarningMessages
		msgbox % strWarningMessages
	} ; End If
	
	return
	
} ; End Function
