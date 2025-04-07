# Summary

This is a perpetually in motion config for my mac. Use at your own risk.

## Bootstrap

1) Open a new Terminal
2) Install Nix ``sh <(curl -L https://nixos.org/nix/install)``
3) Install Brew ``/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"``
4) Close the Terminal app and open a new terminal
5) Install git with Brew ``brew install git`` (you may need to source brew)
6) Clone this repo to src (or modify below accordingly)
7) Install the flake ``nix  --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake ~/src/Toyotama-Nix``