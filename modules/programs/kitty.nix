{ ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "Maple Mono NF CN";
      # size = 12;
    };

    settings = {
      background_opacity = "0.8";
      allow_remote_control = "yes";
    };

    keybindings = {
      "ctrl+v" = "launch --type=background --allow-remote-control --keep-focus ~/.local/bin/clip2path";
      "ctrl+shift+enter" = "launch --cwd=current";
    };
  };

  home.shellAliases = {
    cpd = "kitten clipboard";
    icat = "kitten icat";
  };
}
