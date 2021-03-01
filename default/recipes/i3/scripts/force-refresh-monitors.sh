#!/usr/bin/env bash

env DISPLAY=:0 xset dpms force off

sleep 1

env DISPLAY=:0 xset dpms force on

