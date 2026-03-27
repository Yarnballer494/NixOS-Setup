{ config, lib, pkgs, ... }:

let 
  cfg = config.kitty;
in
{
  options = {
    kitty.enable = lib.mkEnableOption "Enable kitty";
  };  

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      settings = {
	# add settings here
      };
    };
  };
}
