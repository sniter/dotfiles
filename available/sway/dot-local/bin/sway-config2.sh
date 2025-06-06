#!/bin/bash

BATTERY_ICONS=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
BATTERY_CHARGING=""
BATTERY_FULL=""
BATTERY_NOT_CHARGING=""
BATTERY_DISCHARGING=""
TIME_FMT='%Y-%m-%d %H:%M'
MEMORY_LABEL=" mem %d%%"
CPU_LABEL=" cpu %d%%"
DISK_LABEL=" dsk %d%%"
SWAP_LABEL="/%d%%"
TEMP_LABEL=" temp %s"
LAYOUT_LABEL=" | "
BATTERY_LABEL=" %s%s %d%%"
CALENDAR_LABEL=" | %s"
WEATHER_LOCATION="Jurmala"
WEATHER_FMT="%C+%t+%w"
WEATHER_LABEL=" | %s"

BATTERY=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)

weather() {
  local ttl=1200 # Default TTL is 20 mins
  local cache_file="/tmp/wttr.in"

  local needs_refresh=false
  if [[ ! -f "$cache_file" ]] || (($(date +%s) - $(stat -c %Y "$cache_file") >= ttl)); then
    needs_refresh=true
    curl -s "wttr.in/${WEATHER_LOCATION:-Riga}?format=${WEATHER_FMT:-1}" >"$cache_file"
  fi

  printf "${WEATHER_LABEL:- WEATHER: %s}" "$(cat $cache_file)" "$needs_refresh"
}

layout() {
  LAYOUT=$(
    swaymsg -t get_inputs | jq '.[0].xkb_active_layout_name' | cut -d '"' -f 2 2>/dev/null
  )

  printf "${LAYOUT_LABEL}%s" $(case "$LAYOUT" in
    Rus*)
      echo "RU"
      ;;
    Latv*)
      echo "LV"
      ;;
    Eng*)
      echo "EN"
      ;;
    *)
      echo "${1:0:2}"
      ;;
    esac)
}

cpu() {
  printf "${CPU_LABEL:-CPU: %d%%}" $(cat /proc/stat | grep "cpu " | awk '{print ($1+$2+$3)/($1+$2+$3+$4+$5+$6+$7)*100 }')
}

disk() {
  printf "${DISK_LABEL:-DSK: %s}" $(df -h | grep "/home" | awk '{print $5}')
}

battery_icn() {
  len="${#BATTERY_ICONS[@]}"
  idx=$(printf "%d" $(("$BATTERY" / "$len")))
  if [ "$idx" -lt "$len" ]; then
    echo "${BATTERY_ICONS[$idx]}"
  else
    echo "${BATTERY_ICONS[-1]}"
  fi
}

battery_status() {
  case "$BATTERY_STATUS" in
  Charging)
    echo "$BATTERY_CHARGING"
    ;;
  Full)
    echo "$BATTERY_FULL"
    ;;
  "Not charging")
    echo "$BATTERY_NOT_CHARGING"
    ;;
  Discharging)
    echo ""
    ;;
  *)
    echo "$BATTERY_STATUS"
    ;;
  esac
}

battery() {
  printf "${BATTERY_LABEL:-BAT: %s%s %d%%}" "$(battery_status)" "$(battery_icn)" "$BATTERY"
}

temperature() {
  printf "${TEMP_LABEL:-TEMP: %s}" $(sensors | grep CPU | awk '{print $2}')
}

memory() {
  printf "${MEMORY_LABEL:-MEM: %d%%}" $(free | grep "Mem" | awk '{print $3/$2*100}')
}

swap() {
  printf "${SWAP_LABEL:-SWP: %d%%}" $(free | grep "Swap" | awk '{print $3/$2*100}')
}

calendar() {
  printf "${CALENDAR_LABEL:- %s}" "$(date +"$TIME_FMT")"
}

echo "$(temperature)$(disk)$(cpu)$(memory)$(swap)$(weather)$(layout)$(battery)$(calendar)"
