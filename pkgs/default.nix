final: prev: {
  # keep sources this first
  sources = prev.callPackage (import ./_sources/generated.nix) { };
  # then, call packages with `final.callPackage`
  widevine-cdm = prev.callPackage ./applications/networking/browsers/widevine { };
  pam_usb = prev.callPackage ./os-specific/linux/pam_usb { };
  granted = prev.callPackage ./tools/security/granted { };
}
