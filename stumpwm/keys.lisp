(set-prefix-key (kbd "C-RET"))

(bind-key "P" "exec flameshot gui")
(bind-key "C-l" "exec systemctl suspend; slock; exit")
(bind-key "C-f" "fullscreen")

(bind-key "t" "exec alacritty")
(bind-key "c" "exec")
(bind-key "C-r" "loadrc")
(bind-key "C-I" "modules-init")

(run-shell-command "setxkbmap -option caps:escape")
(run-shell-command "xmodmap -e 'keysym Shift_R = Multi_key'")
