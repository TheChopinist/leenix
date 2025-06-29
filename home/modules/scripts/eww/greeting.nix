{
  pkgs,
  config,
  ...
}: {
  home.file.".config/hypr/scripts/eww-greeting.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      # Use the exact Nix-managed config path
      EWW_CONFIG="${config.programs.eww.configDir}"

      # Verify config exists
      if [[ ! -f "$EWW_CONFIG/eww.yuck" ]]; then
        notify-send "EWW Error" "Config missing at $EWW_CONFIG" -u critical
        exit 1
      fi

      # Start/Restart daemon
      eww kill 2>/dev/null || true
      eww --config "$EWW_CONFIG" daemon &
      sleep 1  # Ensure daemon is ready

      # Open window
      eww --config "$EWW_CONFIG" open greeting
      eww --config "$EWW_CONFIG" update greeting-text="Welcome, $(whoami)!"
      eww --config "$EWW_CONFIG" update greeting-subtext="$(date '+%A, %B %d · %H:%M')"

      # Fade out after 3 seconds
      sleep 3
      eww --config "$EWW_CONFIG" update greeting-container_class="fade-out"
      sleep 0.5
      eww --config "$EWW_CONFIG" close greeting
    '';
  };
}
