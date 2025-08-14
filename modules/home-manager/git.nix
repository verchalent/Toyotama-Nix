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
        user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILi+OcRdb7L6hiLF0LO0UqktVP3iXSqrESQQ8YD8MoHJ";
        gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };
  };
}
