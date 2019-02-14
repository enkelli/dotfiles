#
# File: $HOME/.bashrc
# Author: Pavol Plaskon, pavol.plaskon@gmail.com
#
# Based on: https://github.com/s3rvac/dotfiles/blob/master/bash/.bashrc
#

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

#--------------------------------
# Shell options
#--------------------------------
#type just 'dir' instead of 'cd dir'
shopt -s autocd
#use aliases in not interactive shell (e.g. Makefile)
shopt -s expand_aliases

# Enable vi/like motion when typing commands.
set -o vi

# Show a notification when a job finishes.
set -o notify

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Enviroment Variables
export EDITOR=vim
export VISUAL=vim

# Locale
export LANG=en_US.UTF-8
export LC_TIME=en_GB.UTF-8
export LC_PAPER=en_GB.UTF-8
export LC_MEASUREMENT=en_GB.UTF-8

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    alias web='/usr/bin/google-chrome-stable %U'
fi

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Give all cores to `make`. Significant speedup.
export MAKEFLAGS="-j $(nproc)"

# Some more aliases
alias c='clear'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias chx='chmod +x'
alias chnx='chmod -x'
alias chw='chmod +w'
alias chnw='chmod -w'
alias chr='chmod +r'
alias chnr='chmod -r'
alias ds='du -sh'
alias dsa='du -h --all --max-depth=1 --one-file-system 2> /dev/null | sort -h'
alias e='egrep'
alias er='egrep -r'
alias ff='firefox'
alias m='make'
alias g='git'
alias gd='g d'
alias gl='g l'
alias gs='g s'
alias gu='g u'
alias nt='nosetests'
alias ntc='nosetests --with-coverage --cover-erase'
alias ntt='nosetests --with-timer'
alias py='python3'
alias py2='python2'
alias py3='python3'
alias pyprof='py -m cProfile'
alias t='tmux'
alias tn='tmuxinator'
alias Time='/usr/bin/time -v'
alias fn='find . -name'
alias trx='tar xvf'
alias tgz='tar czvf'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias vim='vim -p'
alias v='vim'
alias rm='rm -i'

alias rg='ranger'
function rgc {  # ranger-cd
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

alias rvenv='source virtualenv/bin/activate'
alias mvenv='python3 -m venv'

alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

alias oddlines='sed "n; d"'
alias evenlines='sed "1d; n; d"'

alias m='make'
# -s = dependencies, -r remove build time deps,
# -c clean tmp build files, -i install
alias mpkg='makepkg -srci'

# Arch Linux
# not bulletproof, not found better
if [ -f /etc/arch-release ]; then
    alias yai='yaourt -S'
    alias yas='yaourt -Ss'
    alias yaR='yaourt -R'
    alias yaU='yaourt -Syu --aur'
fi

# Complete
__git_complete g _git &>/dev/null

# Weather forecast
function we()
{
    curl "wttr.in/$1";
}

function mcd()
{
	mkdir "$1";
	cd "$1";
}

# Universal extractor
# Source: https://github.com/metthal/configs/blob/master/.bashrc
complete -f -X '!*.@(tar.gz|tgz|tar.bz2|tbz2|xz|tar|zip|rar|7z|bz2)' extr
extr() {
    if [ ! -r $1 ]; then
        echo "File '$1' not found" >&2
    fi

    case $1 in
        *.tar.gz)   tar -xzvf $1    ;;
        *.tgz)      tar -xzvf $1    ;;
        *.tar.bz2)  tar -xjvf $1    ;;
        *.tbz2)     tar -xjvf $1    ;;
        *.xz)       xz -dvk $1      ;;
        *.tar)      tar -xvf $1     ;;
        *.zip)      unzip $1        ;;
        *.rar)      unrar x $1      ;;
        *.7z)       7za x $1        ;;
        *.bz2)      bunzip2 -vk $1  ;;
        *)          echo "Invalid file format" >&2  ;;
    esac
}

# grep in current folder recursively
function grec()
{
    grep "$1" . -R
}

# egrep in current folder recursively with boundaries
function greb()
{
    egrep "\b$1\b" . -R
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi
