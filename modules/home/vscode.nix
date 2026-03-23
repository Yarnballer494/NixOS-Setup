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
      profiles.default.extensions = with pkgs.vscode-extensions; [
	visualstudiotoolsforunity.vstuc
	ms-dotnettools.csharp
	ms-dotnettools.csdevkit
      ];
    }; 
  };
}
