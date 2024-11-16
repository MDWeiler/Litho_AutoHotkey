AddPattern(strPatternName, strPattern, boolHotString:=False){
		
	global ; This brings in listPtrnVars and makes the ptrn variables global
    local strHotStringString := ""
	
	; Add HotString if necessary
	if (boolHotString) {
		strHotStringString := ":X*?:\\" . strPatternName
		Hotkey IfWinActive
		HotString(strHotStringString, Func("ParseClipboardWithFilters").Bind(strPatternName . ":=!None!", "{Shift}"), True)
	} ; End if
	
	listPtrnVars.Push([strPatternName, boolHotString])
	strPatternName := "ptrn" . strPatternName
	%strPatternName% := strPattern
	
} ; End Function