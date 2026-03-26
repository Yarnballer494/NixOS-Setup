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
		monitor = ",preferred,auto,1.6";
		device = {
		    # Disabling touchpad because it keeps holding down left click
		    name = "microsoft-surface-045e:09af-touchpad";
		    enabled = false;
		};
		xwayland = {
		    force_zero_scaling = true;
		};
                input = {
                    kb_layout = "de";
                    kb_options = "grp:win_space_toggle";
                };
                bind = [
                    # Main binds
                    "SUPER, Q, exec, kitty"
                    "SUPER, W, exec, rofi -show run"
                    "SUPER, E, exec, firefox"
                    "SUPER, C, killactive,"
                    "SUPER, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"             

                    # Workspaces
                    "SUPER, 1, focusworkspaceoncurrentmonitor, 1"
                    "SUPER, 2, focusworkspaceoncurrentmonitor, 2"
                    "SUPER, 3, focusworkspaceoncurrentmonitor, 3"
                    "SUPER, 4, focusworkspaceoncurrentmonitor, 4"
                    "SUPER, 5, focusworkspaceoncurrentmonitor, 5"
                    "SUPER, 6, focusworkspaceoncurrentmonitor, 6"
                    "SUPER, 7, focusworkspaceoncurrentmonitor, 7"
                    "SUPER, 8, focusworkspaceoncurrentmonitor, 8"
                    "SUPER, 9, focusworkspaceoncurrentmonitor, 9"
                    "SUPERSHIFT, 1, movetoworkspace, 1"
                    "SUPERSHIFT, 2, movetoworkspace, 2"
                    "SUPERSHIFT, 3, movetoworkspace, 3"
                    "SUPERSHIFT, 4, movetoworkspace, 4"
                    "SUPERSHIFT, 5, movetoworkspace, 5"
                    "SUPERSHIFT, 6, movetoworkspace, 6"
                    "SUPERSHIFT, 7, movetoworkspace, 7"
                    "SUPERSHIFT, 8, movetoworkspace, 8"
                    "SUPERSHIFT, 9, movetoworkspace, 9"

                    # Move focus
                    "SUPER, left, movefocus, l"
                    "SUPER, right, movefocus, r"
                    "SUPER, up, movefocus, u"
                    "SUPER, down, movefocus, d"
                ];
		binde = [
		    ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
		    ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
		    ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
		    ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
		    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
		];
            };
        };      
    }; 
}
