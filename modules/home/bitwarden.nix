{ config, lib, pkgs, ... }:

let 
  cfg = config.bitwarden;
in
{
  options = {
    bitwarden.enable = lib.mkEnableOption "Enable bitwarden";
  };  

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.bitwarden-desktop
    ]; 
  };
}
