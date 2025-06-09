{pkgs, ...}: {
  home.file.".config/hypr/scripts/toggle-waybar.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      CONFIG_FILE="$HOME/.config/waybar/style.css"

      if grep -q "display: none" "$CONFIG_FILE"; then
          sed -i 's/display: none/display: block/' "$CONFIG_FILE"
      else
          sed -i 's/display: block/display: none/' "$CONFIG_FILE"
      fi

      # Reload Waybar
      pkill -USR1 waybar
    '';
  };
}
