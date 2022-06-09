{ pkgs, ... }: {
  # TODO adapt what I need from github: andrewrk/dotfiles/.nixpkgs/config.nix
  # why does kakoune import these?
  imports = [ ../python ../haskell ];

  environment.systemPackages = with pkgs; [
    ((vim_configurable.override { python = python3; }).customize {
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace ];
        opt = [ ];
      };
      vimrcConfig.customRC = ''
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
        "
      '';
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
