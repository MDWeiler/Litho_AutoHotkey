; Focused Control:
; Right: ClassNN:	TUiEditorWindow.UnicodeClass3
; Left:  ClassNN:	TUiEditorWindow.UnicodeClass4
; Window Title:     New Text Compare - Text Compare - Beyond Compare

BeyondComparePaste(BCside:="None") {
	
	global  ; Give access to the TSV values		
	local strValuesToPaste, strClipboard

	ParseClipboard()
	
	if (BCside == "Left") {
		; Assume that there is an AM Reticle Settings row on the clipboard - Paste all but RowID and TimeStamp
		strValuesToPaste = %TSV2%`t%TSV3%`t%TSV4%`t%TSV5%`t%TSV6%`t%TSV7%`t%TSV8%`t%TSV9%`t%TSV10%`t%TSV11%`t%TSV12%`t%TSV13%`t%TSV14%`t%TSV15%`t%TSV17%
		Clipboard = %strValuesToPaste%
		Sleep 100
		Send {blind}{Ctrl up}{v up}+{Insert}
	} else if (BCside == "Right") {
		; Assume that there is a ACE Verification row on the clipboard - Paste all but TimeStamp
		strValuesToPaste = %TSV1%`t%TSV2%`t%TSV3%`t%TSV4%`t%TSV5%`t%TSV6%`t%TSV7%`t%TSV8%`t%TSV9%`t%TSV10%`t%TSV11%`t%TSV12%`t%TSV13%`t%TSV14%`t%TSV16%
		Clipboard = %strValuesToPaste%
		Sleep 100
		Send {blind}{Ctrl up}{v up}+{Insert}
	} else {
		MsgBox Unknown Side: %BCside%
		exit
	}
	
	return
} ; End Function
