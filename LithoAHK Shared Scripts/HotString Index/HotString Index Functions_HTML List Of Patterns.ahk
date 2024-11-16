htmlListOfPatterns() {
	
	global listPtrnVars	
	if (listPtrnVars = "") {
		htmlPatternsTable := "&nbsp;"
	} else {
		htmlPatternsTable := "<table><tr><td ColSpan='2' style='text-align:left;'><big><big><b>Pattern Variables</b></big></big>&nbsp;&nbsp;&nbsp;(** HotString available for pattern)<br/>&nbsp;</td></tr>"
		
		for index, element in listPtrnVars {    
			RegExOutVar  := element[1]
			boolHotString := element[2]
			RegExPattern := "ptrn" . RegExOutVar
			RegExPattern := %RegExPattern%
			
			if (boolHotString) {
				htmlPatternsTable := htmlPatternsTable . "<tr><td><b>" . RegExOutVar . "<big>**</big></b></td><td>" . RegExPattern . "</td></tr>"
			} else {				
				htmlPatternsTable := htmlPatternsTable . "<tr><td>" . RegExOutVar . "</td><td>" . RegExPattern . "</td></tr>"
			} ; End if
		} ; end Loop
	} ; end if
	
	return htmlPatternsTable
} ; End Function
