function ls
   /bin/ls --color=auto $argv
end

if status is-interactive
   set -gx GPG_TTY (tty)
end

set fish_greeting ""

function fish_prompt
    printf "%s:%s %s\$ " (whoami) (hostname) (basename (pwd))
end

# This actually consumes a lot of CPU.
# if not string match "bicon*" (ps -p (ps -p (echo $fish_pid) -o ppid=) -o comm=)
#      bicon.bin
# end

set PATH /usr/local/bin /bin /usr/bin /usr/local/sbin /usr/sbin /sbin $HOME/.cargo/bin $HOME/.local/bin $HOME/.dotnet/
