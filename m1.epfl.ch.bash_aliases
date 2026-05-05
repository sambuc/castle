alias dcb='devcontainer build --workspace-folder $(git rev-parse --show-toplevel)'
alias dce='devcontainer exec --workspace-folder $(git rev-parse --show-toplevel)'
alias dcu='devcontainer up --workspace-folder $(git rev-parse --show-toplevel)'

alias k='kubectl'
alias meld=/Applications/Meld.app/Contents/MacOS/Meld

if /usr/bin/which -s pyenv; then
	alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
fi
