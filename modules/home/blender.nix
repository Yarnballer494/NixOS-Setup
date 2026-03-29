{ config, lib, pkgs, ... }:

let 
  cfg = config.blender;
in
{
  options = {
    blender.enable = lib.mkEnableOption "Enable blender";
  };  

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.blender
    ];
  };
}
