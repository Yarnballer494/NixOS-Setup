{ config, lib, pkgs, ... }:

let 
  cfg = config.unityhub;
in
{
  options = {
    unityhub.enable = lib.mkEnableOption "Enable unityhub";
  };  

  config = lib.mkIf cfg.enable {
    home.packages = [
      # pkgs.unityhub
      (pkgs.unityhub.override {
        extraPkgs = fhsPkgs: [
          # Extra unity libraries/packages here
        ];
      })
    ]; 
  };
}
