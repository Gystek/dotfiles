#!/bin/sh

UNDER_20=0

mod_battery() {
    case $(cat /sys/class/power_supply/AC/online | awk '{$1=$1;print}') in
	1*)
	    echo -n "+"
	    ;;
	*)
	    echo -n "-"
	    ;;
    esac

    level=$(acpi -b | egrep "(D?i?s?[cC]harging|Full), [0-9]?[0-9][0-9]" -o | awk -F', ' '{ print $2 }')
    if [ "$level" -lt 20 ] && [ $UNDER_20 -eq 0]
    then
	herbe "Batterie faible !" " " "Il reste moins de 20% de  batterie."
	UNDER_20=1
    else
p	UNDER_20=0
    fi

    printf "${level}%%\n"
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
