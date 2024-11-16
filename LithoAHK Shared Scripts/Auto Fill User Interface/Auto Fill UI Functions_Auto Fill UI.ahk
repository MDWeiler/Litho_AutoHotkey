Auto_Fill_UI(localAutoFillType, boolFillIn){

	;global ; Control Variables Must be Global
	global listPtrnVars
	global strClipboard, strUserString, cbEditTemplate, cbTestTemplate
	strClipboard := Clipboard
	global strAutoFillType, strTemplatePath, strTemplateFileExtention
	strAutoFillType := localAutoFillType

	boolJustView := Not(boolFillIn)
	strStringToParse := "Nothing Yet"

	global MyName := A_UserName
	global MyInitials := SubStr(A_UserName, 1, 3)

	global pathShared_SIF_Templates := A_ScriptDir . "\LithoAHK Shared Scripts\Auto Fill Templates\SIF Templates"
	global pathShared_CMT_Templates := A_ScriptDir . "\LithoAHK Shared Scripts\Auto Fill Templates\CMT Templates"
	global pathPersonal_SIF_Templates := A_ScriptDir . "\LithoAHK Personal Scripts\Auto Fill Templates\SIF Templates"
	global pathPersonal_CMT_Templates := A_ScriptDir . "\LithoAHK Personal Scripts\Auto Fill Templates\CMT Templates"

	; local strTemplateFileExtention, strTemplatePath, strTemplateFiles

	ReBuild_GUI: ; Gosub Lable to rebuild the GUI - usually after the Source has changed

		; The Default value for undefined booleans is FALSE
		if (boolFullView) {
			Gui Add, Text, Section, Clipboard Contents
			Gui Add, Edit , ReadOnly vstrClipboard r6 w550, %strClipboard%
			Gui Add, Text, , User Provided String
			Gui Add, Edit, vstrUserString r6 w550, %strUserString%
		} ; End if

		ParseClipboard(TRUE, strClipboard)
		; local rbCB_Checked, rbUS_Checked
		if (strStringSource = "UserString") {
			rbCB_Checked =
			rbUS_Checked = Checked
			strStringToParse := strUserString
			ParseClipboard(FALSE, strStringToParse)
		} else {
			strStringSource := "Clipboard"
			rbCB_Checked = Checked
			rbUS_Checked =
			strStringToParse := strClipboard
		} ; End If

		if (boolFullView) {
			Gui Add, Text, xs+10 y+20 , Parse for Values
			Gui Add, Radio, gSourceChanged x+20 yp %rbCB_Checked%, Clipboard
			Gui Add, Radio, gSourceChanged x+5 yp %rbUS_Checked%, User Provided String

			Gui Font, bold,,
			Gui Add, Text, xs+20 w80, Variable
			Gui Add, Text, yp x+28, Current Value
			Gui Font,,,

			; local index, element, valueOfElement, nameOfElement
			for index, element in listPtrnVars {
				valueOfElement := element[1]
				nameOfElement := valueOfElement
				valueOfElement := %valueOfElement%
				if not(valueOfElement == "") {
					Gui Add, Text, xs+10 y+10 w110, %nameOfElement%
					Gui Add, Edit, v%element% yp-4 x+5 w150 ReadOnly, %valueOfElement%
				} ; end if
			} ; end for
		} ; End if

		if (boolFullView) {
			xsOffsetForTemplates := 330
			ysOffsetForTemplates := 236
		} else {
			Gui Font, bold,,
			if (strAutoFillType = "SIF") {
				Gui Add, Text, Section, Auto Fill UI for SIFs
			} else {
				Gui Add, Text, Section, Auto Fill UI for Comments
			} ; End If
			Gui Font,,,

			xsOffsetForTemplates := 20
			ysOffsetForTemplates := 20
		} ; End if

		Gui Font, bold,,
		Gui Add, Text, xs+%xsOffsetForTemplates% ys+%ysOffsetForTemplates%
		Gui Add, Text, yp x+5, Shared Templates
		Gui Font,,,
		Gui Add, Checkbox, vcbEditTemplate yp x+5, Edit
		Gui Add, Checkbox, vcbTestTemplate yp x+2, Test
		Gui Add, Button, h17 yp x+3 gViewChanged, ...

		if (strAutoFillType = "SIF") {
			strTemplatePath := pathShared_SIF_Templates ; Start with Shared Templates
			strTemplateFileExtention := "txt"	; previously used ast
		} else if (strAutoFillType = "Comment") {
			strTemplatePath := pathShared_CMT_Templates ; Start with Shared Templates
			strTemplateFileExtention := "txt" ; previously used aft
		} else {
			MsgBox (2) Unknown Auto Fill Type: %strAutoFillType%
		}
		strTemplateFileExtention := "." . strTemplateFileExtention
		strTemplatePath := strTemplatePath . "\"
		strTemplateFiles := strTemplatePath . "*" . strTemplateFileExtention

		;local listTemplates := ""  ; Initialize to be blank.
		listTemplates := "" ; Initialize to be blank.
		; MsgBox strTemplateFiles = %strTemplateFiles%
		Loop Files, %strTemplateFiles%
			listTemplates .= A_LoopFileName "`n"
		Sort listTemplates
		Loop Parse, listTemplates, `n
		{
			if not(A_LoopField == "") {
				strButtonText := StrReplace(A_LoopField,strTemplateFileExtention)
				if (A_Index == 1) {
					Gui Add, Button, w230 xs+%xsOffsetForTemplates% yp+17 gFillinWithSelected_Shared_Template, %strButtonText%
				} else {
					Gui Add, Button, w230 xs+%xsOffsetForTemplates% yp+23 gFillinWithSelected_Shared_Template, %strButtonText%
				} ; End If
			} ; End If
		}

		if (strAutoFillType = "SIF") {
			strTemplatePath := pathPersonal_SIF_Templates ; Now add personal templates
			strTemplateFileExtention := "txt"	; previously used ast
		} else if (strAutoFillType = "Comment") {
			strTemplatePath := pathPersonal_CMT_Templates ; Now add personal templates
			strTemplateFileExtention := "txt"	; previously used aft
		} else {
			MsgBox (2) Unknown Auto Fill Type: %strAutoFillType%
		}
		strTemplateFileExtention := "." . strTemplateFileExtention
		strTemplatePath := strTemplatePath . "\"
		strTemplateFiles := strTemplatePath . "*" . strTemplateFileExtention

		; Personal Templates

		Gui Font, bold,,
		Gui Add, Text, xs+%xsOffsetForTemplates% yp+23
		Gui Add, Text, yp x+20, Personal Templates
		Gui Font,,,

		listTemplates := "" ; Initialize to be blank.
		; MsgBox strTemplateFiles = %strTemplateFiles%
		Loop Files, %strTemplateFiles%
			listTemplates .= A_LoopFileName "`n"
		Sort listTemplates
		Loop Parse, listTemplates, `n
		{
			if not(A_LoopField == "") {
				strButtonText := StrReplace(A_LoopField,strTemplateFileExtention)
				if (A_Index == 1) {
					Gui Add, Button, w230 xs+%xsOffsetForTemplates% yp+17 gFillinWithSelected_Personal_Template, %strButtonText%
				} else {
					Gui Add, Button, w230 xs+%xsOffsetForTemplates% yp+23 gFillinWithSelected_Personal_Template, %strButtonText%
				} ; End If
			} ; End If
		}

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
		;Gui, Show, % "x" GUI_X " y" GUI_Y, GUI TITLE

		if (strAutoFillType = "SIF") {
			Gui Show,% "x" GUI_X " y" GUI_Y,Auto Fill UI for SIFs
		} else {
			Gui Show,% "x" GUI_X " y" GUI_Y,Auto Fill UI for Comments
		}
	return

	FillinWithSelected_Shared_Template:
		if (strAutoFillType = "SIF") {
			strTemplatePath := pathShared_SIF_Templates ; Start with Shared Templates
			strTemplateFileExtention := "txt" ; previously used ast
		} else if (strAutoFillType = "Comment") {
			strTemplatePath := pathShared_CMT_Templates ; Start with Shared Templates
			strTemplateFileExtention := "txt" ;  ; previously used aft
		} else {
			MsgBox (2z) Unknown Auto Fill Type: %strAutoFillType%
		}
		gosub FillinWithSelectedTemplate
	return

	FillinWithSelected_Personal_Template:
		if (strAutoFillType = "SIF") {
			strTemplatePath := pathPersonal_SIF_Templates ; Start with Shared Templates
			strTemplateFileExtention := "txt" ; previously used ast
		} else if (strAutoFillType = "Comment") {
			strTemplatePath := pathPersonal_CMT_Templates ; Start with Shared Templates
			strTemplateFileExtention := "txt" ; previously used aft
		} else {
			MsgBox (2z) Unknown Auto Fill Type: %strAutoFillType%
		}
		gosub FillinWithSelectedTemplate
	return

	FillinWithSelectedTemplate:
		Gui Submit, NoHide

		; Save Variables that will be destroyed when GUI is Destroyed
		; 	Note: Any Function local variable have alredy been destroyed when the GUI was opened
		strTemplateSelection := strTemplatePath . "\" . A_GuiControl . "." . strTemplateFileExtention
		boolEditTemplate := cbEditTemplate
		boolTestTemplate := cbTestTemplate

		Gui Destroy

		; msgbox boolEditTemplate: %boolEditTemplate%
		if (boolEditTemplate) {
			; Open Template File for Editing
			; MsgBox Edit %strTemplateSelection%
			Run Edit %strTemplateSelection%
		} else {

			if (boolTestTemplate) {
				boolJustView := True
			} ; End if
			; Fill in or View Template results
			; msgbox FillIn (%strAutoFillType%) Selected Template`n%strTemplateSelection%`nJust View: %boolJustView%`n
			if (strAutoFillType = "SIF") {
				FillIn_SIF(strTemplateSelection, boolJustView)
			} else if (strAutoFillType = "Comment") {
				; msgbox FillIn_Comment(%strTemplateSelection%, %boolJustView%)
				FillIn_Comment(strTemplateSelection, boolJustView)
			} else {
				MsgBox (3) Unknown Auto Fill Type: %strAutoFillType%
			} ; End if
		} ; End if
	return

	ViewChanged:
		Gui Submit, NoHide
		; Toggle View value
		boolFullView := not(boolFullView)
		Gui Destroy
		GoSub ReBuild_GUI
	return

	SourceChanged:
		Gui Submit, NoHide
		if (A_GuiControl = "Clipboard") {
			strStringSource := "Clipboard"
			strClipboard = %Clipboard%
			GuiControl,, strClipboard, %strClipboard%
			strStringToParse = %strClipboard%
		} else if (A_GuiControl = "User Provided String") {
			strStringSource := "UserString"
			strStringToParse = %strUserString%
		} else {
			; SourceChanged can only be called by the Clipboard\User String radio buttons
			msgbox SourceChanged called by A_GuiControl=%A_GuiControl%`nThis is not allowed!
			return
		} ; End If

		Gui Destroy
		GoSub ReBuild_GUI
	return

	GuiClose:
		Gui Submit ; Save each control's contents to its associated variable.
		Gui Destroy
	return

} ; End Function
