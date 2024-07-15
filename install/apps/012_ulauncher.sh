DESKTOP_CONFIG="$(cd "$(dirname $(dirname "${BASH_SOURCE[0]}"))" && pwd)/desktop/ulauncher.desktop"
echo $DESKTOP_CONFIG
yay -S ulauncher
cp $DESKTOP_CONFIG ~/.config/autostart/ulauncher.desktop
gtk-launch ulauncher.desktop >/dev/null 2>&1
