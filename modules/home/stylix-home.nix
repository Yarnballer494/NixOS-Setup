{ config, lib, pkgs, ... }:

let 
  cfg = config.stylix-home;
in
{
  options = {
    stylix-home.enable = lib.mkEnableOption "Enable stylix for home";
  };  

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      image = ../../wallpapers/snowflakes.jpg;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
      polarity = "dark";

      # opacity.applications = 1.0;
      # opacity.desktop = 1.0;
      # opacity.popups = 1.0;
      # opacity.terminal = 1.0;
      
      targets = {
	firefox = {
	  profileNames = [
	    "default"
	    "yarn"
	  ];
	};
	# Can't make these transparent if stylix is overwriting values
	rofi.enable = false;
	waybar.enable = false;
      };
    }; 
  };
}
