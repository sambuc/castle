alias dcb='devcontainer build --workspace-folder $(git rev-parse --show-toplevel)'
alias dce='devcontainer exec --workspace-folder $(git rev-parse --show-toplevel)'
alias dcu='devcontainer up --workspace-folder $(git rev-parse --show-toplevel)'

if /usr/bin/which -s pyenv; then
	alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
fi
