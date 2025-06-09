{pkgs, ...}: {
  imports = [
    ./applications/default.nix
    ./scripts/default.nix
  ];
}
