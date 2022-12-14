{ pkgs, ... }:
# TODO add config for showing local md files: https://terminalroot.com/how-to-open-markdown-files-with-md-extension-in-firefox/
# TODO add conventional comments addon: https://addons.mozilla.org/de/firefox/addon/conventional-comments/
#{ config, lib, pkgs, ... }:
#let inherit (builtins) readFile;
#in
{
  #  sound.enable = true;

  environment = {
    # add dracula theme as instructed by https://draculatheme.com/qutebrowser
    #    etc."xdg/qutebrowser/dracula/draw.py".source = ../../../assets/themes/qutebrowser/dracula/draw.py;
    #    etc."xdg/qutebrowser/dracula/__init__.py".source = ../../../assets/themes/qutebrowser/dracula/__init__.py;

    #    etc."xdg/qutebrowser/config.py".text =
    #      let mpv = "${pkgs.mpv}/bin/mpv";
    #      in
    #      ''
    #        ${readFile ./config.py}
    #        ${lib.optionalString
    #          (config.networking.extraHosts != "")
    #          "c.content.blocking.enabled = False"
    #        }
    #
    #        c.qt.args.append('widevine-path=${pkgs.widevine-cdm}/lib/libwidevinecdm.so')
    #
    #        import dracula.draw
    #
    #        dracula.draw.blood(c, {
    #            'spacing': {
    #                'vertical': 6,
    #                'horizontal': 8
    #            }
    #        })
    #
    #        config.bind(',m', 'hint links spawn -d ${mpv} {hint-url}')
    #        config.bind(',v', 'spawn -d ${mpv} {url}')
    #      '';

    #    sessionVariables.BROWSER = "qute";

    systemPackages = with pkgs; [ firefox ];
    #systemPackages = with pkgs; [ qute qutebrowser mpv youtubeDL ];
  };

  #  nixpkgs.overlays = [
  #    (final: prev: {
  #      # wrapper to specify config file
  #      qute = prev.writeShellScriptBin "qute" ''
  #        QUTE_DARKMODE_VARIANT=qt_515_2 QT_QPA_PLATFORMTHEME= exec ${final.qutebrowser}/bin/qutebrowser -C /etc/xdg/qutebrowser/config.py "$@"
  #      '';
  #    })
  #  ];
}
