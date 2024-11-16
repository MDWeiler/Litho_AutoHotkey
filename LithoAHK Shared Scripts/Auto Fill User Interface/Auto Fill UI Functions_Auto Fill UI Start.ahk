Auto_Fill_UI_Start(strAutoFillType)
{ ; Begin Function
    if (strAutoFillType = "SIF") {
        if     WinActive("Add SIF") 
            or WinActive("Approve SIF") 
            or WinActive("Edit SIF") 
            or WinActive("[ Add ] SIF Flag") 
            or WinActive("[ Edit ] SIF Flag") {
                Auto_Fill_UI("SIF", True)
        } else {
                Auto_Fill_UI("SIF", False)
        } ; End If
    } else if (strAutoFillType = "Comment") {
        Auto_Fill_UI("Comment",True)
    } else if (strAutoFillType = "Comment_Test") {
        Auto_Fill_UI("Comment",False) 
    } else {
        MsgBox (1) Unknown Auto Fill Type: %strAutoFillType%
    }
    
    return
} ; End Function
