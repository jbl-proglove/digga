{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    # vimDiffAlias = true;

    withPython3 = true;

    # extraPython3Packages = (ps: with ps: [ python-language-server ]);

    extraConfig = ''
      set nocompatible
      set backspace=indent,eol,start
      set cursorcolumn
      set cursorline
      set autoindent
      set expandtab
      set lcs=tab:>-,eol:$
      set number
      set ruler
      set shiftwidth=2
      set smartcase
      set tabstop=2
      set textwidth=72
      syntax on

      " colors
      colorscheme nord

      " set correct yaml indentation (https://www.arthurkoziel.com/setting-up-vim-for-yaml/)
      autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

      " let g:indentLine_char = '⦙'
    '';

    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-lastplace
      # see and learn https://github.com/jiangmiao/auto-pairs
      auto-pairs
      vim-colorschemes
      {
        plugin = vim-json;
        config = ''
          autocmd FileType json :packadd vim-json
          let g:vim_json_syntax_conceal = 0
        '';
      }
    ];
  };
}
