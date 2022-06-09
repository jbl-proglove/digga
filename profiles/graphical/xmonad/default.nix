{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    farbfeld
    imgurbash2
    maim
    libnotify
    haskellPackages.xmobar
    xclip
    xdotool
    xorg.xdpyinfo
    xss-lock
  ];

  environment.etc = {
    "xmobar/xmobarrc".source = ./_xmobar.hs;
  };

  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    #    haskellPackages = pkgs.haskellPackages.extend(
    #      pkgs.haskell.lib.packageSourceOverrides {
    #        xmonad = pkgs.fetchFromGitHub {
    #          owner = "xmonad";
    #          repo = "xmonad";
    #          rev = "6a7eb85e84ddc2091706fbce5ff293e859481e51";
    #          sha256 = "mHc46yf/gjGW+55Yui4UR0u8zFjgDWfOLTJKBABQmoo=";
    #        };
    #        xmonad-contrib = pkgs.fetchFromGitHub {
    #          owner = "xmonad";
    #          repo = "xmonad-contrib";
    #          rev = "5067164d195a899a9e63547e94891919e97e0b74";
    #          sha256 = "ZoN7Ue1QMpF8BuZZU9p4FaKV7EsCj83R45Rb55+cqdo=";
    #        };
    #        X11 = pkgs.fetchFromGitHub {
    #          owner = "xmonad";
    #          repo = "X11";
    #          rev = "46bc48c08b0d1f4f682e6730983f789883f4db78";
    #          sha256 = "Lnt6RK+Ef/dOIlu7g0Fob9719VEuAZlwgtQ5dgCZWxI=";
    #        };
    #      }
    #    );
    extraPackages = haskellPackages: [
      haskellPackages.xmonad-contrib
      haskellPackages.xmonad-extras
      haskellPackages.xmonad
      haskellPackages.xmobar
      #      haskellPackages.X11
      # needed by the xmobar Volume command
      haskellPackages.alsa-core
      haskellPackages.alsa-mixer
    ];
    config = import ./xmonad.hs.nix { inherit pkgs; };
  };

  # TODO apply stuff from https://github.com/hlissner/dotfiles/blob/b5a6812227c24b975819cf1a8705cd24c6917aa2/modules/desktop/default.nix
  # TODO checkout https://gist.github.com/scheckley/b91d7b50c7f372ba7107baf01127da3a
  services.picom = {
    enable = true;
    # TODO exclude browser, rofi, screen locker, what else?
    activeOpacity = 0.9;
    inactiveOpacity = 0.8;
    # INVESTIGATE pro? con?
    backend = "glx";
    fade = true;
    fadeDelta = 3;
    opacityRules = [
      "100:name *= 'Microsoft Teams'"
      "100:name *= 'Google Chrome'"
      "100:class_g = 'qutebrowser'"
      "100:class_g *= 'google-chrome'"
      "100:class_g *= 'Firefox'"
      "100:class_g = 'zoom'"
      "100:class_g = 'Rofi'"
      "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
    ];

    # https://btwiusegentoo.github.io/nixconfig/#org49aacba mentions
    # setting services.picom.blur and .extraOptions.
    # It took me a painful while to find out that these are home-manager
    # settings... the following way sets the picom config using a
    # `normal` way ie without home-manager.
    settings = {
      unredir-if-possible = true;
      focus-exclude = "name = 'slock'";
      blur = {
        method = "dual_kawase";
        strength = 6;
      };
      vsync = true;
      shadow-exclude = [
        "name = 'xmobar'"
        #        "name *= 'rofi'"
        "name *= 'compton'"
        "name *= 'picom'"
        "name *= 'Chromium'"
        "name *= 'Chrome'"
        "class_g = 'Firefox' && argb"
      ];
      shadow-radius = 3;
      shadow-offset-x = 3;
      shadow-offset-y = 3;
      shadow-opacity = 0.5;
      shadow-blue = 0.2;
      shadow-red = 0.1;
    };
    #    experimentalBackends = true;
    shadow = true;
    shadowOpacity = 0.9;
    # not sure if this is needed / better...
  };

  # TODO Evaluate and setup this in xorg.conf or find an alternative - maybe
  # by skipping the display manager
  #
  # Section "ServerFlags"
  #   Option "DontVTSwitch" "True"
  #   Option "DontZap"      "True"
  # EndSection

  # TODO setup some suspend functionality with a nice keybinding.
  # One example, taken from man slock:
  # $ slock /usr/sbin/s2ram
  programs.slock.enable = true;
}
