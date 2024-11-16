ParseSeperatedValues(strString, strSeperationToken, pseudoArrayName) {
	; Values are seperated by Token and\or New Line characters
	; This does not support escaping the seperation token
	; This does support empty fields
	global ; This will force the pseudo array elements to be global
	local index, value
	local pseudoArrayElement := "Empty"
	local StartingPos := 1
	local OutVariable := "Empty"
	local ReturnArray := []
	local ptrnSeperatedValues := "(^|" . strSeperationToken . "|\v)\K[^" . strSeperationToken . "\v]*(?=($|" . strSeperationToken . "|\v))"
	local FoundPos := RegExMatch(strString, ptrnSeperatedValues, OutVariable, StartingPos)
	if(FoundPos == 1 and StrLen(OutVariable) == 0){
		; If strString starts with the strSeperationToken it needs a little help
		;   There may be a better RegEx pattern to get around this
		ReturnArray.push("")
		strString := " " . strString
		StartingPos := 2
	} ; end if
	if (StrLen(strString) > 0) {
		while (FoundPos > 0)
		{ ; Begin Loop
			FoundPos := RegExMatch(strString, ptrnSeperatedValues, OutVariable, StartingPos)
			If (FoundPos > 0) {
				ReturnArray.push(OutVariable)
				; tempLength := strLen(OutVariable)
				; msgbox %StartingPos% / %FoundPos% -->%OutVariable%<-- (%tempLength%)
				StartingPos := FoundPos + StrLen(OutVariable)
			} ; end if
		} ; end loop

		for index, value in ReturnArray
		{ ; Begin Loop
			pseudoArrayElement := pseudoArrayName . index
			%pseudoArrayName% := index ; The name of the pseudoArray will contain the total number of elements
			%pseudoArrayElement% := value
			; OutVariable := %pseudoArrayElement%
			; send %pseudoArrayElement% := %OutVariable%{enter}
		} ; End Loop

		; OutVariable := %pseudoArrayName%
		; send %pseudoArrayName% has %OutVariable% elements{enter}
	} ; end if
} ; end function
