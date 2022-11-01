[[ $- != *i* ]] && return

code() {
    ret=$?

    if [[ $ret != 0 ]]
    then
	printf "[$ret] "
    else
	printf ""
    fi
}

flags() {
    local e=0

    if [[ -d "$(pwd)/.git" ]]
    then
	printf "G"
	e=1
    fi

    if [[ -n "$STY" ]]
    then
	printf "S"
	e=1
    fi

    if [[ $e -gt 0 ]]
    then
	printf " "
    fi


}

PS1='$(code)$(flags)\W \$ '

alias ls='ls --color=auto'
alias emacs='emacs -nw'

PATH="/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:${HOME}/.cargo/bin"; export PATH
GPG_TTY=$(tty); export GPG_TTY;
