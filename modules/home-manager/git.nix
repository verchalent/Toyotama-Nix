{inputs, config, pkgs, ...}: {
  programs.git = { #Nix was smashing git config. Added 03.25
    enable = true;
    userName = "PestyLint";
    userEmail = "me@example.com";
    includes = [
      { path = "~/.gitconfig.local"; }
    ];
    extraConfig = {
        push.autoSetupRemote = true;
        pull.rebase = true;
        fetch.prune = true;
        fetch.writeCommitGraph = true;
        branch.sort = "-committerdate";
        commit.gpgSign = true;
        tag.gpgSign = true;
        gpg.format = "ssh";
        user.signingKey = "~/.ssh/id_rsa.pub";
    };
  };
}       
