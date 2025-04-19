{pkgs, ...}: {
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 24;
      gtk_dark = true;
      dynamic_lines = true;
      hide_scroll = true;
    };

    style = ''
      * {
        font-family: "Fira Code", "Font Awesome 6 Free";
        font-size: 14px;
      }

      window {
        margin: 0px;
        border: 1px solid rgba(168, 153, 132, 0.3);
        border-radius: 12px;
        background-color: rgba(40, 40, 40, 0.8);
        background-clip: padding-box;
        backdrop-filter: blur(12px);
      }

      #input {
        margin: 12px 16px;
        padding: 8px 12px;
        border: none;
        border-radius: 8px;
        color: #ebdbb2;
        background-color: rgba(60, 56, 54, 0.8);
      }

      #inner-box {
        margin: 0px 16px 16px 16px;
        border: none;
        background-color: transparent;
      }

      #outer-box {
        margin: 0px;
        border: none;
        background-color: transparent;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 4px 8px;
        color: #ebdbb2;
      }

      #entry {
        padding: 8px 12px;
        border-radius: 8px;
        background-color: transparent;
        transition: background-color 0.2s ease;
      }

      #entry:selected {
        background-color: rgba(69, 133, 136, 0.6);
        border: none;
        outline: none;
      }

      #img {
        margin-right: 12px;
      }
    '';
  };
}
