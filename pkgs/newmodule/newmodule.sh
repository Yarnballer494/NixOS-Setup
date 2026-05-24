set -euo pipefail

# Check if the script is being run as sudo
if [[ $EUID -ne 0 ]]; then
    echo "Error: This command requires sudo privileges."
    echo "Please run it with sudo: sudo newmodule filename /path/to/dir"
    exit 1
fi

# Enforce two parameters
if [[ $# -ne 1 ]]; then
    echo "Error: The script requires exactly 1 parameter with no spaces."
    echo "Usage: sudo newmodule <optional_path_and_filename>"
    exit 1
fi

# Prevent trailing slashes
if [[ $1 == */ ]] then
    echo "Error: Target path cannot end with a slash. Please specify a filename."
    exit 1
fi

TARGET_FILE=$(realpath -m "$1")

TARGET_DIR=$(dirname "$TARGET_FILE")
FILENAME=$(basename "$TARGET_FILE")

# Enforce filename ending with .nix
if [[ $FILENAME != *.nix ]]; then
    echo "Error: Invalid file type. The filename must end with '.nix'."
    echo "Example: sudo newmodule configuration.nix"
    exit 1
fi

DOT_COUNT=$(echo "$FILENAME" | tr -cd '.' | wc -c)

# Handle hidden vs visible files
if [[ $FILENAME == .* ]]; then
    if [[ $DOT_COUNT -ne 2 ]]; then
	echo "Error: Hidden files must have exactly one extension."
	echo "Example: sudo newmodule .file.nix"
	exit 1
    fi
else
    if [[ $DOT_COUNT -ne 1 ]]; then
	echo "Error: Visible files must have exactly one extension."
	echo "Example: sudo newmodule file.nix"
	exit 1
    fi
fi

# Check if target dir exists
if [[ ! -d $TARGET_DIR ]]; then
    echo "Error: The directory '$TARGET_DIR' does not exist."
    exit 1
fi

# Check if the file already exists 
if [[ -e $TARGET_FILE ]]; then
    echo "Error: The file '$TARGET_FILE' already exists."
    exit 1
fi

# Identify the regular user who called sudo
REAL_USER="${SUDO_USER:-$USER}"
REAL_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)

# Strip leading dot of hidden filenames and .nix ext before injection
INJECTED_NAME=$(basename "${FILENAME#.}" .nix)

# Layout template using the filename parameter
cat << EOF >> "$TARGET_FILE"
{ config, lib, pkgs, ... }:

let 
  cfg = config.$INJECTED_NAME;
in
{
  options = {
    $INJECTED_NAME.enable = lib.mkEnableOption "Enable $INJECTED_NAME";
  };  

  config = lib.mkIf cfg.enable {
    # Add module code here 
  };
}
EOF

# Change file ownership back to the regular user
chown "$REAL_USER": "$TARGET_FILE"

# Open nvim as user
sudo -i -u "$REAL_USER" HOME="$REAL_HOME" nvim +12 "$TARGET_FILE"
