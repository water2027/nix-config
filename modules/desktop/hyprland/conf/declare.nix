{ ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''
    local mainMod = "SUPER"
    local menu = "fuzzel"
    local fileManager = "thunar"
    local terminal = "kitty"

    _G.hyprlandUserCommands = {
      mainMod = mainMod,
      menu = menu,
      fileManager = fileManager,
      terminal = terminal,
    }
  '';
}
