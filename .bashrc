# Must-have shortcuts
# to expand an alias in zsh: C-x a
# to expand an alias in bash: C-M-e or <Esc> C-e
# to edit current line in $EDITOR (usu. vim): C-x C-e
alias cdz="vim ~/.bashrc"
alias sdz="source ~/.bashrc"
alias ..="cd .. && pwd && ls"
alias ...="cd ../.. && pwd && ls"
alias ....="cd ../../.. && pwd && ls"
alias ls="ls -F "
alias lsa="ls -aF"
alias lsl="ls -alF"
alias cp="cp -v"
alias mv="mv -v"
cdd () {
  if [[ "$#" -eq 0 ]]; then
    cd && pwd && ls
  else
    cd "$1" && pwd && ls;
  fi
}
mkcd () {
  mkdir -p -- "$1" &&
    cd -P -- "$1"
}
alias checksize="du -h -d 1 | sort -n" #display file sizes
mann () {
  if [[ "$#" -eq 0 ]]; then
    echo "What manual page do you want?"
  else
    man $1 |
      # sed "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K|H]//g" |
      sed "s/.\//g" |
      vim -M - +'set nonu' +'set ls=1' +'nnoremap q :qa!<CR>'
  fi
}
unspace () {
  for f in "$@"; do
    mv "$f" "${f// /_}"
  done
}
respace () {
  for f in "$@"; do
    mv "$f" "${f//_/ }"
  done
}
testt () {
  result=$(test "$@"; echo $?)
  if [ $result == 0 ]; then
    echo True
  else
    echo False
  fi
  return $result
}

# Git aliases
alias  gac-Add-commit-and-push="git add . && git commit -v && git push origin master" #stage everything, create new commit and push in one step
alias  gak-Add-kommit-amend-and-push-force="git add . && git commit -v --amend --no-edit && git push -f origin master" #stage & commit everything into previous commit and force push in one step (DO NOT USE FOR SHARED REPOSITORIES)
alias  gko-kommit-amend-and-push-force="git commit -v --amend --no-edit && git push -f origin master" #commit whatever's been staged into the previous commit and force push in one step (DO NOT USE FOR SHARED REPOSITORIES)
alias gx="git status"
alias ga="git add"
alias ga.="git add ."
alias gap="git add -p"
gco () {
if [[ "$#" -eq 0 ]]; then
  git commit -v
else
  git commit -vm "$@"
fi
}
gca () {
if [[ "$#" -eq 0 ]]; then
  git add .; git commit -va
else
  git add .; git commit -vam "$@"
fi
}
alias gka="git add . && git commit -v --amend --no-edit"
alias gko="git commit -v --amend --no-edit"
alias gps="git push"
alias gc="git checkout"
alias gb="git branch"
alias gcb="git checkout -b"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --reflog"
alias gll="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gsp-slave-pull="git fetch --all && git reset --hard origin/master"
alias gsl="git stash list | vim - +'set nonu' +'set ls=1'"
alias grs="git reset --soft HEAD~1" #soft git commit rollback
alias gr.="git reset ."
alias gdiv="git diff | vim -M - +'set nonu' +'set ls=1' +'nnoremap q :qa!<CR>' +'echo(\"[PRESS q TO QUIT]\")'"
gdi () {
  if [[ "$#" -eq 0 ]]; then
    echo "please input a git file to diff"
  else
    git diff "$1" | vim -M - +'set nonu' +'set ls=1' +'nnoremap q :qa!<CR>' +'echo("[PRESS q TO QUIT]")'
  fi
}
gbla () {
  git blame "$@" | vim - +'set nu' +'set ls=1' +'nnoremap q :qa!<CR>' +'echo("[PRESS q TO QUIT]")'
}
alias gnv_open="vim \$(git status --porcelain | awk '{print \$2}')"
ghclone () {
  git clone https://github.com/$1 $2
}
ghclone-bw () {
  git clone https://github.com/bokwoon95/$1 $2
}
alias gcheckdangling="git fsck --unreachable --no-reflogs"
gprunedangling () {
  git reflog expire --expire-unreachable=now --all
  git gc --prune=now
}
gdif () {
  if [[ -f ~/.vim/diff-highlight ]];then
    git diff --color "$@" | ~/.vim/diff-highlight | less
  else
    git diff --color "$@" | diff-highlight | less
  fi
}
gdifc () {
  if [[ -f ~/.vim/diff-highlight ]];then
    git diff --cached --color "$@" | ~/.vim/diff-highlight | less
  else
    git diff --cached --color "$@" | diff-highlight | less
  fi
}
gsho () {
  if [[ -f ~/.vim/diff-highlight ]];then
    git show --color "$@" | ~/.vim/diff-highlight | less
  else
    git show --color "$@" | diff-highlight | less
  fi
}
#git add --p(atch) <filename> to stage hunks

# youtube-dl aliases
youtube-dl3 () {
if [[ "$#" -eq 0 ]]; then
  echo "provide Youtube URL(s) to extract their mp3. Playlist URLs will have all their audio files inside extracted."
else
  for filename in "$@"; do
    youtube-dl -x --audio-format mp3 "$filename"
  done
fi
}
youtube-dl4 () {
if [[ "$#" -eq 0 ]]; then
  echo "provide Youtube URL(s) to extract their mp4. Playlist URLs will have all their videos inside extracted."
else
  for filename in "$@"; do
    youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "$filename"
  done
fi
}

# path aliases
export chome=$(echo ${USERPROFILE//\\/\/} | sed 's|C:|/c|')
export dhome=$(echo ${USERPROFILE//\\/\/} | sed 's|C:|/d|')
alias chome="cd $chome && pwd && ls"
alias dhome="cd $dhome && pwd && ls"
alias whome="cd $chome && pwd && ls"
alias desk="cd $chome/Desktop && pwd && ls"
alias down="cd $chome/Downloads && pwd && ls"
alias doc="cd $chome/Documents && pwd && ls"
alias dbox="cd $chome/Dropbox && pwd && ls"
alias vimfiles="cd $chome/vimfiles && pwd && ls"
alias cduser="cd $chome && pwd && ls"
if [[ $(echo $USERPROFILE | sed 's:.*\\::') == "cbw" ]]; then
  alias down="cd $dhome/Downloads && pwd && ls"
  alias doc="cd $dhome/Documents && pwd && ls"
fi

# disable flow control
stty -ixon

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\''\)"'

# export LS_OPTIONS='--color=auto'
# eval "$(dircolors -b)"
# alias ls='ls $LS_OPTIONS'

#LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'

#LS_COLORS='rs=0:di=34:ln=36:mh=00:pi=40;33:so=35:do=35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30:ow=34:st=37;44:ex=32:*.tar=31:*.tgz=31:*.arc=31:*.arj=31:*.taz=31:*.lha=31:*.lz4=31:*.lzh=31:*.lzma=31:*.tlz=31:*.txz=31:*.tzo=31:*.t7z=31:*.zip=31:*.z=31:*.Z=31:*.dz=31:*.gz=31:*.lrz=31:*.lz=31:*.lzo=31:*.xz=31:*.bz2=31:*.bz=31:*.tbz=31:*.tbz2=31:*.tz=31:*.deb=31:*.rpm=31:*.jar=31:*.war=31:*.ear=31:*.sar=31:*.rar=31:*.alz=31:*.ace=31:*.zoo=31:*.cpio=31:*.7z=31:*.rz=31:*.cab=31:*.jpg=35:*.jpeg=35:*.gif=35:*.bmp=35:*.pbm=35:*.pgm=35:*.ppm=35:*.tga=35:*.xbm=35:*.xpm=35:*.tif=35:*.tiff=35:*.png=35:*.svg=35:*.svgz=35:*.mng=35:*.pcx=35:*.mov=35:*.mpg=35:*.mpeg=35:*.m2v=35:*.mkv=35:*.webm=35:*.ogm=35:*.mp4=35:*.m4v=35:*.mp4v=35:*.vob=35:*.qt=35:*.nuv=35:*.wmv=35:*.asf=35:*.rm=35:*.rmvb=35:*.flc=35:*.avi=35:*.fli=35:*.flv=35:*.gl=35:*.dl=35:*.xcf=35:*.xwd=35:*.yuv=35:*.cgm=35:*.emf=35:*.ogv=35:*.ogx=35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
export LS_COLORS
