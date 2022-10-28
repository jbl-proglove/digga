final: prev: {
  pam_usb = prev.pam_usb.overrideAttrs (o: rec{
    inherit (prev.sources.pam_usb) pname version src;
  });
}
