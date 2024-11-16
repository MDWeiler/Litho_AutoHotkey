ParseClipboard(boolClearEmptyTerms:=FALSE, strStringToParse:="") {

	; Input:
	;   Clipbard will be saved as raw text to strStringToParse
	;   boolClearEmptyTerms - When True any pattern that does not match will clear the associated global variable if any
	;   boolView - When True then a verbose description of the Matches will be displayed (Mostly for Debugging)

	local strViewMessage, strOldValue, RegExOutVar, boolHotString, strHotStringReplace, RegExPattern, index, element

	; If a string is not provided then use the Clipboard
	if (strStringToParse == "") {
		strStringToParse := clipboard
		strViewMessage = Parsing the Clipboard text:`n{raw}%strStringToParse%
	} else {
		strViewMessage = Parsing the supplied text:`n{raw}%strStringToParse%
	} ; end if

	; send %strViewMessage%`n

	for index, element in listPtrnVars {
		RegExOutVar := element[1]
		boolHotString := element[2]
		RegExPattern := "ptrn" . RegExOutVar
		RegExPattern := %RegExPattern%
		strOldValue := %RegExOutVar%
		; send {raw}`n  %RegExOutVar%`n------------------------------`n
		if (RegExMatch(strStringToParse, RegExPattern, %RegExOutVar%)) {
			; send Pattern: {raw}%RegExPattern%`n
			; send %RegExOutVar% =>
			; RegExOutVar := %RegExOutVar%
			; send {raw}%RegExOutVar%<=`n
		} else if not(boolClearEmptyTerms) {
			%RegExOutVar% := strOldValue
		} ; end if

	} ; end for loop

	; Parse strStringToParse for Tab Seperated Values
	ParseSeperatedValues(strStringToParse, "\t", "TSV")
	; Parse strStringToParse for Comma Seperated Values
	ParseSeperatedValues(strStringToParse, ",", "CSV")
	; Parse strStringToParse for CRLF Seperated Values
	ParseSeperatedValues(strStringToParse, "\v", "NLSV")

} ; End Function
