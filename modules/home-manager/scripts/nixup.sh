#!/usr/bin/env bash
# Script to update Brew, NixOS and ensure defaults applied

# Set Wallpaper - no fun Nix way to do this yet :)
osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$(dirname "$PWD")/wallpaper/JackFrost.jpg\""

# Update and clean up Brew
brew update 
brew upgrade 
brew cleanup --prune=all

# Update and clean up Nix
pushd ~/src/Toyotama-Nix
nix flake update
darwin-rebuild switch --flake ~/src/Toyotama-Nix/.#
pop