#!/usr/bin/env sh

get_mic_default() {
    # pw-cat --record --list-targets | sed -n -E "1 s/^.*: (.*)/\1/p"
    echo "alsa_input.usb-RODE_Microphones_RODE_NT-USB-00.iec958-stereo"
}

is_mic_muted() {
    mic_name="$(get_mic_default)"

    pactl list sources | \
        awk -v mic_name="${mic_name}" '{
            if ($0 ~ "Name: " mic_name) {
                matched_mic_name = 1;
            } else if (matched_mic_name && /Mute/) {
                print $2;
                exit;
            }
        }'
}

get_mic_volume() {
    mic_name="$(get_mic_default)"

    pactl list sources | \
        awk -v mic_name="${mic_name}" '{
            if ($0 ~ "Name: " mic_name) {
                matched_mic_name = 1;
            } else if (matched_mic_name && /Volume/) {
                print $5;
                exit;
            }
        }'
}

get_mic_status() {
    is_muted="$(is_mic_muted)"
    volume="$(get_mic_volume)"

    if [ "${is_muted}" = "yes" ]; then
        printf "%s\n" "%{F${COLOR_URGENT}}%{T8}%{T-}%{F-}"
    else
        printf "%s\n" "%{T8}%{T-} ${volume}"
    fi
}

listen() {
    get_mic_status

    LANG=EN; pactl subscribe | while read -r event; do
        if printf "%s\n" "${event}" | grep --quiet "source" || printf "%s\n" "${event}" | grep --quiet "server"; then
            get_mic_status
        fi
    done
}

toggle() {
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
}

increase() {
    pactl set-source-volume @DEFAULT_SOURCE@ +5%
}

decrease() {
    pactl set-source-volume @DEFAULT_SOURCE@ -5%
}

main() {
    case "${1}" in
        --toggle)
            toggle
            ;;
        --increase)
            increase
            ;;
        --decrease)
            decrease
            ;;
        *)
            listen
            ;;
    esac
}

main "${@}"
