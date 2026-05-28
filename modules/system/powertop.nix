{ config, lib, pkgs, ... }:

let 
  cfg = config.powertop;
in
{
  options = {
    powertop.enable = lib.mkEnableOption "Enable powertop";
  };  

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.powertop
    ];
  };
}
