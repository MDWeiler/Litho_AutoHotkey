GenerateHTMLfile(htmlHotStrings:="<tr><th ColSpan='3'><h1>Blank</h1></th></tr>") {

	global strLocalScriptVersion

	filenameHTML := "Litho_AutoHotkey_Index.html"

	; Parpare HTML Index file
	; Open HTML Index file for writting
	htmlFile := FileOpen(filenameHTML, "w")
	; Add HTML Header tags
	htmlFile.Write("<html>`n<head><title>AutoHotkey Index</title></head>`n<body>`n")
	; Add page table
	htmlFile.Write("<table>`n")
	; Add htmlHotStrings
	htmlFile.Write("<tr><td><table>" . htmlHotStrings . "</table></td>`n")
	; Add Empty column
	htmlFile.Write("<td>&nbsp;&nbsp;&nbsp;</td>`n")
	; Pattern and Shortcut Header
	htmlFile.Write("<td style='vertical-align:top'><table>`n")
	; Add Window Short Cuts
	htmlFile.Write("<tr><th ColSpan='2'><h2 style='text-align:left;'>Windows Shortcuts</h2></th></tr>`n")
	htmlFile.Write("<tr><td>Windows + . or `;</td><td>Open Emoji panel</td><tr>`n")
	htmlFile.Write("<tr><td>Windows + A</td><td>Open Action Center</td><tr>`n")
	htmlFile.Write("<tr><td>Windows + K</td><td>Open Connection Center</td><tr>`n")
	htmlFile.Write("<tr><td>Windows + V</td><td><b>Open Clipboard History</b></td><tr>`n")
	htmlFile.Write("<tr><td>Windows + X</td><td>Open Quick Links</td><tr>`n")
	htmlFile.Write("<tr><td>Windows + Shift + S</td><td>Capture part of the screen with Snip &#38; Sketch</td><tr>`n")
	; htmlFile.Write("<tr><td>Alt + Spacebar</td><td>Open context menu for the active window</td><tr>`n")
	; htmlFile.Write("<tr><td>Alt + F8</td><td>Reveals typed password in Sign-in screen</td><tr>`n")
	htmlFile.Write("<tr><td>&nbsp;</td><td>&nbsp;</td><tr>`n")
	; Add patterns
	htmlFile.Write(htmlListOfPatterns())
	; Pattern and Shortcut Footer
	htmlFile.Write("</table></td></tr>`n")
	; Add HTML Footer tags
	htmlFile.Write("</table><p>LithoAHK Version:" . strLocalScriptVersion . "</p></body></html>")
	; Close File
	htmlFile.Close()
	
	; Display the HTML File
	run %filenameHTML%
	
} ; End Function