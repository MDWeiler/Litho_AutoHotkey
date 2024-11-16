#SingleInstance force ; Automatically replace any instance of this script already running
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory -- This is not helpful when loading from a Shared Location
#IfWinActive ; Used to prevent any of the following
;    scripts from being window specific due to previous code
; #Warn                      ; Enable to see warnings to help detect common errors

/*

	These HotStrings manipulate information on the Clipboard
	ParseClipboardWithFilters(
		strListOfTerms:="[VIEW]",
		strEOLsequence:="{Enter}",
		boolClearField:=FALSE,
		boolSkipEmptyTerms:=TRUE)
*/

:*?:\\pst::		; Paste just the Text currently on Clipboard (No formating)
	Clipboard = %Clipboard% ; Saves only the Text portion of Clipboard to the Clipboard
	Send ^v
return

:*?:\\send::		; AHK Send to parse and "type" the Text currently on Clipboard without implied end of line characters
	Clipboard := StrReplace(StrReplace(Clipboard, "`r", ""), "`n", "") ; Saves only the Text portion of Clipboard to the Clipboard
	Send %Clipboard%
return

; An interesting in between would be one that escapes modifiers like !+^#{} but not keys like {tab} pattern: {\w+( ([0-9]+|up|down)){0,1}}
:*?X:\\type::TypeString(Clipboard)		; Type the Text unformated but allow AHK {keys}

; Consider combinding the four into one with a user form to select the desired output
:X:\\PC::ParseClipboard(TRUE)	; Parse Clipboard - Just refreshes Pattern Variable values (No output)
:*?:\\PC_All::		; Parse Clipboard - Refresh values and display All patterns and values
	ParseClipboard(TRUE)
	ListPatternedVariables(FALSE)
return
:*?:\\TSV::		; Parse Clipboard - Refresh values then display the contents of TSV pseudo array
	ParseClipboard(TRUE)
	ListPatternedVariables(,,"TSV")
return
:*?:\\CSV::		; Parse Clipboard - Refresh values then display the contents of CSV pseudo array
	ParseClipboard(TRUE)
	ListPatternedVariables(,,"CSV")
return
:*?:\\NLSV::	; Parse Clipboard - Refresh values then display the contents of NLSV pseudo array
	ParseClipboard(TRUE)
	ListPatternedVariables(,,"NLSV")
return
:X*?:\\PC_List::ListPatternedVariables(TRUE, FALSE)	; Parse Clipboard - Display all Pattern Variables with values
:X*?:\\PC_Show::ListPatternedVariables(FALSE, TRUE)	; Parse Clipboard - Display all Pattern Variables with values and the patterns

; *** Camel Case Product ***
:X*?:\\CCP::SendEvent % CamelCaseProduct(clipboard)		; Camel Case Product Name

; ***  EFCC Common Functions  ***
:*?:\\Const::		; APC3 (EFCC) Fill in Constants filter values 
	ParseClipboardWithFilters("Area:=EFCC,Technology:=1276,Scanner:=*,ReticleLayerID:=*,Reticle:=*,Operation:=*,OperGrp:=*,Process_OPN:=*,Product:=*,ProdGrp:=*,Route:=*,RouteGrp:=*,Name:=*", "{tab}", TRUE, FALSE)
return
:*?:\\States::		; APC3 (EFCC) Fill in States filter values 
	ParseClipboardWithFilters("Area:=EFCC,Technology:=1276,Scanner:=*,OperGrp:=*,ProdGrp:=*,ReticleLayerID:=*,RouteGrp:=*,Reticle:=*,Name:=*", "{tab}", TRUE, FALSE)
	; Replace the Copy ID with *
	Send {up}{home}{right 12}+{end}*
return
:*?:\\Prelook::		; APC3 (EFCC) Fill in Prelook form
	ParseClipboardWithFilters("Scanner,Reticle,Product,Route,Operation", "{down}", TRUE, FALSE)
return
:*?:\\PreRwk::		; APC3 (EFCC) Fill in Prelook Rework form
	ParseClipboardWithFilters("Scanner,Reticle,MES_Product:=MES,LotID,RWK_Num:=1,Operation", "{tab}", TRUE, FALSE)
return

; ***  AM Recipe PreLook  ***
:*?:\\F3SED::		; AM Recipe Prelook function for SED
	ParseClipboardWithFilters("LotID,Route,Product,Operation,Scanner,Has_SIF:=FALSE", "{down}")
return
:*?:\\F3DCCD::		; AM Recipe Prelook function for DCCD
	ParseClipboardWithFilters("CDSEM:=*,Operation,Product,Route,Scanner", "{down}")
return

; ***  LCA  ***
:*?:\\LCAca::		; Fill in the LCA CA Filter Form
	ParseClipboardWithFilters("Scanner,Product,Operation,Reticle,Route", "{tab}", TRUE, FALSE)
return
:*?:\\LCAadmin:: 	; Fill in the LCA Update Flag Admin Function Form
	ParseClipboardWithFilters("Reason:=Flag Update,IDSID:=%A_UserName%,Prelook:=Y,Metro_Prefix:=CD,SAHD_From:=NPI,SAHD_To:=LAHD,Entity,Product,Operation,Layer:=???,Reticle:=*,RegEx_Enable:=Y,Route:=ALL", "{down}", TRUE, FALSE)
return
:*?:\\CoMD:: 	; Fill in the ACE Create or Modify Dose request
	ParseClipboardWithFilters("Scanner,Product:=DEFAULT,Reticle,Operation:=DEFAULT,Route:=DEFAULT,Dose,MaxMoveFbOverride:=YES,CreateNewStates:=NO", "{tab}", TRUE)
return

; *** Reticle on Scanner
:*?:\\RetOnScan::	; Replace with [Reticle] on [Scanner]
	ParseClipboardWithFilters("Reticle,Scanner", " on ")
return

:*?:\\AutoEF::		; Parse Clipboard - Fill in Reticle and Scanner for AutoEF Searches
	ParseClipboard()
	SendEvent %FullReticle%
	SendEvent {tab 4}
	SendEvent +{Home}{Delete}  ; Clear any current Scanner value
	if (Scanner != "!None!") {
		SendEvent %Scanner%
	} ; End If
	SendEvent {enter}
return

; *** Lists of Things ***
:*?:\\LotList:: ; New line seperated list of Lot IDs
	SendEvent % ParseListOfValues(clipboard, ptrnLotID, "`n")
return
:*?:\\LDfav:: ; Formated list of lots ready for Lot Detail Favorites
	SendEvent % ParseListOfLotNotes(clipboard)
return
:*?:\\LotPlanList:: ; New line seperated list of Lot Plans
	SendEvent % ParseListOfValues(clipboard, ptrnLotPlan, "`n")
return
:*?:\\ListEMStemplates:: ; New line seperated list of EMS (COLA) Template IDs
	SendEvent % ParseListOfValues(clipboard, ptrnEMStemplate, "`n")
return

; *** Beyond Compare ***
:*?X:\\BCAM:: ; Fill in Beyond Compare Left side - Assume that there is an AM Reticle Settings row on the clipboard - Paste all but RowID and TimeStamp
	:*?X:\\BCleft::BeyondComparePaste("Left")	
:*?X:\\BCACE:: ; Fill in Beyond Compare Right side - Assume that there is a ACE Verification row on the clipboard - Paste all but TimeStamp
	:*?X:\\BCright::BeyondComparePaste("Right")

; *** Fillin COLA UI from Excel or BKM ***
:?*:\\COLA:: ; Fill in the COLA UI from the Clipboard
	ParseClipboard(TRUE)  ;  TRUE (Clear Empty Patterns) I do not want any old data to be kept
	Special_Paste(clipboard, "{Tab}{Sleep 5}", FALSE, TRUE)	; Pasting in COLA Template settings from BKM or Excel
	; Should end with the cursor on the PFC Pre-Check - Checkbox
	Send {tab 4} ; move to Enter Comments
	; Enter Comment
	Send %ReticleLayerID% EF on %Scanner%
return