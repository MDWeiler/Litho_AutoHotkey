/*
			Change the Product ID from the MES format to the Camel Case format
			Example: 8PX6CV   B to 8pX6cv-B0
*/
CamelCaseProduct(strInput)
{ ; Begin Function
	local strProduct, ucProduct, lcProduct, ccProduct, strStepping
	;msgbox strInput`n%strInput%
	RegExMatch(strInput, ptrnProduct, strProduct)
	;msgbox strInput`n%strInput%`nptrnProduct`n%ptrnProduct%`nstrProduct`n%strProduct%
	
	ccProduct := "" ; Inital Value    
	if (strProduct == "") {
        ; No Product Found - Do Nothing
	} else {
        ; StringUpper and StringLower are conversion functions - The output string is the first argument and strProduct is the input string
		StringUpper, ucProduct, strProduct
		StringLower, lcProduct, strProduct
		if (SubStr(strProduct,8,1) == " ") {
			strStepping := 0
		} else {
			strStepping := Asc(SubStr(ucProduct,8,1))-64
		} ; End if
		
		if (SubStr(strProduct,1,1) == "1") {
            ; Test Product 1X22CV   M --> 1x22Cv-M0
			ccProduct := SubStr(lcProduct,1,2) . SubStr(ucProduct,3,3) . SubStr(lcProduct,6,1) . "-" . SubStr(ucProduct,10,1) . strStepping
		} else {
            ; Product 8PESCV C A  --> 8pEScv-A3
			ccProduct := SubStr(lcProduct,1,2) . SubStr(ucProduct,3,2) . SubStr(lcProduct,5,2) . "-" . SubStr(ucProduct,10,1) . strStepping
		} ; End If
        ;msgbox ccProduct`n%ccProduct%
	} ; End If
	
	return %ccProduct%
	
} ; End Function
