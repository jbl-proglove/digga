{ lib
, pkgs
, stdenv
, fetchFromGitHub
, pkg-config
, wrapGAppsHook
, dbus
, python3Packages
, gobject-introspection
, udisks2
, libxml2
, pam
}:
#let
#  inherit (python3Packages) python dbus-python lxml pygobject3;
#  mkrpath = p: "${lib.makeSearchPathOutput "lib" "lib64" p}:${lib.makeLibraryPath p}";
python3Packages.buildPythonApplication rec {
  # in stdenv.mkDerivation rec {
  #stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "pam_usb";
  version = "0.8.2";

  # avoid installer execution
  format = "other";

  src = fetchFromGitHub {
    owner = "mcdope";
    repo = "pam_usb";
    rev = "refs/tags/${version}";
    sha256 = "sha256-lOioPyCf8LGX269WoxcE8ZpbMtybeeXOoQu9v961uV0=";
  };

  nativeBuildInputs = [ pkg-config gobject-introspection wrapGAppsHook ];

  buildInputs = [ pkg-config gobject-introspection dbus libxml2 pam udisks2 ];

  #  strictDeps = false;

  propagatedBuildInputs = with python3Packages; [ dbus-python lxml pygobject3 ];

  pythonPath = with python3Packages; [
    dbus-python
    lxml
    pygobject3
  ];

  # what finally worked was to do it like this:
  # https://github.com/NixOS/nixpkgs/blob/851fd63179a7c171ac2eb757fe83e88c4a48d886/pkgs/applications/misc/udiskie/default.nix
  # after finding this: https://github.com/NixOS/nixpkgs/issues/56943
  dontWrapGApps = true;
  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';
  doCheck = false;

  preBuild = ''
    makeFlagsArray=(DESTDIR=$out LIBDIR=lib)
    substituteInPlace ./src/local.c \
        --replace '/usr/bin/loginctl' '/run/current-system/sw/bin/loginctl'
  '';

  postInstall = ''
    mv $out/usr/* $out/.
    rm -rf $out/usr
    substituteInPlace $out/bin/pamusb-agent \
        --replace '/usr/bin/pamusb-check' $out/bin/pamusb-check
  '';

  meta.platforms = [ "x86_64-linux" ];
}
