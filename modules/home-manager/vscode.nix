{ config, lib, pkgs, ... }:

let 
  cfg = config.vscode;
in
{
  options = {
    vscode.enable = lib.mkEnableOption "Enable vscode";
  };  

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
	
      ];
    }; 
  };
}
