{ pkgs, ... }: {
  # TODO adapt what I need from github: andrewrk/dotfiles/.nixpkgs/config.nix
  # why does kakoune import these?
  imports = [ ../python ../haskell ];

  environment.systemPackages = with pkgs; [
    (neovim.override {
      vimAlias = true;
      configure = {
        packages.myplugins = with pkgs.vimPlugins; {
          start = [
            vim-nix
            vim-lastplace
            # see and learn https://github.com/jiangmiao/auto-pairs
            auto-pairs
            vim-colorschemes
            #  indentLine
          ];
          opt = [
            # see and learn https://github.com/elzr/vim-json
            vim-json
          ];
        };
        customRC = ''
          " systemwide vimrc baseline
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

          " filetype-specific settings (see https://nixos.wiki/wiki/Vim#Using_vim.27s_builtin_packaging_capability)
          autocmd FileType json :packadd vim-json
          " set correct yaml indentation (https://www.arthurkoziel.com/setting-up-vim-for-yaml/)
          autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
          " let g:indentLine_char = '⦙'
          let g:vim_json_syntax_conceal = 0
          "
        '';
      };
    }
    )
  ];

  #  environment.etc = {
  #    "xdg/kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;
  #    "xdg/kak/kakrc".source = ./kakrc;
  ##    "xdg/kak/autoload/plugins-config".source = ./plugins;
  #    "xdg/kak/autoload/lint".source = ./lint;
  #    "xdg/kak/autoload/lsp".source = ./lsp;
  #    "xdg/kak/autoload/default".source =
  #      "${pkgs.kakoune}/share/kak/rc";
  #    "xdg/kak/autoload/plugins".source =
  #      "${pkgs.kakoune}/share/kak/autoload/plugins";
  #  };
}
