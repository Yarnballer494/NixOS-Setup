{ inputs, pkgs, config, lib, ... }:

let 
    cfg = config.systemSettings.hyprland;
in
{
    options = { 
        systemSettings.hyprland = {
            enable = lib.mkEnableOption "Enable hyprland";
        };
    };

    config = lib.mkIf cfg.enable {
        # configuration here
    };  
}
