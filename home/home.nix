{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./modules/hyprland/hyprland.nix
    ./modules/default.nix
    inputs.catppuccin.homeModules.catppuccin
    inputs.spicetify.homeManagerModules.default
  ];

  catppuccin = {
    enable = true;
    flavor = "frappe"; # Always specify flavor
    kitty.enable = true;
    waybar.enable = true;
  };

  home.username = "lee";
  home.homeDirectory = "/home/lee";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  /*

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      ”\\\${HOME}/.steam/root/compatibilitytools.d”;
  };
  */

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.spicetify = let
    spicetify = inputs.spicetify.legacyPackages.${pkgs.system};
  in {
    enable = true;
    enabledExtensions = with spicetify.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
    enabledCustomApps = with spicetify.apps; [
      newReleases
      ncsVisualizer
    ];
    theme = spicetify.themes.catppuccin;
    colorScheme = "mocha";
  };

  #  home.packages = [ pkgs.example ];

  programs.home-manager.enable = true;
}
