{pkgs, ...}: {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        margin = "5px 5px 0 5px";
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
          spacing = 4;
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
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(40, 42, 54, 0.9);
      }

      #workspaces button {
        padding: 0 8px;
        color: #f8f8f2;
      }

      #workspaces button.active {
        color: #50fa7b;
      }

      #clock {
        color: #f8f8f2;
        padding: 0 10px;
      }

      #tray {
        padding: 0 6px;
      }

      #custom-wallpaper, #custom-reboot, #custom-shutdown {
        padding: 0 8px;
      }

      #custom-wallpaper:hover {
        color: #ffb86c;
      }

      #custom-reboot:hover {
        color: #8be9fd;
      }

      #custom-shutdown:hover {
        color: #ff5555;
      }
    '';
  };
}
