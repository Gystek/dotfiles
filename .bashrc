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

OPAM_SWITCH_PREFIX="${HOME}/.opam/default"; export OPAM_SWITCH_PREFIX;
CAML_LD_LIBRARY_PATH="${HOME}/.opam/default/lib/stublibs:${HOME}/.opam/default/lib/ocaml/stublibs:${HOME}/.opam/default/lib/ocaml"; export CAML_LD_LIBRARY_PATH;
OCAML_TOPLEVEL_PATH='${HOME}/.opam/default/lib/toplevel'; export OCAML_TOPLEVEL_PATH;
MANPATH=':${HOME}/.opam/default/man'; export MANPATH;
PATH='${HOME}/.opam/default/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin'; export PATH;
