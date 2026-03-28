{ config, lib, pkgs, ... }:

let 
  cfg = config.waybar;
in
{
  options = {
    waybar.enable = lib.mkEnableOption "Enable waybar";
  };  

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings.mainBar = {
        layer = "top";
	position = "top";
	height = 30;
	output = [
	  "eDP-1"
	];
	modules-left = [ "hyprland/workspaces" ];
	modules-center = [ "hyprland/window" ];
	modules-right = [ "network" "memory" "battery" "clock" "tray" ];
      };
    }; 
  };
}
