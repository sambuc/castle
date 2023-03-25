alias       c='echo -n "\033&a0c0R";clear'
alias   xterm='xterm -rv -fg grey -bg black -sb -sl 2000 &'
alias    term='aterm -sr -sl 10000 -fg white -bg black &'
alias   tterm='aterm -tr -trsb -sr -sl 10000 -sh 40 -fg white -bg black &'
alias   cterm='bterm -tr +scrollBar -sh 40 -fg white -bg black'
alias  alterm='bterm -tr +scrollBar -sh 80 -fg white -bg black'

# some more ls aliases
alias ll='ls -l'
alias l='ls'

alias mroe='more'
alias m='more'

alias grep='grep --color=auto'

alias weather='curl -H "Accept-Language: en" http://wttr.in/Lausanne'

function dias() {
	n=$1
	shift
	ssh diascld$n.iccluster.epfl.ch -A -Y $@
}

function diasrange() {
	start=$1
	end=$2
	shift; shift;
	for d in $(seq ${start} ${end})
	do
		echo diascld$d
		dias $d -x "$@"
		echo ------------------------------------------------------------------------------
	done
}
