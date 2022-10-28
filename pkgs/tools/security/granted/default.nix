{ lib
, stdenv
, makeWrapper
, buildGo117Module
, fetchFromGitHub
, installShellFiles
, awscli2 ? null
, git
  #, gnupg
  #, xclip
  #, wl-clipboard
, passAlias ? false
}:

buildGo117Module rec {
  pname = "granted";
  version = "0.2.0";

  nativeBuildInputs = [ installShellFiles makeWrapper ];

  src = fetchFromGitHub {
    owner = "common-fate";
    repo = "granted";
    rev = "v${version}";
    sha256 = "sha256-euCYXV7r/CeXIVzY3pyzolLHQLg/o2VhQaZoJezw8fU=";
  };

  vendorSha256 = "sha256-EH3Wp4cYy3L4epB2YLC9pLfZ4Ph8ZJjzoq3b2Bb0GoM=";

  subPackages = [
    "cmd/assume"
    "cmd/granted"
  ];
  doCheck = false;
  ldflags = [
    "-X github.com/common-fate/granted/internal/build.Version=${version}"
    "-X github.com/common-fate/granted/internal/build.Commit=${src.rev}"
  ];

  wrapperPath = lib.makeBinPath (
    [
      awscli2
      #     xclip
    ]
    #    ]++ lib.optional stdenv.isLinux wl-clipboard
  );

  installPhase = ''
    runHook preInstall

    ls -lah $src
    GOOS=linux go build -o $out/bin/assume $src/cmd/assume/main.go
    GOOS=linux go build -o $out/bin/granted $src/cmd/granted/main.go
  '';
  #  postInstall = ''
  #    installManPage gopass.1
  #    installShellCompletion --zsh --name _gopass zsh.completion
  #    installShellCompletion --bash --name gopass.bash bash.completion
  #    installShellCompletion --fish --name gopass.fish fish.completion
  #  '' + lib.optionalString passAlias ''
  #    ln -s $out/bin/gopass $out/bin/pass
  #  '';

  postFixup = ''
    wrapProgram $out/bin/granted \
      --prefix PATH : "${wrapperPath}" \
      --set GOPASS_NO_REMINDER true
  '';

  meta = with lib; {
    description = "The slightly more awesome Standard Unix Password Manager for Teams. Written in Go";
    homepage = "https://www.gopass.pw/";
    license = licenses.mit;
    maintainers = with maintainers; [ rvolosatovs sikmir ];
    changelog = "https://github.com/gopasspw/gopass/raw/v${version}/CHANGELOG.md";

    longDescription = ''
      gopass is a rewrite of the pass password manager in Go with the aim of
      making it cross-platform and adding additional features. Our target
      audience are professional developers and sysadmins (and especially teams
      of those) who are well versed with a command line interface. One explicit
      goal for this project is to make it more approachable to non-technical
      users. We go by the UNIX philosophy and try to do one thing and do it
      well, providing a stellar user experience and a sane, simple interface.
    '';
  };
}
