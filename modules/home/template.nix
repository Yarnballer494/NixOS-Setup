{ config, lib, pkgs, ... }:

let 
  cfg = config.template;
in
{
  options = {
    template.enable = lib.mkEnableOption "Enable template";
  };  

  config = lib.mkIf cfg.enable {
  
  };
}
