#!/bin/bash

INITIAL_COUNTER=0

function init_counter() {
  for file in *; do 
    if [ -f "$file" ]; then 
        pattern='([[:digit:]]+)'
        [[ "$file" =~ $pattern ]]
        if [ $((BASH_REMATCH[0])) -gt $((INITIAL_COUNTER)) ]; then
            INITIAL_COUNTER="${BASH_REMATCH[0]}"
        fi
    fi 
  done
}

function scan_document() {
  WID=`xdotool search "Document Scanner" | head -1`
  xdotool windowactivate --sync $WID
  xdotool key --clearmodifiers ctrl+s 
  sleep 1
  xdotool key --clearmodifiers ctrl+l
  sleep 0.5
  xdotool key --clearmodifiers ctrl+a
  xdotool type $((INITIAL_COUNTER+1)).png
  sleep 0.5
  xdotool key --clearmodifiers Return
  sleep 5
  xdotool key --clearmodifiers ctrl+n
  sleep 1
  xdotool key Escape
  sleep 1
  xdotool key --clearmodifiers ctrl+1
  xdotool key --clearmodifiers alt+Tab
  sleep 1
  # type the name of this script into the terminal so that Return can be used to run it again when ready
  xdotool type $(realpath $0)
}

init_counter
echo saving $((INITIAL_COUNTER+1)).png
scan_document