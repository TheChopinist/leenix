{
  pkgs,
  config,
  ...
}: {
  home.file.".config/hypr/scripts/eww-greeting.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # System info
      USER=$(whoami)
      HOST=$(hostname)
      DATE=$(date "+%A, %B %d")
      TIME=$(date "+%H:%M")

      # Start EWW if not running
      if ! pgrep -x "eww" > /dev/null; then
        eww daemon
        sleep 1
      fi

      # Show greeting
      eww --config ${config.programs.eww.configDir} open greeting
      eww --config ${config.programs.eww.configDir} update greeting-text="Welcome, $USER!"
      eww --config ${config.programs.eww.configDir} update greeting-subtext="$HOST · $DATE · $TIME"

      # Fade out after delay
      sleep 3
      eww --config ${config.programs.eww.configDir} update greeting-container_class="greeting-container fade-out"
      sleep 0.5
      eww --config ${config.programs.eww.configDir} close greeting
    '';
  };
}
