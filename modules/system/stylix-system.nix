{ config, lib, pkgs, ... }:

let 
  cfg = config.stylix-system;
in
{
  options = {
    stylix-system.enable = lib.mkEnableOption "Enable stylix for system";
  };  

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      image = ../../wallpapers/snowflakes.jpg;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
      polarity = "dark";
    }; 
  };
}
