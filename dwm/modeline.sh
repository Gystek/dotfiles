#!/bin/sh

mod_battery() {
    case $(cat /sys/class/power_supply/AC/online | awk '{$1=$1;print}') in
	1*)
	    echo -n "+"
	    ;;
	*)
	    echo -n "-"
	    ;;
    esac

    acpi -b | egrep "[cC]harging, [0-9]?[0-9][0-9]%" -o | awk -F', ' '{ print $2 }'
}

mod_date() {
    date +"%a %d %b, %Y    %H:%M"
}

mod_mem() {
    free -h | head -n 2 | tail -n 1 | awk -F' ' '{ print $7"/"$2 }'
}

mod_cpu() {
    load="$(uptime | egrep "load average: [0-9].[0-9][0-9]" -o | awk -F': ' '{ print $2 }')"
    echo "$load;$(nproc)" | awk -F';' '{ print $1/$2*100 }'
}

echo "  $(mod_cpu)% | $(mod_mem) | $(mod_battery) | $(mod_date)  "
