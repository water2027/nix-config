{ config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    env = [
      "GTK_THEME,Tokyonight-Dark"
      "XCURSOR_THEME,Nordzy-cursors"
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"

      "HYPRLAND_INTERACTIVE_SCREENSHOT_SAVEDIR,${config.home.homeDirectory}/Pictures/Screenshots/"
    ];
  };
}
