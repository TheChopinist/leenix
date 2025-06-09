{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./modules/hyprland/hyprland.nix
    ./modules/default.nix
    ./modules/scripts/default.nix

    inputs.catppuccin.homeModules.catppuccin
    inputs.spicetify.homeManagerModules.default
  ];

  catppuccin = {
    enable = true;
    flavor = "frappe"; # latte, frappe, macchiato, mocha
    kitty.enable = true;
    waybar.enable = true;
  };

  home.username = "lee";
  home.homeDirectory = "/home/lee";

  home.stateVersion = "24.11";

  /*

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      ”\\\${HOME}/.steam/root/compatibilitytools.d”;
  };
  */

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      rebuild() {
          echo "🚀 Starting NixOS rebuild process..."

          echo "🔄 Step 1: Updating flake inputs..."
          if (cd /home/lee/nixos && nix flake update); then
              echo "✅ Flake inputs updated successfully!"
          else
              echo "⚠️ Flake update failed or rate limited. Skipping update and continuing with rebuild."
          fi

          echo "🔧 Step 2: Rebuilding system with flake..."
          if sudo nixos-rebuild switch --flake /home/lee/nixos#leenix; then
              echo "✅ System rebuild successful!"

              echo "🗑️ Step 3: Cleaning up old generations (keeping last 10)..."
              if sudo nix-collect-garbage --delete-older-than 10d; then
                  echo "✅ Cleanup completed successfully!"
                  echo "✨ All done! System updated and cleaned."
              else
                  echo "❌ Error during cleanup!" >&2
                  return 1
              fi
          else
              echo "❌ Rebuild failed!" >&2
              return 1
          fi
      }
      alias rb=rebuild
    '';
  };

  # ==============================
  #         SPOTIFY (SPICETIFY)
  # ==============================
  programs.spicetify = let
    spicetify = inputs.spicetify.legacyPackages.${pkgs.system};
  in {
    enable = true;
    enabledExtensions = with spicetify.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
    enabledCustomApps = with spicetify.apps; [
      newReleases
      ncsVisualizer
    ];
    theme = spicetify.themes.catppuccin;
    colorScheme = "frappe";
  };

  programs.home-manager.enable = true;
}
