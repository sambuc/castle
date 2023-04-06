# Override on the command line, for example
#   make Q=""
# would print on the console all the commands being run, instead of just their outputs
Q		:= @

# The role of echo is to print, so never print the command itsef
ECHO		:= @echo
LN		:= ${Q}ln -sf
MKDIR		:= ${Q}mkdir -p
MV		:= ${Q}mv

# Make sure that all files moved during this invokation of make get the same
# timestamp.
TS		:= $(shell date -Iseconds)

OMYZSH_URL	:= https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh
VUNDLE_URL	:= https://github.com/gmarik/vundle.git

.PHONY: help
help:
	${ECHO} "help:\tShow this help"
	${ECHO} "all:\tSetup all the dot files in one go"
	${ECHO}
	${ECHO} "omz:\tInstall oh-my-zsh"
	${ECHO} "git:\tInstall GIT configuration files"
	${ECHO} "bash:\tInstall BASH configuration files"
	${ECHO} "zsh:\tInstall ZSH configuration files"
	${ECHO} "vim:\tInstall VIM configuration files"
	${ECHO} "tmux:\tInstall tmux configuration files"
	${ECHO} "x11:\tInstall X configuration files"
	${ECHO} "i3:\tInstall i3wm configuration files"
	${ECHO}

.PHONY: all
all: bash zsh git vim x11 i3

.PHONY: git config/git
git: config/git
config/git: config/dir

.PHONY: bash profile bashrc bash_aliases bash_logout
bash: profile bashrc bash_aliases bash_logout

.PHONY: zsh oh-my-zsh/themes/lsambuc.zsh-theme
zsh: profile zprofile zshrc oh-my-zsh/themes/lsambuc.zsh-theme
oh-my-zsh/themes/lsambuc.zsh-theme: oh-my-zsh/themes/dir

.PHONY: omz
omz:
	${MV} "$@" "$@-${TS}"
	${Q} ${CURL} "${OMYZSH_URL}" | sh

.PHONY: vim vim/bundle/dir vimrc vim/filetype.vim vim/syntax
vim: ~/.vim/bundle/vundle
	${ECHO}
	vim +BundleInstall +qall
	${ECHO}
	${ECHO} Do not forget to install and set a Nerdfont enhanced font.

~/.vim/bundle/vundle: vim/bundle/dir vimrc vim/filetype.vim vim/syntax
	${MV} "$@" "$@-${TS}"
	git clone "${VUNDLE_URL}" "$@"

vim/filetype.vim vim/syntax: vim/dir

.PHONY: tmux config/tmux config/dir
tmux: config/tmux
config/tmux: config/dir

.PHONY: i3 config/i3 config/i3status.conf
i3: config/i3 config/i3status.conf
config/i3 config/i3status.conf: config/dir

.PHONY: x11 Xdefaults xinitrc xsession
x11: Xdefaults xinitrc xsession

%/dir:
	${MKDIR} "~/.$(shell dirname $@)"

%:
	@# Prevent generating link within links to folders
	${MV} "~/.$@" "~/.$@-${TS}"
	${LN} "$(shell pwd)/_$@" "~/.$@"

