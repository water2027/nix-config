{ pkgs, ... }:

let
  hyprlandBin = "${pkgs.hyprland}/bin";
  pkill = "${pkgs.procps}/bin/pkill";
in
{
  services.wayle = {
    enable = true;
    settings = import ./settings.nix {
      inherit hyprlandBin pkill;
    };
  };

  xdg.configFile."wayle/styles/index.scss".source = ./styles/index.scss;
}
