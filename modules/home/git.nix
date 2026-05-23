{ config, lib, pkgs, username, ... }:

let
  cfg = config.git;
in
{
  options = with lib; {
    git.enable = lib.mkEnableOption "Enable git";
    git.name = mkOption {
      type = types.str;
      description = "Git username of the home manager user";
    };
    git.email = mkOption {
      type = types.str;
      description = "Git email of the home manager user";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = { 
	  name = "${config.git.name}";
          email = "${config.git.email}";
        };
      init.defaultBranch = "main";
      safe.directory = "/home/${username}/nixos";
      };
    };
  }; 
}
