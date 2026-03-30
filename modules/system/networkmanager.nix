{ config, lib, pkgs, ... }:

let 
  cfg = config.networkmanager;
in
{
  options = {
    networkmanager.enable = lib.mkEnableOption "Enable networkmanager";
  };  

  config = lib.mkIf cfg.enable {
    sops.secrets."wifi/olja/ssid" = {};
    sops.secrets."wifi/olja/psk" = {};  

    networking.networkmanager = {
      enable = true;
      ensureProfiles = {

        environmentFiles = [
          config.sops.secrets."wifi/olja/ssid".path
	  config.sops.secrets."wifi/olja/psk".path
        ];

	profiles = {
	  "olja" = {
	    connection = {
	      id = "olja";
	      type = "wifi";
	      autoconnect = true;
	    };
	    wifi = {
	      mode = "infrastructure";
	      ssid = "$OLJA_SSID";
	    };
	    wifi-security = {
	      key-mgmt = "wpa-psk";
	      psk = "$OLJA_PSK";
	    };
	    ipv4 = {
	      method = "auto";
	    };
	    ipv6 = {
	      method = "auto";
	      addr-gen-mode = "stable-privacy";
	    };
	  };
	};
      };
    };
  };
}
