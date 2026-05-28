{ config, lib, pkgs, hostname, ... }:

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
		    # Add monitor settings for different hosts
		    monitor = if "${hostname}" == "surface" 
		      then ",preferred,auto,1.6"
		      else ",preferred,auto,1.6"; # Change to else-if when adding more hosts 
      
        general = {
          border_size = 1;
          gaps_in = 2;
          gaps_out = 10;
        };
        
		    xwayland = {
		      force_zero_scaling = true;
		    };

        input = {
          kb_layout = "de";
          kb_options = "grp:win_space_toggle";
        };

	      layerrule = [
		      "blur, rofi"
		      "blur, waybar"
		    ];

		    decoration = {
		      rounding = "10";
		      active_opacity = "0.8";
		      inactive_opacity = "0.8";
		      blur = {
			      enabled = true;
			      size = "8";
			      passes = "2";
			      new_optimizations = true;
			      ignore_opacity = false;
		      };
          shadow = {
            enabled = true;
          };
		    };

        misc = {
          vfr = true;
        };
		
        bind = [
          # Main binds
          "SUPER, Return, exec, kitty"
          "SUPER, Q, killactive,"
          "SUPER, W, exec, rofi -show drun"
          "SUPER, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"             
          "SUPER, L, exec, hyprlock"

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

          # Bind for power save
          "SUPER, P, exec, ${pkgs.writeShellScript "hyprlandToggleEffects" ''
            STATUS=$(hyprctl getoption animations:enabled | awk 'NR==1 {print $2}')

            if [[ "$STATUS" = "1" ]] then
              hyprctl keyword animations:enabled 0
              hyprctl keyword decoration:blur:enabled 0
              hyprctl keyword decoration:shadow:enabled 0
            else
              hyprctl keyword animations:enabled 1
              hyprctl keyword decoration:blur:enabled 1
              hyprctl keyword decoration:shadow:enabled 1
            fi
          ''}"
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
