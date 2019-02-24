#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"
source "$CURRENT_DIR/helpers.sh"


color_warning_charge=$(get_tmux_option "@batt_color_custom_warning_charge" "red")

get_charge_color_settings() {
    color_background=$(get_tmux_option "@batt_color_custom_background" "$color_background_default")
}

color_full_charge_default="green"
color_high_charge_default="green"
color_medium_charge_default="yellow"
color_low_charge_default="colour208"
color_warning_charge_default="red"
color_charging_default="green"
color_background_default=$(get_tmux_option "@batt_color_custom_background" "colour234")

color_full_charge=""
color_high_charge=""
color_medium_charge=""
color_low_charge=""
color_warning_charge=""
color_charging=""
color_background=""

get_charge_color_settings() {
    color_full_charge=$(get_tmux_option "@batt_color_custom_full_charge" "$color_full_charge_default")
    color_high_charge=$(get_tmux_option "@batt_color_custom_high_charge" "$color_high_charge_default")
    color_medium_charge=$(get_tmux_option "@batt_color_custom_medium_charge" "$color_medium_charge_default")
    color_low_charge=$(get_tmux_option "@batt_color_custom_low_charge" "$color_low_charge_default")
    color_warning_charge=$(get_tmux_option "@batt_color_custom_warning_charge" "$color_warning_charge_default")
    color_charging=$(get_tmux_option "@batt_color_custom_charging" "$color_charging_default")
    color_background=$(get_tmux_option "@batt_color_custom_background" "$color_background_default")
}

print_battery_custom() {
    # Call `battery_percentage.sh`.
    percentage=$($CURRENT_DIR/battery_percentage.sh | sed -e 's/%//')
    icon=`$CURRENT_DIR/battery_icon.sh`
    status=$($CURRENT_DIR/battery_icon.sh | sed -e 's/%//')
    if [ $status == 'charging' ]; then
      echo "#[fg=$color_charging]$icon $percentage %  "
    elif [ $percentage -eq 100 ]; then
      echo "#[fg=$color_full_charge]$icon $percentage %  "
    elif [ $percentage -le 99 -a $percentage -ge 76 ];then
      echo "#[fg=$color_high_charge]$icon $percentage %  "
    elif [ $percentage -le 75 -a $percentage -ge 31 ];then
      echo "#[fg=$color_medium_charge]$icon $percentage %  "
    elif [ $percentage -le 30 -a $percentage -ge 11 ];then
      echo "#[fg=$color_low_charge]$icon $percentage %  "
    elif [ "$percentage" == "" ];then
      echo "#[fg=$color_full_charge]$icon  "
    else
      echo \
        "#[fg=$color_warning_charge,bg=$color_background,nobold]"\
        "#[fg=$color_background,bg=$color_warning_charge,nobold]$icon  $percentage % "\
        "#[fg=$color_warning_charge,bg=$color_background,nobold]'"
    fi
}

main() {
  get_charge_color_settings
	print_battery_custom
}
main
