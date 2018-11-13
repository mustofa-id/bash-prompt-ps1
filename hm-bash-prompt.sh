#!/bin/bash

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

# My Custom PS1
hmCustomPS1() {
    # Unique chars
    local LEFT_DOWN=$'\u250f' # ┏
    local ARROW_RIGHT=$'\xe1\x9a\xa7' # ᚧ
    local DOWN_RIGHT=$'\u2517' # ┗
    local DOT_LINE=$'\u2508' # ┈
    local MDOT_LINE="$(printf "${DOT_LINE}%.0s" {0..3})" # Repeate DOT_LINE 3times.
    local LINE_RIGHT=$'\u257c' # ╼
    local POLE_RIGHT=$'\u2528' # ┨
    local DISAPEAR=$'\u2593\u2592\u2591' # ▓▒░
    
    # Foregorund or font colors
    local CDEFAULT="\[\e[39m\]"
    local CGREEN="\[\e[32m\]"
    local CWHITE="\[\e[97m\]"
    local CBLUE="\[\e[34m\]"
    local CLYELLOW="\[\e[93m\]"
    
    # Background colors
    local BDEFAULT="\[\e[49m\]"
    local BMAGENTA="\[\e[45m\]"
    local BBLUE="\[\e[44m\]"
    local BGREEN="\[\e[42m\]"
    
    # Print Git branch name
    local GIT_BRANCH="\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/${CWHITE}${BMAGENTA} git[\1] ${BDEFAULT}/')"
    
    # Return
    echo "${CGREEN}${LEFT_DOWN}${DOT_LINE}${POLE_RIGHT}${CWHITE}${debian_chroot:+($debian_chroot)}${BGREEN} hm ${GIT_BRANCH}${BBLUE} \w ${BDEFAULT}${CBLUE}${DISAPEAR}\n${CGREEN}${DOWN_RIGHT}${MDOT_LINE}${LINE_RIGHT}${CLYELLOW}${ARROW_RIGHT}${CDEFAULT} "
}

if [ "$color_prompt" = yes ]; then
    # Default PS1
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    
    # Call custom PS1
    PS1=$(hmCustomPS1)
    
    # Add new line after output or command result
    reset_prompt () {
        PS1="\n$PS1"
    }
    PROMPT_COMMAND='(( PROMPT_CTR-- < 0 )) && {
        unset PROMPT_COMMAND PROMPT_CTR
        reset_prompt
    }'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
