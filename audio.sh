#!/bin/bash

case "${1:-}" in
  (""|list)
    pacmd list-sinks |
      grep -E 'index:|name:'
    ;;
  ([0-9]*)
    echo switching default
    pacmd set-default-sink $1 ||
      echo failed
    echo switching applications
    pacmd list-sink-inputs |
      awk '/index:/{print $2}' |
      xargs -r -I{} pacmd move-sink-input {} $1 ||
        echo failed
    ;;
  ("speackers"|"headset")
    declare -A devices
    devices=(["speackers"]="hdmi-stereo-extra4" ["headset"]="USB_Audio_Device-00")
    echo switching default
    sink_index=$(pacmd list-sinks | grep -B1 "${devices[$1]}" | awk '/index:/{print $NF}')
    pacmd set-default-sink $sink_index ||
      echo failed
    echo switching applications
    pacmd list-sink-inputs |
      awk '/index:/{print $NF}' |
      xargs -r -I{} pacmd move-sink-input {} $sink_index ||
        echo failed
    ;;
  (*)
    echo "Usage: $0 [|list|<sink name to switch to>]"
    ;;
esac
