; Search object for value and return the index or Zero
HasVal(haystack, needle)
{ ; Begin Function
	
     ; Local Variables
	local returnIndex := 0 ; Default value
	local index, value
	
     ; If non empty object then search
	if (IsObject(haystack) && (haystack.Length() > 0)) {
	; loop through object looking for needle
		for index, value in haystack {
			if (value == needle) {
				returnIndex := index
			} ; End if
		} ; End For
	} ; End if
	
	return returnIndex
} ; End Function