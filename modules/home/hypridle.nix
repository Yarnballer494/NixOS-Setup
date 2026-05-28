{ config, lib, pkgs, ... }:

let 
  cfg = config.hypridle;
in
{
  options = {
    hypridle.enable = lib.mkEnableOption "Enable hypridle";
  };  

  config = lib.mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "loginctl lock-session";
          lock_cmd = "pidof hyprlock || hyprlock";
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
        ];
      };
    };
  };
}
