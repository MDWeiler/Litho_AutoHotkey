/*
  Pivot a TSV Table string
    (2x3)
    AREA`tPROCESS`tLOTID`nEFCC`t1222`tZ417EHJ0
    (3x2)
    AREA`tEFCC`nPROCESS`t1222`nLOTID`tZ417EHJ0
*/
Pivot_Function(strTSVtable){
  tblPriPivot := Array()
  strPivoted := ""
  numMaxElements := 0

  arrayOfLines := StrSplit(StrReplace(strTSVtable, "`r", ""), "`n")  ; Remove any `r then Split by Lines
  ; msgbox % arrayOfLines.Length()
  Loop % arrayOfLines.Length()
    {
      LineArray := StrSplit(arrayOfLines[A_Index], A_Tab) ; Split each lines by Elements (Tabs)
      tblPriPivot[A_Index] := LineArray
      numMaxElements := Max(numMaxElements,LineArray.Length())
    }
  ; msgbox %numMaxElements%
  
  ; Pivot The Table -- It is assumed each line has the same number of elements as the First Line
  Loop %numMaxElements%
    {
      eIndex := A_Index
      For lIndex in tblPriPivot
      {
        strPivoted := strPivoted . tblPriPivot[lIndex][eIndex] . "`t"
      }
    strPivoted := strPivoted . "`n"
  }

  clipboard = %strPivoted%
  ; SendEvent %strPivoted%

  return
}
