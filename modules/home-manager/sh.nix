{ config, lib, pkgs, ... }:

let 
    cfg = config.sh;

    myAliases = {
        ll = "ls -l";
        ".." = "cd ..";
    };
in
{
    options = {
        sh.enable = lib.mkEnableOption "Enable shell";
    };

    config = lib.mkIf cfg.enable {
        programs.bash = {
            enable = true;
            shellAliases = myAliases;
            profileExtra = ''
                if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
                    exec hyprland
                fi
            '';
        };
    };
}
