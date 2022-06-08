{ hmUsers, ... }:
{
  home-manager.users = { inherit (hmUsers) nixos; };
  #  programs.git.extraConfig = {
  #    user.name = "jbl-proglove";
  #    user.email = "julius.blank@proglove.de";
  #  };

  users.users.nixos = {
    password = "nixos";
    description = "default";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
