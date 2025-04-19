{pkgs, ...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # Window geometry
        width = 300;
        height = 150;
        origin = "top-right";
        offset = "10x50";
        notification_limit = 5;

        # Appearance
        font = "Fira Code 10";
        line_height = 3;
        padding = 12;
        horizontal_padding = 12;
        frame_width = 2;
        separator_height = 2;
        separator_color = "frame";

        # Transparency and colors
        background = "#282a36dd"; # Semi-transparent background
        foreground = "#f8f8f2";
        frame_color = "#6272a4";

        # Close button
        close = "button2"; # Middle mouse button
        close_all = "ctrl+button2";

        # Animations
        fade_in = "on";
        fade_out = "on";
        fade_timeout = 200; # ms
        shrink = "on";

        # Mouse control
        mouse_left_click = "close_current";
        mouse_middle_click = "close_all";
        mouse_right_click = "do_action";
      };

      urgency_low = {
        background = "#44475add";
        foreground = "#f8f8f2";
        frame_color = "#6272a4";
        timeout = 4;
      };

      urgency_normal = {
        background = "#282a36dd";
        foreground = "#f8f8f2";
        frame_color = "#50fa7b";
        timeout = 6;
      };

      urgency_critical = {
        background = "#ff5555dd";
        foreground = "#f8f8f2";
        frame_color = "#ff5555";
        timeout = 0;
      };

      # Custom rules for specific applications
      app-specific = {
        # Example for Spotify
        "Spotify" = {
          appname = "Spotify";
          urgency = "low";
          timeout = 5;
          background = "#1DB954dd";
          foreground = "#191414";
        };
      };
    };
  };
}
