{ config, lib, pkgs, ... }:

let 
  cfg = config.powersave;
in
{
  options = {
    powersave.enable = lib.mkEnableOption "Enable powersave";
  };  

  config = lib.mkIf cfg.enable {
    # Don't use services.tlp.enable = true
    # It interferes with Surface drivers
    boot.kernelParams = [ "mem_sleep_default=deep" "amd_pstate=active" ];
    services.power-profiles-daemon.enable = true;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.udev.extraRules = ''
      SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
      SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"
    '';
  };
}
