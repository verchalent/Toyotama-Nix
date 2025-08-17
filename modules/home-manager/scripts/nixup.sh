#!/usr/bin/env bash

# Update and clean up Nix - Created to address permission requirements for switch
nix flake update
cwd=$(pwd)
sudo darwin-rebuild switch --flake $cwd