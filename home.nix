{ config, pkgs, ... }:

{
	home.username = "yarn";
	home.homeDirectory = "/home/yarn";
	home.stateVersion = "25.11";
	programs.bash = {
		enable = true;
		shellAliases = {
			meow = "echo meoww";
		};
		profileExtra = ''
			if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
				exec hyprland
			fi
		'';
	};

	programs.git = {
		enable = true;
		userName = "yarn";
		userEmail = "flowercat@tuta.com";
		extraConfig = {
			init.defaultBranch = "main";
			safe.directory = "/etc/nixos";
		};
	};

	wayland.windowManager.hyprland = {
		enable = true;
		settings = {
			"$mod" = "SUPER";

			input = {
				kb_layout = "de";
				kb_options = "grp:win_space_toggle";
			}
			bind = [
				# Main binds
				"$mod, T, exec, kitty"
				"$mod, C, killactive,"
				"$mod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"

				# Move focus 
				"$mod, left, movefocus, l"
				"$mod, right, movefocus, r"
				"$mod, up, movefocus, u"
				"$mod, down, movefocus, d"
			];
			
		};
	};
}
