{ config, lib, pkgs, ... }:

let
    cfg = config.hyprland;
in
{
    options = {
        hyprland.enable = lib.mkEnableOption "Enable hyprland";
    };  

    config = lib.mkIf cfg.enable {
        wayland.windowManager.hyprland = {
            enable = true;
            settings = {
                "$mod" = "SUPER";

                input = {
                    kb_layout = "de";
                    kb_options = "grp:win_space_toggle";
                };
                bind = [
                    # Main binds
                    "$mod, T, exec, kitty"
                    "$mod, C, killactive,"
                    "$mod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"             

                    # Applications
                    "$mod, 1, exec, rofi -show run"
                    "$mod, 2, exec, firefox"

                    # Move focus
                    "$mod, left, movefocus, l"
                    "$mod, right, movefocus, r"
                    "$mod, up, movefocus, u"
                    "$mod, down, movefocus, d"
                ];
            };
        };      
    }; 
}
