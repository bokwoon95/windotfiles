; the $ sign makes the mapping non-recursive
; * makes a mapping work regardless of other pressed buttons
; ~ ignores the mapping if there are any other pressed buttons
; #,^,!,+ == Win,Ctrl,Alt,Shift
#SingleInstance force
if FileExist(A_ScriptDir . "\icons\star.ico") {
    Menu, Tray, Icon, %A_ScriptDir%\icons\star.ico
}
SetTitleMatchMode, 2

#+Backspace::
    FileRecycleEmpty
    if WinActive("Recycle Bin ahk_exe Explorer.EXE") {
        if FileExist("%A_ProgramFiles%\QTTabBar") {
            WinClose, Recycle Bin ahk_exe Explorer.EXE
        } else {
            SendInput, {Ctrl Down}{w}{Ctrl Up}
        }
    }
return

#If substr(A_OSVersion, 1, 2) != "10"
    #s::SendInput ^{Esc}
#If

#If (InStr(USERPROFILE, "cbw") != 0)
    userprofile_D := RegExReplace(userprofile, "C:", Replacement := "D:")
    ^!#h:: OpenFolder("C:\Users\cbw")
    ^!#l:: OpenFolder("D:\Users\cbw", "\Downloads")
    ^!#o:: OpenFolder("D:\Users\cbw", "\Documents")
    ^!#d:: OpenFolder("C:\Users\cbw", "\Desktop")
    ^!#p:: OpenFolder("D:\Users\cbw", "\Pictures")
    ^!#v:: OpenFolder("D:\Users\cbw", "\Videos")
#If
#If (InStr(USERPROFILE, "cbw") == 0)
    ^!#h:: OpenFolder(userprofile)
    ^!#l:: OpenFolder(userprofile, "\Downloads")
    ^!#o:: OpenFolder(userprofile, "\Documents")
    ^!#d:: OpenFolder(userprofile, "\Desktop")
    ^!#p:: OpenFolder(userprofile, "\Pictures")
    ^!#v:: OpenFolder(userprofile, "\Videos")
#If
^!#-:: Run, explorer.exe /e`,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}
^!#0:: OpenFolder("C:\")
#If (InStr(USERPROFILE, "SinTemp.IT") != 0)
    ^!#1:: OpenFolder("Z:\")
#If
#If (InStr(USERPROFILE, "SinTemp.IT") == 0)
    ^!#1:: OpenFolder("D:\")
#If
^!#9:: OpenFolder("E:\")
^!#x:: OpenFolder(userprofile, "\Dropbox")
^!#s:: OpenFolder(appdata, "\Microsoft\Windows\Start Menu\Programs\Startup")
^!#e:: Edit, %A_ScriptDir%\shortcuts.ahk
^!#w:: Run, %A_ProgramFiles%\AutoHotKey\WindowSpy.ahk
$^!#[::
    Run, cmd, %userprofile%
return
$^!#]::
    Run, PowerShell, %userprofile%
    WinWait, ahk_exe powershell.exe
    WinGetPos,,, sizeX, sizeY, ahk_exe powershell.exe
    WinMove, ahk_exe powershell.exe,, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2)
return
$^!#\::
    Run, %localappdata%\wsltty\WSL Terminal
return
$^!#+[::
    try {
        Run *RunAs cmd
    }
return
$^!#+]::
    try {
        Run, *RunAs PowerShell
        WinWait, ahk_exe powershell.exe
        WinGetPos,,, sizeX, sizeY, ahk_exe powershell.exe
        WinMove, ahk_exe powershell.exe,, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2)
    }
return

OpenFolder(home, folderpath := "") {
    tempvar := Clipboard
    Clipboard := home . folderpath
    if (!FileExist(home . folderpath)) {
        MsgBox, %home%%folderpath% not found
        return
    }
    if (WinActive("Open") || WinActive("Save As") || WinActive("Choose files") || (WinActive("ahk_exe Explorer.EXE") && !WinActive("ahk_class Progman") && !WinActive("ahk_class WorkerW") || WinActive("Where are the files?") && !(WinActive("ahk_class Shell_TrayWnd") || WinActive("ahk_class ClassicShell.CStartButton")))) {
        SendInput !d{End}+{Home}{Del}
        Send ^v
        SendInput {Enter}
    } else {
        Run %home%%folderpath%
    }
    return
    Clipboard := tempvar
    tempvar :=
}

;Telegram Universal Clipboard
;$+#!c::
;tempvar := Clipboard
;if WinActive("ahk_exe gvim.exe") {
;    SendInput Y
;} else {
;    SendInput ^c
;}
;Run, %appdata%\Telegram Desktop\Telegram.exe
;WinWait, ahk_exe Telegram.exe,,3
;if (ErrorLevel == 1) {
;    return
;}
;WinActivate, ahk_exe Telegram.exe
;SendInput {Down}{Enter}
;Send ^v{Enter}
;WinMinimize ahk_exe Telegram.exe
;Clipboard := tempvar
;tempvar :=
;return
;$+#!v::
;tempvar := Clipboard
;Run, %appdata%\Telegram Desktop\Telegram.exe,,2
;WinWait, ahk_exe Telegram.exe,,3
;if (ErrorLevel == 1) {
;    return
;}
;WinActivate, ahk_exe Telegram.exe
;SendInput {Down}{Enter}{Up}{End}+{Home}
;Send ^c{Esc}{Enter}
;WinMinimize ahk_exe Telegram.exe
;if WinActive("ahk_exe gvim.exe") {
;    SendInput {Esc}a
;    SendInput ^y
;} else {
;    Send ^v
;}
;Clipboard := tempvar
;tempvar :=
;return

;Ctrl+Win+C copies without formatting
^#c::
Clipboard =
Send ^c
Clipboard = %Clipboard%
ClipWait
return

#If WinActive("ahk_exe Explorer.EXE ahk_class CabinetWClass")
    $#!7::SendInput {AppsKey}7{Down 2}{Enter}
#If

#If !(WinActive("ahk_class WorkerW") || WinActive("ahk_class ClassShell.CStartButton") || WinActive("ahk_class tooltips_class32") || WinActive("ahk_class Shell_TrayWnd"))
$#h:: WinMinimize, A
#If
$#!k::
if WinActive("ahk_exe gvim.exe") {
    WinMaximize, A
    SendInput, !+9
} else {
    WinMaximize, A
}
return
$#q::
if WinActive("ahk_exe powershell.exe") {
    WinClose, ahk_exe powershell.exe
} else if WinActive("ahk_exe cmd.exe") {
    WinClose, ahk_exe cmd.exe
} else if WinActive("ahk_exe OUTLOOK.EXE") {
    WinMinimize, ahk_exe OUTLOOK.EXE
} else {
    SendInput {Alt Down}{F4}{Alt Up}
}
return
$#!c::
WinExist("A")
WinGetPos,,, sizeX, sizeY
WinMove, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2)
return
$^#h::SendInput ^#{Left}
$#^l::Send, {Ctrl Down}{LWin Down}{Right}{Ctrl Up}{LWin Up}
$^#q::SendInput ^#{F4}

; Command click works the same as Ctrl click
#LButton::
SendInput {Ctrl Down}
MouseClick, left
SendInput {Ctrl Up}
return

; Disable the Windows logo by itself
~RWin Up:: return
~LWin Up:: return
~Shift & LWin::SendInput {AppsKey}
~Shift & RWin::SendInput {AppsKey}
#+r::SendInput {LWin Down}r{LWin Up}

; Window-Space now opens search
#Space::SendInput {LWin Down}{s}{LWin Up}
; Window-Alt-Space replaces Window-Space
#!Space::SendInput {LWin Down}{Space}{LWin Up}

; Systemwide Ctrl-Tab & F5 refresh mappings
#+]::SendInput {Ctrl Down}{Tab}{Ctrl Up}
#+[::SendInput {Ctrl Down}{Shift Down}{Tab}{Shift Up}{Ctrl Up}
#r::SendInput {F5}

#If (WinActive("ahk_class MultitaskingViewFrame") || WinActive("ahk_class TaskSwitcherWnd") || WinActive("Windows.UI.Core.CoreWindow"))
!`::SendInput {Alt Down}{Left}
!h::SendInput {Alt Down}{Left}
!j::SendInput {Alt Down}{Down}
!k::SendInput {Alt Down}{Up}
!l::SendInput {Alt Down}{Right}
h::SendInput {Left}
j::SendInput {Down}
k::SendInput {Up}
l::SendInput {Right}
#If

; Home & End highlighting
^+e::SendInput {Shift Down}{End}{Shift Up}
^+a::SendInput {Shift Down}{Home}{Shift Up}
; Ctrl-Alt-A replaces Ctrl-A
^!a::SendInput {Ctrl Down}{a}{Ctrl Up}

GroupAdd, UnixGroup , ahk_exe gvim.exe
GroupAdd, UnixGroup , ahk_exe ubuntu.exe
GroupAdd, UnixGroup , ahk_exe mintty.exe

; #IfWinNotActive, ahk_group UnixGroup ;Why doesn't GroupAdd work here?
; #IfWinNotActive, ahk_exe gvim.exe
#If !(WinActive("ahk_exe gvim.exe") || WinActive("ahk_exe mintty.exe") || WinActive("ahk_exe ubuntu.exe") || WinActive("ahk_exe emacs.exe") || WinActive("ahk_exe devenv.exe"))
    $^a::SendInput {Home}
    ^e::SendInput {End}
    $!+,::SendInput ^{Home}
    $!+.::SendInput ^{End}
    ; Character-wise movement
    $^f::SendInput {Right}
        #f::SendInput {Ctrl Down}{f}{Ctrl Up}
            ^+f::SendInput {Shift Down}{Right}{Shift Up}
    $^b::SendInput {Left}
        #b::SendInput {Ctrl Down}{b}{Ctrl Up}
            ^+b::SendInput {Shift Down}{Left}{Shift Up}
    $^n::SendInput {Down}
        #n::SendInput {Ctrl Down}{n}{Ctrl Up}
            ^+n::SendInput {Shift Down}{Down}{Shift Up}
    $^p::SendInput {Up}
        #p::SendInput {Ctrl Down}{p}{Ctrl Up}
            ^+p::SendInput {Shift Down}{Up}{Shift Up}
    ; Word-wise movement
    ^!f:: SendInput {Ctrl Down}{Right}{Ctrl Up}
        ^!+f::SendInput {Ctrl Down}{Shift Down}{Right}{Ctrl Up}{Shift Up}
    ^!b:: SendInput {Ctrl Down}{Left}{Ctrl Up}
        ^!+b::SendInput {Ctrl Down}{Shift Down}{Left}{Ctrl Up}{Shift Up}
    ; Deletion
    $^d::SendInput {Delete}
    ;^!d::SendInput {Ctrl Down}{Shift Down}{Right}{Ctrl Up}{Shift Up}{Backspace}
    *+BackSpace::SendInput, % (GetKeyState("Control", "P") ? "^{Delete}" : "{Delete}")
    #k::SendInput {Ctrl Down}{k}{Ctrl Up}
    #BS::SendInput {Shift Down}{Home}{Shift Up}{Backspace}
    ; Vertical Mobility
    ;^!n::SendInput {Down}{Down}{Down}{Down}{Down}
    ^!n::SendInput {Down 5}
        ^!+n::SendInput {Shift Down}{Down}{Down}{Down}{Down}{Down}{Shift Up}
    ;^!p::SendInput {Up}{Up}{Up}{Up}{Up}
    ^!p::SendInput {Up 5}
        ^!+p::SendInput {Shift Down}{Up}{Up}{Up}{Up}{Up}{Shift Up}
    ^+,::SendInput {Ctrl Down}{Home}{Ctrl Up}
        ^+!,::SendInput {Shift Down}{Ctrl Down}{Home}{Ctrl Up}{Shift Up}
    ^+.::SendInput {Ctrl Down}{End}{Ctrl Up}
        ^+!.::SendInput {Shift Down}{Ctrl Down}{End}{Ctrl Up}{Shift Up}
    ^m::SendInput {Enter}
        #m::SendInput {Ctrl Down}{m}{Ctrl Up}
#If

; Contextual C-k depending on whether application is MS Word
#If !(WinActive("ahk_exe gvim.exe") || WinActive("ahk_exe mintty.exe") || WinActive("ahk_exe ubuntu.exe") || WinActive("ahk_exe emacs.exe") || WinActive("ahk_exe devenv.exe")) && WinActive("ahk_exe WINWORD.EXE")
    $^k::SendInput {Shift Down}{End}{Left}{Shift Up}{Delete}
    $^!h::SendInput {WheelUp 4}
    $^!l::SendInput {WheelDown 4}
    $^h::SendInput {WheelUp 4}
    $^l::SendInput {WheelDown 4}
    ^#e::SendInput ^e
    $#r::SendInput ^r
    $#l::SendInput ^l
#If
#If !(WinActive("ahk_exe gvim.exe") || WinActive("ahk_exe mintty.exe") || WinActive("ahk_exe ubuntu.exe") || WinActive("ahk_exe emacs.exe") || WinActive("ahk_exe devenv.exe")) && !(WinActive("ahk_exe WINWORD.EXE") || WinActive("ahk_exe POWERPNT.EXE"))
    $^k::SendInput {Shift Down}{End}{Shift Up}{Delete}
    ;$^k::MsgBox, yee
#If
#If !(WinActive("ahk_exe gvim.exe") || WinActive("ahk_exe mintty.exe") || WinActive("ahk_exe ubuntu.exe") || WinActive("ahk_exe emacs.exe") || WinActive("ahk_exe devenv.exe")) && WinActive("ahk_exe SumatraPDF.exe")
    $^h::SendInput {Up 5}
    $^l::SendInput {Down 5}
    $^!h::SendInput {Up 20}
    $^!l::SendInput {Down 20}
#If
#If !(WinActive("ahk_exe gvim.exe") || WinActive("ahk_exe mintty.exe") || WinActive("ahk_exe ubuntu.exe") || WinActive("ahk_exe emacs.exe") || WinActive("ahk_exe devenv.exe")) && WinActive("ahk_exe POWERPNT.EXE")
    $^k::SendInput {Shift Down}{End}{Left}{Shift Up}{Delete}
    $^h::SendInput {PgUp}
    $^l::SendInput {PgDn}
    $^!h::SendInput {F6}
    $^!l::SendInput +{F6}
#If

#If WinActive("scrape[jupynb]")
$^[::SendInput {Esc}
#If

#IfWinActive, ahk_exe opera.exe
#+b::SendInput {Ctrl Down}{Shift Down}{b}{Ctrl Up}{Shift Up}
#^d::SendInput {Ctrl Down}{d}{Ctrl Up}
#IfWinActive

; MacOS niceties
$#t::SendInput {Ctrl Down}{t}{Ctrl Up}
$#w::SendInput {Ctrl Down}{w}{Ctrl Up}
$#c::SendInput {Ctrl Down}{c}{Ctrl Up}
$#v::SendInput {Ctrl Down}{v}{Ctrl Up}
$#x::SendInput {Ctrl Down}{x}{Ctrl Up}
    #+x::SendInput {LWin Down}x{LWin Up}
$#z::SendInput {Ctrl Down}{z}{Ctrl Up}
$#y::SendInput {Ctrl Down}{y}{Ctrl Up}
$#[::SendInput {Alt Down}{Left}{Alt Up}
$#]::SendInput {Alt Down}{Right}{Alt Up}
$#o::SendInput {Ctrl Down}{o}{Ctrl Up}
#+t::SendInput {Ctrl Down}{Shift Down}{t}{Ctrl Up}{Shift Up}
#+n::SendInput {Ctrl Down}{Shift Down}{n}{Ctrl Up}{Shift Up}
#!Esc::SendInput {Ctrl Down}{Shift Down}{Esc}{Ctrl Up}{Shift Up}
;LWin & l::SendInput {Ctrl Down}l{Ctrl Up} ; seems a little laggy

#IfWinActive ahk_class Chrome_WidgetWin_1
    ^WheelDown:: SendInput {Blind}{Ctrl Up}{WheelDown}
    ^WheelUp:: SendInput {Blind}{Ctrl Up}{WheelUp}
    ^+!l::SendInput {WheelDown}
    ^+!h::SendInput {WheelUp}
    $^!l::SendInput {WheelDown 2}
    $^!h::SendInput {WheelUp 2}
    $^!d::SendInput {WheelDown 5}
    $^!u::SendInput {WheelUp 5}
    #MaxHotkeysPerInterval 1000
#IfWinActive

#If WinActive("ahk_class CabinetWClass ahk_exe Explorer.EXE")
    $^Left::SendInput {Alt Down}{Left}{Alt Up}
    $^Right::SendInput {Alt Down}{Right}{Alt Up}
    $^Up::SendInput {Alt Down}{Up}{Alt Up}
    $^Down::SendInput {Alt Down}{Left}{Alt Up}
    $^t::SendInput {Ctrl Down}{n}
#If

#IfWinActive, shortcuts.ahk
    #!r::
        Msgbox, %A_ScriptDir%\shortcuts.ahk reloaded
        Reload
    return
#IfWinActive

#If WinExist("ahk_exe wmplayer.exe")
    ^#F7::ControlSend,,{F7},ahk_exe wmplayer.exe
    ^#F8::ControlSend,,{F8},ahk_exe wmplayer.exe
    ^#F9::ControlSend,,{F9},ahk_exe wmplayer.exe
    ^#F10::ControlSend,,^b,ahk_exe wmplayer.exe
    ^#F11::ControlSend,,^p,ahk_exe wmplayer.exe
    ^#F12::ControlSend,,^f,ahk_exe wmplayer.exe
#If

CenterWindow(WinTitle) {
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
}

; Hotstrings
#If WinActive("ahk_exe PowerShell.exe")
::sv::.\venv\Scripts\activate
#If

#If (InStr(USERPROFILE, "cbw") != 0)
#If

^!m::
toggle := !toggle
if (WinActive("ahk_exe javaw.exe")) {
    if (toggle) {
        SetTimer, AutoClicker, 500
        SetTimer, EatFood, 360000
        GoSub, AutoClicker
        GoSub, EatFood
    } else {
        SetTimer, AutoClicker, Off
        SetTimer, EatFood, Off
    }
}
Return

AutoClicker:
Click
Return

EatFood:
Click, Down, Right
Sleep 4000
Click, Up, Right
Return
