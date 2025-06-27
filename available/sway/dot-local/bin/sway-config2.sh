#!/bin/bash

swaymsg -t subscribe -m '["tick","input"]' -r | /home/ilya/.local/bin/sway-status
