{ config, lib, pkgs, ... }:

let 
  cfg = config.godot;
in
{
  options = {
    godot.enable = lib.mkEnableOption "Enable godot";
  };  

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.godot_4
    ]; 
  };
}
