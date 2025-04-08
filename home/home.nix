{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./modules/hyprland/hyprland.nix
    # ./modules/default.nix
    inputs.catppuccin.homeModules.catppuccin
    inputs.spicetify.homeManagerModules.default
  ];

  catppuccin = {
    enable = true;
    flavor = "frappe";  # Always specify flavor
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

  programs.spicetify = {
    enable = true;
    /* theme = {
      name = "catppuccin";
      variant = "mocha";
      colorScheme = "flamingo";  # Accent color
    };
    enabledExtensions = with pkgs.spicetify-extensions; [
      "fullAppDisplay"
      "shuffle" 
      "hidePodcasts"
      "adblock"
    ]; */
  };
  
  home.packages = [ pkgs.spotify ];

  programs.waybar = {
    enable = true;
    settings = [
    {
      layer = "top";
      position = "top";
      height = 30;
      modules-left = ["hyprland/workspaces"];
      modules-center = ["clock"];
      modules-right = ["cpu"];
      cpu = {
        format = "{usage}%";
      };
    }
  ];
  style = ''
      #waybar > * {
        margin: 10px;
      }
      #waybar {
        margin: 10px;
        /* background: #16191C;
        color: #AAB2BF; */
      }
      
    '';
  };
  
  programs.home-manager.enable = true;
}
