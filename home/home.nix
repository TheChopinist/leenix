{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/hyprland/hyprland.nix
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";  # Always specify flavor
    kitty.enable = true;
  };

  home.username = "lee";
  home.homeDirectory = "/home/lee";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # pkgs.hello

    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  /*
 
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      ”\\\${HOME}/.steam/root/compatibilitytools.d”;
  };
  */

  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  programs.kitty = {
    enable = true;
    settings = {
      font_size = 12;
      font_family = "Fira Code";
      background_opacity = "0.7";
      confirm_os_window_close = 0;
      hide_window_decorations = true;
    };
  };
  programs.home-manager.enable = true;
}
