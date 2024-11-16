TypeString(strStringToType) {
	
	; Replacement Strings
	strKeyOpen  := "<<keY_opeN>>"  ; Replacement for {
	strKeyClose := "<<keY_closE>>" ; Replacement for }
	
	; Replace `r`n with just `n
	strStringToType := StrReplace(strStringToType, "`r`n", "`n")
	
	; For Each Key replace the { and } with <<keY_opeN>> and <<keY_closE>>
	patternKeys := "i){\w+( ([0-9]+|up|down)){0,1}}"
	intKeyPos := RegExMatch(strStringToType, patternKeys, strKey)
	while (intKeyPos > 0) 
	{ ; Begin Loop
		; MsgBox %strKey%
		strStringToType := StrReplace(strStringToType, strKey, StrReplace(StrReplace(strKey, "{", strKeyOpen), "}", strKeyClose))
		intKeyPos := RegExMatch(strStringToType, patternKeys, strKey, intKeyPos+1)
	} ; End Loop
	
	; Escape any remaining { or } -- Using the KeyOpen and Close to keep the 2nd replacement from turning {{} into {{{}}
	strStringToType := StrReplace(strStringToType, "{", strKeyOpen . "{" . strKeyClose)
	strStringToType := StrReplace(strStringToType, "}", strKeyOpen . "}" . strKeyClose)
	
	; Revert the Key Open and Close replacement strings back to { and }
	strStringToType := StrReplace(strStringToType, strKeyOpen,  "{")
	strStringToType := StrReplace(strStringToType, strKeyClose, "}")
	
	; Escape Modifiers
	strStringToType := StrReplace(strStringToType, "!", "{!}")
	strStringToType := StrReplace(strStringToType, "+", "{+}")
	strStringToType := StrReplace(strStringToType, "^", "{^}")
	strStringToType := StrReplace(strStringToType, "#", "{#}")
	
	; Send the results
	Send %strStringToType%
	
} ; End Function