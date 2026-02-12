setxkbmap us -variant workman
xmodmap -e "keysym Alt_R = Multi_key"

while xsetroot -name "$(/home/gustek/Documents/sources/dotfiles/dwm/modeline.sh)"
do
    sleep 5
done &

exec dbus-run-session dwm

