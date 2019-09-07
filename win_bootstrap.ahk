#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

if (!FileExist("C:\Program Files\Git\git-bash.exe")) {
    psScript =
    (
        param($gitexe)
        if ([string]::IsNullOrEmpty($gitexe)) {
            $gitexe = $env:home + '\Desktop\git-windows.exe'
        }
        $links = curl https://git-scm.com/download/win -usebasicparsing | select -expand 'links'
        foreach ($link in $links) {
            $re = [regex]::Match($link.href, 'https://github.com/git-for-windows/git/releases/download/v.*Git-.*64-bit.exe')
            if ($re.Success) {
                $url = $link.href;
                break;
            }
        }
        if (![string]::IsNullOrEmpty($url)) {
            (New-Object System.Net.WebClient).DownloadFile($url, $gitexe);
        }
    )
    gitexe = %A_Desktop%\git-windows.exe
    RunWait PowerShell.exe -Command &{%psScript%} '%gitexe%',, hide
    Run %gitexe%
}

UrlDownloadToFile, https://raw.githubusercontent.com/bokwoon95/windotfiles/master/.bashrc, C:\Users\%A_UserName%\.bashrc
UrlDownloadToFile, https://raw.githubusercontent.com/bokwoon95/windotfiles/master/.bash_profile, C:\Users\%A_UserName%\.bash_profile
UrlDownloadToFile, https://raw.githubusercontent.com/bokwoon95/windotfiles/master/.minttyrc, C:\Users\%A_UserName%\.minttyrc
if (!FileExist("C:\Users\" . A_UserName . "\vimfiles") || !FileExist("C:\Users\" . A_UserName . "\windotfiles")) {
    if (FileExist("C:\Program Files\Git\git-bash.exe")) {
        Run C:\Program Files\Git\git-bash.exe
        WinWait, MINGW64: ahk_exe mintty.exe
        tempclip := Clipboard
        Clipboard := "bash -c ""$(curl https://raw.githubusercontent.com/bokwoon95/setup/master/gitconfig.sh)"" && git clone https://github.com/bokwoon95/vimfiles ""$USERPROFILE\vimfiles"" && ln -sf ~/vimfiles/vimrc ~/.vimrc; git clone https://github.com/bokwoon95/windotfiles ""$USERPROFILE\windotfiles"""
        ControlSend,, {Shift Down}{Insert}{Shift Up}{Enter}, MINGW64: ahk_exe mintty.exe
        Clipboard := tempclip
        tempclip := ""
    } else {
        ; use powershell to download
    }
}


if (!FileExist("C:\Program Files (x86)\Vim")) {
    psScript =
    (
        param($gvimexe)
        if ([string]::IsNullOrEmpty($gvimexe)) {
            $gvimexe = $env:home + '\Desktop\gvim.exe'
        }
        $links = curl https://www.vim.org/download.php -usebasicparsing | select -expand 'links'
        foreach ($link in $links) {
            $re = [regex]::Match($link.href, 'https://.*gvim.*.exe')
            if ($re.Success) {
                $url = $link.href;
                break;
            }
        }
        if (![string]::IsNullOrEmpty($url)) {
            (New-Object System.Net.WebClient).DownloadFile($url, $gvimexe);
        }
    )
    gvimexe = %A_Desktop%\gvim.exe
    RunWait PowerShell.exe -Command &{%psScript%} '%gvimexe%',, hide
    Run %gvimexe%
}

if (!FileExist("C:\Program Files\AutoHotkey\AutoHotkey.exe")) {
    UrlDownloadToFile, https://www.autohotkey.com/download/ahk-install.exe, %A_Desktop%\ahk-install.exe
    Run %A_Desktop%\ahk-install.exe
}

; autohotkey
; chrome
; whatsapp
; telegram
; idm
; sumatrapdf
; vlc
