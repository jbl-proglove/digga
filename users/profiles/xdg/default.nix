{ config, home-manager, ... }:
{
  xdg.enable = true;

  #  environment = {
  #    sessionVariables = {
  #      # see https://github.com/hlissner/dotfiles/blob/8fe1fbb6e7fc0d2f95fe75cdb9df7eb0595a0047/modules/xdg.nix
  #      # These are the defaults, and xdg.enable does set them, but due to load
  #      # order, they're not set before environment.variables are set, which could
  #      # cause race conditions.
  #      XDG_CACHE_HOME  = "$HOME/.cache";
  #      XDG_CONFIG_HOME = "$HOME/.config";
  #      XDG_DATA_HOME   = "$HOME/.local/share";
  #      XDG_BIN_HOME    = "$HOME/.local/bin";
  #    };
  #  };
}
