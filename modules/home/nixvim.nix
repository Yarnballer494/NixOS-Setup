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
      viAlias = true;
      vimAlias = true;

      opts = {
        number = true;
	      relativenumber = true;
	      shiftwidth = 2;
	      tabstop = 2;
	      expandtab = true;
      };

      plugins = {
	      telescope.enable = true;
	      web-devicons.enable = true;
        neo-tree.enable = true;
	      treesitter.enable = true;
        luasnip.enable = true;
        friendly-snippets.enable = true;
        comment.enable = true;

	      lsp = {
	        enable = true;
	        servers = {
	          nil_ls.enable = true;
	          ts_ls.enable = true;
	        };
	      };

        cmp = {
          enable = true;
          settings.sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; keywordLength = 3; }
            { name = "path"; keywordLength = 1; }
          ];
        };
      };

      extraConfigLua = ''
	      vim.opt.exrc = true;
      '';
    };   
  };
}
