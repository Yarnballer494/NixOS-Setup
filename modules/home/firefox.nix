{ config, lib, pkgs, ... }:

let 
  cfg = config.firefox;
in
{
  options = {
    firefox.enable = lib.mkEnableOption "Enable firefox";
  };  

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      languagePacks = [ "en-US" ];
      
      policies = {
	DisablePocket = true;
	HardwareAcceleration = true;
      };

      profiles = {
	default = {
	  id = 0;
	  name = "default";
	  isDefault = true;
	  search = {
	    default = "google";
	    force = true;
	  };
	};

	yarn = {
	  id = 1;
	  name = "yarn";
	  isDefault = false;
	  search = {
	    default = "ddg";
	    force = true;
	  };
	};
      };
    };
  };
}
