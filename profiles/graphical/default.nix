{ pkgs, ... }: {
  imports = [ ./qutebrowser ./xmonad ./im ];

  hardware.opengl.enable = true;
  # TODO verify setting
  hardware.opengl.driSupport = true;
  hardware.pulseaudio.enable = true;

  # TODO verify settings
  boot = {
    tmpOnTmpfs = true;

    kernel.sysctl."kernel.sysrq" = 1;

  };

  environment.systemPackages = with pkgs; [
    # TODO not sure if this is the right place
    alacritty
    # TODO verify and select packages for XMonad
    # TODO customize dunst
    cmatrix
    dunst
    dzen2 # used by xmonad/scripts/stoggle
    feh
    ffmpeg-full
    imagemagick
    imlib2
    librsvg
    libsForQt5.qtstyleplugins
    manpages
    nyxt
    #    papirus-icon-theme
    pulsemixer
    qt5.qtgraphicaleffects
    #    sddm-chili
    stdmanpages
    xsel
    zathura
  ];

  # TODO should this be an overlay? A package? I need to learn stuff...
  environment.etc = {
    "wallpapers/nix-wallpaper-stripes.png".source = ../../assets/images/nix-wallpaper-stripes.png;
    "wallpapers/nix-wallpaper-mosaic-blue.png".source = ../../assets/images/nix-wallpaper-mosaic-blue.png;
    "wallpapers/nix-wallpaper-nineish-dark-gray.png".source = ../../assets/images/nix-wallpaper-nineish-dark-gray.png;
    "wallpapers/nix-wallpaper-simple-blue.png".source = ../../assets/images/nix-wallpaper-simple-blue.png;
    "wallpapers/wallpaper-desert.png".source = ../../assets/images/wallpaper-desert.png;
    "wallpapers/wallpaper-darth-vader.png".source = ../../assets/images/wallpaper-darth-vader.png;
    "wallpapers/wallpaper-light-rain.jpg".source = ../../assets/images/wallpaper-light-rain.jpg;
    "wallpapers/wallpaper-lake-mountains.jpg".source = ../../assets/images/wallpaper-lake-mountains.jpg;
    "wallpapers/wallpaper-nord-nixos-1.jpg".source = ../../assets/images/wallpaper-nord-nixos-1.jpg;
    "wallpapers/wallpaper-nord-nixos-2.jpg".source = ../../assets/images/wallpaper-nord-nixos-2.jpg;
    "wallpapers/wallpaper-wallhaven-moon.jpg".source = ../../assets/images/wallpaper-wallhaven-moon.jpg;

    # Taken from https://konfou.xyz/posts/nixos-without-display-manager/
    # in order to get rid off the display manager
    #    "profile.local".text = ''
    #      #!/bin/sh
    #      # /etc/profile.local: DO NOT EDIT -- this file has been generated automatically.
    #      if [ -f ~/.profile ]; then
    #        . ~/.profile
    #      fi
    #      #if [ -f "$HOME/.profile" ]; then
    #      #  . "$HOME/.profile"
    #      #fi
    #    '';

    #    "zprofile.local".text = ''
    #      #!/bin/sh
    #      # /etc/zprofile.local: DO NOT EDIT -- this file has been generated automatically.
    #      if [ -f ~/.zprofile ]; then
    #        . ~/.zprofile
    #      fi
    #      #if [ -f "$HOME/.profile" ]; then
    #      #  . "$HOME/.profile"
    #      #fi
    #    '';
  };

  # ANSWERED: what does xbanish do? - it hides the mouse cursor when
  # typing starts.
  #  services.xbanish.enable = true;

  services.xserver = {
    enable = true;
    #  tty = 1;
    #autorun = false;
    autorun = true;
    #exportConfiguration = true;
    #layout = "us";
    layout = "us,de";
    xkbOptions = "grp:alt_shift_toggle";
    #    resolutions = [
    #      { x = 1920; y = 1080; }
    #      { x = 2560; y = 1440; }
    #    ];

    # Enable touchpad support.
    libinput.enable = true;

    resolutions = [{ x = 1920; y = 1280; } { x = 2560; y = 2440; }];
    #videoDrivers = [ "displaylink" "modesetting" ];
    logFile = "/var/log/Xorg.0.log";
    # Disable desktop manager.
    #    desktopManager.default = "none";

    updateDbusEnvironment = true;

    #displayManager = {
    #startx.enable = true;
    #defaultSession = "none+xmonad";
    #
    # Should be default, but I prefer explicit
    #lightdm.enable = true;
    #};
  };
}
