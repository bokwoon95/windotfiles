FileExt = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt"
Set Sh = WScript.CreateObject("WScript.Shell")
St = Sh.RegRead(FileExt)
If St = 1 Then
Sh.RegWrite FileExt, 0, "REG_DWORD"
Else
Sh.RegWrite FileExt, 1, "REG_DWORD"
End If
Sh.SendKeys("{F5}")