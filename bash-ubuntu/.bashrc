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

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
set -o vi

#EDITOR=/usr/local/bin/vim
EDITOR=/usr/bin/vim
#alias vim=/usr/local/bin/vim
alias vim=/usr/bin/vim

# Apparently, Ubuntu doesn't like to follow POSIX standards and decides not to set TMPDIR :/
export TMPDIR=/tmp

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

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
#force_color_prompt=yes

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -h -F --show-control-chars --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias more='less'
export PAGER=less
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
                # Use this if lesspipe.sh exists.
export LESS='-i -N -W  -z-4 -g -e -M -X -F -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export STOW_DIR="$HOME/dotfiles"
export STOW_SMDIR="$HOME/dotfiles/submodules"
export NVM_DIR="$HOME/.nvm"
if [ ! -d $NVM_DIR ]; then
    # Restore nvm dotfiles
    stow -d $HOME/dotfiles nvm
    
    # If the nvm.sh file still doesn't exist, then init the nvm submodule
    # and "reinstall" nvm.
    if [ ! -e $STOW_DIR/submodules/nvm/nvm.sh ]; then
	pushd $STOW_SMDIR
	git submodule update --init nvm
	pushd nvm
	git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))"
	popd
	popd
    fi
else
    pushd $STOW_SMDIR/nvm
    git fetch --tags origin
    git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))"
    popd
fi
# At this point, nvm.sh should exist and have a size > 0; if it does, source it, and its bash completions.
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 

if [ -d '$HOME/.local/bin' ]; then
    PATH="$PATH:$HOME/.local/bin"
fi

# TODO: Create an update function for nvm
# TODO: It should check to see if the latest tag's sha1 == HEAD, and if not, prompt to update.

#export TERM=xterm-24bit
# Some character definitions for various markers about branch state.
#MAX_CONFLICTED_FILES=0
#DELTA_CHAR="△"
#CONFLICT_CHAR="☢"
#BISECTING_TEXT="bisecting"
#NOBRANCH_TEXT="no branch!"
#REBASE_TEXT="✂ ʀebase"
#SUBMODULE_TEXT="[submodule] "

#GIT_PS1_SHOWUPSTREAM_STYLE: One of none|arrow|rlarrowhead|udarrowhead|rltri|udtri|custom
GIT_PS1_SHOWUPSTREAM_STYLE="arrow"
#GIT_PS1_SHOWUPSTREAM_STYLE="custom"
#GIT_PS1_SHOWUPSTREAM_CUSTOM_AHEAD_GLYPH=""
#GIT_PS1_SHOWUPSTREAM_CUSTOM_BEHIND_GLYPH=""
#GIT_PS1_SHOWUPSTREAM_CUSTOM_DIVERGED_GLYPH=""
#GIT_PS1_SHOWUPSTREAM_CUSTOM_UPTODATE=""

#GIT_PS1_SHOWUPSTREAM_USE_SEPARATOR=0
#GIT_PS1_SHOWUPSTREAM_SEPARATOR_GLYPH="|"

GIT_PS1_SHOWSHORTSHA=1
GIT_PS1_SHORTSHA_FORMAT="[{s}] "
GIT_PS1_SHORTSHA_COLOR="$(tput setaf 218)"

GIT_PS1_DETACHEDHEAD_COLOR="$(tput setaf 160)"
GIT_PS1_OKBRANCH_COLOR="$(tput setaf 149)"
GIT_PS1_INITIALCOMMIT="#"
GIT_PS1_INITIALCOMMIT_COLOR="$(tput setaf 74)"
GIT_PS1_STAGEDCHANGES="+"
GIT_PS1_STAGEDCHANGES_COLOR="$(tput setaf 10)"
GIT_PS1_NOSTAGEDCHANGES_COLOR="$(tput setaf 22)"
GIT_PS1_UNTRACKEDFILES="●"
GIT_PS1_UNTRACKEDFILES_COLOR="$(tput setaf 208)"
GIT_PS1_NOUNTRACKEDFILES_COLOR="$(tput setaf 130)"
GIT_PS1_UNSTAGEDCHANGES="δ"
GIT_PS1_UNSTAGEDCHANGES_COLOR="$(tput setaf 11)"
GIT_PS1_NOUNSTAGEDCHANGES_COLOR="$(tput setaf 58)"
GIT_PS1_STASHSTATE="§"
GIT_PS1_STASHSTATE_COLOR="$(tput setaf 39)"
GIT_PS1_NOSTASHSTATE_COLOR="$(tput setaf 24)"
GIT_PS1_SHOWSTATE_COUNTS=0

GIT_PS1_BRANCH_FORMAT="hbs" # DEFALUT: bs => master *+$%; hbs => {sha} master *+$%
GIT_PS1_BRANCHSTATE_FORMAT="iwus"  # Default: *+$% {unstaged}{staged}{stashed}{untracked}
GIT_PS1_CLEANSTATE_COLOR="$(tput setaf 240)"

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto git verbose"
GIT_PS1_SHOWBRANCHSTATE="always"

# GIT_PS1_DESCRIBE_STYLE
#  -- contains  - Looks forward in the tree for a tag, so you know which tag you're behind.
#  -- branch    - Looks forward in the tree for a tag or a branch (whatever's nearest).
#  -- describe  - Looks backwards in the tree for a tag so you know which tag you're ahead of.
#  -- (default) - If you're exactly on a tag, display it. If the method you choose fails to find a
#                 tag/branch to display, you'll see the commit id instead. 
#GIT_PS1_DESCRIBE_STYLE="branch"

#SH_PS1_DONT_COLORIZED_PROMPT=0

SH_PS1_USERNAME_COLOR="$(tput setaf 35)"
SH_PS1_HOSTNAME_COLOR="$(tput setaf 35)"
SH_PS1_USER_HOST_SEPARATOR_COLOR="$(tput setaf 35)"
SH_PS1_PWD_COLOR="$(tput setaf 74)"
#SH_PS1_PROMPT_COLOR="$(tput sgr0)"

SH_PS1_USERNAME="\n$(tput setaf 170)${MSYSTEM+:$MSYSTEM }\u"
#SH_PS1_USER_HOST_SEPARATOR="@"
#SH_PS1_HOSTNAME="\h"
SH_PS1_PWD="\n$(tput setaf 15)PWD: \w"
#SH_PS1_PROMPT="\n\\\$ "

#SH_PS1_FORMAT_STRING="%v%u%z%h%w"

# Fixup git-bash in non login env
#shopt -q login_shell
#. /d/Projects/GitRepos/custom_git_prompt/sh-prompt.sh

#. /d/Projects/GitRepos/custom_git_prompt/sh-prompt.sh
#if [[ -e ~/git-prompt.sh ]]; then
#	shopt -q login_shell || . ~/git-prompt.sh
#	. /d/Projects/GitRepos/custom_git_prompt/sh-prompt.sh
#else
#	shopt -q login_shell || . /etc/profile.d/git-prompt.sh
#	. /d/Projects/GitRepos/custom_git_prompt/sh-prompt.sh
#fi


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

if [[ -e ~/.sh-prompt.sh ]]; then
	. ~/.sh-prompt.sh
elif [[ -e ~/sh-prompt.sh ]]; then
	. ~/sh-prompt.sh
elif [[ -e /d/Projects/GitRepos/custom_git_prompt/sh-prompt.sh ]]; then
	. /d/Projects/GitRepos/custom_git_prompt/sh-prompt.sh
elif [[ -e ~/.git-prompt.sh ]]; then
	shopt -q login_shell || . ~/.git-prompt.sh
	PROMPT_COMMAND='__git_ps1 "$(tput setaf 2)\u@\h ${MSYSTEM+$(tput setaf 5)$MSYSTEM }$(tput setaf 3)\w$(tput sgr0)" "\n\\\$ " " (%s)"'
	return
elif [[ -e ~/git-prompt.sh ]]; then
	shopt -q login_shell || . ~/git-prompt.sh
	PROMPT_COMMAND='__git_ps1 "$(tput setaf 2)\u@\h ${MSYSTEM+$(tput setaf 5)$MSYSTEM }$(tput setaf 3)\w$(tput sgr0)" "\n\\\$ " " (%s)"'
	return
else
	shopt -q login_shell || . /etc/profile.d/git-prompt.sh
	PROMPT_COMMAND='__git_ps1 "$(tput setaf 2)\u@\h ${MSYSTEM+$(tput setaf 5)$MSYSTEM }$(tput setaf 3)\w$(tput sgr0)" "\n\\\$ " " (%s)"'
	return
fi

#PROMPT_COMMAND='__git_ps1 "\n$(tput setaf 170)$MSYSTEM $(tput setaf 34)\u@\h\n$(tput setaf 15)PWD: $(tput setaf 111)\w$(tput sgr0)" "\n\\\$ " "\n$(tput setaf 15)GIT:$(tput sgr0) %s$(tput sgr0)"'
PROMPT_COMMAND='__sh_ps1 "uzhwv" "\n$(tput setaf 15)GIT:$(tput sgr0) %s$(tput sgr0)" "bash: \w"'
#PROMPT_COMMAND='__sh_ps1 "" "\n$(tput setaf 15)GIT:$(tput sgr0) %s$(tput sgr0)"'

complete -C /usr/bin/terraform terraform
