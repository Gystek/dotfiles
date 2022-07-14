setkxmap -option caps:escape
xmodmap -e "keysym Shift_R = Multi_key"

HDMI=$(xrandr | grep " connected " | grep HDMI-1)

if [ -z "$HDMI" ]
then
    xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal\
	   --output HDMI-1 --off
else
    xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1680x0 --rotate normal\
	   --output HDMI-1 --mode 1680x1050 --pos 0x0 --rotate normal
fi

exec dbus-launch xfce4-session
