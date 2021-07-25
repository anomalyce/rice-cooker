#!/usr/bin/env bash

# Discord
pkill Discord

# Signal
pkill signal-desktop

# Ferdi
# pkill ferdi

# WhatsDesk
pkill whatsdesk
pkill whatsdesk
pkill whatsdesk
pkill whatsdesk
pkill whatsdesk
pkill whatsdesk
pkill whatsdesk

# Slack
#pkill slack

# Element/Riot
pkill riot-desktop

# YouTube Firefox
pkill -f "\-\-class\=FirefoxYouTube"

# Spotify
pkill spotify

# Startup Shell
pkill -f "\-\-class\=AlacrittyStartup"

# Taskbook
# pkill -f "\-\-class\=AlacrittyTodoList"

exit 0
