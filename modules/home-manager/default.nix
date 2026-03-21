# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
    
  # git = import ./git.nix;
  # hyprland = import ./hyprland.nix;
  # sh = import ./sh.nix;
  # vim = import ./vim.nix;

  imports = [
    ./git.nix
    ./hyprland.nix
    ./sh.nix
    ./vim.nix
    ./nixvim.nix
  ];
}
