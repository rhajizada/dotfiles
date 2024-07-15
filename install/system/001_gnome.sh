sudo pacman -S --needed wayland
sudo pacman -S --needed gdm
sudo pacman -S --needed xorg-xwayland xorg-xlsclients glfw-wayland
sudo pacman -S --needed gnome gnome-tweaks gnome-nettool gnome-usage gnome-multi-writer adwaita-icon-theme xdg-user-dirs-gtk fwupd arc-gtk-theme networkmanager
sudo systemctl enable gdm
sudo systemctl enable NetworkManager
