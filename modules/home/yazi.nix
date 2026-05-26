{ config, lib, pkgs, ... }:

let 
  cfg = config.yazi;
in
{
  options = {
    yazi.enable = lib.mkEnableOption "Enable yazi";
  };  

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;

      settings = {
	      manager = {
	        sort_by = "natural";
	      };
      };
    };
  };
}
