{ config, pkgs, ... }:

let 
    myAliases = {
        ll = "ls -l";
        ".." = "cd ..";
    };

in
{
    programs.bash = {
        enable = true;
        shellAliases = myAliases;
        profileExtra = ''
            if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
                exec hyprland
            fi
        '';
    };
}
