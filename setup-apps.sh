# Exit immediately if a command exits with a non-zero status
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run installers
for script in $DOTFILES_DIR/install/apps/*.sh; do source $script; done