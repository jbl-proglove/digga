{ hmUsers, suites, pkgs, ... }:
# DP1 00ffffffffffff0005e37827fe000000231a0103803c22782aa595a65650a0260d5054bfef00d1c0b30095008180814081c001010101565e00a0a0a029503020350055502100001e000000fd00324c1e631e000a202020202020000000fc0032373738580a20202020202020000000ff004533334739424130303032353401ec02031ef14b101f051404130312021101230907078301000065030c001000023a801871382d40582c450055502100001e011d007251d01e206e28550055502100001e8c0ad08a20e02d10103e96005550210000188c0ad090204031200c405500555021000018000000000000000000000000000000000000000000000000006d
# HDMI1 00ffffffffffff0009d1168045540000181b010380351e782eba45a159559d280d5054a56b80810081c08180a9c0b300d1c001010101023a801871382d40582c4500132a2100001e000000ff003336483032393930534c300a20000000fd00324c1e5311000a202020202020000000fc0042656e5120424c323430350a2001dc020322f14f90050403020111121314060715161f2309070765030c00100083010000023a801871382d40582c4500132a2100001f011d8018711c1620582c2500132a2100009f011d007251d01e206e285500132a2100001e8c0ad08a20e02d10103e9600132a21000018000000000000000000000000000000000000000000eb
# eDP1 00ffffffffffff000daec91400000000161c0104951f11780228659759548e271e505400000001010101010101010101010101010101b43b804a71383440503c680035ad1000001ac22f804a71383440503c680035ad1000001a000000fe0058334b4733803134304843410a000000000000413196001000000a010a2020004c
let
  fingerprint_internal = "00ffffffffffff000daec91400000000161c0104951f11780228659759548e271e505400000001010101010101010101010101010101b43b804a71383440503c680035ad1000001ac22f804a71383440503c680035ad1000001a000000fe0058334b4733803134304843410a000000000000413196001000000a010a2020004c";
  fingerprint_portable_usbc = "00ffffffffffff0066886015010101010c1e0103801e1a78fe6435a5544f9e27125054210800d1c0d1c0a9c0950090408180814081c0023a801871382d40582c25002c041100001e000000fc0059544831353650430a20202020000000ff000a202020202020202020202020000000fd00304b235e14000a20202020202001ce02033ef144011f0204230907078301000067030c001000384467d85dc401448001681a00000109303fe6e50f00000600e305c000e200ffe60605015959495730801871382d40582c25002c041100001e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ee";
  fingerprint_dell = "00ffffffffffff0010acdad054574433231d010380351e78ea0565a756529c270f5054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c45000f282100001e000000ff003659593330393854334457540a000000fc0044454c4c205032343139480a20000000fd00384c1e5311000a2020202020200122020317b14c9005040302071601141f121365030c001000023a801871382d40582c45000f282100001e011d8018711c1620582c25000f282100009e011d007251d01e206e2855000f282100001e8c0ad08a20e02d10103e96000f282100001800000000000000000000000000000000000000000000000000000000000000003d";
  fingerprint_dell_for = "00ffffffffffff0010acdad04c304a31151f010380351e78ea0565a756529c270f5054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c45000f282100001e000000ff00345038375044330a2020202020000000fc0044454c4c205032343139480a20000000fd00384c1e5311000a2020202020200131020317b14c9005040302071601141f121365030c001000023a801871382d40582c45000f282100001e011d8018711c1620582c25000f282100009e011d007251d01e206e2855000f282100001e8c0ad08a20e02d10103e96000f282100001800000000000000000000000000000000000000000000000000000000000000003d";
  fingerprint_dell_mar = "00ffffffffffff0010acdad04c304a31151f010380351e78ea0565a756529c270f5054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c45000f282100001e000000ff00345038375044330a2020202020000000fc0044454c4c205032343139480a20000000fd00384c1e5311000a2020202020200131020317b14c9005040302071601141f121365030c001000023a801871382d40582c45000f282100001e011d8018711c1620582c25000f282100009e011d007251d01e206e2855000f282100001e8c0ad08a20e02d10103e96000f282100001800000000000000000000000000000000000000000000000000000000000000003d";
  fingerprint_dell_pg = "00ffffffffffff0010acdad0424d5638111d010380351e78ea0565a756529c270f5054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c45000f282100001e000000ff00394e54364d56320a2020202020000000fc0044454c4c205032343139480a20000000fd00384c1e5311000a20202020202001e5020317b14c9005040302071601141f121365030c001000023a801871382d40582c45000f282100001e011d8018711c1620582c25000f282100009e011d007251d01e206e2855000f282100001e8c0ad08a20e02d10103e96000f282100001800000000000000000000000000000000000000000000000000000000000000003d";
  fingerprint_aoc = "00ffffffffffff0005e377320b030000231a0103804728782a9145a7554ea0250c5054bfef00d1c0b30095008180814081c001010101565e00a0a0a0295030203500c48f2100001e000000fd00324c1e631e000a202020202020000000fc0051333237370a20202020202020000000ff004c475847394a413030303737390133020320f14b101f051404130312021101230907078301000067030c001000383c023a801871382d40582c4500c48f2100001e011d007251d01e206e285500c48f2100001e8c0ad08a20e02d10103e9600c48f210000188c0ad090204031200c405500c48f21000018f03c00d051a0355060883a00c48f2100001c000000000019";
  fingerprint_dock_pg = "00ffffffffffff0005e37827fe000000231a0103803c22782aa595a65650a0260d5054bfef00d1c0b30095008180814081c001010101565e00a0a0a029503020350055502100001e000000fd00324c1e631e000a202020202020000000fc0032373738580a20202020202020000000ff004533334739424130303032353401ec02031ef14b101f051404130312021101230907078301000065030c001000023a801871382d40582c450055502100001e011d007251d01e206e28550055502100001e8c0ad08a20e02d10103e96005550210000188c0ad090204031200c405500555021000018000000000000000000000000000000000000000000000000006d";
  fingerprint_benq_blitz = "00ffffffffffff0009d11680455400002e1c010380351e782eba45a159559d280d5054a56b80810081c08180a9c0b300d1c001010101023a801871382d40582c4500132a2100001e000000ff0041424a3034363933534c300a20000000fd00324c1e5311000a202020202020000000fc0042656e5120424c323430350a2001a7020322f14f90050403020111121314060715161f2309070765030c00100083010000023a801871382d40582c4500132a2100001f011d8018711c1620582c2500132a2100009f011d007251d01e206e285500132a2100001e8c0ad08a20e02d10103e9600132a21000018000000000000000000000000000000000000000000eb";
  fingerprint_benq_pg = "00ffffffffffff0009d1168045540000181b010380351e782eba45a159559d280d5054a56b80810081c08180a9c0b300d1c001010101023a801871382d40582c4500132a2100001e000000ff003336483032393930534c300a20000000fd00324c1e5311000a202020202020000000fc0042656e5120424c323430350a2001dc020322f14f90050403020111121314060715161f2309070765030c00100083010000023a801871382d40582c4500132a2100001f011d8018711c1620582c2500132a2100009f011d007251d01e206e285500132a2100001e8c0ad08a20e02d10103e9600132a21000018000000000000000000000000000000000000000000eb";
in
{
  home-manager.users.jbl = { suites, ... }: {
    imports = suites.coding;

    home.stateVersion = "21.11";

    programs.git.extraConfig = {
      user.name = "jbl-proglove";
      user.email = "julius.blank@proglove.de";
    };

    home.file = {
      ".zshrc".text = ''
        # found on https://github.com/python-poetry/poetry/issues/2295#issuecomment-715538295:
        #. <(${pkgs.poetry} completions zsh)
        #
        #GPG_TTY=$(tty)
        #export GPG_TTY
      '';
    };

    home.file.".aws/config".text = ''
      # profiles
      [profile default]
      region = eu-west-1
      output = json

      [profile jbl-adm]
      sso_start_url = https://proglove.awsapps.com/start/#/
      sso_region = eu-west-1
      sso_account_id = 953517140029
      sso_role_name = AdministratorAccess
      region = eu-west-1
      output = json

      [profile root-adm]
      sso_start_url = https://proglove.awsapps.com/start/#/
      sso_region = eu-west-1
      sso_account_id = 042986739780
      sso_role_name = AdministratorAccess
      region = eu-west-1
      output = json

      [profile ci-ro]
      sso_start_url = https://proglove.awsapps.com/start/#/
      sso_region = eu-west-1
      sso_account_id = 140349294332
      sso_role_name = ReadOnlyAccess
      region = eu-west-1
      output = json

      [profile ops-adm]
      sso_start_url = https://proglove.awsapps.com/start/#/
      sso_region = eu-west-1
      sso_account_id = 272326719334
      sso_role_name = AdministratorAccess
      region = eu-west-1
      output = json

      [profile deploy-adm]
      sso_start_url = https://proglove.awsapps.com/start/#/
      sso_region = eu-west-1
      sso_account_id = 505235327889
      sso_role_name = AdministratorAccess
      region = eu-west-1
      output = json

      [profile ccc-adm]
      sso_start_url = https://proglove.awsapps.com/start/#/
      sso_region = eu-west-1
      sso_account_id = 344375482229
      sso_role_name = AdministratorAccess
      region = eu-west-1
      output = json

      [profile assets-integration-adm]
      sso_start_url = https://proglove.awsapps.com/start/#/
      sso_region = eu-west-1
      sso_account_id = 168223961895
      sso_role_name = AdministratorAccess
      region = eu-west-1
      output = json

      [profile assets-staging-adm]
      sso_start_url = https://proglove.awsapps.com/start/#/
      sso_region = eu-west-1
      sso_account_id = 976720901276
      sso_role_name = AdministratorAccess
      region = eu-west-1
      output = json

      [profile assets-production-adm]
      sso_start_url = https://proglove.awsapps.com/start/#/
      sso_region = eu-west-1
      sso_account_id = 494884085793
      sso_role_name = AdministratorAccess
      region = eu-west-1
      output = json

      [profile nrfthbst-510288724313-adm]
      role_arn = arn:aws:iam::510288724313:role/CustomerAdministrationRole
      source_profile = ccc-adm
      region = eu-west-1
      output = json

      [profile wrc6ztex-adm]
      role_arn = arn:aws:iam::148364792879:role/CustomerAdministrationRole
      source_profile = ccc-adm
      region = eu-west-1
      output = json

      [profile lo1w5foz-adm]
      role_arn = arn:aws:iam::004837963515:role/CustomerAdministrationRole
      source_profile = ccc-adm
      region = eu-west-1
      output = json

      [profile 132603012339-adm]
      role_arn = arn:aws:iam::132603012339:role/CustomerAdministrationRole
      source_profile = ccc-adm
      region = us-east-1
      output = json
    '';

    #    home.sessionVariables = {
    #      EDITOR = "vim";
    #    };

    programs.autorandr = {
      enable = true;
      profiles = {
        ## only the builtin laptop monitor
        "laptop" = {
          fingerprint = { "eDP1" = fingerprint_internal; };
          config."eDP1" = { enable = true; primary = true; position = "0x0"; mode = "1920x1080"; };
        };
        ## setup for the external dell monitor above the laptop monitor
        "dual-topdown-pg" = {
          fingerprint = { "eDP1" = fingerprint_internal; "HDMI1" = fingerprint_dell_pg; };
          config."HDMI1" = { enable = true; primary = true; position = "0x0"; mode = "1920x1080"; };
          config."eDP1" = { enable = true; primary = false; position = "0x1080"; mode = "1920x1080"; };
        };
        "dual-topdown-pg-blitz" = {
          fingerprint = { "eDP1" = fingerprint_internal; "HDMI1" = fingerprint_benq_blitz; };
          config."HDMI1" = { enable = true; primary = true; position = "0x0"; mode = "1920x1080"; };
          config."eDP1" = { enable = true; primary = false; position = "0x1080"; mode = "1920x1080"; };
        };
        "dual-topdown-pg-aoc" = {
          fingerprint = { "eDP1" = fingerprint_internal; "HDMI1" = fingerprint_dock_pg; };
          config."HDMI1" = { enable = true; primary = true; position = "0x0"; mode = "1920x1080"; };
          config."eDP1" = { enable = true; primary = false; position = "0x1080"; mode = "1920x1080"; };
        };
        "dual-topdown-merian" = {
          fingerprint = { "eDP1" = fingerprint_internal; "HDMI1" = fingerprint_aoc; };
          config."HDMI1" = { enable = true; primary = true; position = "0x0"; mode = "2560x1440"; };
          config."eDP1" = { enable = true; primary = false; position = "640x1440"; mode = "1920x1080"; };
        };
        "dual-martina" = {
          fingerprint = { "eDP1" = fingerprint_internal; "HDMI1" = fingerprint_dell_mar; };
          config."HDMI1" = { enable = true; primary = true; position = "0x0"; mode = "1920x1080"; };
          config."eDP1" = { enable = true; primary = false; position = "0x1080"; mode = "1920x1080"; };
        };
        ## setup for the big one at home, the portable screen and the laptop
        "dual-mobile" = {
          fingerprint = { "eDP1" = fingerprint_internal; "HDMI1" = fingerprint_portable_usbc; };
          config."HDMI1" = { enable = true; primary = true; position = "0x0"; mode = "1920x1080"; };
          config."eDP1" = { enable = true; primary = false; position = "1920x0"; mode = "1920x1080"; };
        };
        "dual-mobile-adapter" = {
          fingerprint = { "eDP1" = fingerprint_internal; "DP1" = fingerprint_portable_usbc; };
          config."DP1" = { enable = true; primary = true; position = "0x0"; mode = "1920x1080"; };
          config."eDP1" = { enable = true; primary = false; position = "0x1080"; mode = "1920x1080"; };
        };
        ## setup for the big one at home, the portable screen and the laptop
        "triple-screen" = {
          fingerprint = {
            "eDP1" = fingerprint_internal;
            "HDMI1" = fingerprint_aoc;
            "DP1" = fingerprint_dell;
          };
          config."HDMI1" = { enable = true; primary = true; position = "0x0"; mode = "2560x1440"; };
          config."DP1" = { enable = true; primary = false; position = "640x1440"; mode = "1920x1080"; };
          config."eDP1" = { enable = true; primary = false; position = "2560x770"; mode = "1920x1080"; };
        };
        ## setup for the two HD screens on top and the internal below
        #centered - benq left via HDMI directly, aoc right via HDMI on
        #the docking station
        "triple-screen-pg" = {
          fingerprint = { "eDP1" = fingerprint_internal; "DP1" = fingerprint_dock_pg; "HDMI1" = fingerprint_benq_pg; };
          config."DP1" = { enable = true; primary = true; position = "1920x0"; mode = "1920x1080"; };
          config."HDMI1" = { enable = true; primary = false; position = "0x0"; mode = "1920x1080"; };
          config."eDP1" = { enable = true; primary = false; position = "960x1080"; mode = "1920x1080"; };
        };
        # 24" top-center, laptop below, portable left
        "triple-screen-for" = {
          fingerprint = { "eDP1" = fingerprint_internal; "HDMI1" = fingerprint_dell_mar; "DP1" = fingerprint_portable_usbc; };
          config."eDP1" = { enable = true; primary = false; position = "1920x1080"; mode = "1920x1080"; };
          config."HDMI1" = { enable = true; primary = true; position = "1920x0"; mode = "1920x1080"; };
          config."DP1" = { enable = true; primary = false; position = "0x1080"; mode = "1920x1080"; };
        };
      };

    };
  };

  users.users.jbl = {
    uid = 1001;
    # generate using `mkpasswd -m sha-512`
    hashedPassword = "$6$1aJR8GVSqojUQVM4$x433Q./ToIpvVtzzFFjctZ3RbzqdrjwxN6ibaQNNwL4ZpiC1vhSsEnEz8O7VAvQYZ779h2TceTVIW5wK8Bw1W.";
    description = "Julius Blank";
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };
}
