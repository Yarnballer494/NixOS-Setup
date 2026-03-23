{ config, lib, pkgs, inputs, ... }:

let 
  cfg = config.nixvim;
in
{
  imports = [ inputs.nixvim.homeModules.nixvim ]; 

  options = {
    nixvim.enable = lib.mkEnableOption "Enable nixvim";
  };  

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      colorschemes.catppuccin.enable = true;
      plugins.lualine.enable = true;
      opts = {
        number = true;
	relativenumber = true;
	shiftwidth = 4;
      };
      keymaps = [
      # Trivial remaps but shows the syntax :)
	{
	  mode = ["n" "v"];
	  key = "<leader>y"; 
	  options.silent = true;
	  action = "\"+y";
	}
	{
	  mode = ["n" "v"];
	  key = "<leader>p";
	  options.silent = true;
	  action = "\"+p";
	}
      ];
    };   
  };
}
