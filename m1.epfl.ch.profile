for d in \
	"${HOME}/.dotnet/tools" \
	"/opt/homebrew/opt/dotnet@9/bin" \
	"${HOME}/go/bin" \
	"${HOME}/.local/bin" \
	"${HOME}/.bun" \
	;
do
	if [ -d ${d} ]; then
		PATH="${d}:${PATH}"
	fi
done

# pyenv support
export PYENV_ROOT="${HOME}/.pyenv"
[[ -d ${PYENV_ROOT}/bin ]] && export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init -)"

# pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"

# DotNet support
export DOTNET_ROOT="/opt/homebrew/opt/dotnet@9/libexec"

export PATH

#export API_KEY_INPUT="d07304e9c314b20c7ac022d6b0c328a5"

# Terraform cache folder is 400MiB per projects...
export TF_PLUGIN_CACHE_DIR="${HOME}/.cache/terraform/plugins"

# Set default config for k9s
export K9S_CONFIG_DIR="${HOME}/.config/k9s"

# bun completions
[ -s "/Users/sambuc/.bun/_bun" ] && source "/Users/sambuc/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
