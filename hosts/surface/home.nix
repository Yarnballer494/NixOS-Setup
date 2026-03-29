# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  flake-inputs,
  ...
}: 

let
  rider = pkgs.jetbrains.rider.overrideAttrs (attrs: {
    postInstall = ''
      # Wrap rider with extra tools and libraries
      mv $out/bin/rider $out/bin/.rider-toolless
      makeWrapper $out/bin/.rider-toolless $out/bin/rider \
        --argv0 rider \
        --prefix PATH : "${lib.makeBinPath extra-path}" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath extra-lib}"
  
      # Making unity rider plugin work
      # The plugin expects the binary to be at /rider/bin/rider, with bundled files at /rider/
      # It does this by going up two directories from the binary path
      # Our rider binary is at $out/bin/rider, so we need to link $out/rider/ to $out/
      shopt -s extglob
      ln -s $out/rider/!(bin) $out/
      shopt -u extglob
      '' + attrs.postInstall or "";
  }); 

  extra-path = with pkgs; [
      # Add any extra binaries you want accessible to rider
  ];

  extra-lib = with pkgs; [
    # Add any extra libraries you want accessible to rider
  ];

in
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # inputs.self.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

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

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # TODO: Set your username
  home = {
    username = "yarn";
    homeDirectory = "/home/yarn";
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
  
  # Toggle imported modules
  git.enable = true;
  hyprland.enable = true;
  sh.enable = true;
  vim.enable = true;
  nixvim.enable = true;
  waybar.enable = true;
  stylix-home.enable = true;
  kitty.enable = true;
  firefox.enable = true;
  rofi.enable = true;
  blender.enable = true;

  # Turn this into its own module
  home.packages = with pkgs; [
    (flake-inputs.nix-jetbrains-plugins.lib.buildIdeWithPlugins pkgs "rider" [
      # Add plugins here (potentially need more setup, check repo of nix-jetbrains-plugins)
    ])
    # mono
    dotnet-sdk_9
    dotnet-runtime_9
  ];

  home.file = {
    ".local/share/applications/jetbrains-rider.desktop".source =
      let
        desktopFile = pkgs.makeDesktopItem {
          name = "jetbrains-rider";
          desktopName = "Rider";
          exec = "\"${rider}/bin/rider\"";
          icon = "rider";
          type = "Application";
          # Don't show desktop icon in search or run launcher
          extraConfig.NoDisplay = "true";
        };
      in
      "${desktopFile}/share/applications/jetbrains-rider.desktop";
  };
}
