{ config, lib, pkgs, ... }:

let 
  cfg = config.obsidian;
in
{
  options = {
    obsidian.enable = lib.mkEnableOption "Enable obsidian";
  };  

  config = lib.mkIf cfg.enable {
    programs.obsidian = {
      enable = true;
    }; 
  };
}
