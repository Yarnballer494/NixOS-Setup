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
    sops.secrets."wifi/stud/ssid" = {};
    sops.secrets."wifi/stud/psk" = {};
    sops.secrets."wifi/unic/ssid" = {};
    sops.secrets."wifi/unic/psk" = {};
    sops.secrets."wifi/home/ssid" = {};
    sops.secrets."wifi/home/psk" = {};

    networking.networkmanager = {
      enable = true;
      ensureProfiles = {

        environmentFiles = [
          config.sops.secrets."wifi/olja/ssid".path
      	  config.sops.secrets."wifi/olja/psk".path
	        config.sops.secrets."wifi/stud/ssid".path
	        config.sops.secrets."wifi/stud/psk".path
          config.sops.secrets."wifi/unic/ssid".path
          config.sops.secrets."wifi/unic/psk".path
          config.sops.secrets."wifi/home/ssid".path
          config.sops.secrets."wifi/home/psk".path
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
	        "stud" = {
	          connection = {
	            id = "stud";
	            type = "wifi";
	            autoconnect = true;
	          };
	          wifi = {
	            mode = "infrastructure";
	            ssid = "$STUD_SSID";
	          };
	          wifi-security = {
	            key-mgmt = "wpa-psk";
	            psk = "$STUD_PSK";
	          };
	          ipv4 = {
	            method = "auto";
	          };
	          ipv6 = {
	            method = "auto";
	            addr-gen-mode = "stable-privacy";
	          };
	        };
          "unic" = {
            connection = {
              id = "unic";
              type = "wifi";
              autoconnect = true;
            };
            wifi = {
              mode = "infrastructure";
              ssid = "$UNIC_SSID";
            };
            wifi-security = {
              key-mgmt = "wpa-psk";
              psk = "$UNIC_PSK";
            };
            ipv4 = {
              method = "auto";
            };
            ipv6 = {
             method = "auto";
             addr-gen-mode = "stable-privacy";
            };
          };
          "home" = {
            connection = {
              id = "home";
              type = "wifi";
              autoconnect = true;
            };
            wifi = {
              mode = "infrastructure";
              ssid = "$HOME_SSID";
            };
            wifi-security = {
              key-mgmt = "wpa-psk";
              psk = "$HOME_PSK";
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
