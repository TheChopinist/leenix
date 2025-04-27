{
  pkgs,
  lib,
  config,
  ...
}: let
  # Convert relative path to absolute using builtins.path
  wallpapersDir = builtins.path {
    path = ./wallpapers;
    name = "hyprpaper-wallpapers";
  };

  # Modified script using absolute paths
  wallpaperScript = pkgs.writeShellScriptBin "hyprpaper-randomizer" ''
    # Use copied wallpapers from ~/.wallpapers
    WALLPAPER_DIR="${config.home.homeDirectory}/.wallpapers"
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

  # Minimal hyprpaper config
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
    };
  };

  # Systemd services (unchanged)
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
}
