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


# Some things have to be done in varying ways depending on the OS
ARCH		:= $(shell uname -s)

# For GNU/Linux
ifeq (${ARCH},Linux)
ARCH_DEFINED	:= ok
HOSTNAME	:= $(shell hostname)
endif

# For MacOS X
ifeq (${ARCH},Darwin)
ARCH_DEFINED	:= ok
HOSTNAME	:= $(shell hostname -s)
endif

# For Windows
ifeq ($(word 2,$(subst -, ,$(subst _, ,${ARCH}))),NT)
ARCH_DEFINED	:= ok
HOSTNAME	:= $(shell hostname)
endif

ifneq (${ARCH_DEFINED},ok)
$(info )
$(info :: ERROR: Please add the necessary support or use one of:)
$(info ::        Linux, Mac OS X (Darwin), Windows.)
$(info )
$(error Unsupported architecture: $(ARCH))
else

.PHONY:
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

.PHONY:
all: bash zsh git vim x11 i3

.PHONY:
git: .config/git
.config/git: .config/dir

.PHONY:
sh: .profile

.PHONY:
bash: .profile .bashrc .bash_aliases .bash_logout

.PHONY:
zsh: .profile .zprofile .zshrc .oh-my-zsh/themes/lsambuc.zsh-theme
.oh-my-zsh/themes/lsambuc.zsh-theme: .oh-my-zsh/themes/dir

.PHONY:
omz:
	${MV} "$@" "$@-${TS}"
	${Q} ${CURL} "${OMYZSH_URL}" | sh

.PHONY:
vim: ~/.vim/bundle/vundle
	${ECHO}
	vim +BundleInstall +qall
	${ECHO}
	${ECHO} Do not forget to install and set a Nerdfont enhanced font.

~/.vim/bundle/vundle: .vim/bundle/dir .vimrc .vim/filetype.vim .vim/syntax
	${MV} "$@" "$@-${TS}"
	git clone "${VUNDLE_URL}" "$@"

.vim/filetype.vim .vim/syntax: .vim/dir

.PHONY:
tmux: .config/tmux
.config/tmux: .config/dir

.PHONY:
i3: .config/i3 .config/i3status.conf
.config/i3 .config/i3status.conf: .config/dir

.PHONY:
x11: .Xdefaults .xinitrc .xsession

%/dir:
	${MKDIR} "~/$(shell dirname $@)"

.%:
	@# Prevent generating link within links to folders
	@[ -e ~/.$* ] && mv ~/.$* ~/.$*-${TS} || true
	${LN} $(shell pwd)/_$* ~/.$*
	@[ -e ${HOSTNAME}.$* ] && ( [ -e ~/.host.$* ] && mv ~/.host.$* ~/.host.$*-${TS};  ln -s $(shell pwd)/${HOSTNAME}.$* ~/.host.$* ) || true

endif
