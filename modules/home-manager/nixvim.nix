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
      colorschemes.catppuccin.enable = true;
      plugins.lualine.enable = true;
    };   
  };
}
