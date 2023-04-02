if [ "$(whoami)" = "root" ]
then
	USERCOLOR="red"
else
	USERCOLOR="green"
fi

local reset_color="%b%u%s%k%f"
local field_color="%b%F{white}"
local sep_color="%B%F{white}"

local time_field="%B%F{blue}%D{%H:%M}"
local user_field="%B%F{$USERCOLOR}%n"
local host_field="${field_color}%m"
local path_field="${field_color}%20<..<%~%<<"
local return_code="%(?.. %B%F{red}%?)"

# With Git status
PROMPT='${time_field}${sep_color} [${user_field}${sep_color}@${host_field}${sep_color}:${path_field}${sep_color}]$(git_prompt_info)${return_code} %B%F{yellow}»${reset_color} '

# Without Git status
#PROMPT='${time_field}${sep_color} [${user_field}${sep_color}@${host_field}${sep_color}:${path_field}${sep_color}]${return_code} %B%F{yellow}»${reset_color} '

# GIT Status theming
ZSH_THEME_GIT_PROMPT_PREFIX=" %b%F{red}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN="%B%F{green}✔"
ZSH_THEME_GIT_PROMPT_DIRTY="%B%F{red}✗"

# LS colors, made with http://geoff.greer.fm/lscolors/
#export LSCOLORS="Gxfxcxdxbxegedabagacad"
#export LS_COLORS="rs=0:di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# Redefine git_prompt_info, just grab the branch name, if there is one.
# This is much faster in large repositories.
function git_prompt_info () {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}
