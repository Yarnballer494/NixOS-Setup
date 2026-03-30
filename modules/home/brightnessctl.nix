{ config, lib, pkgs, ... }:

let 
  cfg = config.brightnessctl;
in
{
  options = {
    brightnessctl.enable = lib.mkEnableOption "Enable brightnessctl";
  };  

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.brightnessctl
    ]; 
  };
}
