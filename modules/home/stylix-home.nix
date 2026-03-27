{ config, lib, pkgs, ... }:

let 
  cfg = config.stylix-home;
in
{
  options = {
    stylix-home.enable = lib.mkEnableOption "Enable stylix";
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
