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
      auto_reload_config = "-1";
    };

    keybindings = {
      "ctrl+v" = "launch --type=background --allow-remote-control --keep-focus ~/.local/bin/clip2path";
      "ctrl+shift+enter" = "launch --cwd=current";
      "alt+shift+[" = "previous_tab";
      "alt+shift+]" = "next_tab";
    };
  };

  home.shellAliases = {
    cpd = "kitten clipboard";
    icat = "kitten icat";
  };
}
