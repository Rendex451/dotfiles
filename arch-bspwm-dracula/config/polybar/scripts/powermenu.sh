#!/bin/env bash

choice=$(printf "Lock\nLogout\nSuspend\nReboot\nShutdown" | rofi -dmenu)
case "$choice" in
  Lock) ~/.config/polybar/scripts/lock.sh ;;
  Logout) pkill -KILL -u "$USER" ;;
  Suspend) systemctl suspend && ~/.config/polybar/scripts/lock.sh ;;
  Reboot) systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
