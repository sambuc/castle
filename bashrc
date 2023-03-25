# Check for an interactive session
[ -z "${PS1}" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
#export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
export HISTSIZE=1000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export VISUAL=vi
export EDITOR=vi

case "$TERM" in
    xterm*) color_prompt=yes;;
    linux) color_prompt=yes;;
    *) color_prompt=no;;
esac

#-------------------------------------
#  Set the PWD to max pwd_length characters
function fixprmpt {
    local pwd_length=20
    if [ $(echo -n "${PWD}" | wc -c | tr -d ' ') -gt ${pwd_length} ]; then
        local newPWD="...$(echo -n ${PWD} | sed -e "s/.*\(.\{${pwd_length}\}\)/\1/")"
    else
        local newPWD="$(echo -n ${PWD})"
    fi
    echo ${newPWD}
}

# Functions & colours used in prompt :
#=====================================
# define the colors
export   RESET="\[\033[m\]"
export    LRED="\[\033[1;31m\]"
export   LBLUE="\[\033[1;34m\]"
export   LGREY="\[\033[0;37m\]"
export   WHITE="\[\033[0;38m\]"
export  LWHITE="\[\033[1;37m\]"
export  LGREEN="\[\033[1;32m\]"
export LYELLOW="\[\033[1;33m\]"

#-------------------------
#  Set prompt in red for root and in green for users
#  if where are at the console or in an xterm compatible terminal
function usercolor {
    if [ "$color_prompt" = "yes" ]; then
        if [ 'root' = `id -un` ]; then
            echo  -n ${LRED}
        else
            echo  -n ${LGREEN}
        fi
    else
        if [ 'root' = `id -un` ]; then
            echo  -n ${LWHITE} 
        else
            echo  -n ${LGREY}
        fi
    fi
}

if [ "$color_prompt" = "yes" ]; then
    PS1="${LBLUE}\$(date '+%H:%M')${LGREY} [$(usercolor)\u${LGREY}@\h:\$(fixprmpt)] \!$LYELLOW>${RESET} "
else
    #PS1="\$(date '+%H:%M') [\u@\h:\$(fixprmpt)] \!> "
    PS1="${LGREY}\$(date '+%H:%M') ${LWHITE}[$(usercolor)\u${LWHITE}@${LGREY}\h${LWHITE}:${LGREY}\$(fixprmpt)${LWHITE}]${LGREY} \!${LWHITE}>${RESET} "
fi

# enable color support of ls
if [ -x /bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#colorize stderr
function swapandcolorize()
{
#    "$@" 3>&2 2>&1 1>&3 | while read line
#    do
#	echo -e "\e[91m$line\e[0m"
#    done
    "$@" 3>&2 2>&1 1>&3 | perl -e 'while(<>) 
	{
		chomp;
    #Print in LYELLOW and blue background xenomai stuff warning and such
                if (m/^xenomai.+:\d+:(\d+:)?\s+warning.*/) 
                {print "\033[1;45m".$_."\033[m\n"; next;}

	#Print in DARKBLUE forced warnings
		if (m/.*\#warning.*/)
		{print "\033[1;34m".$_."\033[m\n"; next;}
	#Print in LYELLOW warning and such
		if (m/.+:\d+:(\d+:)?\s+warning.*/) 
		{print "\033[1;33m".$_."\033[m\n"; next;}
	#print in LRED errors
		if (m/.+:\d+:(\d+:)?\s+error.*/ ||
		    m/.+:\d+:(\d+:)? undefined reference to `/) 
		{print "\033[1;31m".$_."\033[m\n"; next;}
	#Print in default colors
		{print "\033[m".$_."\n"; next;}
	};'
	return ${PIPESTATUS[0]}
}
export -f swapandcolorize
