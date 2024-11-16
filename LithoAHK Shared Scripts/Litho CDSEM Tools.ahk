#SingleInstance force ; Automatically replace any instance of this script already running
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases
SendMode Input ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory -- This is not helpful when loading from a Shared Location
#IfWinActive ; Used to prevent any of the following
;    scripts from being window specific due to previous code
; #Warn                      ; Enable to see warnings to help detect common errors

/*
    Auto Correction Syntax (Called Hotstrings in the manual)
      :[Options]:[What You Type]::[What to Replace it with]
	  Options: (common)
		* - Removes the need for an end character before the HotSting fires
		b0 - prevents the backspacing that clears the HotString
        ? - Allow within word replacements (:*?:al::line would replace the al in cal with line resulting in cline)
      Special Characters need to be wrapped in {} to use normally Example: Hello World{!}
        ! - Alt Key
        + - Shift Key
        ^ - Ctrl
        # - Window Key
        { and } - Escape braces
      Extra Special Characters when using Transform
        % needs to be escaped with `` --> ``%
        ` needs to be double escaped --> ````
*/

/*
	CDSEM Passwords
    Old Passwords: control venice02
*/

;Tools using password london01 -- View only Password is view
;    One document listed "london 1" as a passdown, but I am not sure it the space was not a mistake
:*:\\pwCDK440::
:*:\\pwCDK443::
:*:\\pwCDK447::
:*:\\pwCDK449::
:*:\\pwCDK451::
:*:\\pwCDK453::
:*:\\pwCDK472::
  Send london01{enter}
return

;Tools using password gemini02
:*:\\pwCDK441::
:*:\\pwCDK446::
  Send gemini02{enter}
return

;Tools using password harmony01
:*:\\pwCDK414::
:*:\\pwCDK415::
:*:\\pwCDK416::
:*:\\pwCDK417::
:*:\\pwCDK421::
:*:\\pwCDK442::
:*:\\pwCDK444::
:*:\\pwCDK445::
:*:\\pwCDK465::
:*:\\pwCDK467::
  Send harmony01{enter}
return

;Tools using password venice01 -- View only Password is venice (Verified 2022-08)
:*:\\pw74CuOLE::
:*:\\pw74NCOLE::
:*:\\pw76OLE::
:*:\\pw76CuOLE::
:*:\\pw76NCOLE::
:*:\\pw78OLE::
:*:\\pw78CuOLE::
:*:\\pw78NCOLE::
:*:\\pwCDK405::
:*:\\pwCDK406::
:*:\\pwCDK413::
:*:\\pwCDK418::
:*:\\pwCDK419::
:*:\\pwCDK420::
:*:\\pwCDK452::
:*:\\pwCDK454::
:*:\\pwCDK464::
:*:\\pwCDK466::
:*:\\pwCDK471::
:*:\\pwCDP499::
  Send venice01{enter}
return

;Hi Frame User and Password - the user number can be 0 - 9
:*:\\pwHiFrame::cduser7{tab}Cduser{enter}

/*
    IP Addresses
*/

; == OLEs ==
:*:\\74CuOLE::10.8.56.161
:*:\\74NCOLE::10.8.56.139

:*:\\76OLE::
:*:\\76CuOLE::
:*:\\76NCOLE::
  Send 10.8.56.160
Return

:*:\\78OLE::
:*:\\78CuOLE::
:*:\\78NCOLE::
  Send 10.8.56.163
Return

:*:\\VFOLE::10.8.56.180

; == Hi Frame ==
:*:\\HiFrame::10.8.56.172/iframe_web/login.jsp

; == CDH Tools ==
:*:\\CDH60::10.6.112.192
:*:\\CDH61::10.6.112.194
:*:\\CDH62::10.6.112.193
:*:\\CDH63::10.6.112.195
:*:\\CDH64::10.6.112.196
:*:\\CDH65::10.6.112.197
:*:\\CDH417::10.8.44.166
:*:\\CDH421::10.8.44.182
:*:\\CDH422::10.8.44.184
:*:\\CDH423::10.8.44.187
:*:\\CDH424::10.8.44.188
:*:\\CDH425::10.8.44.213

; == CDK Tools ==
:*:\\CDK72::10.6.112.216
:*:\\CDK73::10.6.112.156
:*:\\CDK90::10.8.123.28
:*:\\CDK401::10.15.167.15	;  p1276 NC Engineering Tool
:*:\\CDK402::10.15.167.17
:*:\\CDK403::10.15.167.19
:*:\\CDK404::10.15.167.21
:*:\\CDK405::10.15.167.23	;  p1276 Cu Engineering Tool
:*:\\CDK406::10.15.167.27	;  p1276 Cu Engineering Tool
:*:\\CDK407::10.15.167.30
:*:\\CDK408::10.15.167.32
:*:\\CDK409::10.15.167.34
:*:\\CDK410::10.15.167.43
:*:\\CDK411::10.15.167.45
:*:\\CDK412::10.15.167.47
:*:\\CDK413::10.15.167.49	;  p1276 NC Engineering Tool
:*:\\CDK414::10.15.167.53
:*:\\CDK415::10.15.167.81
:*:\\CDK416::10.15.167.91
:*:\\CDK417::10.15.167.93
:*:\\CDK418::10.15.167.95	;  p1276 NC Engineering Tool
:*:\\CDK419::10.15.167.97
:*:\\CDK420::10.15.167.99	;  p1276 NC Engineering Tool
:*:\\CDK421::10.15.170.228
:*:\\CDK422::10.15.167.127
:*:\\CDK432::10.8.167.98
:*:\\CDK434::10.8.167.75
:*:\\CDK436::10.8.167.79
:*:\\CDK438::10.8.167.81
:*:\\CDK439::10.8.167.83
:*:\\CDK440::10.8.167.87
:*:\\CDK441::10.8.167.77
:*:\\CDK442::10.8.167.71
:*:\\CDK443::10.8.167.85		; p1274 NC Engineering Tool
:*:\\CDK444::10.8.167.73
:*:\\CDK445::10.8.167.89
:*:\\CDK446::10.8.138.14		;  p1276 Cu Engineering Tool
:*:\\CDK447::10.8.167.91		; p1274 NC Engineering Tool
:*:\\CDK448::10.8.138.15
:*:\\CDK449::10.8.167.101	; p1274 NC Engineering Tool
:*:\\CDK450::10.8.44.28
:*:\\CDK451::10.8.167.104	; p1274 Cu Mark's Tool
:*:\\CDK452::10.8.167.134	;  p1276 NC Engineering Tool
:*:\\CDK453::10.8.167.106	; p1274 Cu Engineering Tool
:*:\\CDK454::10.8.167.132	;  p1276 NC Engineering Tool
:*:\\CDK455::10.8.167.153
:*:\\CDK456::10.8.167.176
:*:\\CDK457::10.8.167.155
:*:\\CDK458::10.8.167.177
:*:\\CDK460::10.8.167.179
:*:\\CDK462::10.8.167.184
:*:\\CDK464::10.8.167.116	;  p1276 NC Engineering Tool
:*:\\CDK465::10.8.167.118
:*:\\CDK466::10.8.167.112
:*:\\CDK467::10.8.167.114
:*:\\CDK469::10.8.167.126
:*:\\CDK470::10.8.167.124
:*:\\CDK471::10.8.167.128	;  p1276 Cu Engineering Tool
:*:\\CDK472::10.8.167.157
:*:\\CDK474::10.8.167.207

; == CDM Tools ==
:*:\\CDM66::10.6.112.204
:*:\\CDM67::10.6.112.50
:*:\\CDM68::10.6.112.48
:*:\\CDM69::10.6.112.49
:*:\\CDM70::10.6.112.57
:*:\\CDM103::10.44.44.62
:*:\\CDM427::10.8.44.211
:*:\\CDM428::10.8.44.24
:*:\\CDM429::10.8.167.13
:*:\\CDM430::10.8.167.12
:*:\\CDM431::10.8.167.19
:*:\\CDM433::10.8.167.20
:*:\\CDM435::10.8.167.47
:*:\\CDM437::10.8.167.58

; == CDP Tools ==
:*:\\CDP498::10.15.167.138
:*:\\CDP499::10.15.167.140 ; p1276 NC Engineering Tool
:*:\\CDP500::10.8.167.200
:*:\\CDP501::10.8.167.202
:*:\\CDP502::10.8.167.198
:*:\\CDP503::10.8.167.204
:*:\\CDP504::10.8.167.216
:*:\\CDP505::10.15.86.195
:*:\\CDP506::10.6.112.11
:*:\\CDP507::10.15.86.211
:*:\\CDP508::10.15.86.197
:*:\\CDP509::10.15.86.209
:*:\\CDP510::10.15.86.200
:*:\\CDP511::10.15.86.203
:*:\\CDP512::10.15.86.206
