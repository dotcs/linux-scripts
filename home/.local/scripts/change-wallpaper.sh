#!/usr/bin/env bash

# USAGE ./change-wallpaper.sh /path/to/wallpaper/folder

WALLPAPER_FOLDER=${1:-/home/$USER/wallpapers}

if ! hash gnome-session 2>/dev/null; then
    1>&2 echo "gnome-session is not installed"
    exit 1
fi
if ! hash gsettings 2>/dev/null; then
    1>&2 echo "gsettings is not installed"
    exit 1
fi
if [ ! -d "$WALLPAPER_FOLDER" ]; then
    1&>2 echo "Wallpaper folder '$WALLPAPER_FOLDER' does not exist."
    exit 1
fi

# https://askubuntu.com/a/1073769/277761
PID=$(pgrep gnome-session | tail -n1)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

FILE_PATH=`ls $WALLPAPER_FOLDER | shuf -n 1`
FILE_URI="file://$WALLPAPER_FOLDER/$FILE_PATH"
/usr/bin/gsettings set org.gnome.desktop.background picture-uri $FILE_URI
