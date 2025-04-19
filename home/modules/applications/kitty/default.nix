{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    settings = {
      font_size = 12;
      font_family = "Fira Code";
      background_opacity = "0.7";
      confirm_os_window_close = 0;
      hide_window_decorations = true;
    };
  };
}
