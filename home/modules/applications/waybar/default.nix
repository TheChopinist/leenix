{pkgs, ...}: {
  programs.waybar = {
    enable = true;

    settings = [
      {
        layer = "top";
        position = "top";
        height = 24;
        spacing = 4;

        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["cpu" "custom/reboot" "custom/shutdown"];

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
          active-only = false;
          all-outputs = true;
        };

        clock = {
          format = "{:%H:%M}";
          tooltip-format = "{:%A, %d %B %Y}";
        };

        cpu = {
          format = "{usage}%";
          interval = 1;
        };

        "custom/shutdown" = {
          format = "⏻";
          tooltip = false;
          on-click = ''
            dunstify -u critical -t 60000 "Shutdown Initiated" "System will shutdown in 60 seconds" &&
            shutdown -P +1
          '';
        };

        "custom/reboot" = {
          format = "↻";
          tooltip = false;
          on-click = ''
            dunstify -u critical -t 60000 "Reboot Initiated" "System will reboot in 60 seconds" &&
            shutdown -r +1
          '';
        };
      }
    ];

    style = ''
      * {
        font-family: sans-serif;
        font-size: 13px;
        min-height: 0;
        padding: 0;
        margin: 0;
      }

      window#waybar {
        background-color: rgba(23, 23, 23, 0.9);
      }

      #workspaces button {
        padding: 0 8px;
        color: #777777;
      }

      #workspaces button.visible {
        color: #bbbbbb;
      }

      #workspaces button.active {
        color: #ffffff;
      }

      #clock, #cpu, #custom-shutdown, #custom-reboot {
        color: #cccccc;
        padding: 0 10px;
      }

      #custom-shutdown:hover {
        color: #ff5555;
      }

      #custom-reboot:hover {
        color: #55aaff;
      }
    '';
  };
}
