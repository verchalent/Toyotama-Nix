# WIP to move application specific prefs into nix
# Apps to Add com.raycast.macos, com.surteesstudios.Bartender, com.lwouis.alt-tab-macos ...
# look at https://github.com/zmre/nix-config/blob/main/modules/darwin/preferences.nix
# Reminder: dump prefs "defaults read <app bundle id>"
# Find prefs "defaults domains | tr ' ' '\n'|grep <app name-ish>"