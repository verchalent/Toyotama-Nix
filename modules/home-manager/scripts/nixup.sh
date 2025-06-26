#!/usr/bin/env bash

# Update and clean up Nix
nix flake update
darwin-rebuild switch --flake /Users/justin/src/Toyotama-Nix/.#