#! /usr/bin/env bash

# Published under the MIT license.

# This Programm can be used if you use KDE and KDEconnect.
# The purpose of this Programm is to send over numbers to your phone.

# check if run in terminal or krunner
if [[ -t 0 && -t 1 ]]; then
	run_in_term=1
fi

# Sanitize/validate numer
number="$*"
if [[ -z "$number" ]]; then # check if num is provided
	if [[ $run_in_term != 1 ]]; then
		notify-send -a "Dialer" "Please provide a number to call!"
		exit 1
	fi
	echo "Please provide a number to call!"
	exit 1
fi

number=${number//[^+0-9]//} # delete everything which isnt a digit or plus sign
if ! [[ "$number" =~ ^(\+[1-9][0-9]{0,14}|00[1-9][0-9]{0,14}|0[0-9]{1,14})$ ]]; then
	if [[ $run_in_term != 1 ]]; then
		notify-send -a "Dialer" "Number invalid!"
		exit 1
	fi
	echo "Number invalid!"
	exit 1
fi

device_id="$(kdeconnect-cli -a --id-only | head -n1)"
if ! [[ "$device_id" =~ ^[0-9a-fA-F]{32}$ ]]; then
	if [[ $run_in_term != 1 ]]; then
		notify-send -a "Dialer" "No Phone connected!"
		exit 1
	fi
	echo "No Phone connected!"
	exit 1
fi

kdeconnect-handler --device "$device_id" "tel:$number"
