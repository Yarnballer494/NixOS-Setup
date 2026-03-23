{ config, lib, pkgs, ... }:

let
    cfg = config.git;
in
{
    options = {
        git.enable = lib.mkEnableOption "Enable git";
    };

    config = lib.mkIf cfg.enable {
        programs.git = {
            enable = true;
            lfs.enable = true;
            settings = {
                user = { 
                    name = "yarn";
                    email = "152090555+Yarnballer494@users.noreply.github.com";
                };
                init.defaultBranch = "main";
                safe.directory = "/etc/nixos";
            };
        };
    }; 
}
