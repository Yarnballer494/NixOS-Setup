# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: 

let
  # FIXME: Set your username
  username = "yarn";

in
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # inputs.self.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    inputs.sops-nix.homeManagerModules.sops

    # You can also split up your configuration and import pieces of it here:
    ../../modules/home/default.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
  
  # Sops imported from flake
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    
  # Toggle imported modules
  git.enable = true;
  hyprland.enable = true;
  sh.enable = true;
  vim.enable = false;
  nixvim.enable = true;
  waybar.enable = true;
  stylix-home.enable = true;
  kitty.enable = true;
  firefox.enable = true;
  rofi.enable = true;
  blender.enable = true;
  obsidian.enable = true;
  godot.enable = true;
  bitwarden.enable = true;
  brightnessctl.enable = true;
  unityhub.enable = true;
  rider.enable = true;
  nixcord.enable = true;
  yazi.enable = true;
  btop.enable = true;
  zathura.enable = true;
  direnv.enable = true;
  hyprlock.enable = true;
  hypridle.enable = true;

  # Set mandatory imported options
  git.name = "${username}";
  git.email = "152090555+Yarnballer494@users.noreply.github.com";
}
