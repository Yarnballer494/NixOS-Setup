# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # inputs.self.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
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

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;   

  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    
    # Self added auto gc
    gc = {
      automatic = true;
      dates = "20:00";
      options = "--delete-older-than 2d";
    };

    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # FIXME: Add the rest of your current configuration

  # TODO: Set your hostname
  networking.hostName = "surface";

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    yarn = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel"];
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";

  # Stuff copied from old config
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  programs.ssh.startAgent = true;
  
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha-mauve";
    wayland = {
      enable = true;
    };
  };

  services.xserver = {
    xkb.layout = "de";
  };

  services.getty.autologinUser = "yarn";

  environment.systemPackages = with pkgs; [
    age # For nix sops
    sops # For nix sops
    wget
    git
    kitty

    rofi
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
    })
    godot_4
    bitwarden-desktop
    brightnessctl
    unityhub
    (pkgs.unityhub.override {
      extraPkgs = fhsPkgs: [
        # Extra unity libraries/packages here
      ];
    })
    (discord.override {
      withVencord = true;
    })
  ];

  
  
  # Auto system upgrade
  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos/flake.nix";
    flags = [
      "-L" # Print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  # Enable touchpad support
  services.libinput.enable = true;

  programs.waybar.enable = true;

  # Sops imported from flake
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/user/.config/sops/age/keys.txt";

  # Font packages need their own options list, read wiki fonts
  fonts.packages = with pkgs; [
    font-awesome_4
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };  
} 
