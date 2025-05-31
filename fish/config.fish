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
	 $HOME/.cargo/bin \
	 $HOME/.ghcup/bin \
	 $HOME/.cabal/bin

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/gustek/.opam/opam-init/init.fish' && source '/home/gustek/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
