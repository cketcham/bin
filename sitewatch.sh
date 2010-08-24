#!/bin/bash
# Cameron Ketcham
# 8/24/10
# will ping a url and tell you via applescript when a change happened
# useful when you want to check if tickets are available etc.
# TODO: make a daemon since it should really happen in the background.
# TODO: display the change in a reasonable way on the dialog
# TODO: make input parameters nicer
# TODO: add help output
# TODO: use applescript to add focus back whatever you were doing after the dialog closes
url=$1
interval=$2
ignore=$3

while true; do 
	if [ ! -e /tmp/sitecheck ]
	then
		curl -s $url | grep -v "$ignore" > /tmp/sitecheck
	fi

	curl -s $url | grep -v "$ignore" > /tmp/sitecheck2
	
	if diff /tmp/sitecheck /tmp/sitecheck2 >/dev/null ; then
		echo "same"
	else
		
		diff /tmp/sitecheck /tmp/sitecheck2 > /tmp/sitecheck.log
		osascript -e "tell application \"Finder\" to activate"
		osascript -e "tell application \"Finder\" to display dialog \"Site has been updated\""
		
		mv /tmp/sitecheck2 /tmp/sitecheck
	fi

	sleep $interval
done
