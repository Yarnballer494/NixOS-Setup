{ config, lib, pkgs, ... }:

let 
  cfg = config.btop;
in
{
  options = {
    btop.enable = lib.mkEnableOption "Enable btop";
  };  

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.btop
    ]; 
  };
}
