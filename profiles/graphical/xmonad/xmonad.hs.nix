{ pkgs, ... }:
let
  inherit (builtins) readFile;
  inherit (pkgs) writeScript;

  screenshots = "Pictures/shots";


  # TODO add scripts here to change themes etc.

  autostart = writeScript "xmonad-autostart" (readFile ./scripts/autostart);
  stoggle = writeScript "xmonad-stoggle" (readFile ./scripts/stoggle);
  rofi-pass = writeScript "xmonad-rofi-pass" (readFile ./scripts/rofi-pass);

  #  volnoti = import ../misc/volnoti.nix { inherit pkgs; };
in
''
    ${readFile ./_xmonad.hs}
    ${import ./_xmonad.nix {
      inherit
      screenshots
      autostart
      stoggle
      pkgs
  #    volnoti
      ;
      }}
''
