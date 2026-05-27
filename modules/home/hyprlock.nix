{ config, lib, pkgs, ... }:

let 
  cfg = config.hyprlock;
in
{
  options = {
    hyprlock.enable = lib.mkEnableOption "Enable hyprlock";
  };  

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.hyprlock
    ];
  };
}
