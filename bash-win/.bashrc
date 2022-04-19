# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# /etc/bash.bashrc: executed by bash(1) for interactive shells.

# System-wide bashrc file

# Check that we haven't already been sourced.
([[ -z ${CYG_SYS_BASHRC} ]] && CYG_SYS_BASHRC="1") || return

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Set a default prompt of: user@host, MSYSTEM variable, and current_directory
#PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n\$ '

# Uncomment to use the terminal colours set in DIR_COLORS
eval "$(dircolors -b /etc/DIR_COLORS)"

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h -F --color --show-control-chars'

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

SH_PS1_USERNAME="\n$(tput setaf 170)$MSYSTEM \u"
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
