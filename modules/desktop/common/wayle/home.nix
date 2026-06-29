{ pkgs, ... }:

let
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
in
{
  services.wayle = {
    enable = true;
    settings = import ./settings.nix { inherit hyprctl; };
  };

  xdg.configFile."wayle/styles/index.scss".source = ./styles/index.scss;
}
