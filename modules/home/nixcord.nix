{ inputs, config, lib, pkgs, ... }:

let 
  cfg = config.nixcord;
in
{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  options = {
    nixcord.enable = lib.mkEnableOption "Enable nixcord";
  };  

  config = lib.mkIf cfg.enable {
    programs.nixcord = {
      enable = true;
      discord.vencord.enable = true;

      # Theming
      quickCss = "/* css goes here */";
      config = {
	useQuickCss = true;
	themeLinks = [
	  # Link themes here
	];
	frameless = true;

	plugins = {
	  # Enable and configure plugins here
	};
      };
    };
  };
}
