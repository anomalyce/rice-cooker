#!/bin/sh

SELF_DIR=`realpath $(dirname "$0")`

case "$1" in
    "display") # Display the current VPN status in the polybar
        VPN_STATUS="`mullvad status`"
        VPN_CONNECTION=`echo "$VPN_STATUS" | grep -i "Tunnel status" | cut -d':' -f 2 | xargs`

        if [[ "$VPN_CONNECTION" == *"Connected"* ]]; then
            echo $(cat "${SELF_DIR}/polybar-online.sh" | sh)
        else
            echo $(cat "${SELF_DIR}/polybar-offline.sh" | sh)
        fi
        ;;

    "leftclick") # Toggle the VPN connection
        VPN_STATUS="`mullvad status`"
        VPN_CONNECTION=`echo "$VPN_STATUS" | grep -i "Tunnel status" | cut -d':' -f 2 | xargs`

        if [[ "$VPN_CONNECTION" == *"Connected"* ]]; then
            # If a connection is already established, disconnect.
            mullvad disconnect

            notify-send \
                -i "${SELF_DIR}/mullvad-offline.svg" \
                "Mullvad" \
                "The VPN is disconnecting."
        else
            # If no connection has been established, connect.
            mullvad connect

            VPN_STATUS="`mullvad relay get`"
            VPN_CONNECTION=`echo "$VPN_STATUS" | grep -i "Current constraints" | cut -d':' -f 2 | xargs`

            notify-send \
                -i "${SELF_DIR}/mullvad-online.svg" \
                "Mullvad" \
                "Connecting to ${VPN_CONNECTION}"
        fi
        ;;

    "rightclick") # Display the current VPN status in a notification
        VPN_STATUS="`mullvad status --location`"

        function vpn_status_field {
            echo `echo "$VPN_STATUS" | grep -i "$1" | cut -d':' -f 2 | xargs`
        }

        VPN_CONNECTION=`vpn_status_field "Tunnel status"`

        if [[ "$VPN_CONNECTION" == "Disconnected" ]]; then
            notify-send \
                -i "${SELF_DIR}/mullvad-offline.svg" \
                "Mullvad" \
                "The VPN is currently disconnected."
                exit 0
        fi
        
        VPN_SERVER=`vpn_status_field "Relay"`
        VPN_LOCATION=`vpn_status_field "Location"`
        VPN_IPV4=`vpn_status_field "IPv4"`

        notify-send \
            -i "${SELF_DIR}/mullvad-online.svg" \
            "Mullvad (${VPN_SERVER})" \
            "${VPN_LOCATION}\n${VPN_IPV4}"
        ;;
esac

exit 0
