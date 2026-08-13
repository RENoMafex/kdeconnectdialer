#! /usr/bin/env bash

# Published under the MIT license.

# check if run in terminal or krunner
if [[ -t 0 && -t 1 ]]; then
	runinterm=1
fi

# Sanitize/validate numer
number="$*"
if [[ -z "$number" ]]; then # check if num is provided
	if [[ $runinterm != 1 ]]; then
		notify-send -a "Dialer" "Please provide a number to call!"
	fi
	echo "Please provide a number to call!"
	exit 1
fi

number=${number//[^+0-9]//} # delete everything which isnt a digit or plus sign
if ! [[ "$number" =~ ^(\+[1-9][0-9]{0,14}|00[1-9][0-9]{0,14}|0[0-9]{1,14})$ ]]; then
	if [[ $runinterm != 1 ]]; then
		notify-send -a "Dialer" "Number invalid!"
	fi
	echo "Number invalid!"
	exit 1
fi

device_id="$(kdeconnect-cli -a --id-only | head -n1)"
if ! [[ "$device_id" =~ ^[0-9a-fA-F]{32}$ ]]; then
	if [[ $runinterm != 1 ]]; then
		notify-send -a "Dialer" "No Phone connected!"
	fi
	echo "No Phone connected!"
	exit 1
fi

kdeconnect-handler --device "$device_id" "tel:$number"
