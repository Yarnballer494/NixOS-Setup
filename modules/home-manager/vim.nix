{ config, lib, pkgs, ... }:
 
let
    cfg = config.vim;
in
{
    options = {
        vim.enable = lib.mkEnableOption "Enable vim";
    };

    config = lib.mkIf cfg.enable {
        programs.vim = {
          enable = true;
          plugins = with pkgs.vimPlugins; [];
          extraConfig = ''
              set number
              set relativenumber
              set expandtab
              set shiftwidth=4
              set softtabstop=4
              set tabstop=4
              syntax on     
          '';
       };
    };
}
