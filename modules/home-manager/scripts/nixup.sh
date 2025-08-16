#!/usr/bin/env bash

# Update and clean up Nix - Created to address permission requirements for switch
nix flake update
sudo darwin-rebuild switch --flake /Users/justin/src/Toyotama-Nix/.#