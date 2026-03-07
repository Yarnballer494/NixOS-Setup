{ config, pkgsm, ... }:

{
    programs.vim = {
        enable = true;
        plugins = with pkgs.vimPlugins; [ indent ];
        extraConfig = '' 
            set number
            set relativenumber
            set expandtab
            set shiftwidth = 4
            set softtabstop = 4
            set tabstop = 4
            set smartindent
            syntax on
        '';
    };
}
