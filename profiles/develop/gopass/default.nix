{ pkgs, ... }:
let
  my-gnupg = pkgs.gnupg.override { pinentry = pkgs.pinentry-gtk2; guiSupport = true; };
  my-gopass = pkgs.gopass.override { gnupg = my-gnupg; passAlias = true; };
in
{

  environment.systemPackages = with pkgs; [
    pinentry-gtk2
    my-gnupg
    my-gopass
  ];

  programs.gnupg = {
    package = my-gnupg;
    agent = {
      enable = true;
      pinentryFlavor = "gtk2";
    };
  };
}
