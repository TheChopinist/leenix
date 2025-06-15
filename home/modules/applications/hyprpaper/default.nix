{pkgs, ...}: let
  # Replace this with your actual Nix-managed wallpapers path
  nixWallpapers = "/home/lee/nixos/home/modules/applications/hyprpaper/wallpapers";
  userWallpapers = "/home/lee/Pictures/wallpapers";

  randomWallpaperScript = pkgs.writeShellScriptBin "hyprpaper-random" ''
    #!/usr/bin/env bash
    echo "---- hyprpaper-random DEBUG ----"
    WALLPAPER_DIRS="${nixWallpapers} ${userWallpapers}"
    echo "All wallpaper dirs: $WALLPAPER_DIRS"
    WALLPAPERS=()
    for DIR in $WALLPAPER_DIRS; do
      echo "Checking directory: $DIR"
      if [ -d "$DIR" ]; then
        while IFS= read -r IMG; do
          echo "  Found image: $IMG"
          WALLPAPERS+=("$IMG")
        done < <(find "$DIR" -type f \( -iname '*.jpg' -o -iname '*.png' \))
      else
        echo "  Directory does not exist: $DIR"
      fi
    done
    echo "Total wallpapers found: ''${#WALLPAPERS[@]}"
    if [ ''${#WALLPAPERS[@]} -eq 0 ]; then
      echo "No wallpapers found! Exiting."
      exit 1
    fi
    SELECTED_WALL="''${WALLPAPERS[$RANDOM % ''${#WALLPAPERS[@]}]}"
    echo "Selected wallpaper: $SELECTED_WALL"

    # First preload the new wallpaper
    hyprctl hyprpaper preload "$SELECTED_WALL"

    # Then set it on all monitors
    for m in $(hyprctl monitors | grep Monitor | awk '{print $2}'); do
      echo "Setting wallpaper for monitor: $m"
      hyprctl hyprpaper wallpaper "$m,$SELECTED_WALL"
    done

    # Only unload old wallpapers after the new one is set
    hyprctl hyprpaper unload all

    echo "---- hyprpaper-random END ----"
  '';
in {
  home.packages = [randomWallpaperScript];

  systemd.user.services.hyprpaper-random = {
    Unit = {
      Description = "Random Hyprpaper Wallpaper";
      After = ["graphical-session.target" "hyprpaper.service"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${randomWallpaperScript}/bin/hyprpaper-random";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  systemd.user.timers.hyprpaper-random = {
    Unit.Description = "Timer for random Hyprpaper wallpapers";
    Timer = {
      OnBootSec = "10s";
      OnUnitActiveSec = "1h";
      Unit = "hyprpaper-random.service";
    };
    Install.WantedBy = ["timers.target"];
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
    };
  };
}
