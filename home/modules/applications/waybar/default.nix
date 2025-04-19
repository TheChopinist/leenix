{pkgs, ...}: {
  programs.waybar = {
    enable = true;

    settings = [
      {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["cpu"];
        cpu = {
          format = "{usage}%";
        };
      }
    ];

    style = ''
      #waybar > * {
          margin: 10px;
      }
      #waybar {
          margin: 10px;
          /* background: #16191C;
          color: #AAB2BF; */
      }
    '';
  };
}
