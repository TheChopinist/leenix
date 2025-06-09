{pkgs, ...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # Basic layout
        width = 320;
        height = "(0, 100)";
        origin = "top-right";
        offset = "(20, 50)";

        # No bullshit appearance
        frame_width = 1;
        separator_height = 2;
        padding = 12;
        font = "Monospace 10";

        # Solid colors - no transparency
        background = "#222222";
        foreground = "#FFFFFF";
        frame_color = "#555555";
      };

      urgency_low = {
        background = "#333333";
        timeout = 5;
      };

      urgency_normal = {
        background = "#222222";
        timeout = 10;
      };

      urgency_critical = {
        background = "#550000";
        timeout = 0;
      };
    };
  };
}
