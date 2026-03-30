# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.

{ lib, ... }: {
  # Import all nix files in this dir
  # Except default.nix, because of infinite recursion
  imports = lib.fileset.toList (
    lib.fileset.fileFilter (
      file: file.hasExt "nix" && file.name != "default.nix"
    ) ./.
  );
}
