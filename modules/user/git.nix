{ config, pkgs, ... }:

{
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
}
