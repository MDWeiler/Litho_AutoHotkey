ParseListOfValues(strHaystack, ptrnNeedle, strDelimiter) {
	; Return a string of matching values found in the string
	; This does support empty fields
	local numStartingPos := 1  ; RegExMatch Found Position - start at One
	local strMatch := ""       ; RegExMatch Output Variable - start Empty
	local listMatches := ""    ; String list of matches - start Empty

	while numStartingPos { ; numStartingPos will become Zero after the last find (Zero = False)
		numStartingPos := RegExMatch(strHaystack, ptrnNeedle, strMatch, numStartingPos)
		if (numStartingPos > 0) {
			numStartingPos := numStartingPos + StrLen(strMatch)
		  if (StrLen(listMatches) > 0){
			listMatches := listMatches . strDelimiter . strMatch 
		  } else {
			listMatches := strMatch 
		  } ; End If
		} ; End If
	  } ; End While
	
	  return %listMatches%

} ; end function

ParseListOfLotNotes(strHaystack){
	; Return formated string of LotIDs and Notes
	; This does support empty fields
	local ptrnLotNote := "(:\+:|- \[ \])\s+\K[[:graph:] ]+(\s+-->\s+)[[:graph:] ]+"

	; First extract the LotNotes
	local listMatches := ParseListOfValues(strHaystack, ptrnLotNote, "{sleep 10}{enter}{sleep 10}")

	; Replace the \s-->\s with {sleep 100}{tab}
	listMatches := StrReplace(listMatches, " --> ", "{sleep 10}{tab}")

	;Remove Wiki Link brackets
	listMatches := StrReplace(listMatches, "[[", "")
	listMatches := StrReplace(listMatches, "]]", "")

	;AutoHotkey Send Sanitize
	listMatches := StrReplace(listMatches, "!", "{!}")
	listMatches := StrReplace(listMatches, "+", "{+}")
	listMatches := StrReplace(listMatches, "^", "{^}")
	listMatches := StrReplace(listMatches, "#", "{#}")

	; MsgBox %listMatches%

	return %listMatches%

} ; end function