{ pkgs, ... }:
let
  my-gnupg = pkgs.gnupg.override { pinentry = pkgs.pinentry-gtk2; guiSupport = true; };
  my-gopass = pkgs.gopass.override { gnupg = my-gnupg; };
in
{

  #  imports = [ ../python ../haskell ];

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

  #  nixpkgs.overlays =
  #    let
  #      gnupg_ov = self: super: {
  #        gnupg = super.gnupg.override {
  #          pinentry = self.pinentry-curses;
  #        };
  #      };
  #    in
  #    [ gnupg_ov ];
}

#self: super:
#
#{
#  gnupg = super.gnupg.override {
#    pinentry = self.pkgs.pinentry-curses;
#  };
#}
