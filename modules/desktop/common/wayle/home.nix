{
  services.wayle = {
    enable = true;
    settings = import ./settings.nix;
  };

  xdg.configFile."wayle/styles/index.scss".source = ./styles/index.scss;
}
