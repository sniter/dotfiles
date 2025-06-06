#!/bin/bash

BATTERY_ICONS=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
BATTERY_CHARGING=""
BATTERY_FULL=""
BATTERY_NOT_CHARGING=""
BATTERY_DISCHARGING=""
TIME_FMT='%a %b %d %H:%M'
# TIME_FMT='%Y-%m-%d %T'
MEMORY_LABEL=" mem %d%%"
CPU_LABEL=" cpu %d%%"
DISK_LABEL=" dsk %d%%"
SWAP_LABEL="/%d%% "
TEMP_LABEL=" temp %s"
LAYOUT_LABEL=" %s "
BATTERY_LABEL=" %s%s %d%% "
CALENDAR_LABEL=" %s"
WEATHER_LOCATION="Jurmala"
WEATHER_FMT="%C+%t+%w"
WEATHER_LABEL=" %s "

weather() {
  local ttl=1200 # Default TTL is 20 mins
  local cache_file="/tmp/wttr.in"

  local needs_refresh=false
  if [[ ! -f "$cache_file" ]] || (($(date +%s) - $(stat -c %Y "$cache_file") >= ttl)); then
    needs_refresh=true
    curl -s "wttr.in/${WEATHER_LOCATION:-Riga}?format=${WEATHER_FMT:-1}" >"$cache_file"
  fi

  printf "${WEATHER_LABEL:- WEATHER: %s}" "$(cat $cache_file)"
}

weather_render() {
  jq -n -c \
    --arg name "Layout" \
    --arg full_text "$(weather)" \
    '{name:$name,full_text:$full_text}'
}

#
# LAYOUT
#
LAYOUT="EN"
layout() {
  echo $(case "$1" in
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
      echo "${layout:0:2}"
      ;;
    esac)
}
layout_init() {
  LAYOUT="$(layout $(swaymsg -t get_inputs | jq '.[].xkb_active_layout_name' | grep -v null | head -n1 | cut -d '"' -f 2))"
}
layout_update() {
  LAYOUT="$(layout $(echo "$1" | jq '.input.xkb_active_layout_name' | cut -d '"' -f 2)) "
}
layout_render() {
  jq -n -c \
    --arg name "Layout" \
    --arg full_text "$(printf "${LAYOUT_LABEL:- Layout: %s}" "$LAYOUT")" \
    '{name:$name,full_text:$full_text}'
}

cpu() {
  printf "${CPU_LABEL:-CPU: %d%%}" $(cat /proc/stat | grep "cpu " | awk '{print ($1+$2+$3)/($1+$2+$3+$4+$5+$6+$7)*100 }')
}

disk() {
  printf "${DISK_LABEL:-DSK: %s}" $(df -h | grep "/home" | awk '{print $5}')
}

battery_icn() {
  local level="$1"
  local len="${#BATTERY_ICONS[@]}"
  local idx=$(printf "%d" $(("$level" / "$len")))
  if [ "$idx" -lt "$len" ]; then
    echo "${BATTERY_ICONS[$idx]}"
  else
    echo "${BATTERY_ICONS[-1]}"
  fi
}

battery_status() {
  local BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
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
  local level="$1"
  printf "${BATTERY_LABEL:-BAT: %s%s %d%%}" "$(battery_status)" "$(battery_icn "$level")" "$level"
}

battery_render() {
  local level=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
  jq -n -c \
    --arg name "Battery" \
    --arg full_text "$(battery "$level")" \
    '{name: $name, full_text: $full_text}'
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

stats_render() {
  jq -n -c \
    --arg name "Laptop stats" \
    --arg full_text "$(temperature)$(cpu)$(disk)$(memory)$(swap)" \
    '{name: $name, full_text: $full_text}'
}

#
# CALENDAR
#
calendar_render() {
  jq -n -c \
    --arg name "Time" \
    --arg full_text "$(printf "${CALENDAR_LABEL:- %s}" "$(date +"$TIME_FMT")")" \
    '{name: $name, full_text: $full_text}'
}

#
# STATUS RENDER
#
render() {
  echo "[$(stats_render),$(weather_render),$(layout_render),$(battery_render),$(calendar_render)],"
}

render_error() {
  local msg=$1
  local error=$(
    jq -n -c \
      --arg name Error \
      --arg full_text "$msg" \
      '{name: $name, full_text: $full_text}'
  )
  echo "[$error],"
}

ticking() {
  while true; do
    swaymsg -t send_tick
    sleep 5 # пауза 1 секунда
  done &
}

main() {
  # ticking
  # 1>/dev/null 2>/dev/null
  echo '{"version": 1, "click_events": false}'
  echo "["
  # set -x

  swaymsg -t subscribe -m '["tick","input"]' -r | while read -r event; do
    case $(echo "$event" | jq -r '.change // .first' | cut -d '"' -f 2) in
    true)
      layout_init
      ;&
    false)
      echo "$(render)"
      ;;
    xkb_layout)
      layout_update "$event"
      echo "$(render)"
      ;;
    libinput_config | xkb_keymap) ;;
    *)
      echo "$(render_error "$(echo "$event" | jq -r '.first // .change')")"
      ;;
    esac
  done

  # set +x
  echo "[],]"
}

main
# echo "$(temperature)$(disk)$(cpu)$(memory)$(swap)$(weather)$(layout)$(battery)$(calendar)"
