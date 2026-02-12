{config, lib, pkgs, ... }:

{
  imports =
    [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  programs.ssh.startAgent = true;
  services.openssh.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;		
  };

  programs.firefox.enable = true;

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

  #Enable CUPS to print documents.
  services.printing.enable = true;

  #Enable sound.
  

  #Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  #Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yarn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  #List packages installed in system profile.
  #You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    kitty
    waybar
    hyprpaper
    rofi
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
    })
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono  
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";

  nix.gc.automatic = true;
  nix.gc.dates = "20:00";
  nix.gc.options = "--delete-older-than 2d";


  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos/flake.nix";
    flags = [
      "-L" # Print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };
}

