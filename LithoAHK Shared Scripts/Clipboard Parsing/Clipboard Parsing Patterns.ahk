#SingleInstance force ; Automatically replace any instance of this script already running
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory -- This is not helpful when loading from a Shared Location
#IfWinActive ; Used to prevent any of the following
;    scripts from being window specific due to previous code
; #Warn                      ; Enable to see warnings to help detect common errors

;  ***************************************
;    Global Patterns and Match Variables
;  ***************************************
;    \b word boundary anchor
;    \w word character [a-zA-Z_0-9]
;    \K the pattern to the left must be present to return the match (pattern to the right)
;        Example: foo\Kbar returns bar with foobar as input but returns no matches with handlebar as input
;    (?<=...) Positive (Pattern has to match) Look-ahead (look for pattern to the left) this is the same as \K example: (?<=foo)bar
;     (?=...) Positive Look-behind (look for pattern after the match)
;    (?<!...) and (?!...) are Negative Look-ahaed/behinds - the "look for pattern" needs to be absent
;
;

AddPatterns(){

    ; AddPattern(strPatternName, strPattern, boolHotString:=False)

    ; List of Global Variables with Patterns
    global listPtrnVars := []

    ; Signed Number -- This is for testing, not normal use
    ; AddPattern("SignedNumber", "(\+|\-|)[0-9]*(\.|)[0-9]+")

    ; ParseSeperatedValues Patterns - Placed here for Information purposes only - This way they will show in the HTML list
    AddPattern( "TSV", "Tab Seperated Values in pseudo array")
    AddPattern( "CSV", "Comma Seperated Values in pseudo array")
    AddPattern("NLSV", "New Line Seperated Values in pseudo array")

    ; Reticle Patterns - 1P22CEDCBMAA1, 1X22SAADP1AA1, 1X22SAADP1AA*, 1X22SAADP* and 1X22SAADP (The last three are common wildcarding patterns in recipes)
    AddPattern(       "Reticle","(\b[18][8A-Z][A-Z0-9]{4}[A-Z0-9]{3}(\*|[A-Z0-9][A-Z]{2}(\*|[0-9]{1,}){0,1}){0,1}|Reticle(\t| )*:(\t| )*\K[A-Z0-9\*\?]+)", True)
    AddPattern(   "FullReticle","\b[18][8A-Z][A-Z0-9]{4}[A-Z0-9]{3}[A-Z0-9][A-Z]{2}[0-9]{1,2}\b")
    AddPattern("ReticleProduct","\b[18][8A-Z][A-Z0-9]{3}[A-Z]") ; Added the additional requirement that the last character is a letter - this will prevent matching operation numbers that start with 18
    AddPattern("ReticleLayerID","(\b[18][8A-Z][A-Z0-9]{4}\K[A-Z0-9]{3}|ReticleLayerID(\t| )*:(\t| )*\K[A-Z0-9\*\?]+)")
    AddPattern(       "LayerID","\b[18][8A-Z][A-Z0-9]{4}\K[A-Z0-9]{3}", True)
    AddPattern("ReticlePlateID","\b[18][8A-Z][A-Z0-9]{4}[A-Z0-9]{3}\K[M0-9][A-Z][A-Z\*][0-9\*]+")

    ; Route Pattern
    AddPattern("Route","(AU|DP|RG|[ADEILMNPRTWZ][CN]|[HKSV]C|[GRT]W|[BF]L|[FRS]E)([0-9A-Z]{2})?\.[0-9A-Z]{1,6}", True)
    AddPattern("RouteShort","(AU|DP|RG|[ADEILMNPRTWZ][CN]|[HKSV]C|[GRT]W|[BF]L|[FRS]E)([0-9A-Z]{2})?\.[0-9A-Z]", False)

    ; Operation Pattern
    ; AddPattern("Operation","\b([1-9][0-9]{5}|[0-9]{4})\b") -- Allows both 4 and 6 digit operations
    AddPattern(       "Oper","(\b([1-9][0-9]{5}(\||))+\b|Oper(ation)?(\t| )*:(\t| )*\K[0-9\*\?]+)", True) ; Only Allows 6 digit operations
    AddPattern(  "Operation","(\b([1-9][0-9]{5}(\||))+\b|Oper(ation)?(\t| )*:(\t| )*\K[0-9\*\?]+)") ; Only Allows 6 digit operations
    AddPattern(       "Desc","[1A-Z][\ \*\-][\ \#]?[^A-Z]+[A-Z][A-Z0-9]{2}[\ A-Za-z0-9]*",True)
    ; AddPattern("DescLayerID","[A-Z12][\ \#\*\-][\ \#A-Za-z0-9]{1,2}\K[A-Z0-9]{3}",False)
    AddPattern("DescLayerID","[1A-Z][\ \*\-][\ \#]?[^A-Z]+\K[A-Z][A-Z0-9]{2}",False)
    AddPattern( "Technology","\b12[0-9]{2}\b",False)

    ; Product Patterns
    AddPattern(  "Product","(\b[18]([8A-Z]|\[[8A-Z]{2,}\])(([A-Z0-9]|\[[A-Z0-9]{2,}\])){3}[AV] ([A-Z ?]|\[[A-Z ]{2,}\]) ([A-Z?]|\[[A-Z]{2,}\])|Product(\t| )*:(\t| )*\K[A-Z0-9\*\?\[\]][A-Z0-9\ \*\?\[\]]+)", True)
    AddPattern("CCproduct","\b[18][8a-z][A-Za-z0-9]{3}[av]-[A-Z][0-9]+")

    ; Entity Patterns - SNU06, SNQ472, PRT06 and CDM451 (The first two are also Scanners and the Last is a CDSEM) - ALL (in caps) is a valid Entity and CDSEM, but not Scanner
    AddPattern( "Entity","\b(ALL|[A-Z]{3}[0-9]{2,3})", True)
    AddPattern("Scanner","(\bS[A-Z]{2}[0-9]{2,3}|Scanner(\t| )*:(\t| )*\K[A-Z0-9\?\*]+)", True)
    AddPattern(  "CDSEM","(\b(ALL|CD[A-Z][0-9]{2,3})|CDSEM(\t| )*:(\t| )*\K[A-Z0-9\?\*]+)")

    ; LotID Patterns - D113RG00M, D113RG0R1, D113RG0, D113RG00, D113RG0 but not D113RG00R123 (too long) or D113RG (too short)
    AddPattern(      "LotID","\b[A-Z][0-9](0[1-9]|[1-4][0-9]|5[0-3])[A-Z0-9]{3}[A-Z0-9]{0,4}\b", True)
    AddPattern(     "Lot7ID","\b[A-Z][0-9](0[1-9]|[1-4][0-9]|5[0-3])[A-Z0-9]{3}")
    AddPattern(    "LotPlan","\bDLP[0-9]{6,}.[0-9]+\b", True)
    AddPattern("EMStemplate","\bDET[0-9]{6,}.[0-9]+\b", True)

    ; Other useful patterns
    AddPattern("SAHD_FROM","i)(SAHD_|)(FROM|CD)(:|\s)\s*\K[A-Z0-9]+")
    AddPattern(  "SAHD_TO","i)(SAHD_|)TO(:|\s)\s*\K[A-Z0-9]+")
    AddPattern(     "Dose","i)\b[0-9]{1,2}\.[0-9]{1,3}(\b|(?=mj))", True)
    AddPattern(    "idsid","i)\b(amr\\|)[a-z]{5,}[0-9]*\b", True)
    AddPattern(   "SPECid","i)\b[0-9]{4}-[0-9]{2}-[0-9]{4}-[0-9]{3}\b", True)

    ; Email Patterns
    AddPattern(  "eMail_From",   "i)\bFrom:\s*\K([[:alnum:]\, ]+(?=Sent:)|[[:alnum:]\, ]+\b)")
    AddPattern(  "eMail_Sent",   "i)\Sent:\s*\K([[:alnum:], -]+(?=Subject:)|[[:alnum:], -]+\b)")
    AddPattern(  "eMail_Subject","i)\Subject:\s*\K.+")

    ; CDSEM Patterns - 22eng_22x22aa_c/va4_ef/2
    AddPattern("CDSEMrecipeFull","\w{3,}\/\w{3,}\/[1-9][0-9]*")
    AddPattern(     "CDSEMclass","\w{3,}(?=\/\w{3,})")
    AddPattern(    "CDSEMrecipe","\w{3,}\/\K\w{3,}")
    AddPattern(    "CDSEMwafers","i)(\w{3,}\/\w{3,}\/\K[1-9][0-9]*|SIF(\_|\ )WAFERS(\=|)\s*\K[A-Z0-9\,]+)")
    AddPattern(      "ChipShift","i)CHIPSHIFT\s*(\=|\||\:|)\s*\K(\+|\-|)[0-9]+,(\+|\-|)[0-9]+")

    ; SIF Parameters - Headers are required
    AddPattern( "ReworkBehavior", "i)\b(Rework|Behavior)[\s\=\:\|]*\K(Approve|Pending|Remove)\b")
    AddPattern(       "GateQual", "i)Gate([ \_]?Qual)?[\s\=\:\|]*\K(TRUE|FALSE)")
    AddPattern(       "ChemQual", "i)Chem([ \_]?Qual)?[\s\=\:\|]*\K(TRUE|FALSE)")
    AddPattern(       "Exposure", "i)\b((EFCC )?DOSE|EX)[\s\=\:\|]*\K(AUTO|\[BLANK\]|-1|\+?[0-9]{2}(\.[0-9]{0,3})?)", True)
    AddPattern(  "ValidExposure", "i)\b((EFCC )?DOSE|EX)[\s\=\:\|]*\+?[0-9]{2}(\.[0-9]{0,3})?", False) ; Looking for valid dose values and source (Not -1, AUTO or [BLANK])
    AddPattern(  "ExposureSteps", "i)(ES|DOSE[ \_]?STEP(S|))[\s\=\:\|]*\K(\+|\-|)[0-9]*(\.|)[0-9]+")
    AddPattern(  "ExposureDelta", "i)(DEX|DOSE[ \_]?DELTA)[\s\=\:\|]*\K(\+|\-|)[0-9]*(\.|)[0-9]+")
    AddPattern(    "FocusCenter", "i)(FC|FOCUS)[\s\=\:\|]*\K(\[BLANK\]|[\+\-]?(0?\.[0-9]+|0))", True)
    AddPattern(     "FocusSteps", "i)(FS|FOCUS[ \_]?STEPS?)[\s\=\:\|]*\K(\+|\-|)[0-9]*(\.|)[0-9]+")
    AddPattern(     "FocusDelta", "i)(DFC|FOCUS[ \_]?DELTA)[\s\=\:\|]*\K(\+|\-|)[0-9]*(\.|)[0-9]+")
    AddPattern(          "Xtilt", "i)(x[ \_]?Tilt|RX|LCOY)[\s\=\:\|]*\K(\+|\-|)[0-9]*(\.|)[0-9]+")
    AddPattern(          "Ytilt", "i)(y[ \_]?Tilt|RY|LCOX)[\s\=\:\|]*\K(\+|\-|)[0-9]*(\.|)[0-9]+")
    AddPattern(            "SPR", "i)(SIF_SPR_WIP_ASSOCIATION|SPR|SPR[ \_]?WIPA)[\s\=\:\|]*\K(TRUE|FALSE)")
    AddPattern(            "SRC", "SRC[\s\=\:\|]+\K\S{2,}")
    AddPattern(      "SCNRalign", "i)SC(NR|ANNER)[ \_]?ALIGN[\s\=\:\|]+\K\S{2,}")
    AddPattern(       "SIFinput", "i)SIF[ \_]?INPUT[\s\=\:\|]+\K\S{2,}")
    AddPattern(  "ScannerRecipe", "i)(\?|SC(NR|ANNER)[ \_]?RECIPE[\s\=\:\|]+\K[\/\w]{2,}", True)
    AddPattern(    "TrackRecipe", "i)TRACK[ \_]?RECIPE[\s\=\:\|]+\K\S{2,}", True)
    AddPattern(          "AGILE", "\/pdoc_\K\w+", True)
    AddPattern(          "Pilot", "i)PILOT([ \_]?NAME)?[\s\=\:\|]+\K\S{2,}")
    AddPattern(        "LCAflag", "i)LCA([ \_]?Flag)?[\s\=\:\|]+\K\S{2,}")
    
    
    ; Date Time Pattern - Matches YYYY?MM?DD?HH:mm(:ss)
    AddPattern("ClipboardDateTime", "\b(19|20)[0-9]{2}[^0-9][0-2][0-9][^0-9][0-3][0-9][^0-9][0-2][0-9]:[0-5][0-9](:[0-5][0-9])?")

    ; Simple email pattern for intel.com addresses
    AddPattern("IntelEmail","i)[A-Z0-9\._-]+@(|[A-Z0-9\._-]+\.)intel\.com")

    ; SIF Parameters - Between Tags
    AddPattern("ModuleOwnerInst", "i)<moi>\K[\w\W]+(?=<\/moi>)")
    AddPattern(    "SignOutInst", "i)<soi>\K[\w\W]+(?=<\/soi>)")
    AddPattern(   "DispoComment","i)(<h[1-6]>.+<\/h[1-6]>|<dc>\K[\w\W]+(?=<\/dc>)|Disposition Comment\s*(\=|\||\:|)\s*\K.+)") ; If having trouble verify that the closing tag is correct </h#>

} ; end function
