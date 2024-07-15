# Exit immediately if a command exits with a non-zero status
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Needed for all installers
sudo pacman -Sy
sudo pacman -S curl git unzip

# Run installers
for script in $DOTFILES_DIR/install/system/*.sh; do source $script; done
