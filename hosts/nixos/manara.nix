{ suites, profiles, hardware, config, lib, pkgs, ... }:

{
  #imports = suites.progloveLaptop ++ [ hardware.dell-latitude-3480 ];
  imports = suites.workstation ++ [
    profiles.laptop
    profiles.proglove
    profiles.proaudio
  ];

  # Setup networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # set locale
  i18n.defaultLocale = "en_US.UTF-8";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "i915" ];
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;

    configurationLimit = 20;

    gfxmodeEfi = "1920x1280";
    #    theme = pkgs.grub2-themes-virtuaverse;
    splashImage = pkgs.nixos-artwork.wallpapers.stripes-logo.gnomeFilePath;
    backgroundColor = "#292A35";
  };

  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-partuuid/5d8be917-7365-474b-9c55-d36a969477f0 ";
      header = "/dev/disk/by-partuuid/5c0828b5-5aae-4e46-98b4-fa1a437fe9ef ";
      allowDiscards = true;
      preLVM = true;
    };
  };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/f3a4d049-46fb-4f04-a8b2-f4bfb3de6a17";
      fsType = "ext4";
    };

  fileSystems."/nix/store" =
    {
      device = "/nix/store";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/A55C-3994";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/7c925476-da2d-40fd-83b0-6fd77b2ffee9"; }];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  services.dbus.enable = true;
  #  security.pam.services.sudo.showMotd = true;
  users.motd = "hellou\n";
  environment.systemPackages = [ pkgs.pam_usb ];
  #  environment.systemPackages = [ pkgs.pam_usb pkgs.granted ];
  environment.variables = {
    VDPAU_DRIVER = "va_gl";
  };

  #  services.udisks2.enable = true;
  security.pam.usb.enable = false;
  security.pam.services.su.usbAuth = true;
  security.pam.services.sudo.usbAuth = true;
  #  security.pam.services.login.usbAuth = true;
  security.pam.services.sudo.logFailures = true;
  #  security.pam.services.sudo.text = "# Account management.\naccount required pam_unix.so\n\n# Authentication management.\nauth sufficient ${pkgs.pam_usb}/lib/security/pam_usb.so debug\nauth sufficient pam_unix.so likeauth try_first_pass\nauth required pam_deny.so\n\n# Password management.\npassword sufficient pam_unix.so nullok sha512\n\n# Session management.\nsession required pam_env.so conffile=/etc/pam/environment readenv=0\nsession required pam_unix.so\n";

  environment.etc = {
    "security/pam_usb.conf".source = ./pam_usb.conf;
  };
  #  services.dbus.packages = [ pkgs.udisks1 ];
  #  services.udev.packages = [ pkgs.udisks1 ];
  #  systemd.packages = [ pkgs.udisks1 ];



  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # based on https://nixos.wiki/wiki/Accelerated_Video_Playback
  #  config.packageOverrides = pkgs: {
  #    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  #  };
  services.xserver.videoDrivers = [ "intel" ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jbl = {
    hashedPassword = "$6$1aJR8GVSqojUQVM4$x433Q./ToIpvVtzzFFjctZ3RbzqdrjwxN6ibaQNNwL4ZpiC1vhSsEnEz8O7VAvQYZ779h2TceTVIW5wK8Bw1W.";
    description = "Julius Blank";
    extraGroups = [ "wheel" "docker" ];
    isNormalUser = true;
  };
  users.mutableUsers = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  #   firefox
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

