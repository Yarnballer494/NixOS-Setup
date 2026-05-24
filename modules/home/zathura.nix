{ config, lib, pkgs, ... }:

let 
  cfg = config.zathura;
in
{
  options = {
    zathura.enable = lib.mkEnableOption "Enable zathura";
  };  

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.zathura
    ];
  };
}
