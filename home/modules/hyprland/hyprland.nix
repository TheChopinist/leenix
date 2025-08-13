{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    settings = {
      monitor = "DP-1,3440x1440@144,0x0,1.25";

      exec-once = [
        "hyprpaper"
        "waybar"
        "dunst"
        "easyeffects --gapplication-service"
        "sleep 1 && hyprpaper-random"
        "eww daemon" # Start EWW daemon first
        "sleep 1 && $HOME/.config/hypr/scripts/eww-greeting.sh" # Then show greeting
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = 2;
        gaps_out = 8;
        border_size = 1;
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";

        # Simple dark borders
        "col.active_border" = "rgba(2A2A2AEE)"; # Pure dark gray
        "col.inactive_border" = "rgba(3A3A3A99)"; # Slightly lighter with transparency
      };

      decoration = {
        rounding = 4;
        active_opacity = 0.95;
        inactive_opacity = 0.95;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1A1A1A55)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 3;
          noise = 0.02;
          contrast = 1.1;
          vibrancy = 0.1;
          new_optimizations = true;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          # Faster, more linear curves
          "workspaceBezier, 0.1, 0.9, 0.2, 1.0"
          "slideBezier, 0.4, 0, 0.2, 1"
        ];

        animation = [
          # Faster workspace transitions (reduced from 5 to 2.5)
          "workspaces, 1, 2.5, slideBezier, slide"

          # Faster window movements (reduced from 4 to 2)
          "windows, 1, 2, slideBezier, slide"

          # Minimal border animations
          "border, 1, 3, default"

          # Quick fade effects
          "fade, 1, 3, default"

          # Faster window open/close
          "windowsIn, 1, 2.5, slideBezier, slide"
          "windowsOut, 1, 2.5, slideBezier, slide"

          # Quick layer animations
          "layers, 1, 2, slideBezier, slide"

          # Fast special workspace
          "specialWorkspace, 1, 2, slideBezier, slidevert"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      misc = {
        # force_default_wallpaper = -1;
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "ch";
        follow_mouse = 1;
        sensitivity = -0.5;

        touchpad.natural_scroll = false;
      };

      gestures.workspace_swipe = false;

      bind = [
        "SUPER, Q, exec, kitty"
        "SUPER, C, killactive"
        "SUPER, M, exit"
        "SUPER, E, exec, kitty -e ranger"
        "SUPER, F, fullscreen"
        "SUPER, V, togglefloating"
        "SUPER, exec, wofi --show drun"
        "SUPER, P, pseudo"
        "SUPER, J, togglesplit"
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
        "SUPER, D, exec, bash ${config.home.homeDirectory}/.config/hypr/scripts/toggle-waybar.sh"
        "SUPER, G, killactive, waybar"

        # Vim-style movement
        "SUPER SHIFT, H, movewindow, l"
        "SUPER SHIFT, L, movewindow, r"
        "SUPER SHIFT, K, movewindow, u"
        "SUPER SHIFT, J, movewindow, d"

        # Arrow keys movement
        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, right, movewindow, r"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER SHIFT, down, movewindow, d"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
        "SUPER, S, togglespecialworkspace, magic"
        "SUPER SHIFT, S, movetoworkspace, special:magic"
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };

  # Required environment packages
  home.packages = with pkgs; [
    waybar
    wofi
    dunst
    hyprpaper
  ];
}
