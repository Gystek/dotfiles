function ls
   /bin/ls --color=auto $argv
end

function emacs
   /usr/bin/emacs -nw $argv
end

if status is-interactive
   set -gx GPG_TTY (tty)
end

set PATH /usr/local/bin /bin /usr/bin /usr/local/sbin /usr/sbin /sbin $HOME/.cargo/bin
