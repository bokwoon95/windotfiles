#SingleInstance force
if FileExist(A_ScriptDir . "\icons\diamond.ico") {
    Menu, Tray, Icon, %A_ScriptDir%\icons\diamond.ico
}

#IfWinActive ahk_exe devenv.exe
    $^a::SendInput {Home}
    ^e::SendInput {End}
    $^f::SendInput {Right}
        #f::SendInput {Ctrl Down}{f}{Ctrl Up}
    ^!f:: SendInput {Ctrl Down}{Right}{Ctrl Up}
    $^b::SendInput {Left}
        #b::SendInput {Ctrl Down}{b}{Ctrl Up}
    ^!b:: SendInput {Ctrl Down}{Left}{Ctrl Up}
    $^n::SendInput {Down}
        #n::SendInput {Ctrl Down}{n}{Ctrl Up}
    $^p::SendInput {Up}
        #p::SendInput {Ctrl Down}{p}{Ctrl Up}
    ^!n::SendInput {Down}{Down}{Down}{Down}{Down}
    ^!p::SendInput {Up}{Up}{Up}{Up}{Up}
#IfWinActive

SetTitleMatchMode, 2
#IfWinActive, vs-studio.ahk
    #!r::
        Msgbox, %A_ScriptDir%\vs-studio.ahk reloaded
        Reload
    return
#IfWinActive
