#!/bin/env bash

choice=$(printf "Lock\nLogout\nSuspend\nReboot\nShutdown" | rofi -dmenu)
case "$choice" in
  Lock) xsecurelock ;;
  Logout) pkill -KILL -u "$USER" ;;
  Suspend) systemctl suspend && xsecurelock ;;
  Reboot) systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
