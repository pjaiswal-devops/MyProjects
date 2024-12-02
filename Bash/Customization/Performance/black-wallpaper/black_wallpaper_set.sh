#!/bin/bash

WALLPAPER_URL="https://via.placeholder.com/1x1/000000/000000.png"

WALLPAPER_PATH="$HOME/black_wallpaper.png"

echo "Downloading solid black wallpaper..."
wget -O "$WALLPAPER_PATH" "$WALLPAPER_URL"

if [ $? -ne 0 ]; then
    echo "Failed to download the wallpaper. Please check your internet connection or the URL."
    exit 1
fi

echo "Setting the solid black wallpaper as the desktop background..."
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_PATH"
gsettings set org.gnome.desktop.background picture-options "zoom"

if [ $? -eq 0 ]; then
    echo "Wallpaper successfully set to solid black."
else
    echo "Failed to set the wallpaper. Please check if 'gsettings' is installed and configured correctly."
    exit 1
fi