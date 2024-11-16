TestToggleCheckBoxControl(strControlName, strSIFeditor, boolControlChecked, cbPosX, cbPosY, boolReport:=False) {
    ; Returns any necessary Warning Messages or an Empty String
	local strNewWarnings, bgrPixelColor, boolModuleTesting
	strNewWarnings := ""
	boolModuleTesting := FALSE
	
    ;       Get Color
	MouseMove %cbPosX%, %cbPosY%, 5
	sleep 200
	PixelGetColor bgrPixelColor, %cbPosX%, %cbPosY%
    ;       Test - 
	if (bgrPixelColor == 0xBEBEBE or bgrPixelColor == 0xA0A0A0) {
                ; Disabled - Checked
		if not(boolControlChecked) {
			strNewWarnings := "`n" . strControlName . " Disabled and Unable to Uncheck"
		} ; End If
	} else if (bgrPixelColor == 0xFFFFFF and strSIFeditor == "EMS") or (bgrPixelColor == 0xF0F0F0 and strSIFeditor == "MES"){
                ; Disabled - Not Checked
		if (boolControlChecked) {
			strNewWarnings := "`n" . strControlName . " Disabled and Unable to Check"
		} ; End If
	} else if (bgrPixelColor == 0x444444 or bgrPixelColor == 0x868686 or bgrPixelColor == 0x000000) {
                ; Enabled - Checked
		if not(boolControlChecked) {
                    ; strNewWarnings := "`n" . strControlName . " Enabled and Checked - Now Unchecked"
			Click ; Uncheck it
		} ; End If
	} else if (bgrPixelColor == 0xC5C5C5 and strSIFeditor == "EMS") or (bgrPixelColor == 0xFFFFFF and strSIFeditor == "MES") {
                ; Ensabled - Not Checked
		if  (boolControlChecked) {
                    ; strNewWarnings := "`n" . strControlName . " Enabled and Not Checked - Now Checked"
			Click ; Check it
		} ; End If
	} else {
                ; Unknown Color\Status
		strNewWarnings := "`n" . strControlName . " Unknown color\status (color=0x" . bgrPixelColor . ")"
	} ; End If
	
	if (boolReport || boolModuleTesting) {
		msgbox Pixel Color is %bgrPixelColor%`n`nWarnings:`n%strNewWarnings%
	} ; End If
	
	return strNewWarnings
	
} ; End Function
