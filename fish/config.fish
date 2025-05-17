if status is-interactive
    set -gx GPG_TTY (tty)
end

set fish_greeting ""

set -gx ORGANIZATION "Gustek <gustek@riseup.net>"

set PATH /usr/local/bin \
         /bin \
         /usr/bin \
         /usr/local/sbin \
         /usr/sbin \
         $HOME/.local/bin \
	 $HOME/.cargo/bin
