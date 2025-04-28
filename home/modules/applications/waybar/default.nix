{pkgs, ...}: {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        margin = "6px 8px 6px 8px";
        spacing = 0;

        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["tray" "custom/wallpaper" "custom/reboot" "custom/shutdown"];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
          };
        };

        clock = {
          format = "{:%H:%M}";
        };

        tray = {
          spacing = 6;
        };

        "custom/wallpaper" = {
          format = "🎨";
          tooltip = false;
          on-click = "hyprpaper-random";
        };

        "custom/reboot" = {
          format = "↻";
          on-click = "reboot";
        };

        "custom/shutdown" = {
          format = "⏻";
          on-click = "shutdown now";
        };
      };
    };

    style = ''
      * {
        font-family: sans-serif;
        font-size: 14px;
        min-height: 0;
        padding: 0;
        margin: 0;
        border: none;
      }

      window#waybar {
        background-color: rgba(46, 52, 64, 0.7);
        border-radius: 12px;
      }

      #workspaces {
        padding: 0 6px;
      }

      #workspaces button {
        padding: 0 10px;
        color: #d8dee9;
        background: transparent;
        border-radius: 8px;
      }

      #workspaces button.active {
        color: #88c0d0;
        background: rgba(136, 192, 208, 0.2);
      }

      #clock {
        color: #eceff4;
        padding: 0 16px;
      }

      #tray {
        padding: 0 8px;
        margin-right: 4px;
      }

      #custom-wallpaper, #custom-reboot, #custom-shutdown {
        color: #d8dee9;
        padding: 0 16px;
        background: transparent;
        transition: background 0.2s ease;
      }

      #custom-wallpaper:hover {
        color: #a3be8c;
        background: rgba(163, 190, 140, 0.2);
      }

      #custom-reboot:hover {
        color: #88c0d0;
        background: rgba(136, 192, 208, 0.2);
      }

      #custom-shutdown:hover {
        color: #bf616a;
        background: rgba(191, 97, 106, 0.2);
      }
    '';
  };
}
