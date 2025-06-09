{
  config,
  pkgs,
  ...
}: {
  home.file.".config/hypr/scripts/toggle-waybar.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Robust Waybar toggle script

      if pgrep -f 'waybar -b bar-0' >/dev/null; then
          pkill -f 'waybar -b bar-0'
          ${pkgs.libnotify}/bin/notify-send "Waybar" "Killed all instances"
      else
          ${config.wayland.windowManager.hyprland.package}/bin/waybar -b bar-0 && \
          ${pkgs.libnotify}/bin/notify-send "Waybar" "Started"
      fi
    '';
  };
}
