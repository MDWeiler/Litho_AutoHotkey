		/*
			Parse the Clipboard for possible
			terms using standard filtering
			Then based on how envoken return
			terms of interest in specific order
			---------------------------------------
			ParseClipboardWithFilters(strListOfTerms, strEOLsequence, boolClearField, boolSkipEmptyTerms)
			strListOfTerm - Comma seperated list of terms in the desired order
			Terms that do not map to a specific filters will be Blank
			Special Terms:
			[VIEW] - If the first Term is [VIEW] then 
			1) It is expected that a text editor is the focus
			2) First the Terms will be listed with parsed values
			3) Then Terms will will be listed again with filter parameters
			Terms that do not map to filter will display NO FILTER
			4) If no terms are provided then all terms will be outputed
			strEOLsequence [Default is the Enter key] - The string sequence to be sent after the value of the term
			boolClearField [Default is FALSE] - Clear the Field before Entering new values
			boolSkipEmptyTerms [Default is TRUE] - When FALSE then fields with empty terms will be cleared before the EOL sequence is sent
			
*/

ParseClipboardWithFilters(strListOfTerms:="[VIEW]", strEOLsequence:="{Enter}", boolClearField:=FALSE, boolSkipEmptyTerms:=TRUE)
{ ; Begin Function
	
    ; Parse Clipboard -- boolClearField
    ; Loop through provided terms
    ;   If term has := then
    ;       Header = text to the left of :=
    ;       If header has a global value then use it
    ;       else
    ;           Default Value = text to the right of :=
    ;           ptrnHeader = i)\b%Header%[ \t]*(\=|\||\:|)[ \t]*\K[\S ]+
    ;           if not(RegExp ptrnHeader, clipboard, matchHeader)
    ;               matchHeader := Default value
    ;   else
    ;       Header = term
    ;       matchHeader = %term%
    ;
    ;   If NotePad then
    ;       Output Header | Default value or Parsed value
    ;   Else
    ;       boolSkipEmptyTerms - When false the field is cleared {Home}+{end}{delete}
    ;       Ouptut matchHeader EOL
    ;
	
	local strHeader, strDefaultValue, strClipboard, valueMatch, strDefaultVariable
	
	ParseClipboard(boolClearEmptyTerms:=boolClearField)
	
	strClipboard = %Clipboard%
	
	; Loop Through Each Term
	Loop parse, strListOfTerms, `, 
	{ ; Begin Loop - If added to the end of a Loop Parse then it becomes part of the split variable
		if (InStr(A_LoopField, ":=") > 0) {
			strHeader := SubStr(A_LoopField, 1, InStr(A_LoopField, ":=")-1)
			valueMatch := %strHeader%
			if (valueMatch == "") {
				strDefaultValue := SubStr(A_LoopField, InStr(A_LoopField, ":=")+2)
				ptrnHeader := "i)\b" . strHeader . "[ \t]*(\=|\||\:|)[ \t]*\K[^:\s][\S ]+"
				if not(RegExMatch(strClipboard, ptrnHeader, valueMatch)) {
					if RegExMatch(strDefaultValue,"i)(?<=^%)[A-Z0-9\_]+(?=%$)",strDefaultVariable) {
						valueMatch := %strDefaultVariable%
					} else {
						valueMatch := strDefaultValue
					} ; end if
				} ; end if
			} ; end if
		} else {
			strHeader := A_LoopField
			valueMatch := %strHeader%
		} ; end if
		
		if WinActive("ahk_class Notepad") {
			SendEvent %strHeader%: {raw}%valueMatch%`n
		} else {
			if (A_Index > 1) {
				SendEvent %strEOLsequence%
			} ; end if
			if not(boolSkipEmptyTerms) {
				SendEvent {home}+{end}{delete}
			} ; end if
			; MsgBox {raw}-->%valueMatch%<-- 
			SendEvent {raw}%valueMatch%
			; send %strEOLsequence% -- I no longer want a EOL sequence after the last term
		} ; end if
	} ; end Loop
	
} ; End Function
