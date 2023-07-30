setxkbmap -option caps:escape
xmodmap -e "keysym Shift_R = Multi_key"

start-pulseaudio-x11

HDMI=$(xrandr | grep " connected " | grep HDMI1)

if [ -z "$HDMI" ]
then
    xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal\
	   --output HDMI1 --off
else
    xrandr --output eDP1 --primary --mode 1920x1080 --pos 1680x0 --rotate normal\
	   --output HDMI1 --mode 1680x1050 --pos 0x0 --rotate normal
fi

feh --bg-max ~/Documents/pictures/czeczenia_noc.jpg

while xsetroot -name "$(/home/gustek/sources/dotfiles/dwm/modeline.sh)"
do
    sleep 5
done &
exec dbus-launch dwm
