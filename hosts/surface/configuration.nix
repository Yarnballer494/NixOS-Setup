# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  hostname,
  ...
}:

{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # inputs.self.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    ../../modules/system/default.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  options = {
    # Define custom options here
  };

  config = {
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
  
    networking.hostName = "${hostname}";
  
    # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
    users.users = {
      # TODO: Add your username
      yarn = {
        isNormalUser = true;
        # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
        extraGroups = ["wheel"];
      };
    };
  
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "25.11";
  
    # Stuff copied from old config
    boot.loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };
    };
  
    time.timeZone = "Europe/Berlin";
  
    programs.ssh.startAgent = true;
    
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  
    services.xserver = {
      xkb.layout = "de";
    };
  
    environment.systemPackages = with pkgs; [
      age # For nix sops
      sops # For nix sops
      wget
      git
      kitty

      # Custom pkgs, might move into own modules
      newmodule
    ];
    
    # Auto system upgrade
    system.autoUpgrade = {
      enable = true;
      flake = "../../flake.nix";
      flags = [
        "-L" # Print build logs
      ];
      dates = "02:00";
      randomizedDelaySec = "45min";
    };
  
    # Enable touchpad support
    services.libinput.enable = true;

    # Enable audio server
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    }; 
  
    # Sops imported from flake
    sops.defaultSopsFile = ./secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";
    sops.age.keyFile = "/home/yarn/.config/sops/age/keys.txt";
  
    # Font packages need their own options list, read wiki fonts
    fonts.packages = with pkgs; [
      font-awesome_4
    ];
  
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };  
  
    bluetooth.enable = true;
    sddm.enable = true;
    stylix-system.enable = true;
    networkmanager.enable = true;
  };
} 
