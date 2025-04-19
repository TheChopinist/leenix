{ pkgs, ... }:

{
programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 300;
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
    };
    style = ''
      window {
        margin: 0px;
        border: 2px solid #458588;
        background-color: #282828;
      }
      
      #input {
        margin: 5px;
        border: none;
        color: #ebdbb2;
        background-color: #3c3836;
      }
      
      #inner-box {
        margin: 5px;
        border: none;
        background-color: #282828;
      }
      
      #outer-box {
        margin: 5px;
        border: none;
        background-color: #282828;
      }
      
      #scroll {
        margin: 0px;
        border: none;
      }
      
      #text {
        margin: 5px;
        border: none;
        color: #ebdbb2;
      }
      
      #entry:selected {
        background-color: #458588;
      }
    '';
  };
}
