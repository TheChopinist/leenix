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

        "custom/shutdown" = {
          format = "⏻";
          on-click = ''sh -c 'wofi --yesno "Shutdown?" && systemctl poweroff' '';
        };
        "custom/reboot" = {
          format = "↻";
          on-click = ''sh -c 'wofi --yesno "Reboot?" && systemctl reboot' '';
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
        background-color: rgba(42, 42, 42, 0.9);
        border-bottom: 1px solid rgba(58, 58, 58, 0.6);
        border-radius: 4px;
      }

      #workspaces button {
        padding: 0 8px;
        color: rgba(248, 248, 242, 0.8);
        background-color: transparent;
        border-radius: 4px;
        margin: 4px 2px;
      }

      #workspaces button.active {
        color: rgba(80, 250, 123, 0.9);
        background-color: rgba(58, 58, 58, 0.4);
      }

      #workspaces button:hover {
        background-color: rgba(58, 58, 58, 0.6);
      }

      #clock {
        color: rgba(248, 248, 242, 0.9);
        padding: 0 10px;
        background-color: rgba(58, 58, 58, 0.3);
        border-radius: 4px;
        margin: 4px 2px;
      }

      #tray {
        padding: 0 6px;
        background-color: rgba(58, 58, 58, 0.3);
        border-radius: 4px;
        margin: 4px 2px;
      }

      #custom-wallpaper, #custom-reboot, #custom-shutdown {
        padding: 0 8px;
        background-color: rgba(58, 58, 58, 0.3);
        border-radius: 4px;
        margin: 4px 2px;
      }

      #custom-wallpaper {
        color: rgba(248, 248, 242, 0.8);
      }

      #custom-reboot {
        color: rgba(248, 248, 242, 0.8);
      }

      #custom-shutdown {
        color: rgba(248, 248, 242, 0.8);
      }

      #custom-wallpaper:hover {
        color: #ffb86c;
        background-color: rgba(58, 58, 58, 0.6);
      }

      #custom-reboot:hover {
        color: #8be9fd;
        background-color: rgba(58, 58, 58, 0.6);
      }

      #custom-shutdown:hover {
        color: #ff5555;
        background-color: rgba(58, 58, 58, 0.6);
      }
    '';
  };
}
