#!/usr/bin/env bash

# Firefox Twitter
pkill -f "\-\-class\=FirefoxTwitter"

# Discord
pkill Discord

# Signal
pkill signal-desktop

# Ferdi
pkill ferdi

# Slack
#pkill slack

# Element/Riot
pkill riot-desktop

# YouTube Firefox
pkill -f "\-\-class\=FirefoxYouTube"

# Spotify
pkill spotify

# TodoList
pkill -f "\-\-class\=AlacrittyTodoList"

exit 0
