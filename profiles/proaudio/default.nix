{ pkgs, config, ... }: {
  #  imports = [ ./qutebrowser ./xmonad ./im ];

  #  hardware.opengl.enable = true;
  # TODO make this an option
  #  hardware.opengl.driSupport = true;
  # based on https://nixos.wiki/wiki/Accelerated_Video_Playback
  #config.packageOverrides = pkgs: {
  #  vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  #};

  # pipewire
  #  hardware.pulseaudio.enable = true;


  environment.systemPackages = with pkgs; [
    bitwig-studio
  ];


  # ANSWERED: what does xbanish do? - it hides the mouse cursor when
  # typing starts.
  #  services.xbanish.enable = true;

}
