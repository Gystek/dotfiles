function ls
   /bin/ls --color=auto $argv
end

if status is-interactive
   set -gx GPG_TTY (tty)

   set terminal "st"

   set active_w  (xdotool getactivewindow)
   set act_class (xprop -id $active_w | grep WM_CLASS)

   if string match "*$terminal*" $act_class
       set term_pid (xprop -id $active_w| grep _NET_WM_PID | grep -oP "\d+")
       if test "$term_pid" != ""
           set shell_pid (pgrep -P $term_pid)
           if test "$shell_pid" != ""
               cd (readlink /proc/$shell_pid/cwd)
           end
       end	
   end
end


set PATH /usr/local/bin /bin /usr/bin /usr/local/sbin /usr/sbin /sbin $HOME/.cargo/bin $HOME/.local/bin $HOME/.dotnet/
