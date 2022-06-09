{ hmUsers, suites, ... }:
{
  #home-manager.users = { inherit (hmUsers) jbl; };

  home-manager.users.jbl = { suites, ... }: {
    imports = suites.coding;
    programs.git.extraConfig = {
      user.name = "jbl-proglove";
      user.email = "julius.blank@proglove.de";
    };
  };

  environment.sessionVariables = {
    EDITOR = "vim";
  };



  users.users.jbl = {
    uid = 1001;
    # FIXME replace password
    password = "nixos";
    description = "Julius Blank";
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };
}
