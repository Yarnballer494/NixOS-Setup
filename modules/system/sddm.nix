{ config, lib, pkgs, ... }:

let 
  cfg = config.sddm;
in
{
  options = {
    sddm.enable = lib.mkEnableOption "Enable sddm";
  };  

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      theme = "sddm-astronaut-theme";
      extraPackages = with pkgs; [
	kdePackages.qtsvg
	kdePackages.qtvirtualkeyboard
	kdePackages.qtmultimedia
      ];
    };

    # https://www.reddit.com/r/NixOS/comments/1kcj34p/comment/mq6szsp/
    environment.systemPackages = with pkgs; [
      (sddm-astronaut.override {
	themeConfig = {
	  AspectRatio = "none";
	  ScreenPadding = "0";

          Font = config.stylix.fonts.sansSerif.name;
          FontSize = "12";

          RoundCorners = "20";

          BackgroundPlaceholder = "${config.stylix.image}";
	  Background = "${config.stylix.image}";
          # Background =
          #   if cfg.animatedBackground.enable
          #   then "${cfg.animatedBackground.path}"
          #   else "${config.stylix.image}";
          BackgroundSpeed = "1.0";
          PauseBackground = "";
	  CropBackground = "false";
          BackgroundHorizontalAlignment = "center";
          BackgroundVerticalAlignment = "center";
          DimBackground = "0.0";

	  # deleted section, figure out variables

          FullBlur = "true";
          BlurMax = "64";
          Blur = "1.0";

          HaveFormBackground = "false";
          FormPosition = "left";
	};
      })
    ];
  };
}
