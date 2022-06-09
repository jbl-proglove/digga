{ ... }: {
  services.openssh = {
    enable = true;
    challengeResponseAuthentication = false;
    passwordAuthentication = true; # TODO set to false, once keys are there
    forwardX11 = true;
    permitRootLogin = "no";
    startWhenNeeded = true;
  };

  programs.ssh.startAgent = true;
}
