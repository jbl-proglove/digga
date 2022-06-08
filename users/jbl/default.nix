{ hmUsers, suites, ... }:
{
  home-manager.users = { inherit (hmUsers) jbl; };

  #  imports = suites.coding;
  #    programs.git.extraConfig = {
  #      user.name = "jbl-proglove";
  #      user.email = "julius.blank@proglove.de";
  #    };
  #  };



  users.users.jbl = {
    uid = 1001;
    # FIXME replace password
    password = "nixos";
    description = "Julius Blank";
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };
}
