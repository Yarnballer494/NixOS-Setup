{ config, pkgs, ... }:

{
    imports = [
        ./modules/user/sh.nix
        ./modules/user/hyprland.nix
        ./modules/user/git.nix
    ];

    home.username = "yarn";
    home.homeDirectory = "/home/yarn";
    home.stateVersion = "25.11";
}
