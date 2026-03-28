{ config, lib, pkgs, ... }:

let 
  cfg = config.rofi;

  # Use `mkLiteral` for string-like values that should show without
  # quotes, e.g.:
  # {
  #   foo = "abc"; =&gt; foo: "abc";
  #   bar = mkLiteral "abc"; =&gt; bar: abc;
  # };
  inherit (config.lib.formats.rasi) mkLiteral;

in
{
  options = {
    rofi.enable = lib.mkEnableOption "Enable rofi";
  };  

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;

      # https://github.com/adi1090x/rofi/blob/master/files/launchers/type-1/style-5.rasi
      # Adapted changes from stylix, original code is commented at the end of each line
      theme = {
        configuration = {
	  modi = "drun,run,filebrowser,window";
	  show-icons = true;
	  display-drun = "";
	  display-run = "";
	  display-filebrowser = "";
	  display-window = "";
	  drun-display-format = "{name}";
	  window-format = "{w} · {c} · {t}";
	};

	# @import = "shared/colors.rasi";
	# @import = "shared/fonts.rasi";

	"*" = {
	  lightbg = mkLiteral "rgba ( 59, 66, 82, 30 % )"; 
	  lightfg = mkLiteral "rgba ( 236, 239, 244, 60 % )"; 
	  red = mkLiteral "rgba ( 191, 97, 106, 60 % )";
	  blue = mkLiteral "rgba ( 129, 161, 193, 60 % )"; 
	  # Font from the same repo
	  font = "JetBrains Mono Nerd Font 10";
	  # Nord colors from the same repo
	  background = mkLiteral "rgba ( 46, 52, 64, 30 % )"; # #2E3440FF
	  background-alt = mkLiteral "rgba ( 56, 62, 74, 30 % )"; # #383E4AFF
	  foreground = mkLiteral "rgba ( 229, 233, 240, 60 % )"; # #E5E9F0FF
	  selected = mkLiteral "rgba ( 129, 161, 193, 60 % )"; # #81A1C1FF
	  active = mkLiteral "rgba ( 163, 190, 140, 60 % )"; # #A3BE8CFF
	  urgent = mkLiteral "rgba ( 191, 97, 106, 60% )"; # #BF616AFF

	  border-color = mkLiteral "@foreground"; # "var(selected)";
	  handle-color = mkLiteral "var(selected)";
	  background-color = mkLiteral "var(background)";
	  foreground-color = mkLiteral "var(foreground)";
	  alternate-background = mkLiteral "var(background-alt)";
	  normal-background = mkLiteral "@background"; # "var(background)";
	  normal-foreground = mkLiteral "@foreground"; # "var(foreground)";
	  urgent-background = mkLiteral "@background"; # "var(urgent)";
	  urgent-foreground = mkLiteral "@red"; # "var(background)";
	  active-background = mkLiteral "@background"; # "var(active)";
	  active-foreground = mkLiteral "@blue"; # "var(background)";
	  selected-normal-background = mkLiteral "@lightfg"; # "var(background)";
	  selected-normal-foreground = mkLiteral "@lightbg"; # "var(foreground)";
	  selected-urgent-background = mkLiteral "@red"; # "var(urgent)";
	  selected-urgent-foreground = mkLiteral "@background"; # "var(background)";
	  selected-active-background = mkLiteral "@blue"; # "var(active)";
	  selected-active-foreground = mkLiteral "@background"; # "var(background)";
	  alternate-normal-background = mkLiteral "@lightbg"; # "var(background)";
	  alternate-normal-foreground = mkLiteral "@foreground"; # "var(foreground)";
	  alternate-urgent-background = mkLiteral "@lightbg"; # "var(urgent)";
	  alternate-urgent-foreground = mkLiteral "@red"; # "var(background)";
	  alternate-active-background = mkLiteral "@lightbg"; # "var(active)";
	  alternate-active-foreground = mkLiteral "@blue"; # "var(background)";
        };

	"#window" = {
	  transparency = "real";
	  location = mkLiteral "center";
	  achor = mkLiteral "center";
	  fullscreen = mkLiteral "false";
	  width = mkLiteral "600px";
	  x-offset = mkLiteral "0px";
	  y-offset = mkLiteral "0px";

	  # properties for all widgets
	  enabled = true;
	  margin = mkLiteral "0px";
	  padding = mkLiteral "0px";
	  border = mkLiteral "0px solid";
	  border-radius = mkLiteral "10px";
	  border-color = mkLiteral "@border-color";
	  cursor = "default";

	  # background colors
	  background-color = "@background-colour";
	  # background image
	  # background-image = mkLiteral "url("/path/to/image.png", none)";
	  # simple linear gradient
	  # background-image = mkLiteral "linear-gradient(red, orange, pink, purple)";
	  # directional linear gradient
	  # background-image = mkLiteral "linear-gradient(to bottom, pink, yellow, magenta)";
	  # angle linear gradient
	  # background-image = mkLiteral "linear-gradient(45, cyan, purple, indigo)";
	};

	"#mainbox" = {
	  enabled = true;
	  spacing = mkLiteral "10px";
	  margin = mkLiteral "0px";
	  padding = mkLiteral "30px";
	  border = mkLiteral "0px solid";
	  border-radius = mkLiteral "0px 0px 0px 0px";
	  border-color = mkLiteral "@border-color";
	  background-color = mkLiteral "@background-color";
	  children = map mkLiteral [ "inputbar" "message" "listview" ];
 
	};

        "#inputbar" = {
	  enabled = true;
	  spacing = mkLiteral "10px";
	  margin = mkLiteral "0px";
	  padding = mkLiteral "0px";
	  border = mkLiteral "0px solid";
	  border-radius = mkLiteral "0px";
	  border-color = mkLiteral "@border-color";
	  background-color = mkLiteral "transparent";
	  text-color = mkLiteral "@foreground-color";
	  children = map mkLiteral [ "textbox-prompt-colon" "entry" "mode-switcher" ];
	};

	"#prompt" = {
	  enabled = true;
	  background-color = mkLiteral "inherit";
	  text-color = mkLiteral "inherit";
	};

	"#textbox-prompt-colon" = {
	  enabled = true;
	  padding = mkLiteral "5px 0px";
	  expand = false;
	  str = "";
	  background-color = mkLiteral "inherit";
	  text-color = mkLiteral "inherit";
	};

	"#entry" = {
	  enabled = true;
	  padding = mkLiteral "5px 0px";
	  background-color = mkLiteral "inherit";
	  text-color = mkLiteral "inherit";
	  cursor = mkLiteral "text";
	  placeholder = "Search...";
	  placeholder-color = mkLiteral "inherit";
	};

	"#num-filtered-rows" = {
	  enabled = true;
	  expand = false;
	  background-color = mkLiteral "inherit";
	  text-color = mkLiteral "inherit";
	};

	"#textbox-num-sep" = {
	  enabled = true;
	  expand = false;
	  str = "/";
	  background-color = mkLiteral "inherit";
	  text-color = mkLiteral "inherit";
	};

	"#num-rows" = {
	  enabled = true;
	  expand = false;
	  background-color = mkLiteral "inherit";
	  text-color = mkLiteral "inherit";
	};

	"#case-indicator" = {
	  enabled = true;
	  background-color = mkLiteral "inherit";
	  text-color = mkLiteral "inherit";
	};

	"#listview" = {
	  enabled = true;
	  columns = mkLiteral "1";
	  lines = mkLiteral "8";
	  cycle = true;
	  dynamic = true;
	  scrollbar = true;
	  layout = mkLiteral "vertical";
	  reverse = false;
	  fixed-height = true;
	  fixed-columns = true;

	  spacing = mkLiteral "5px";
	  margin = mkLiteral "0px";
	  padding = mkLiteral "0px";
	  border = mkLiteral "0px solid";
	  border-radius = mkLiteral "0px";
	  border-color = mkLiteral "@border-color";
	  background-color = mkLiteral "transparent";
	  text-color = "@foreground-color";
	  cursor = "default";
	};

	"#scrollbar" = {
	  handle-width = mkLiteral "5px";
	  handle-color = mkLiteral "@handle-color";
	  border-radius = mkLiteral "10px";
	  background-color = mkLiteral "@alternate-background";
	};

	"#element" = {
	  enabled = true;
	  spacing = mkLiteral "10px";
	  margin = mkLiteral "0px";
	  padding = mkLiteral "5px 10px";
	  border = mkLiteral "0px solid";
	  border-radius = mkLiteral "10px";
	  border-color = mkLiteral "@border-color";
	  background-color = mkLiteral "transparent";
	  text-color = mkLiteral "@foreground-color";
	  cursor = mkLiteral "pointer";
	};

	"#element normal.normal" = {
	  background-color = mkLiteral "var(normal-background)";
	  text-color = mkLiteral "var(normal-foreground)";
	};
	"#element normal.urgent" = {
	  background-color = mkLiteral "var(urgent-background)";
	  text-color = mkLiteral "var(urgent-foreground)";
	};
	"#element normal.active" = {
	  background-color = mkLiteral "var(active-background)";
	  text-color = mkLiteral "var(active-foreground)";
	};
	"#element selected.normal" = {
	  background-color = mkLiteral "var(selected-normal-background)";
	  text-color = mkLiteral "var(selected-normal-foreground)";
	};
	"#element selected.urgent" = {
	  background-color = mkLiteral "var(selected-urgent-background)";
	  text-color = mkLiteral "var(selected-urgent-foreground)";
	};
	"#element selected.active" = {
	  background-color = mkLiteral "var(selected-active-background)";
	  text-color = mkLiteral "var(selected-active-foreground)";
	};
	"#element alternate.normal" = {
	  background-color = mkLiteral "var(alternate-normal-background)";
	  text-color = mkLiteral "var(alternate-normal-foreground)";
	};
	"#element alternate.urgent" = {
	  background-color = mkLiteral "var(alternate-urgent-background)"; 
	  text-color = mkLiteral "var(alternate-urgent-foreground)";
	};
	"#element alternate.active" = {
	  background-color = mkLiteral "var(alternate-active-background)";
	  text-color = mkLiteral "var(alternate-active-foreground)";
	};
	
	"#element-icon" = {
	  background-color = mkLiteral "transparent";
	  text-color = mkLiteral "inherit";
	  size = mkLiteral "24px";
	  cursor = mkLiteral "inherit";
	};

	"#element-text" = {
	  background-color = mkLiteral "transparent";
	  text-color = mkLiteral "inherit";
	  highlight = mkLiteral "inherit";
	  cursor = mkLiteral "inherit";
	  vertical-align = mkLiteral "0.5";
	  horizontal-align = mkLiteral "0.0";
	};

	"#mode-switcher" = {
	  enabled = true;
	  spacing = mkLiteral "10px";
	  margin = mkLiteral "0px";
	  padding = mkLiteral "0px";
	  border = mkLiteral "0px solid";
	  border-radius = mkLiteral "0px";
	  border-color = mkLiteral "@border-color";
	  background-color = mkLiteral "transparent";
	  text-color = mkLiteral "@foreground-color";
	};

	"#button" = {
	  padding = mkLiteral "5px 10px";
	  border = mkLiteral "0px solid";
	  border-radius = mkLiteral "10px";
	  border-color = mkLiteral "@border-color";
	  background-color = mkLiteral "@alternate-background";
	  text-color = mkLiteral "inherit";
	  cursor = mkLiteral "pointer";
	};

	"#button selected" = {
	  background-color = mkLiteral "@selected-normal-background";
	  text-color = mkLiteral "@selected-normal-foreground";
	};
	
	"#message" = {
	  enabled = true;
	  margin = mkLiteral "0px";
	  padding = mkLiteral "0px";
	  border = mkLiteral "0px solid";
	  border-radius = mkLiteral "0px 0px 0px 0px";
	  border-color = mkLiteral "@border-color";
	  background-color = mkLiteral "transparent";
	  text-color = mkLiteral "@foreground-color";
	};

	"#textbox" = {
	  padding = mkLiteral "8px 10px";
	  border = mkLiteral "0px solid";
	  border-radius = mkLiteral "10px";
	  border-color = mkLiteral "@border-color";
	  background-color = mkLiteral "@alternate-background";
	  text-color = mkLiteral "@foreground-color";
	  vertical-align = mkLiteral "0.5";
	  horizontal-align = mkLiteral "0.0";
	  highlight = mkLiteral "none";
	  placeholder-color = mkLiteral "@foreground-color";
	  blink = true;
	  markup = true;
	};

	"#error-message" = {
	  padding = mkLiteral "10px";
	  border = mkLiteral "2px solid";
	  border-radius = mkLiteral "10px";
	  border-color = mkLiteral "@border-color";
	  background-color = mkLiteral "@background-color";
	  text-color = mkLiteral "@foreground-color";
	};
      };
    }; 
  }; }
