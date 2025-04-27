{
  pkgs,
  lib,
  ...
}: let
  # Path to your wallpapers (relative to this Nix file)
  wallpapersDir = ./wallpapers;

  # Generate randomizer script
  wallpaperScript = pkgs.writeShellScriptBin "hyprpaper-randomizer" ''
    WALLPAPER_DIR="${wallpapersDir}"
    MONITORS=($(hyprctl monitors | grep -oP 'Monitor \K\S+'))
    SELECTED_WALL=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$SELECTED_WALL"
    for monitor in "''${MONITORS[@]}"; do
      hyprctl hyprpaper wallpaper "$monitor,$SELECTED_WALL"
    done
  '';
in {
  # Deploy wallpapers to ~/.wallpapers
  home.file.".wallpapers" = {
    source = wallpapersDir;
    recursive = true;
  };

  # Configure hyprpaper
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
    };
  };

  # Auto-randomize on login and hourly
  systemd.user = {
    services.wallpaper-randomizer = {
      Unit = {
        Description = "Random wallpaper rotation";
        After = ["graphical-session.target"];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${wallpaperScript}/bin/hyprpaper-randomizer";
      };
    };
    timers.wallpaper-randomizer = {
      Unit.Description = "Hourly wallpaper rotation";
      Timer = {
        OnUnitActiveSec = "1h";
        OnBootSec = "5s";
      };
      Install.WantedBy = ["timers.target"];
    };
  };

  # Keybind example (add to Hyprland config)
  #wayland.windowManager.hyprland.settings.bind = [
  #  "SUPER, W, exec, ${wallpaperScript}/bin/hyprpaper-randomizer"
  #];
}
