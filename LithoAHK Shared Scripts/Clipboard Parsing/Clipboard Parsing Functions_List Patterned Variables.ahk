ListPatternedVariables(boolSkipEmptyTerms:=TRUE, boolShowPatterns:=TRUE, strpseudoArrayToList:="None")
{ ; Begin Function
	
	global ; Necessary to bring in listPtrnVars and the actual Pattern variables
	
	local index, element, RegExOutVar, RegExPattern
	
	if (strpseudoArrayToList = "None") {
		for index, element in listPtrnVars {    
			RegExOutVar  := element[1]
			RegExPattern := "ptrn" . RegExOutVar
			RegExPattern := %RegExPattern%
			if (not(boolSkipEmptyTerms) or %RegExOutVar% != "") {
				send {raw}  %RegExOutVar% =>	
				RegExOutVar := %RegExOutVar%
				send {raw}%RegExOutVar%<=`n
				if boolShowPatterns {
					send Pattern: {raw}%RegExPattern%`n------------------------------`n
				} ; end if
			} ; end if
		} ; end for loop
	} else if (strpseudoArrayToList = "TSV") {
		; List Tab Seperated Values if any
		send There are %TSV% Tab Seperated Values{enter}
		if (TSV > 0){
			loop %TSV%
			{ ; Begin Loop
				element := TSV%A_Index%
				if (not(boolSkipEmptyTerms) or element != "") {
					sendEvent {raw} TSV%A_Index% =>
					sendEvent {raw}%element%<= `n
				} ; End If
			} ; End loop
		} ; End If
	} else if (strpseudoArrayToList = "CSV") {		
		; List Comma Seperated Values if any
		send There are %CSV% Comma Seperated Values{enter}
		if (CSV > 0){
			loop %CSV%
			{ ; Begin loop
				element := CSV%A_Index%
				if (not(boolSkipEmptyTerms) or element != "") {
					sendEvent {raw} CSV%A_Index% =>
					sendEvent {raw}%element%<= `n
				} ; End If
			} ; End loop
		} ; End If
	} else if (strpseudoArrayToList = "NLSV") {		
		; List New Line Seperated Values if any
		send There are %NLSV% New Line Seperated Values{enter}
		if (NLSV > 0){
			loop %NLSV%
			{ ; Begin loop
				element := NLSV%A_Index%
				if (not(boolSkipEmptyTerms) or element != "") {
					sendEvent {raw} NLSV%A_Index% =>
					sendEvent {raw}%element%<= `n
				} ; End If
			} ; End loop
		} ; End If
	} ; End if
} ; End Function
