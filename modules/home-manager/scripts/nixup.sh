#!/usr/bin/env bash
# Script to update Brew, NixOS and ensure defaults applied

# Set Wallpaper - no fun Nix way to do this yet :) - Doen't seem to work (need to investigate)
#osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$(dirname "$PWD")/wallpaper/JackFrost.jpg\""

# Update and clean up Brew
brew update 
brew upgrade 
brew cleanup --prune=all

# Update and clean up Nix
pushd ~/src/Toyotama-Nix
nix flake update
sudo darwin-rebuild switch --flake /Users/justin/src/Toyotama-Nix/.#
popd