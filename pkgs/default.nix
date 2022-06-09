final: prev: {
  # keep sources this first
  sources = prev.callPackage (import ./_sources/generated.nix) { };
  # then, call packages with `final.callPackage`
  widevine-cdm = prev.callPackage ./applications/networking/browsers/widevine { };
}
