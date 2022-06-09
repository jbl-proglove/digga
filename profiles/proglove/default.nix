{ pkgs, ... }: {
  # TODO read up on how to structure this
  # is it supposed to be a sub-profile of laptop or graphical?
  # if it stays toplevel, what do I HAVE to import?
  imports = [ ../graphical ];

  environment.systemPackages = with pkgs; [
    teams
    drawio
  ];

  services.xserver = {
    #  enable = true;
    displayManager = {
      defaultSession = "none+xmonad";

      # Should be default, but I prefer explicit
      lightdm.enable = true;

      # the lightdm mini-greeter automatically uses the default session
      # This only makes sense in a single user machine, like my work laptop
      # A logical place to put this would be a proglove laptop profile or
      # something user-specific.
      lightdm.greeters.mini = {
        enable = true;
        # TODO how do I solve this more elegantly? Currently, this is an
        # implicit dependency to users/jbl, which feels off.
        user = "jbl";
        extraConfig = ''
          [greeter]
          show-password-label = false
          invalid-password-text = Nope
          show-input-cursor = true
          password-alignment = center
          show-image-on-all-monitors = true
          [greeter-theme]
          text-color = "#FFD119"
          password-character = x
          error-color = "#F07178"
          border-color = "#FFFFFF"
          window-color = "#202952"
          password-color = "#FFD119"
          password-background-color = "#202952
          password-border-color = "#202331"
          password-border-width = 0px
          border-width = 1px
          background-image = "/etc/wallpapers/nix-wallpaper-simple-blue.png"
        '';
      };
    };
  };
}
