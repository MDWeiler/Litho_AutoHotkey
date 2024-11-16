ParseFileForHotStringsAndIncludes(strFileToParse, ByRef listFilesToParse, ByRef htmlHotStrings)
{ ; Begin Function
	
	local ; Keep variables local
	moduleTesting := False
	boolCommentBlock := False
	strHotString := ""
	boolFirstHotString := True
	RegExPattern := "Oi)((^:.*:|^)(?P<ahkString>(\!|\+|\^|\#|)[^\s]+)(?=::)(.+;\s+(?P<ahkComment>((?P<IndexExclude>\<IndexExclude\>)|).+$)|)|#Include (?P<IncludeFile>.+\.ahk)|\s*(;|)\s*(?P<IndexCmt>\<IndexCmt\>)\s+(?P<LineComment>.+$))"
	strRegExResult := ""
	
	; Seperate out File Name
	RegExMatch(strFileToParse, "O)((?P<Path>^.*\\)|^)(?P<File>.*)\.(?P<Ext>[[:alnum:]]+)$", objFileToParse)

	;strFileToParse := A_ScriptDir . "\" . strFileToParse

	if (moduleTesting) {
		MsgBox % "Parsing :`n" . strFileToParse
	} ; end if

	boolCommentBlock := False ; Set initial state
	boolFirstHotString := True ; Set initial state
	; Loop through file
	loop read, %strFileToParse%
	{ ; Begin Read Loop
		
		RegExMatch(A_LoopReadLine, RegExPattern, strRegExResult)
		
		if (moduleTesting) {
			if (strRegExResult["ahkString"]) {
				msgbox % strRegExResult["ahkString"] . "`n->" . strRegExResult["ahkComment"] . "<-`n->" . strRegExResult["IndexExclude"] . "<-"
			} ; end if
		
			; msgbox % A_LoopReadLine . "`n->" . strRegExResult["IndexCmt"] . "<-`n->" . strRegExResult["LineComment"] . "<-`n" . (!(strRegExResult[IndexCmt] == "<IndexCmt>"))
		} ; end if
		
		; If within a Comment block then and the Line is not an Index Comment
		if ((boolCommentBlock) && !(strRegExResult["IndexCmt"])) {
		; If End of Comment Block then boolCommentBlock := False
			if (SubStr(Trim(A_LoopReadLine), 1, 2) == "*/") {
				boolCommentBlock := False
			} ; End If
		} else {
			
			if (SubStr(Trim(A_LoopReadLine), 1, 2) == "/*") {
				boolCommentBlock := True
			} else if (strRegExResult["IndexCmt"]) {
				if (boolFirstHotString) {
					boolFirstHotString := False
					htmlHotStrings := htmlHotStrings . "<tr><th ColSpan='3'><br/><h2>" . objFileToParse.File . "</h2></th></tr>`n"
				} ; End if
				htmlHotStrings := htmlHotStrings . "`t<tr><td ColSpan = '3' style='text-align:center;'>" . strRegExResult["LineComment"] . "</td></tr>`n"
			} else if (strRegExResult["IncludeFile"]) {
				; Test Included file name:
					; If in listFilesParsed then Skip file
					; If in listFilesToParse then Skip file
				if ((HasVal(listFilesParsed, strRegExResult["IncludeFile"]) == 0) || (HasVal(listFilesToParse, strRegExResult["IncludeFile"]) == 0)) {
					if (moduleTesting) {
						MsgBox % "Adding Include File:`n" . strRegExResult["IncludeFile"]
					} ; end if
					listFilesToParse.push(strRegExResult["IncludeFile"])
				} ; end if
			} else if (strRegExResult["ahkString"] && !strRegExResult["IndexExclude"]) {
				
				strHotString := strRegExResult["ahkString"]

				if (moduleTesting) {
					MsgBox % "Adding HotString: " . strHotString
				} ; end if
				
				; Replace (! Alt) (+ Shift) (^ Ctrl) (# Windows) and add + between them if the HotString starts with one
				if (InStr("+!^#", SubStr(strHotString,1,1)) > 0) {
					strHotString := StrReplace(StrReplace(StrReplace(StrReplace(strHotString, "+", "Shift + ",,1), "!", "Alt + ",,1), "^", "Ctrl + ",,1), "#", "Windows + ",,1)
				} ; End if
				
				if (boolFirstHotString) {
					boolFirstHotString := False
					htmlHotStrings := htmlHotStrings . "<tr><th ColSpan='3'><br/><h2>" . objFileToParse.File . "</h2></th></tr>`n"
				} ; End if
				htmlHotStrings := htmlHotStrings . "`t<tr><td style='text-align:right;'>" . strHotString . "</td><td>&nbsp;</td>"
				; Add Hot String Comment if any
				htmlHotStrings := htmlHotStrings . "<td>" . strRegExResult["ahkComment"] . "</td></tr>`n"
			} ; End if
		} ; End if
	} ; End Loop through file

} ; End Function