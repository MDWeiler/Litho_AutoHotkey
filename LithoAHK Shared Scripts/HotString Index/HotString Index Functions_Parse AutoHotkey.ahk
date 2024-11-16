ParseAutoHotkey()
{ ; Begin Function
	
	local ; Keep variables local
	moduleTesting := False
	listFilesToSkip := ["Litho CDSEM Tools","Litho Scanners"]
	listFilesParsed := []
	listFilesToParse := ["LithoAHK.ahk"]
	htmlHotStrings := "<tr><th ColSpan='3'><h1>Hot Strings</h1></th></tr>"
	
	; Loop through listFilesToParse
	Loop {
		if (moduleTesting) {
			MsgBox % "Files in list to parse: " . listFilesToParse.Count()
		}

		; Pop file from list
		strFileToParse := listFilesToParse.RemoveAt(1)
		listFilesParsed.push(strFileToParse)

		if (moduleTesting) {
			MsgBox % "Next File to maybe Parse:`n" . strFileToParse
		}
		
		RegExMatch(strFileToParse, "O)((?P<Path>^.*\\)|^)(?P<File>.*)\.(?P<Ext>[[:alnum:]]+)$", objFileToParse)
		
		if (moduleTesting) {
			MsgBox % "File Name:`n" . objFileToParse.File
		}

		; If file is not in the listFilesToSkip then
		if (HasVal(listFilesToSkip, objFileToParse.File) == 0) {

			if (moduleTesting) {
				MsgBox % "Sending to Parse File function:`n" . strFileToParse
			}

			ParseFileForHotStringsAndIncludes(strFileToParse, listFilesToParse, htmlHotStrings)

		} ; End if
	; Loop through listFilesToParse
	} Until (listFilesToParse.Count() == 0)

	; Create and Open HotString Index File
	GenerateHTMLfile(htmlHotStrings)	
	
} ; End Function