{ config, lib, pkgs, ... }:

let 
  cfg = config.bluetooth;
in
{
  options = {
    bluetooth.enable = lib.mkEnableOption "Enable bluetooth";
  };  

  config = lib.mkIf cfg.enable {
    services.blueman.enable = true;

    hardware.bluetooth = {
      enable = true;
      settings = {
	General = {
	  Enable = "Source,Sink,Media,Socket";
	};
      };
    };
  };
}
